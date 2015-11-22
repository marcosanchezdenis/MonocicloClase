`timescale 1ns / 1ps
`default_nettype none

module mem_rom(
	input wire [7:0] addr_r,
	output wire [31:0] data_r
);
	reg [31:0] rom_array [0:256];

	initial begin
		$readmemh("instr.txt", rom_array, 0, 256);
	end

	assign data_r = rom_array[addr_r];

endmodule
