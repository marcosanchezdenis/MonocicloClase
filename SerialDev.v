`timescale 1ns / 1ps
module SerialDev (
	input wire clk, reset,
	output wire tx,
	input wire rx,w5,w6,
	input wire [31:0]dE,
	output wire [31:0]qE,qS
);

 wire finished;
 wire [7:0]out_data;
//check
register entrada (
    .clk(clk), 
	 .reset(reset),
    .enable(w5), 
    .d(dE),// completar los 32 bits de informacion de estados utiles 
    .q(qE)
    );
	 
register salida (
    .clk(clk), 
	 .reset(reset),
    .enable(w6), 
    .d({finished,23'd0,out_data}), 
    .q(qS)  // completar los 32 bits con informacion de estados utiles
    );
	 
serialDevice uart (
    .clk(clk), 
    .reset(reset), 
    .rx(rx), 
    .tx(tx), 
    .start_send(qE[31]), 
    .in_data(qE[7:0]), 
    .out_data(out_data), 
    .finished(finished)
    );
endmodule

