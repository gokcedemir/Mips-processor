`define DELAY 500
module mips_testbench();

reg clock;

mips_core test(clock);

initial begin
	clock = 0;
end
      
initial begin
	/*instruciton sayisi * 2*/
  #50 clock=~clock;  #50 clock=~clock;

  #50 clock=~clock; #50 clock=~clock;
  
  #50 clock=~clock; #50 clock=~clock;
  
  #50 clock=~clock; #50 clock=~clock;
  
  #50 clock=~clock; #50 clock=~clock;
  
  #50 clock=~clock; #50 clock=~clock;
  
  #50 clock=~clock; #50 clock=~clock;
  
  #50 clock=~clock; #50 clock=~clock; 
  
  #50 clock=~clock; #50 clock=~clock;
  
 //depend instruciton number 
end

// tum instructionlar bittikten sonra register bloguna veya data memorye yazar
initial begin
#2500
$writememb("res_registers.mem", test.registers.registers);
$writememb("res_data.mem", test.mymem.data_mem);
end


endmodule
