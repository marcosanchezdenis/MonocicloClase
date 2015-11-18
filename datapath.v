`timescale 1ns / 1ps
module datapath(
	input wire clk, reset,
	input wire memtoreg, pcsrc,
	input wire alusrc, regdst,
	input wire regwrite, jump,
	input wire [2:0] alucontrol,
	output wire zero,
	output wire [31:0] pc,
	input wire [31:0] instr,
	output wire [31:0] aluout, writedata,
	input wire [31:0] readdata);




wire [4:0] writereg;
wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
wire [31:0] signimm, signimmsh;
wire [31:0] srca, srcb;
wire [31:0] result;
// next PC wire
//flopr #(32) pcreg(clk, reset, pcnext, pc);
flopr #(32) pcreg (
    .clk(clk), 
    .reset(reset), 
    .d(pcnext), 
    .q(pc)
    );
//adder pcadd1(pc, 32'b100, pcplus4);
adder pcadd1 (
    .a(pc), 
    .b(32'b100), 
    .y(pcplus4)
    );
//sl2 immsh(signimm, signimmsh);
sl2 immsh (
    .a(signimm), 
    .y(signimmsh)
    );
//adder pcadd2(pcplus4, signimmsh, pcbranch);
adder pcadd2 (
    .a(pcplus4), 
    .b(signimmsh), 
    .y(pcbranch)
    );
//mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
mux2 #(32) pcbrmux (
    .d0(pcplus4), 
    .d1(pcbranch), 
    .s(pcsrc), 
    .y(pcnextbr)
    );

//mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28],instr[25:0], 2'b00}, jump, pcnext);
mux2 #(32) pcmux (
    .d0(pcnextbr), 
    .d1({pcplus4[31:28],instr[25:0], 2'b00}), 
    .s(jump), 
    .y(pcnext)
    );

// register file wire
//regfile rf(clk, regwrite, instr[25:21], instr[20:16],writereg, result, srca, writedata);
regfile rf (
    .clk(clk), 
    .we3(regwrite), 
    .ra1(instr[25:21]), 
    .ra2(instr[20:16]), 
    .wa3(writereg), 
    .wd3(result), 
    .rd1(srca), 
    .rd2(writedata)
    );
//mux2 #(5) wrmux(instr[20:16], instr[15:11],regdst, writereg);
mux2 #(5) wrmux (
    .d0(instr[20:16]), 
    .d1(instr[15:11]), 
    .s(regdst), 
    .y(writereg)
    );

//mux2 #(32) resmux(aluout, readdata, memtoreg, result);
mux2 #(32) resmux (
    .d0(aluout), 
    .d1(readdata), 
    .s(memtoreg), 
    .y(result)
    );

//signext se(instr[15:0], signimm);
signext se (
    .a(instr[15:0]), 
    .y(signimm)
    );
// ALU wire
//mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
mux2 #(32) srcbmux (
    .d0(writedata), 
    .d1(signimm), 
    .s(alusrc), 
    .y(srcb)
    );

//alu alu(srca, srcb, alucontrol, aluout, zero);
alu alu (
    .scrA(srca), 
    .scrB(srcb), 
    .operation(alucontrol), 
    .ALUResult(aluout), 
    .zero(zero)
    );
endmodule	