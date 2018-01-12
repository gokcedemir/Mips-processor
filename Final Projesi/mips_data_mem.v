module mips_data_mem (read_data, mem_address, write_data, sig_mem_read, sig_mem_write);
output [31:0] read_data; 
input [31:0] mem_address;   //datanin yazilacagi adres
input [31:0] write_data;    // memorye yazilacak olan data 
input sig_mem_read;       //control unitten gelen memoryden okuma sinyali
input sig_mem_write;			//control unitten gelen momorye yazma sinyali

reg [31:0] data_mem  [63:0];
reg [31:0] read_data;

initial begin
	$readmemb("data.mem", data_mem);
end

always @(mem_address or write_data or sig_mem_read or sig_mem_write) begin
	if (sig_mem_read) begin
		read_data <= data_mem[mem_address];
	end
	
	if (sig_mem_write) begin
		data_mem[mem_address] <= write_data[31:0];
	end
end

endmodule