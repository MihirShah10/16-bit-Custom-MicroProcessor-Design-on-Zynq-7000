`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:37 10/30/2016 
// Design Name: 
// Module Name:    A5_DATA_ALU_DEMUX 
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
module A5_DATA_ALU_DEMUX(clk, data_addr, opcode2, select_demux, address, alu_opcode2
    );

input clk, select_demux;
input [11:0] data_addr;
input [7:0] opcode2;

output reg [11:0] address;
output reg [7:0] alu_opcode2;

always @(posedge clk)
begin
		if (select_demux)
		begin
				address = data_addr; 
		end
		
		else
		begin
				alu_opcode2 = opcode2;
		end
end

endmodule
