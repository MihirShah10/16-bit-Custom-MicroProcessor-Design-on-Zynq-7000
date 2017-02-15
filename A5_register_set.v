`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:24 10/23/2016 
// Design Name: 
// Module Name:    A5_register_set 
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
module A5_register_set(register_a,register_b,register_c,register_z,clk, reg_1,reg_2,reg_wr,write_data,write_enable,read_a,read_b,data_register_set,zero_carry_ien,temp_alu_result
    );
output reg[15:0]register_a;
output reg[15:0]register_b;
output reg[15:0]register_c;
output reg[15:0]register_z;

input [16:0] temp_alu_result;
input clk,write_enable;
input [2:0] reg_1,reg_2,reg_wr;
input [15:0] write_data;
output reg [15:0] read_a, read_b;
//addr[reg A]=0,addr[reg B]=1
reg [15:0] register_set [4:0];
output reg[15:0]data_register_set;
output reg[15:0] zero_carry_ien;
initial 
	begin
		
		register_set[0]=16'b0000000000000001; //a
		register_set[1]=16'b0000000000000111; //b
		register_set[2]=16'b0000000000000001; //c
		register_set[3]=16'b0000000000000001; //z

		//register_set[2]=16'b1110000000000000;
		
	end
always @(posedge clk)
begin
		zero_carry_ien = register_set[2];
		data_register_set=write_data;

		if(write_enable)
		begin
				register_set[reg_wr] = write_data;
				register_a=register_set[0];
				register_b=register_set[1];
				register_c=register_set[2];
                register_z=register_set[3];
				
				if(temp_alu_result > 16'b1111111111111111)
					begin
					zero_carry_ien = 16'b0100000000000000;
					end
					
					else if(temp_alu_result == 17'b00000000000000000)
					zero_carry_ien = 16'b1000000000000000;
					
		end
		
		else
		begin
				read_a = register_set[reg_1];
				read_b = register_set[reg_2];
		end
end
endmodule
