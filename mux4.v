`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:16:29 11/18/2015 
// Design Name: 
// Module Name:    mux4 
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
module mux4(
	input wire [31:0]a,b,c,d,e,f,g,h,
	input wire [1:0]select,
	output reg [31:0] y
 );

always@(*) begin 
	case(select) 
		3'b000: y = a;
		3'b001: y = b;
		3'b010: y = c;
		3'b011: y = d;
		3'b100: y = e;
		3'b101: y = f;
		3'b110: y = g;
		3'b111: y = h;
		default: y = 32'dx;
	endcase
end	 
	 


endmodule
