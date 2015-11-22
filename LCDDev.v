`timescale 1ns / 1ps
module LCDDev (
	input wire clk,reset,
	input wire [31:0]d,
	output reg [31:0]q,
	input wire w7,
	output wire[7:0]lcd_db,
	output wire lcd_e,
	output wire lcd_rs,
	output wire lcd_rw
	);
	
always@(posedge clk ) begin 
	if(reset) begin 
		q <= 32'd0;
	end else begin 
		if(w7) begin
				q<= d;
		end
	end
end	

lcd instance_name (
    .clk(clk), 
    .reset(reset), 
    .init(1), //
    .enviar(q[8]), 
    .limpiar(q[9]), 
    .info(q[7:0]), 
    .lcd_db(lcd_db), 
    .lcd_e(lcd_e), 
    .lcd_rs(lcd_rs), 
    .lcd_rw(lcd_rw)
    );
endmodule

