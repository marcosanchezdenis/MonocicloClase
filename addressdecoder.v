`timescale 1ns / 1ps

module addressdecoder(
	input wire [31:0]address,
	input wire memwrite,
	output wire [2:0]select,
	output wire we1,
	output wire we2,
	output wire we3,
	output wire we4,
	output wire we5,
	output wire we6,
	output wire we7,
	output wire we8
	 );
	 
	localparam LED = 32'hFFFF_FFFF;
	localparam SLIDE_SWITCH = 32'hFFFF_FFFE;
	localparam BUTTON = 32'hFFFF_FFFD;
	localparam SERIAL_IN = 32'hFFFF_FFFC;
	localparam SERIAL_OUT = 32'hFFFF_FFFB;
	localparam LCD = 32'hFFFF_FFFA;
	localparam ROTARY = 32'hFFFF_FFF9;

	reg [9:0]signals;
	assign {select,we1,we2,we3,we4,we5,we6,we7,we8} = signals;
	
always@(*) begin 
	case(address)
		LED: 					signals = {3'b001,000_000_0,memwrite}; 
		SLIDE_SWITCH:		signals = {3'b010,000_000,memwrite,0}; 
		BUTTON: 				signals = {3'b011,000_00,memwrite,00};
		SERIAL_IN: 			signals = {3'B100,000_0,memwrite,000};
		SERIAL_OUT: 		signals = {3'b101,000,memwrite,0_000};
		LCD: 					signals = {3'b110,00,memwrite,00_000};
		ROTARY: 				signals = {3'b111,0,memwrite,000_000};
		default: 			signals = {3'b000,memwrite,0_000_000}; 
	endcase
end


endmodule
