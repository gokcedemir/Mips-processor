module alu(zero, ALU_result, read_data_1, read_data_2, shamt, ALU_control);

output [31:0] ALU_result;
reg [31:0] ALU_result;
output zero;  // 0
input [31:0] read_data_1, read_data_2;   //rs , rt or sign exrend
input [4:0] shamt;   //shift amount instruction[10:6]
input [3:0] ALU_control;  //control sinyali

always @(read_data_1 or read_data_2 or shamt or ALU_control)
begin
if(ALU_control == 4'b0000)  //and  --> rs & rt
	 ALU_result = (read_data_1 & read_data_2) ;
else if(ALU_control == 4'b0001)  //or --> rs || rt
	 ALU_result = (read_data_1 | read_data_2);
else if(ALU_control == 4'b0010)  // add --> rs+rt
	 ALU_result = read_data_1 + read_data_2;
else if(ALU_control == 4'b0110)  // sub --> rs-rt
	 ALU_result = $signed(read_data_1) - $signed(read_data_2);
else if(ALU_control == 4'b0111)  // slt --> rs < rt
	 ALU_result = $signed(read_data_1) < $signed(read_data_2) ? 32'd1 : 32'd0;
else if(ALU_control == 4'b0011)  // sltu --> rs< rt
	 ALU_result = read_data_1 < read_data_2;
else if(ALU_control == 4'b1100)  // nor
	ALU_result = ~(read_data_1 | read_data_2);
else if(ALU_control == 4'b1101)    //left shift
	ALU_result = read_data_1 << shamt;
else if(ALU_control == 4'b1110)  //right shift
	ALU_result = read_data_1 >> shamt;
else
	ALU_result = 32'dx;   //don't care 
end

assign zero = (ALU_result == 0) ? 1'b1 : 1'b0;  //eger alu resultumuz 0 ise sifir registeri outputumuz olur

endmodule