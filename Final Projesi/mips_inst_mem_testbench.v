`define DELAY 20
module mips_inst_mem_testbench();

reg [31:0] program_counter; 
wire [31:0] instruction;  //output

mips_instr_mem myFunc(instruction, program_counter);

initial begin
program_counter = 32'b00000000000000000000000000000000;  //pc =0
#`DELAY;
program_counter = 32'b00000000000000000000000000000001; //pc =1
#`DELAY;
program_counter = 32'b00000000000000000000000000000010; //pc =2
end

initial
begin
$monitor("time = %2d instruction: %32b", $time, instruction);
end

endmodule