`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:32:17 11/20/2015 
// Design Name: 
// Module Name:    registro 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module registro_transmisor (
	input wire clk,
	input wire reset,
	input wire enable,
	input wire [31:0]d,
	output reg [31:0]q
);
always@(posedge clk or posedge reset ) begin
	if (reset) begin 
		q<=32'd0;
	end else begin 
		if(enable) begin 
			q<=d;
		end 		
	end
end
endmodule