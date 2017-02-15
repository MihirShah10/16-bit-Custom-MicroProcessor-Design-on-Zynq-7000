`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:52:07 10/23/2016 
// Design Name: 
// Module Name:    A5_INST_DECODE 
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
//`include"/home/eng/a/avb150230/Assignment5_Reconfig/definition.v"

module A5_INST_DECODE(zero_carry_ien,instruction_reg,clk,operand1,operand2,destination,data_addr,
opcode2, decode_flag,select,select2,select_demux,addr,opcode1,jmp_addr,stack_mux_sel,stack_pc_en, zc_flag, IFF,
interrupt_counter,ex_flag
 );

input [15:0] zero_carry_ien;
input [15:0]instruction_reg;
input clk;
output reg IFF;
input [2:0] interrupt_counter;
input ex_flag;

output reg[2:0]operand1;
output reg[2:0]operand2;
output reg [2:0] destination;
output reg [11:0] data_addr;
output reg decode_flag;
output reg select_demux;
output reg [1:0] select2;
output reg [1:0] select;
output reg [1:0] stack_mux_sel;

output reg [11:0]jmp_addr;
//reg [3:0]opcode1;
output reg [7:0]opcode2;
//reg [11:0]addr;

output reg [11:0]addr;
output reg [3:0]opcode1;

output reg stack_pc_en;
output reg zc_flag;
//output reg IFF;

always @(posedge clk)
begin
opcode1 = instruction_reg[15:12];
opcode2 = instruction_reg[15:8];

addr = instruction_reg[7:0];
	if(addr < 8'b11111111)
	begin
		zc_flag = 0;
		case(opcode1)
			4'b0000 : begin
							decode_flag = 1;
							select=0;  
							select2=2'b11; //data_input to data memory
							select_demux = 1; //data address
							stack_mux_sel=2'bxx; //stack operation does not matter
							stack_pc_en=1'bx;
							destination = 3'b000 ;
							IFF=1'b0;
							data_addr = instruction_reg[11:0];
						 end

			4'b0001 : begin
							decode_flag = 1;
							select=0;
							select2=2'b11;
							select_demux = 1;
							stack_mux_sel=2'bxx;
							stack_pc_en=1'bx;
							destination = 3'b001 ;
							IFF=1'b0;
							data_addr = instruction_reg[11:0];
						 end
						 
			4'b0010 : begin
							decode_flag = 1;
							select=0;
							select2=2'b11;
							select_demux = 1;
							stack_mux_sel=2'bxx;
							stack_pc_en=1'bx;
							operand1 = 3'b000;
							IFF=1'b0;
							data_addr = instruction_reg[11:0];
	    				 end     
						 
			4'b0011 : begin
							decode_flag = 1;
							select=0;
							select2=2'b11;
							select_demux = 1;
							stack_mux_sel=2'bxx;
							stack_pc_en=1'bx;
							operand1 = 3'b001;
							IFF=1'b0;
						   data_addr = instruction_reg[11:0];
						 end
						 
			4'b1010 : begin //PUSHA
							select2=2'b01;
							select=2'bxx;
							stack_mux_sel=2'b11;
							stack_pc_en=1'bx;
							operand1 = 3'b000;
							IFF=1'b0;
						   //data_addr = instruction_reg[11:0];
						 end
						 
						 
			4'b1100 : begin //POPA
							select=2'b01;
							select2=2'bxx;
							stack_mux_sel=2'bxx;
							destination = 3'b000;
							stack_pc_en=0;
							IFF=1'b0;
						   //data_addr = instruction_reg[11:0];
						 end
						 
			4'b0100 : begin //JMP
							stack_mux_sel=2'bxx;
							stack_pc_en=1'bx;
							jmp_addr=instruction_reg[11:0];
							IFF=1'b0;
						   //data_addr = instruction_reg[11:0];
						 end
						 
			4'b1000 : begin //JSR
							stack_mux_sel=2'b00;
							jmp_addr=instruction_reg[11:0];
							stack_pc_en=1'b0;
							IFF=1'b0;
						   //data_addr = instruction_reg[11:0];
						 end
						 
			4'b1110 : begin //RET
						    //stack_pc_en=1'b1;
							IFF=1'b0;
						   //data_addr = instruction_reg[11:0];
						 end
						 
            
		endcase
	end


	else if (addr == 8'b11111111)
	begin
			decode_flag = 0;
			select=2'b11;
		   select2=2'b00;
		   select_demux = 0;
			stack_mux_sel=2'bxx;
			
			case (opcode2)
					8'b01110001 : //add
					begin
						operand1 = 3'b000;
						operand2 = 3'b001;
                        destination = 3'b000;
						zc_flag = 0;
				        IFF=1'b0;
               end
					
					8'b01110010 : //and
					begin
						operand1 = 3'b000;
						operand2 = 3'b001;
                        destination = 3'b000;
						zc_flag = 0;
						IFF=1'b0;
               end
					
					8'b01110011 : //cla
					begin
						operand1 = 3'b000;
                        destination = 3'b000;
						zc_flag = 0;
						IFF=1'b0;
               end
					
					8'b01110100 ://CLB
					begin
						operand2 = 3'b001;
                        destination = 3'b001;
						zc_flag = 0;
						IFF=1'b0;
					end
					
					8'b01110101 : //CMB
					begin
						operand2 = 3'b001;
                        destination = 3'b001;
						zc_flag = 0;
						IFF=1'b0;
               end
					
					8'b01110110 : //INCB
					begin
						operand2 = 3'b001;
                        destination = 3'b001;
                        IFF=1'b0;
						zc_flag = 0;
               end
					
					8'b01110111 ://DECB
					begin
						operand2 = 3'b001;
                        destination = 3'b001;
						zc_flag = 0;
						IFF=1'b0;
               end
					
					8'b01111000 : //clc
					begin
						operand1 = 3'b010;
                        destination = 3'b010;
						zc_flag = 0;
						IFF=1'b0;
               end
					
					8'b01111001 : //clz
					begin
						operand1 = 3'b011;
                        destination = 3'b011;
						zc_flag = 0;
						IFF=1'b0;
               end
					
					8'b01111010 : //ion
					begin
						//operand1 = 3'b011;
                        //destination = 3'b011;
                        IFF=1'b1;
						//IFF=1;
               end
					
					8'b01111011 : //iof
					begin
						//operand1 = 3'b101;
                        //destination = 3'b101;
						//zc_flag = 0;
						IFF=1'b0;
               end
					
					8'b01111101 ://SZ
					begin
						operand1 = 3'b011;
                        destination = 3'b011;
                        IFF=1'b0;
					end

					8'b01111100 : //sc
					begin
						operand1 = 3'b010;
                        destination = 3'b010;
                  		IFF=1'b0;
					end
                  

			endcase
		
		end
	else if (IFF == 1 && interrupt_counter == 3'b000 && ex_flag == 0)
				begin
					stack_mux_sel = 2'b01;
					stack_pc_en = 2'b00;
				end 
end
endmodule

