`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:17:33 10/28/2016 
// Design Name: 
// Module Name:    ALU_DATA_MEM_MUX 
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
module ALU_DATA_MEM_MUX(clk,select, data_mem_in,alu_in,mux_out,stack_out
    );

input clk;
input [15:0]data_mem_in;
input [15:0]alu_in;
input [15:0]stack_out;
input [1:0] select;

output reg [15:0]mux_out;


always @(posedge clk)

begin
	case(select)
	
	2'b00: mux_out=data_mem_in;
	2'b11: mux_out=alu_in;
	2'b01: mux_out=stack_out;
			
	endcase
end

endmodule
