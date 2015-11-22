`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:36 10/19/2015 
// Design Name: 
// Module Name:    serialDevice 
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
module serialDevice(
	input wire clk,
	
	input wire reset,
	input wire rx,
	output wire tx,
	input wire start_send,
	input wire [7:0]in_data,
	output wire [7:0]out_data,
	output wire finished
	
	);
		
	receptor r1(
		.clk(clk),
		.reset(reset),
		.x(rx),// entrada de datos
		.data(out_data),
		.finished(finished) //finalizado el envio
	);
	
	
	
	transmisor  t1(
		.clk(clk),
		.reset(reset),
		.iniciar_envio(start_send), //empezar el envio
		.data(in_data),
		.y(tx)// salida de datos
	);
	

	

endmodule
