`define DELAY 20

module mips_data_mem_testbench();

wire [31:0] read_data; 
reg [31:0] mem_address;   //datanin yazilacagi adres
reg [31:0] write_data;    // memorye yazilacak olan data 
reg sig_mem_read;       //control unitten gelen memoryden okuma sinyali
reg sig_mem_write;			//control unitten gelen momorye yazma sinyali

mips_data_mem tester(read_data, mem_address, write_data, sig_mem_read, sig_mem_write);

initial begin
mem_address=0; write_data=0; sig_mem_read=0; sig_mem_write=0;
#`DELAY
mem_address=0; write_data=0; sig_mem_read=1; sig_mem_write=0;
#`DELAY 
mem_address=3; write_data=0; sig_mem_read=1; sig_mem_write=0;
#`DELAY
mem_address=1; write_data=8; sig_mem_read=0; sig_mem_write=1;  //memorye yazma
#`DELAY
mem_address=12; write_data=13; sig_mem_read=0; sig_mem_write=1;

end

initial
begin
$monitor("time=%2d,read_data=%1d, mem_address=%1d, write_data=%1d, sig_mem_read=%1d, sig_mem_write=%1d",$time,read_data, mem_address, write_data, sig_mem_read, sig_mem_write);
end

endmodule