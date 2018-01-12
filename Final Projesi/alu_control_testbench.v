`define DELAY 20
module alu_control_testbench();

wire [2:0] ALU_control;  //3 bit control singal
reg [2:0] ALUOp;  //3-bit 
reg [5:0] funct;  //6-bit funciton field

alu_control_unit test(ALU_control, ALUOp, funct);


initial begin
ALUOp = 3'b000; funct =6'b000000;  
#`DELAY;
ALUOp= 3'b010; funct = 6'b100100; //and
#`DELAY;
ALUOp=3'b100;  funct =6'b000000;  //andi
#`DELAY;
ALUOp= 3'b010; funct = 6'b100000; //add
#`DELAY;
ALUOp= 3'b010; funct = 6'b100001; //addu
#`DELAY;
ALUOp= 3'b010; funct = 6'b100101; //or
#`DELAY;
ALUOp=3'b101;  funct =6'b000000;  //ori
#`DELAY;
ALUOp= 3'b010; funct = 6'b100111; //nor
#`DELAY;
ALUOp= 3'b010; funct = 6'b100010; //sub
#`DELAY;
ALUOp=3'b010;  funct =6'b100011; // subu
#`DELAY;   
ALUOp=3'b001;  funct =6'b000000; // bne,beq
#`DELAY;  
ALUOp=3'b110;  funct =6'b000000; // slti, sltiu
#`DELAY;  
ALUOp=3'b010;  funct =6'b101010; // slt
#`DELAY;  
ALUOp=3'b010;  funct =6'b101001; // sltu
#`DELAY;  
ALUOp=3'b010;  funct =6'b000010; // srl
#`DELAY; 
ALUOp = 3'b010; funct =6'b000000;  //sll
#`DELAY; 
ALUOp = 3'b011; funct = 6'b000000; 
end

initial begin
    $monitor("Time:%2d ALUOp: %3b Function Field: %6b Alu_control: %4b",$time,ALUOp, funct, ALU_control);
  end
  
endmodule