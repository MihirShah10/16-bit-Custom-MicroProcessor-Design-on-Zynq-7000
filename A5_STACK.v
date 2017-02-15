`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:13:36 11/17/2016 
// Design Name: 
// Module Name:    A5_STACK 
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
module A5_STACK(clk, stack_in, reg_mux_in, stack_en,sp_out, stack_pc_en, pc_in
    );

input clk,stack_en;
input [15:0] stack_in;
input stack_pc_en;

output reg [15:0] reg_mux_in;
output reg [15:0] pc_in;
reg [15:0] stack [19:0];
reg [11:0] sp;
output reg [11:0]sp_out;

initial
begin
	sp = 12'b000000010011;
end

always @(posedge clk)
begin
	if (stack_en && (stack_pc_en ==0))
	begin
		stack[sp] = stack_in;
		sp = sp - 1'b1;
		sp_out=sp;
	end
	
	else if(~stack_en && (stack_pc_en ==0))
	begin
		sp = sp + 1'b1;
		sp_out=sp;
		reg_mux_in = stack[sp]; 
	end
	
	else if(~stack_en && (stack_pc_en ==1))
	begin
		sp = sp + 1'b1;
		sp_out=sp;
		pc_in = stack[sp]; 
	end
	
	
end
endmodule
