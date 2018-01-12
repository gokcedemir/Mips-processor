module alu_control_unit(ALU_control, ALUOp, funct);

output [3:0] ALU_control;  //3 bit control singal
reg [3:0] ALU_control;
input [2:0] ALUOp;  //3-bit 
input [5:0] funct;  //6-bit funciton field

always @(funct or ALUOp)
begin
if(ALUOp == 3'b100)            //or
	ALU_control = 4'b0001;
else if(ALUOp == 3'b000)          //
	ALU_control =  4'b0010;  //add
else if(ALUOp == 3'b001)       	
	ALU_control = 4'b0110;  //sub
else if((funct == 6'b100000) || (funct == 6'b100001))    //add
	ALU_control = 4'b0010;
else if(funct == 6'b100100)   //and	 
	ALU_control =  4'b0000;
else if(funct == 6'b100111)  //nor
	ALU_control = 4'b1100 ;
else if(funct == 6'b100101)    //or
	ALU_control =4'b0001;
else if(funct == 6'b101010)   //set-on-less-than
	ALU_control = 4'b0111;
else if(funct == 6'b101011)   //sltu
	ALU_control = 4'b0011;
else 						//r-typelarda
   ALU_control = 4'b0110;
end

endmodule