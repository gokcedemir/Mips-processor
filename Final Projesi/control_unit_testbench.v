`define DELAY 20
module control_unit_testbench();

wire RegDst;
wire Branch;
wire MemRead; 
wire MemtoReg;
wire [2:0] ALUOp; 
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire jump;  //jump
wire bne;  //brach not equal
wire jal;  //jump and link
wire lui;  
wire lbu;
wire lhu;
wire sb;
wire sh;
reg [5:0] opcode;  //input

control_unit testfunc(RegDst, Branch,MemRead, MemtoReg,ALUOp,MemWrite,ALUSrc, RegWrite,opcode); 

initial begin
opcode = 6'b000000;   //r_type
#`DELAY;
opcode = 6'b000100;  //beq
#`DELAY; 
opcode = 6'b000101;   //bne
#`DELAY;
opcode = 6'b100000;  //lb
#`DELAY;
opcode = 6'b100001;  //lh
#`DELAY;
opcode = 6'b100011;  //lw
#`DELAY;
opcode = 6'b100100;  //lbu
#`DELAY;
opcode = 6'b100101;  //lhu
#`DELAY;
opcode = 6'b001100; //andi
#`DELAY;
opcode = 6'b001101;  //ori
#`DELAY;
opcode = 6'b001010;  //slti
#`DELAY;
opcode = 6'b001011;  //sltiu
#`DELAY;
opcode = 6'b101000;  //sb
#`DELAY;
opcode = 6'b101001; //sh
#`DELAY;
opcode = 6'b101011;  //sw
end


initial 
begin
 $monitor("Time=%2d, RegDst = %1b, Branch=%1b, MemRead=%1b, MemtoReg=%1b, ALUOp=%3b, MemWrite=%1b, AluSrc=%1b, RegWrite=%1b, opcode=%6b",$time,RegDst, Branch,MemRead, MemtoReg,ALUOp,MemWrite,ALUSrc, RegWrite,opcode);
end

endmodule