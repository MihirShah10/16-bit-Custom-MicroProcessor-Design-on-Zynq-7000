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
module A5_Data_Memory(data_in, data_write_enable, address, clk, data_out//,mem
    );
	 
	 
	 input [15:0] data_in;
	 input data_write_enable;
	 input [11:0] address;
	 input clk;
	 output reg [15:0] data_out;
	 //output reg [15:0] mem;
	 
	 reg [15:0] memory [4095:0];
initial
begin
 memory[1]   = 16'b0000000000000010;
 memory[8]   = 16'b0000000000000001;
 //memory[512] = 16'b0000000000000001;
end
	 
	 always @(posedge clk)
	 begin
			if (data_write_enable)
			begin
					memory[address] = data_in;
					//mem = data_in ;
					//mem=memory[address];
					
			end
	 end
	  always @(negedge clk)
	  begin
			if(~data_write_enable)
			begin
			data_out = memory[address] ;
			//mem=memory[2];
				//	data_out = data_in;		
			end
	 end
	 
//assign data_out = memory[address];
	 
endmodule
