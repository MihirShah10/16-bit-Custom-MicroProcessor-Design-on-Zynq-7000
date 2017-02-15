//This demo was originally written for NEXYS 4 DDR by Girish Deshpande
//Aug-2016
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:51:25 09/06/2016 
// Design Name: 
// Module Name:    MAIN 
// Project Name: 
// Target Devices: Zybo
// Tool versions:  Vivado 2016.2
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//############################### Sample VGA character display demo##########################################//
//############################################################################################################


module MAIN
(
CLK,
RST,
PC_LIMIT,
REG_SIGNAL,
LED_STATUS,
VGA_HSYNCH,
VGA_VSYNCH,
R0,R1,R2,R3,
G0,G1,G2,G3,
B0,B1, B2,B3, ps2_data,ps2_clk
);

input REG_SIGNAL;
input ps2_data, ps2_clk;
input				CLK;				// 100MHz LVTTL SYSTEM CLOCK
output 			VGA_HSYNCH;					// horizontal sync for the VGA output connector
output			VGA_VSYNCH;					// vertical sync for the VGA output connector
output R0,R1,R2,R3,G0,G1,G2,G3,B0,B1,B2,B3;
wire				system_clock_buffered;	// buffered SYSTEM CLOCK
wire				pixel_clock;				// generated from SYSTEM CLOCK
wire				reset;						// reset asserted when DCMs are NOT LOCKED
wire				vga_red_data;				// red video data
wire				vga_green_data;			// green video data
wire				vga_blue_data;				// blue video data

// internal video timing signals
wire 				h_synch;						// horizontal synch for VGA connector
wire 				v_synch;						// vertical synch for VGA connector
wire 				blank;						// composite blanking
wire [10:0]		pixel_count;				// bit mapped pixel position within the line
wire [9:0]		line_count;					// bit mapped line number in a frame lines within the frame
wire [2:0]		subchar_pixel;				// pixel position within the character
wire [2:0]		subchar_line;				// identifies the line number within a character block
wire [6:0]		char_column;				// character number on the current line
wire [6:0]		char_line;					// line number on the screen
wire [15:0]REGISTER_A;
wire [15:0]REGISTER_B;

input [2:0]PC_LIMIT;
input RST;
//output reg EX_FLAG;
output LED_STATUS;

Top_Module Top_Module(RST,PC_LIMIT,CLK,EX_FLAG,LED_STATUS,REGISTER_A,REGISTER_B,PC_COUNTER);


// instantiate the character generator
CHAR_DISPLAY CHAR_DISPLAY
(
CLK,
REG_SIGNAL,
char_column,
char_line,
subchar_line,
subchar_pixel,
pixel_clock,
reset,
vga_red_data,
vga_green_data,
vga_blue_data,
ps2_data,
ps2_clk,
REGISTER_A,
REGISTER_B,
PC_COUNTER
);


//Instantiating Clock Generator for VGA Interface
CLOCK_GEN CLOCK_GEN
(
CLK,
pixel_clock
);

// instantiate the video timing generator
SVGA_TIMING_GENERATION SVGA_TIMING_GENERATION
(
pixel_clock,
reset,
h_synch,
v_synch,
blank,
pixel_count,
line_count,
subchar_pixel,
subchar_line,
char_column,
char_line
);

// instantiate the video output mux
VIDEO_OUT VIDEO_OUT
(
pixel_clock,
reset,
vga_red_data,
vga_green_data,
vga_blue_data,
h_synch,
v_synch,
blank,
VGA_HSYNCH,
VGA_VSYNCH,
R0,
R1,
R2,
R3,
G0,
G1,
G2,
G3,
B0,
B1,
B2,
B3
);

endmodule // MAIN