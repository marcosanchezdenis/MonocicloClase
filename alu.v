
`timescale 1ns / 1ps
`default_nettype none

module alu(
	input wire [31:0]scrA,	
	input wire [31:0]scrB,	
	input wire [3:0]operation,		
	output reg [31:0]ALUResult,
	output wire zero		
);





	always @(scrA,scrB,operation)begin	
				
				
			case (operation)
				3'b000: 	ALUResult <= scrA & scrB; //AND				
				3'b001: 	ALUResult <= scrA | scrB; //OR						
				3'b010:	ALUResult <= scrA + scrB; //SUMA							
				3'b110:	ALUResult <= scrA - scrB;	// RESTA
				3'b111:	ALUResult <= (scrA < scrB) ? 1:0; //SLT
				//3'b000:	ALUResult <= {scrB[15:0], 16'b0}; //LUI				
				default: ALUResult <= 32'dx;
					
			endcase
	end



assign zero = (ALUResult == 0)? 1:0;


endmodule

