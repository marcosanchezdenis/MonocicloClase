`timescale 1ns / 1ps

module addressdecoder(
	input wire [31:0]address,
	input wire memwrite,
	output wire [1:0]select,
	output wire we1,
	output wire we2,
	output wire we3,
	output wire we4
	 );
	 
	localparam LED = 32'hFFFF_FFFF;
	localparam SLIDE_SWITCH = 32'hFFFF_FFFE;
	localparam BUTTON = 32'hFFFF_FFFD;

	reg [5:0]signals;
	assign {select,we1,we2,w3,w4} = signals;
	
always@(*) begin 
	case(address)
		LED: 				signals = {2'b01,3'd0,memwrite}; 
		SLIDE_SWITCH:	signals = {2'b10,2'd0,memwrite,1'd0}; 
		BUTTON: 			signals = {2'b11,1'd0,memwrite,2'd0};
		default: 		signals = {2'b00,memwrite,3'd0}; 
	endcase
end


endmodule
