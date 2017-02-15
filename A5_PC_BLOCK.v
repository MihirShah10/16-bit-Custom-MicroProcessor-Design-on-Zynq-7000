`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:26 10/21/2016 
// Design Name: 
// Module Name:    A5_PC_BLOCK 
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
module A5_PC_BLOCK(pc_counter,register_a,register_c,register_z,led_status,clk,rst,pc_limit, ex_flag,ret_flag, pc,jmp_en,jmp_addr, demux_pc_in, zc_flag, IFF, 
interrupt_counter//,alu_fb
    );
input [15:0]register_a;
input [15:0]register_c;
input [15:0]register_z;
input ret_flag;

input clk,rst;
input [2:0] pc_limit;
inout ex_flag;
input [1:0] jmp_en;
input [11:0] jmp_addr;
input [15:0] demux_pc_in;
input zc_flag;
input IFF;
output reg led_status;

output reg [11:0] pc;
//output  reg alu_fb;
reg [11:0] stack_pc_int;

wire ex_flag;
output reg [4:0]pc_counter;
reg [11:0] intvec;
reg [11:0] pc_temp;
output reg [2:0] interrupt_counter;
reg [4:0] pc_temp_count;
reg [2:0] int_temp_count;

//assign pc = 12'b100000000000;
initial 
	begin
		intvec=12'b000001000000;
		interrupt_counter=3'b000;
		pc_counter=5'b0000;
		pc_temp_count=5'b10110;
		int_temp_count=3'b110;
	end

always @(posedge clk)
begin
//alu_fb = 0;
		if (rst)
		begin
			pc = 12'b000000000000;
			pc_temp = 12'b000000000000;
		//	alu_fb = 1;
		end
		
		else
			begin
			
			case(register_a)
			 16'b0000000000000000 : led_status=1'b0;
			 16'b0000000000000001 : led_status=1'b0;
			 16'b0000000000000010 : led_status=1'b0;
			 16'b0000000000000011 : led_status=1'b0;
			 16'b0000000000000100 : led_status=1'b0;
			 16'b0000000000000101 : led_status=1'b0;
			 16'b0000000000000110 : led_status=1'b0;
			 16'b0000000000000111 : led_status=1'b0;
			 16'b0000000000001010 : led_status=1'b1;
			endcase
			
				if(IFF==0 && ex_flag==1 && pc_limit < 3'b111 && pc_counter < pc_temp_count && jmp_en == 2'b00 && interrupt_counter<=int_temp_count )
				begin
					pc_temp = pc_temp +1'b1;
					pc = pc_temp;
					pc_counter=pc_counter+1;
				//	alu_fb=1;
				end
				
				else if(IFF==0 && ex_flag==1 && pc_limit < 3'b111 && (register_c==0 || register_z==0) && pc_counter < pc_temp_count && jmp_en == 2'b00 && interrupt_counter<=int_temp_count )
                begin
                    pc_temp = pc_temp + 1;
                    pc = pc_temp;
                    pc_counter=pc_counter+1;
                //    alu_fb=1;
                end
				
				else if(IFF==0 && ex_flag==1 && pc_limit < 3'b111 && (register_c==0 || register_z==0) && pc_counter < pc_temp_count && jmp_en == 2'b10 && interrupt_counter<=int_temp_count )
                begin
                    pc_temp = pc_temp +2;
                    pc = pc_temp;
                    pc_counter=pc_counter+2;
                //    alu_fb=1;
                end
                
				else if(IFF==0 && ex_flag==1 && pc_limit < 3'b111 && (register_c==1 && register_z==1) && pc_counter < pc_temp_count && jmp_en == 2'b10 && interrupt_counter<=int_temp_count )
                begin
                    pc_temp = pc_temp+1;
                    pc = pc_temp;
                    pc_counter=pc_counter+1;
                //    alu_fb=1;
                end
                                				
				else if (IFF==0 && ex_flag==1 && pc_counter < pc_temp_count && pc_limit < 3'b111 && (jmp_en == 2'b11))				
				begin
					pc_temp=jmp_addr;
					pc=pc_temp;
					pc_counter=pc_counter+1;
				end
				
			/*	else if (IFF==0 && ex_flag==1 && pc_counter < pc_temp_count && pc_limit < 3'b111 && (jmp_en == 2'b01))
				begin
					pc_temp= demux_pc_in[11:0];
					pc=pc_temp;
					pc_counter=pc_counter+1;
				end
			*/	
				else if (IFF==1 && ex_flag==1 && pc_counter < pc_temp_count && interrupt_counter==3'b000 && jmp_en == 2'b00)
				begin
					stack_pc_int=pc_temp;
					pc=intvec;
					pc_temp=intvec;
					interrupt_counter=interrupt_counter+ 1'b1;
					pc_counter=pc_counter+1;
				end
				
				else if (IFF==0 && ex_flag==1 && (register_c==1 && register_z==1) && pc_counter < pc_temp_count && interrupt_counter <3'b110 && jmp_en == 2'b00)
				begin
					pc_temp=pc_temp+1'b1;
					pc=pc_temp;
					interrupt_counter=interrupt_counter+1'b1;
					pc_counter=pc_counter+1;
				end
				
			/*	else if (IFF==0 && ex_flag==1 && (register_c==0 || register_z==0) && pc_counter < pc_temp_count && interrupt_counter <3'b110 && jmp_en == 2'b00)
                begin
                    pc_temp=pc_temp+1;
                    pc=pc_temp;
                    interrupt_counter=interrupt_counter+1;
                    pc_counter=pc_counter+1;
                end
				
				else if (IFF==0 && ex_flag==1 && (register_c==0 || register_z==0) && pc_counter < pc_temp_count && interrupt_counter <3'b110 && jmp_en == 2'b10)
                begin
                    pc_temp=pc_temp+2;
                    pc=pc_temp;
                    interrupt_counter=interrupt_counter+2;
                    pc_counter=pc_counter+2;
                end
			*/	
				else if (IFF==0 && ex_flag==1 && (register_c==0 || register_z==0) && ret_flag==1 && jmp_en == 2'b01)
				begin
					pc_temp=stack_pc_int + 1'b1;
					pc=pc_temp;
					interrupt_counter=3'b000;
				end
				
				
			//jmp_en and demux_pc_in
		end
end
endmodule

