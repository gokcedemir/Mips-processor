module mips_core(input clock);

wire [31:0] instruction;  //32 bit instruction
reg[31:0] PC=0;  //program counter
reg counter =0;

/**parser instruction  ********************/
wire [4:0] rs, rt, rd, shamt;   	//for parser instruction rs, rt and rd register
wire [15:0] immediate;   			//for i type instruction immediate field  - 16 bit
wire [25:0] target_address;  	   // for j type instruction target_address field - 26 bit
wire [5:0] opcode;    				// for all type instruction has 6 bit opcode field 
wire [5:0] func; 				 		//function code field for r type instruction
wire [31:0] read_data_1;         //rs_content
wire [31:0] read_data_2;			  //rt_content 
reg [31:0] write_data;
wire [31:0] read_data;
/************************************************************/

/* control sinyalleri, control_unit tarafindan uretilir..   */
wire RegDst;    //
wire Branch;    // branch sinyali
wire MemRead;   //memorye yazma sinyali
wire MemtoReg;  //memoryden registera yazma sinyali
wire [2:0] ALUOp;
wire MemWrite;   //memorye yazma izni
wire ALUSrc;
wire RegWrite;   //registera yazma sinyali
wire jum;
wire bne;
wire jal;
wire lui;
wire lbu;
wire [3:0] ALU_control;
wire lhu;
wire zero;
wire sb;
wire [31:0] ALU_result;
wire sh;
reg sll, srl, jr;

/************************************************************/
reg [31:0] alu_input;
wire [31:0] sign_extend;
reg [31:0] mem_address;

/* instruction fetch edilir */
mips_instr_mem inst_mem(instruction, PC);

// decode instruction --> opcode, rs, rt, rd, shamt, funct
 assign opcode= instruction[31:26];   //6 bits opcode
 assign rs= instruction[25:21];		  //5 bits rs
 assign rt= instruction[20:16];		  //5 bits rt
 assign rd= instruction[15:11];		  //5 bits rd
 assign shamt= instruction[10:6];	  //5 bits shift amount
 assign func= instruction[5:0];		  //6 bits function code
 assign immediate = instruction[15:0];  // immediate field for i type instruction
 assign target_address = instruction[25:0];  //16 bit target address for j type instruction
 
//mips_instr_mem instructionmem(instruction, PC);
mips_registers registers(read_data_1,read_data_2, write_data,rs, rt, rd ,RegWrite, clock);

assign sign_extend= {{16{instruction[15]}}, immediate};  // signed extend yapilir
always @(ALUSrc)
begin
//aluya input olarak giden mux
if(ALUSrc == 0)  //rt girer aluya
	alu_input = read_data_2;
else if(ALUSrc== 1)  //signed extend girer aluya
	alu_input = sign_extend;
end

//Decodes instruction to determine what segments will be active in the datapath
control_unit mips_control(RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, jump, bne, jal,lui,lbu,lhu,sb,sh, opcode);

//assign jr = ((ALUOp == 3'b010) && (func == 6'b001000)) ? 1'b1 : 1'b0;  //jr ise 1 yap
//assign sll = ((ALUOp == 3'b010) && (func == 6'b000000)) ? 1'b1 : 1'b0;  // sll ise 1 yap
//assign srl = ((ALUOp == 3'b010) && (func == 6'b000010)) ? 1'b1 : 1'b0;  //srl ise 1 yap


// register bloguna yazilacak write_data'yi secme
/****************************************************************************************/

always @(*)
begin

jr = ((ALUOp == 3'b010) && (func == 6'b001000)) ? 1'b1 : 1'b0;  //jr ise 1 yap
 sll = ((ALUOp == 3'b010) && (func == 6'b000000)) ? 1'b1 : 1'b0;  // sll ise 1 yap
 srl = ((ALUOp == 3'b010) && (func == 6'b000010)) ? 1'b1 : 1'b0;  //srl ise 1 yap

if(lui == 1)  //Load upper immediate  --> 	$t = (imm << 16); 
	write_data = immediate << 16;
else if(jal == 1)  //jump and link  -->  PC = nPC
	write_data = PC+1;  //return degerini saklar
else if(MemRead == 1)   //lw icin
	write_data = read_data;   //memoryden okunan deger retistegra yazilir
else if(MemRead ==1 & (lbu ==1)) // Load Unsigned Byte
	write_data = {{24{1'b0}}, read_data[7:0]};   //lbu Rdest, imm(Rsrc)
else if(MemRead ==1 & (lhu==1) )   // Load Unsigned Halfword
	write_data = {{16{1'b0}}, read_data[15:0]};  //lhu Rdest, imm(Rsrc):
else if(srl ==1)   //shift right logical
	write_data = alu_input >> shamt;
else if( sll ==1)   //shift left 
	write_data = alu_input << shamt;
else
	write_data = ALU_result;
	
if(MemWrite ==1 && ((opcode == 6'b101000) || (opcode == 6'b101001 ) || (opcode == 6'b101011))) //store instructionları 
	mem_address = read_data_1 + sign_extend;   //sb, sh,sw
else
	mem_address = ALU_result;
	
end

/*******************************************************************************/

alu_control_unit mycontrolunit(ALU_control, ALUOp, func);
alu myalu(zero, ALU_result, read_data_1, alu_input, shamt, ALU_control); //alu_input , alu_src gore secilir --> rt veya signedextend
mips_data_mem mymem(read_data, mem_address, read_data_2, MemRead, MemWrite);


// program counteri set etme
/*****************************************************************************/
always @(posedge clock) 
begin
	if(jr ==1)   //PC = nPC
		PC <= rs;
	else if( jal ==1 || jump ==1 )   // jump  
		PC <= {{6{1'b0}}, target_address};   
   else if(bne ==1 && zero ==0)
		PC <= PC+1+ $signed(sign_extend);  //branch not equal
	else if(Branch ==1 && zero==1 && bne ==0)
		PC <= PC+1+ $signed(sign_extend);  //beq
	else
		PC <= PC+1; 
end
/********************************************************************************/

initial begin
$monitor("Instruction: %32b, PC:%d RS: %d, RT: %d, regWrite_signal:%b, RD_adress: %d, RD:%d mem_address: %d, ALU_REsult= %d , shamt = %d, Write_data= %32b, Sign_Extend: %32b",instruction,PC, read_data_1,read_data_2, RegWrite, rd, write_data, ALU_result, ALU_result, shamt, write_data, sign_extend);
end


endmodule