`timescale 1ns / 1ps
`default_nettype none

module mem_ram(
	input wire clk,
	input wire [3:0] addr_rw,
	input wire we,
	input wire [31:0] data_w,
	output wire [31:0] data_r
);
	reg [31:0] ram_array [0:15];

	initial begin
		$readmemh("data.txt", ram_array, 0, 15);
	end
	
	always @ (posedge clk) begin
		if (we) begin
			ram_array[addr_rw] <= data_w;
		end
	end
	
	assign data_r = ram_array[addr_rw];   

endmodule
