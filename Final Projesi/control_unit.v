module control_unit(output RegDst, 
						  output Branch,
						  output MemRead, 
						  output MemtoReg,
						  output [2:0] ALUOp,  //bu output alu_control'a input olarak gider
						  output MemWrite, 
						  output ALUSrc,
						  output RegWrite,
						  output jump,  //jump
						  output bne,  //brach not equal
						  output jal,  //jump and link
						  output lui,  
						  output lbu,
						  output lhu,
						  output sb,
					     output sh,
						  input [5:0] opcode);  //instruction[31:26]

assign RegDst =  (opcode == 6'b000000) ? 1'b1 : 1'b0;   // r-type'larda RegDst=1, digerlerinde RegDst=0
//branch instructions
assign Branch = (opcode == 6'b000100) || (opcode == 6'b000101) ? 1'b1 : 1'b0;  // bne, beq

//load instructions
assign MemRead = (opcode == 6'b100000) || (opcode==6'b100001) || (opcode == 6'b100011) || 
					 (opcode == 6'b100100) || (opcode== 6'b100101) ? 1'b1 : 1'b0;  //lb,lh,lw,lbu,lhu

assign MemtoReg = MemRead; //lb,lh,lw,lbu,lhu  //her ikisi de load instructionlarda 1 olur, diger durumlarda x veya 0 olurlar

//alu_control'e input olarak gidecek
assign ALUOp = (opcode == 6'b000000) ? 3'b010 : //r-typlerda
							((opcode == 6'b000100) || (opcode == 6'b000101) ) ? 3'b001 :  ///beq,bne	
							(opcode == 6'b001100) ? 3'b011 : //andi
							(opcode == 6'b001101) ? 3'b100 : //ori
						   (opcode == 6'b001010) ? 3'b101 : //slti
					      (opcode == 6'b001011) ? 3'b110 : //sltiu
					       3'b000 ; //others ins.

//store instructions
assign MemWrite = (opcode == 6'b101000) || (opcode == 6'b101001 ) || (opcode == 6'b101011) ? 1'b1 : 1'b0; //sb, sh,sw

assign ALUSrc = (opcode == 6'b100000) || (opcode==6'b100001) || (opcode == 6'b100011) || 
					 (opcode == 6'b100100) || (opcode== 6'b100101) || (opcode == 6'b101000) || 
					 (opcode == 6'b101001 ) || (opcode == 6'b101011) ? 1'b1 : 1'b0; //lb,lh,lw,lbu,lhu,sb,sh,sw
					 
assign RegWrite = (opcode == 6'b000000) ||  //r-type
						(opcode == 6'b100000) || (opcode==6'b100001) || (opcode == 6'b100011) || 
					   (opcode == 6'b100100) || (opcode== 6'b100101) ||    //lb,lh,lw,lbu,lhu
						(opcode == 6'b001000) || (opcode == 6'b001001) ||   //addi, addiu
						(opcode == 6'b001100) || (opcode == 6'b000011)  ||  //andi ,jal
						(opcode == 6'b001101) || (opcode == 6'b001010) ||   // ori,slti
						(opcode == 6'b001011) ? 1'b1 : 1'b0;  //sltiu
						

assign jump = ((opcode == 6'b000010) || (opcode == 6'b000011)) ? 1'b1 : 1'b0; //j, jal
assign bne = (opcode == 6'b000101) ? 1'b1 : 1'b0; //bne
assign jal = (opcode == 6'b000010) ? 1'b1 : 1'b0; //jal
assign lui = (opcode == 6'b001111) ? 1'b1 : 1'b0; //lui
assign lbu = (opcode == 6'b100100) ? 1'b1 : 1'b0;  //lbu
assign lhu = (opcode == 6'b100101) ? 1'b1 : 1'b0;  //lhu
assign sb = (opcode == 6'b101000) ? 1'b1 : 1'b0; //sb
assign sh = (opcode == 6'b101001) ? 1'b1: 1'b0; //sh
			
			
endmodule