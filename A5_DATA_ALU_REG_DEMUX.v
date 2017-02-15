`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:34:55 10/30/2016 
// Design Name: 
// Module Name:    A5_DATA_ALU_REG_DEMUX 
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
module A5_DATA_ALU_REG_DEMUX(clk, data_out, select2, data_in, read_a,stack_push_a
    );

input clk;
input [1:0] select2;
input [15:0] data_out;
output  reg [15:0] data_in;
output reg [15:0] read_a;
output reg [15:0] stack_push_a;

always @(posedge clk)
begin
	case(select2)
			2'b11 : begin 
							data_in = data_out;
						 end
			2'b00: begin
							read_a = data_out;
					 end
			2'b01: begin
							stack_push_a=data_out;
					 end
	endcase
end
endmodule
