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
	input wire [31:0]a,b,c,d,
	input wire [1:0]select,
	output reg [31:0] y
 );

always@(*) begin 
	case(select) 
		2'd00: y = a;
		2'd00: y = b;
		2'd00: y = c;
		2'd00: y = d;
		default: y = 32'dx;
	endcase
end	 
	 


endmodule
