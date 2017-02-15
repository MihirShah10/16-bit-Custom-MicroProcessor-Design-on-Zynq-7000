module CHAR_DISPLAY
(CLK,
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

input ps2_data, ps2_clk;

input [15:0]REGISTER_A;
input [15:0]REGISTER_B;
input [4:0]PC_COUNTER;

input REG_SIGNAL;
input [6:0] char_column; // character number on the current line
input [6:0] char_line; // line number on the screen
input [2:0] subchar_line; // the line number within a character block 0-8
input [2:0] subchar_pixel; // the pixel number within a character block 0-8
input pixel_clock;
input reset, CLK;
output vga_red_data;
output vga_green_data;
output vga_blue_data;

wire [15:0] char ;
reg [0:8*14-1] bscii;
reg [0:8*14-1] ascii;
reg [0:8*14-1] cscii;
reg [7:0] mii_a;
reg [7:0] mii_a_prefix;
reg [7:0] mii_b;
reg [7:0] mii_b_prefix;
reg [7:0] mii_pc;
reg [7:0] mii_pc_prefix;
///   IMP:  block below will allow you to print A-Z you may want to print numbers or special characters depending
///         on application project. 
always@(posedge CLK) begin
    /*case ({char})
{16'hF01C}:ascii<=8'h41;
{16'hF032}:ascii<=8'h42;
{16'hF021}:ascii<=8'h43;
        {16'hF023}:ascii<=8'h44;
        {16'hF024}:ascii<=8'h45;
        {16'hF02B}:ascii<=8'h46;
        {16'hF034}:ascii<=8'h47;
        {16'hF033}:ascii<=8'h48;
        {16'hF043}:ascii<=8'h49;
        {16'hF03B}:ascii<=8'h4A;
        {16'hF042}:ascii<=8'h4B;
        {16'hF04B}:ascii<=8'h4C;
        {16'hF03A}:ascii<=8'h4D;
        {16'hF031}:ascii<=8'h4E;
        {16'hF044}:ascii<=8'h4F;
        {16'hF04D}:ascii<=8'h50;
        {16'hF015}:ascii<=8'h51;
        {16'hF02D}:ascii<=8'h52;
        {16'hF01B}:ascii<=8'h53;
        {16'hF02C}:ascii<=8'h54;
        {16'hF03C}:ascii<=8'h55;
        {16'hF02A}:ascii<=8'h56;
        {16'hF01D}:ascii<=8'h57;
        {16'hF022}:ascii<=8'h58;
        {16'hF035}:ascii<=8'h59;
        {16'hF01A}:ascii<=8'h5A;
default: ascii <= 8'h20;
    endcase
end 
end */
  
  
   /*  a = write_data[3:0];
    b = write_data[7:4];
    c = write_data[11:8];
    d = write_data[15:12];
    
    
     e = ALU_RESULT_OUT[3:0];
     //f = IFF;
       f = PC_ADDRESS[7:4];
      // g = PC_ADDRESS[11:8];
      g = {1'b0,PC_LIMIT};  */
    
 if (REG_SIGNAL)     begin
     case(REGISTER_A)
     16'b0000000000000000 : begin mii_a<=8'h30; mii_a_prefix<=8'h30; end
     16'b0000000000000001 : begin mii_a<=8'h31; mii_a_prefix<=8'h30; end
     16'b0000000000000010 : begin mii_a<=8'h32; mii_a_prefix<=8'h30; end
     16'b0000000000000011 : begin mii_a<=8'h33; mii_a_prefix<=8'h30; end
     16'b0000000000000100 : begin mii_a<=8'h34; mii_a_prefix<=8'h30; end
     16'b0000000000000101 : begin mii_a<=8'h35; mii_a_prefix<=8'h30; end
     16'b0000000000000110 : begin mii_a<=8'h36; mii_a_prefix<=8'h30; end
     16'b0000000000000111 : begin mii_a<=8'h37; mii_a_prefix<=8'h30; end
     16'b0000000000001000 : begin mii_a<=8'h38; mii_a_prefix<=8'h30; end
     16'b0000000000001001 : begin mii_a<=8'h39; mii_a_prefix<=8'h30; end
     16'b0000000000001010 : begin mii_a<=8'h30; mii_a_prefix<=8'h31; end
     
     16'b0000000000001011 : begin mii_a<=8'h31; mii_a_prefix<=8'h31; end
     16'b0000000000001100 : begin mii_a<=8'h32; mii_a_prefix<=8'h31; end
     16'b0000000000001101 : begin mii_a<=8'h33; mii_a_prefix<=8'h31; end
     16'b0000000000001110 : begin mii_a<=8'h34; mii_a_prefix<=8'h31; end
     16'b0000000000001111 : begin mii_a<=8'h35; mii_a_prefix<=8'h31; end
     16'b0000000000010000 : begin mii_a<=8'h36; mii_a_prefix<=8'h31; end
     16'b0000000000010001 : begin mii_a<=8'h37; mii_a_prefix<=8'h31; end
     16'b0000000000010010 : begin mii_a<=8'h38; mii_a_prefix<=8'h31; end
     16'b0000000000010011 : begin mii_a<=8'h39; mii_a_prefix<=8'h31; end
     16'b0000000000010100 : begin mii_a<=8'h30; mii_a_prefix<=8'h32; end
     endcase
     
     case(REGISTER_B)
     16'b0000000000000000 : begin mii_b<=8'h30; mii_b_prefix<=8'h30; end
     16'b0000000000000001 : begin mii_b<=8'h31; mii_b_prefix<=8'h30; end
     16'b0000000000000010 : begin mii_b<=8'h32; mii_b_prefix<=8'h30; end
     16'b0000000000000011 : begin mii_b<=8'h33; mii_b_prefix<=8'h30; end
     16'b0000000000000100 : begin mii_b<=8'h34; mii_b_prefix<=8'h30; end
     16'b0000000000000101 : begin mii_b<=8'h35; mii_b_prefix<=8'h30; end
     16'b0000000000000110 : begin mii_b<=8'h36; mii_b_prefix<=8'h30; end
     16'b0000000000000111 : begin mii_b<=8'h37; mii_b_prefix<=8'h30; end
     16'b0000000000001000 : begin mii_b<=8'h38; mii_b_prefix<=8'h30; end
     16'b0000000000001001 : begin mii_b<=8'h39; mii_b_prefix<=8'h30; end
     16'b0000000000001010 : begin mii_b<=8'h30; mii_b_prefix<=8'h31; end
     
     16'b0000000000001011 : begin mii_b<=8'h31; mii_b_prefix<=8'h31; end
     16'b0000000000001100 : begin mii_b<=8'h32; mii_b_prefix<=8'h31; end
     16'b0000000000001101 : begin mii_b<=8'h33; mii_b_prefix<=8'h31; end
     16'b0000000000001110 : begin mii_b<=8'h34; mii_b_prefix<=8'h31; end
     16'b0000000000001111 : begin mii_b<=8'h35; mii_b_prefix<=8'h31; end
     16'b0000000000010000 : begin mii_b<=8'h36; mii_b_prefix<=8'h31; end
     16'b0000000000010001 : begin mii_b<=8'h37; mii_b_prefix<=8'h31; end
     16'b0000000000010010 : begin mii_b<=8'h38; mii_b_prefix<=8'h31; end
     16'b0000000000010011 : begin mii_b<=8'h39; mii_b_prefix<=8'h31; end
     16'b0000000000010100 : begin mii_b<=8'h30; mii_b_prefix<=8'h32; end
     endcase
     
     case(PC_COUNTER)
     5'b00000 : begin mii_pc<=8'h30; mii_pc_prefix<=8'h30; end
     5'b00001 : begin mii_pc<=8'h31; mii_pc_prefix<=8'h30; end
     5'b00010 : begin mii_pc<=8'h32; mii_pc_prefix<=8'h30; end
     5'b00011 : begin mii_pc<=8'h33; mii_pc_prefix<=8'h30; end
     5'b00100 : begin mii_pc<=8'h34; mii_pc_prefix<=8'h30; end
     5'b00101 : begin mii_pc<=8'h35; mii_pc_prefix<=8'h30; end
     5'b00110 : begin mii_pc<=8'h36; mii_pc_prefix<=8'h30; end
     5'b00111 : begin mii_pc<=8'h37; mii_pc_prefix<=8'h30; end
     5'b01000 : begin mii_pc<=8'h38; mii_pc_prefix<=8'h30; end
     5'b01001 : begin mii_pc<=8'h39; mii_pc_prefix<=8'h30; end
     5'b01010 : begin mii_pc<=8'h30; mii_pc_prefix<=8'h31; end
     
     5'b01011 : begin mii_pc<=8'h31; mii_pc_prefix<=8'h31; end
     5'b01100 : begin mii_pc<=8'h32; mii_pc_prefix<=8'h31; end
     5'b01101 : begin mii_pc<=8'h33; mii_pc_prefix<=8'h31; end
     5'b01110 : begin mii_pc<=8'h34; mii_pc_prefix<=8'h31; end
     5'b01111 : begin mii_pc<=8'h35; mii_pc_prefix<=8'h31; end
     5'b10000 : begin mii_pc<=8'h36; mii_pc_prefix<=8'h31; end
     5'b10001 : begin mii_pc<=8'h37; mii_pc_prefix<=8'h31; end
     5'b10010 : begin mii_pc<=8'h38; mii_pc_prefix<=8'h31; end
     5'b10011 : begin mii_pc<=8'h39; mii_pc_prefix<=8'h31; end
     5'b10100 : begin mii_pc<=8'h30; mii_pc_prefix<=8'h32; end
     
     5'b10101 : begin mii_pc<=8'h31; mii_pc_prefix<=8'h32; end
     5'b10110 : begin mii_pc<=8'h32; mii_pc_prefix<=8'h32; end
     5'b10111 : begin mii_pc<=8'h33; mii_pc_prefix<=8'h32; end
     5'b11000 : begin mii_pc<=8'h34; mii_pc_prefix<=8'h32; end
     5'b11001 : begin mii_pc<=8'h35; mii_pc_prefix<=8'h32; end
     5'b11010 : begin mii_pc<=8'h36; mii_pc_prefix<=8'h32; end
     5'b11011 : begin mii_pc<=8'h37; mii_pc_prefix<=8'h32; end
     5'b11100 : begin mii_pc<=8'h38; mii_pc_prefix<=8'h32; end
     5'b11101 : begin mii_pc<=8'h39; mii_pc_prefix<=8'h32; end
     5'b11110 : begin mii_pc<=8'h30; mii_pc_prefix<=8'h33; end
     
     5'b11111 : begin mii_pc<=8'h31; mii_pc_prefix<=8'h33; end
          
     endcase
     
             ascii <=  {"Register A: ",mii_a_prefix,mii_a} ;
             bscii <= {"Register B: ",mii_b_prefix,mii_b};
             cscii <= {"PC_COUNTER: ",mii_pc_prefix,mii_pc};

        //end*/
   /*else //if (PC_LIMIT < 3'b010)  
      begin
         ascii <= "            wait"  ;
         bscii <= "              wait"  ;
         //cscii <= "             wait"  ;
          //dscii <= "             wait" ;        
     
      end  
   */   
     /* else if (PC_LIMIT >3'b010)
      begin
               ascii <= "            wrong"  ;
               bscii <= "              wrong"  ;
               cscii <= "             wrong"  ;
                dscii<= "             wrong" ;        
           
      end */
 // $display("The value of ascii is: %b", ascii) ;
end
end 
//Instantiating Keyboard Module
keyboard keyb(CLK, ps2_clk, ps2_data, char);


// Note: all labels must match their defined length--shorter labels will be padded with solid blocks,
// and longer labels will be truncated

// 48 character label for the example text


wire [13:0] char_addr = {char_line[6:0], char_column[6:0]};
wire write_enable; // character memory is written to on a clock rise when high
wire pixel_on; // high => output foreground color, low => output background color
reg [7:0] char_write_data; // the data that will be written to character memory at the clock rise
integer i; // iterator

// always enable writing to character RAM
assign write_enable = 1;

// write the appropriate character data to memory
always @ (char_line or char_column) begin
// insert a space by default
char_write_data <= 8'h20;
// write the example text to the first line
//if (char_line == 7'h00) begin 
// write the example text starting at the first column
if (char_line == 7'h00) begin 
                // write the example text starting at the first column
                for (i = 0; i < 14; i = i + 1) begin
                    if (char_column == i)
                        char_write_data <= ascii[i*8+:8];
                end
            end
if (char_line == 7'h02) begin 
            // write the example text starting at the first column
            for (i = 0; i < 14; i = i + 1) begin
                  if (char_column == i)
                    //if (i <19)
                    //char_write_data <= 8'h20;//Writing first 15 spaces before printing keyboard value. You may want to change it.
                    //else
                    char_write_data <= bscii[i*8+:8];//Printing Ascii 
                    //char_write_data <= ascii[i*8+:8];
            end
        end

/*if (char_line == 7'h04) begin 
            // write the example text starting at the first column
            for (i = 0; i < 14; i = i + 1) begin
                  if (char_column == i)
                    //if (i <19)
                    //char_write_data <= 8'h20;//Writing first 15 spaces before printing keyboard value. You may want to change it.
                    //else
                    char_write_data <= cscii[i*8+:8];//Printing Ascii 
                    //char_write_data <= ascii[i*8+:8];
            end
        end
*/                       
end
reg background_red; // the red component of the background color
reg background_green; // the green component of the background color
reg background_blue; // the blue component of the background color
reg foreground_red; // the red component of the foreground color
reg foreground_green; // the green component of the foreground color
reg foreground_blue; // the blue component of the foreground color

// use the result of the character generator module to choose between the foreground and background color
assign vga_red_data = (pixel_on) ? foreground_red : background_red;
assign vga_green_data = (pixel_on) ? foreground_green : background_green;
assign vga_blue_data = (pixel_on) ? foreground_blue : background_blue;

// select the appropriate character colors
always @ (char_line or char_column) begin
// always use a black background with white text
background_red <= 1'b0;
background_green <= 1'b0;
background_blue <= 1'b0;
foreground_red <= 1'b1;
foreground_green <= 1'b1;
foreground_blue <= 1'b1;
end

// the character generator block includes the character RAM
// and the character generator ROM
CHAR_GEN CHAR_GEN
(
reset, // reset signal
char_addr, // write address
char_write_data, // write data
write_enable, // write enable
pixel_clock, // write clock
char_addr, // read address of current character
subchar_line, // current line of pixels within current character
subchar_pixel, // current column of pixels withing current character
pixel_clock, // read clock
pixel_on // read data
);

endmodule //CHAR_DISPLAY