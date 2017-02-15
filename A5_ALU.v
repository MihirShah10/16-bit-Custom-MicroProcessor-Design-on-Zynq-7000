`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:24:28 10/27/2016 
// Design Name: 
// Module Name:    A5_ALU 
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
module A5_ALU(clk,read_a, read_b, opcode2,alu_result, carry,zero,temp_alu_result
    );

input clk;
input [15:0] read_a, read_b;
input [7:0] opcode2;


output reg [15:0] alu_result;
output reg carry, zero;

output reg [16:0] temp_alu_result;



always @(posedge clk)
begin

	begin
		case (opcode2)
				8'b01110001 : 
				begin
					
					alu_result=read_a + read_b;					
					temp_alu_result = read_a + read_b;
					if (temp_alu_result[16] == 1)
					begin
					carry = 1;
					zero = 0;
					end
					if (temp_alu_result[16] == 0)
					begin
					zero = 1;
					carry = 0;
					end
				
				end
				
				8'b01110010 : 
				begin
					alu_result = read_a & read_b;
								
					temp_alu_result = read_a & read_b;
					if (temp_alu_result[16] == 1)
					begin
					carry = 1;
					zero = 0;
					end
					if (temp_alu_result[16] == 0)
					begin
					zero = 1;
					carry = 0;
					end
				
				end
				
				8'b01110011 : 
				begin
					alu_result = 0;
										
					temp_alu_result = 0;
					if (temp_alu_result[16] == 1)
					begin
					carry = 1;
					zero = 0;
					end
					if (temp_alu_result[16] == 0)
					begin
					zero = 1;
					carry = 0;
					end
				end
				
				8'b01110100 : //CLB
				begin
					alu_result = 0;
					temp_alu_result = 0;
					if (temp_alu_result[16] == 1)
					begin
					carry = 1;
					zero = 0;
					end
					if (temp_alu_result[16] == 0)
					begin
					zero = 1;
					carry = 0;
					end
				end
				
				8'b01110101 : 
				begin
					alu_result = ~(read_a);
					temp_alu_result = 0;
					if (temp_alu_result[16] == 1)
					begin
					carry = 1;
					zero = 0;
					end
					if (temp_alu_result[16] == 0)
					begin
					zero = 1;
					carry = 0;
					end
				end
				
				8'b01110110 : 
				begin
					alu_result = 1'b1 + read_b;
					temp_alu_result = 0;
					if (temp_alu_result[16] == 1)
					begin
					carry = 1;
					zero = 0;
					end
					if (temp_alu_result[16] == 0)
					begin
					zero = 1;
					carry = 0;
					end
				end
				
				8'b01110111 : 
				begin
					alu_result = read_b - 1'b1;
					temp_alu_result = 0;
					if (temp_alu_result[16] == 1)
					begin
					carry = 1;
					zero = 0;
					end
					if (temp_alu_result[16] == 0)
					begin
					zero = 1;
					carry = 0;
					end
				end
				
				8'b01111000 : 
				begin
					alu_result = {read_a[15:1],1'b0} ;
					//ex_flag = 1;
				end
				
				8'b01111001 : 
				begin
					alu_result = {read_a[15:1],1'b0} ;
					//ex_flag = 1;
				end
				
				8'b01111100 : 
                begin
                    alu_result = {read_a[15:1],1'b1} ;
                    //ex_flag = 1;
                end
                
                8'b01111101 : 
                begin
                    alu_result = {read_a[15:1],1'b1} ;
                    //ex_flag = 1;
                end
				
				8'b01111010 : 
				begin
					alu_result = {read_a[15],read_a[14],1'b1,read_a[12:0]} ;
					//ex_flag = 1;
				end
				
				8'b01111011 : 
				begin
					alu_result = {read_a[15],read_a[14],1'b0,read_a[12:0]} ;
					//ex_flag = 1;
				end
		endcase
		end
		end
endmodule
