module top(
	input wire clk, reset,
	output wire [31:0] writedata, dataadr,
	output wire memwrite,
	output wire [7:0]led,
	input wire [3:0]slide,
	input wire bt1
	);


wire [31:0] pc, instr, readdata;
wire [31:0]readdata_mem; // cable de selectorDevice a Memoria
wire [31:0]readdata_led;
wire [31:0]readdata_slide;
wire [31:0]readdata_bt;

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
    .we(we1), 
    .data_w(writedata), 
    .data_r(readdata_mem)
    );
	 
//LEDs de 8bit, 
//Slide Switch de 4bit,
// 1 Push Button	 
 
wire [1:0]select;	 
wire we1,we2,we3,we4;

addressdecoder da (
    .address(dataadr), 
    .memwrite(memwrite), 
    .select(select), 
    .we1(we1), 
    .we2(we2), 
    .we3(we3), 
    .we4(we4)
    );
mux4 deviceSelector (
    .a(readdata_mem), 
    .b(readdata_led), 
    .c(readdata_slide), 
    .d(readdata_bt), 
    .select(select), 
    .y(readdata)
    );
	 
LedDev led (
    .clk(clk), 
    .reset(reset), 
    .we2(we2), 
    .d(writedata), 
    .q(readdata_led)
    );
//conectar dispositivo LED	 


SlideDev slide (
    .clk(clk), 
    .reset(reset), 
    .w3(w3), 
    .d(writedata), 
    .q(readdata_slide)
    );
//conectar dispositivo SLIDE
	 
BtDev bt (
    .clk(clk), 
    .reset(reset), 
    .w4(w4), // .w4(w4 | bt1 )
    .d(writedata), //.q(writedata | (bt1 != readdata_bt ))
    .q(readdata_bt) 
);

// conectar dispositivo BT


	


	 
 









endmodule
