`define DELAY 20
module mips_registers_testbench ();

wire [31:0] read_data_1, read_data_2;
reg [31:0] write_data;
reg [4:0] read_reg_1, read_reg_2, write_reg;
reg signal_reg_write, clk;


initial begin
write_data = 32'b00000010000100101000000100000; read_reg_1 = 5'b01110; read_reg_2 = 5'b01010; write_reg = 5'b00010; 
signal_reg_write=1'b0;  
#`DELAY;
write_data = 32'b11111010101010101010101010101010; read_reg_1 = 5'b01111; read_reg_2 = 5'b01000; write_reg = 5'b00010; 
signal_reg_write=1'b1;  
#`DELAY;
end


initial begin
	clk <= 1;
end
      
always begin
  #5;
  clk=~clk;
end

mips_registers myFucntion(read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );

initial
begin
$monitor("time = %2d, read_data_1= %32b  read_data_2= %32b", $time, read_data_1, read_data_2);
end


endmodule