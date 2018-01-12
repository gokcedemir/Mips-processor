module mips_registers
(read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );

	output  [31:0] read_data_1, read_data_2;
	input [31:0] write_data;
	input [4:0] read_reg_1, read_reg_2, write_reg;
	input signal_reg_write, clk;
	reg [31:0] registers [31:0];
	
	//registerlari bir kez dosyadan okur
	initial begin
		$readmemb("registers.mem", registers);
	end

	//rs contenti alinir
	assign read_data_1 = registers[read_reg_1];
	//rt contenti read_data_2'ye atilir
	assign read_data_2 = registers[read_reg_2];

	//signal_reg_write gelirse registera yazar
	always @(posedge clk)
	begin
		if (signal_reg_write) begin
			registers[write_reg] = write_data;
		end
	end
endmodule