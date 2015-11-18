module top(
	input wire clk, reset,
	output wire [31:0] writedata, dataadr,
	output wire memwrite);


wire [31:0] pc, instr, readdata;
// instantiate processor and memories

mips mips (
    .clk(clk), 
    .reset(reset), 
    .pc(pc), 
    .instr(instr), 
    .memwrite(memwrite), 
    .aluout(dataadr), 
    .writedata(writedata), 
    .readdata(readdata)
    );

mem_rom imem (
    .addr_r(pc[7:2]), 
    .data_r(instr)
    );

mem_ram dmem (
    .clk(clk), 
    .addr_rw(dataadr), 
    .we(memwrite), 
    .data_w(writedata), 
    .data_r(readdata)
    );




endmodule
