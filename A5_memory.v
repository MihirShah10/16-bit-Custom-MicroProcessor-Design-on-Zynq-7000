`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:24:55 10/21/2016 
// Design Name: 
// Module Name:    A5_memory 
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
module A5_memory(data_in, write_enable, address, clk, data_out//,mem
    );
	 
	 
	 input [15:0] data_in;
	 input write_enable;
	 input [11:0] address;
	 input clk;
	 output reg [15:0] data_out;
	// output reg [15:0] mem;
	 
	 reg [15:0] memory [4095:0];
initial
begin 

memory[65] = 16'b0111110011111111; // SC
//--memory[2] = 16'b0111110111111111; // SZ
//memory[8] = 16'b0100000000001111; //JMP
//memory[1] = 16'b1100000000001110; //POPA
memory[15] = 16'b0111101011111111; //ION
//memory[4] = 16'b0111001111111111; //CLRA
memory[67] = 16'b0111000111111111; // ADD: A=A+B
memory[3] = 16'b0010001000000000; // STA
memory[14] = 16'b0111000111111111; // ADD: A=A+B 
//memory[66]= 16'b0111001011111111; // AND: A=A & B
memory[66] = 16'b0111001111111111; // CLA: A=0
//memory[64] = 16'b0111010011111111; //CLB: B=0
//memory[16] = 16'b0111010111111111; //CMB: B=~B
memory[13] = 16'b0111011011111111; //INCB: B=B+1
memory[16] = 16'b0111011111111111; //DECB: B=B-1
memory[64] = 16'b0111100011111111; //CLC: C=0
//--memory[0] = 16'b0111100111111111; //CLZ: Z=0
//--memory[5] = 16'b0111101011111111; //ION: INTERRUPT ENABLE (1)
memory[68] = 16'b0111101111111111; //IOF: INTERRUPT DISABLE (0)

//memory[0] = 16'b0111101111111111; //IOF: INTERRUPT DISABLE (0)
memory[6] = 16'b0111010011111111; //CLB: B=0
memory[5] = 16'b0111001111111111; //CLA: A=0
memory[7] = 16'b0001001000000000; //LDB: 0x0104 //B<=0x01
memory[8] = 16'b0000000000010000; //LDA: 0x0102 //A<=0x03
//--memory[6] = 16'b0111010111111111; //CMB: B=~B
//memory[6] = 16'b0111011011111111; //INCB: B=B+1
memory[11] = 16'b0111000111111111; // ADD: A=A+B
//memory[2]= 16'b1000000000000111; //JSR
//memory[8] = 16'b0001000100000011; //LDB: 0x0103 
memory[69] = 16'b1110000000001110; //RET
memory[12] = 16'b1100000000001110; //POPA
memory[9] = 16'b0111001011111111; // AND: A=A & B
memory[10]= 16'b1010000000001110; //PUSHA
memory[2] = 16'b0111000111111111; //ADD A=A+B
memory[4] = 16'b0011000000010000; // STB: 0x0500
memory[0] = 16'b0000000000000001; //LDA: 0x0500
memory[1] = 16'b0001000000001000; //LDB: 0x0500
/*

memory[0] = 16'b0111101011111111; //ION
memory[64] = 16'b0111100011111111; //CLC: C=0
memory[65] = 16'b0111110011111111; // SC
memory[66] = 16'b0111001111111111; // CLA: A=0
memory[67] = 16'b0111000111111111; // ADD: A=A+B
memory[68] = 16'b0111101111111111; //IOF: INTERRUPT DISABLE (0)
memory[69] = 16'b1110000000001110; //RET
memory[1] = 16'b0000000000000001; //LDA: 0x0500
memory[2] = 16'b0001000000001000; //LDB: 0x0500
memory[3] = 16'b0111001011111111; // AND: A=A & B
*/
/*

//memory[0] = 16'b0111100111111111; //CLZ: Z=0
memory[0] = 16'b0000000000000001; //LDA: 0x0500
memory[1] = 16'b0001000000001000; //LDB: 0x0500
memory[2] = 16'b0111000111111111; //ADD A=A+B
memory[3] = 16'b0111110111111111; // SZ
memory[4] = 16'b0111001011111111; // AND: A=A & B
memory[5] = 16'b0111010011111111; //CLB: B=0
memory[6] = 16'b0111000111111111; //ADD A=A+B
memory[7] = 16'b1010000000001110; //PUSHA
*/

end

	 always @(posedge clk)
	 begin
			if (write_enable)
			begin
					memory[address] = data_in;
					//mem = data_in ;
					//mem=memory[address];
					
			end
	 end
	  always @(negedge clk)
	  begin
			if(~write_enable)
			begin
			data_out = memory[address] ;
			//mem=memory[0];
				//	data_out = data_in;		
			end
	 end
	 
//assign data_out = memory[address];
	 
endmodule
