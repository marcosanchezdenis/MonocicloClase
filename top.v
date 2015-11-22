module top(
	input wire clk, reset,
	output wire [31:0] writedata, dataadr,
	output wire memwrite,
	output wire [7:0]led,
	input wire [3:0]slide,
	input wire bt1,
	input wire rx,
	output wire tx,
	output wire [7:0]lcd_db,
	output wire lcd_e,
	output wire lcd_rs,
	output wire lcd_rw
	);


wire [31:0] pc, instr, readdata;
wire [31:0]readdata_mem; // cable de selectorDevice a Memoria
wire [31:0]readdata_led;
wire [31:0]readdata_slide;
wire [31:0]readdata_bt;
wire [31:0]readdata_serial_in;
wire [31:0]readdata_serial_out;
wire [31:0]readdata_lcd;
wire [31:0]readdata_rotary;

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
 
wire [1:0]select;	 
wire we1,we2,we3,we4,we5,we6,we7,we8;
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


addressdecoder da (
    .address(dataadr), 
    .memwrite(memwrite), 
    .select(select), 
    .we1(we1), 
    .we2(we2), 
    .we3(we3), 
    .we4(we4),
	 .we5(we5), 
    .we6(we6), 
    .we7(we7), 
    .we8(we8)
	 
    );
mux4 deviceSelector (
    .a(readdata_mem), 
    .b(readdata_led), 
    .c(readdata_slide), 
    .d(readdata_bt), 
	 .e(readdata_serial_in), 
    .f(readdata_serial_out), 
    .g(readdata_lcd), 
    .h(readdata_rotary),
    .select(select), 
    .y(readdata)
    );
	 
LedDev LED (
    .clk(clk), 
    .reset(reset), 
    .we2(we2), 
    .d(writedata), 
    .q(readdata_led)
    );
//conectar dispositivo LED	 
assign led = readdata_led[7:0];

SlideDev SLIDE (
    .clk(clk), 
    .reset(reset), 
    .we3(we3), 
    .d(writedata), 
    .q(readdata_slide)
    );
//conectar dispositivo SLIDE
	 
BtDev bt (
    .clk(clk), 
    .reset(reset), 
	 .bt(bt1),
    .we4(we4), // .w4(w4 | bt1 )
    .d(writedata), //.q(writedata | (bt1 != readdata_bt ))
    .q(readdata_bt) 
);

// conectar dispositivo BT


SerialDev uart (
    .clk(clk), 
    .reset(reset), 
    .tx(tx), 
    .rx(rx), 
    .w5(we5), 
    .w6(we6), 
    .dE(writedata), 
    .qE(readdata_serial_in), 
    .qS(readdata_serial_out)
    );
	 

	 
 LCDDev lcd (
    .clk(clk), 
    .reset(reset), 
    .d(writedata), 
    .q(readdata_lcd), 
    .w7(we7), 
    .lcd_db(lcd_db), 
    .lcd_e(lcd_e), 
    .lcd_rs(lcd_rs), 
    .lcd_rw(lcd_rw)
    );







endmodule
