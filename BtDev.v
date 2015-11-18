`timescale 1ns / 1ps
module BtDev(
	input wire clk,reset, w4,
	input wire [31:0]d,
	output reg [31:0]q
);
	always@(posedge clk) begin 
		if(reset) begin
			q<=32'd0;
		end else begin 
			if(we3) begin
				q<=d;				
			end 
		end
	end
endmodule
