`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:08:06 11/19/2016 
// Design Name: 
// Module Name:    A5_STACK_MUX 
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
module A5_STACK_MUX(clk, stack_pc_addr, stack_reg, stack_out, stack_mux_sel
    );
input clk;
input [1:0]stack_mux_sel;

input [11:0] stack_pc_addr;
input [15:0] stack_reg;

output reg [15:0] stack_out;

always @(posedge clk)
begin
	if(stack_mux_sel==2'b11)
	begin
	stack_out=stack_reg;
	end
	else if(stack_mux_sel==2'b00)
	begin
	stack_out={4'bxxxx,stack_pc_addr};
	end
end
endmodule
