`define DELAY 20
module alu_testbench();

wire zero;
wire [31:0] ALU_result;
reg [31:0] read_data_1, read_data_2;
reg [4:0] shamt;
reg [3:0] ALU_control;

alu myalu(zero, ALU_result, read_data_1, read_data_2, shamt, ALU_control);

initial begin
read_data_1 = 32'd1; read_data_2 =32'd0; shamt=5'b00000; ALU_control = 4'b0000;  //and
#`DELAY;
read_data_1 = 32'd1; read_data_2 =32'd0; shamt=5'b00000; ALU_control = 4'b0001;  //or
#`DELAY;
read_data_1 = 32'd13; read_data_2 =32'd5; shamt=5'b00000; ALU_control = 4'b0010;  //add
#`DELAY;
read_data_1 = 32'd29; read_data_2 =32'd23; shamt=5'b00000; ALU_control = 4'b0110;  //sub
#`DELAY;
read_data_1 = 32'd8; read_data_2 =32'd2; shamt=5'b00000; ALU_control = 4'b0111;  //slt
#`DELAY;
read_data_1 = 32'd30; read_data_2 =32'd5; shamt=5'b00000; ALU_control = 4'b1100;  //nor
#`DELAY;
read_data_1 = 32'd16; read_data_2 =32'dx; shamt=5'b00010; ALU_control = 4'b1101;  //sll
#`DELAY;
read_data_1 = 32'd30; read_data_2 =32'dx; shamt=5'b00100; ALU_control = 4'b1110;  //srl
#`DELAY;
end

initial
begin
$monitor("time = %2d, read_data_1= %1d read_data_2= %1d , shamt= %1d , ALU_control= %1d , result:%1d", $time,read_data_1, read_data_2, shamt, ALU_control, ALU_result);
end


endmodule