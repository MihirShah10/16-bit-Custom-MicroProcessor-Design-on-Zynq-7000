`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:24:06 10/30/2016 
// Design Name: 
// Module Name:    A5_CONTROL_UNIT 
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
module A5_CONTROL_UNIT(register_c,register_z,pc_counter,rst, clk,decode_flag, reg_write_enable, ex_flag,ret_flag,addr,opcode1,data_write_enable,opcode2,
stack_en,jmp_en,IFF, interrupt_counter
    );
	 
input [15:0]register_c;
input [15:0]register_z;	 
input [4:0]pc_counter;	 
input rst, clk,decode_flag;
input [2:0] interrupt_counter;
output reg reg_write_enable, ex_flag,data_write_enable,ret_flag;
output reg stack_en;
input [11:0] addr;
input [3:0] opcode1;
input [7:0] opcode2;
input IFF;

output reg [1:0]jmp_en;

reg [4:0]pc_temp_count =5'b10110;

reg [2:0] state;

always @(posedge clk)
begin
		if (rst)
		begin
				state <= 3'b001;
		end
	/*	else if (IFF == 1)
		begin
				stack_en = 1;
		end
	*/
		else if(addr < 8'b11111111 && (opcode1==4'b0000 || opcode1==4'b0001) && pc_counter < pc_temp_count) // LDA & LDB
		begin
			//	select=0;
		   //   select2=1;
		     // select_demux = 1;
			  jmp_en <=2'b00;
			  ret_flag<=0;
				case (state)
						/*3'b000 : begin
											ex_flag <= 0;
											reg_write_enable <= 0;
											state <= 3'b001;
											end */
						
						3'b001 : begin
											ex_flag <= 0;
											reg_write_enable <= 0;
											data_write_enable <= 0;
											state <= 3'b010;
											end

						3'b010 : begin
											ex_flag <= 0;
											reg_write_enable <= 0;
											data_write_enable <= 0;
											state <= 3'b011;
											end

						3'b011 : begin
											ex_flag <= 0;
											reg_write_enable <= 0;
											data_write_enable <= 0;
											state <= 3'b100;
											end
						
						3'b100 : begin
											reg_write_enable <= 1;
											data_write_enable <= 0;
											ex_flag <= 1;
											state <= 3'b101;
											end
											
						3'b101 : begin
											reg_write_enable <= 0;
											data_write_enable <= 0;
											ex_flag <= 0;
											state <= 3'b001;
											end
	/*										
					    3'b101 : begin
											 reg_write_enable <= 0;
											 ex_flag <= 0;
											 state <= 3'b000;
											 end
	*/
				endcase
			
		end
		
		else if(addr < 8'b11111111 && (opcode1==4'b0010 || opcode1==4'b0011)  && pc_counter < pc_temp_count) //STA & STB
		begin
			//	select=0;
		   //   select2=1;
		     // select_demux = 1;
			  jmp_en<=2'b00;
			  ret_flag<=0;
				case (state)
						/*3'b000 : begin
											ex_flag <= 0;
											data_write_enable <= 0;
											state <= 3'b001;
											end */
						
						3'b001 : begin
											ex_flag <= 0;
											data_write_enable <= 0;
											reg_write_enable <= 0;
											state <= 3'b010;
											end
											
						3'b010 : begin
                                            ex_flag <= 0;
                                            data_write_enable <= 0;
                                            reg_write_enable <= 0;
                                            state <= 3'b011;
                                            end
						
						3'b011 : begin
											ex_flag <= 0;
											data_write_enable <= 0;
											reg_write_enable <= 0;
											state <= 3'b100;
											end
						
						3'b100 : begin
											data_write_enable <= 1;
											reg_write_enable <= 0;
											ex_flag <= 1;
											state <= 3'b101;
											end
											
						3'b101 : begin
											data_write_enable <= 0;
											reg_write_enable <= 0;
											ex_flag <= 0;
											state <= 3'b001;
											end
	/*										
					    3'b101 : begin
											 data_write_enable <= 0;
											 ex_flag <= 0;
											 state <= 3'b000;
											 end
	*/
				endcase
			
		end
		
		else if(addr < 8'b11111111 && opcode1==4'b1010 && pc_counter < pc_temp_count) //PUSH A
		begin
			jmp_en<=2'b00;
			ret_flag<=0;
				case (state)
						/*3'b000 : begin
											ex_flag <= 0;
											data_write_enable <= 0;
											state <= 3'b001;
											end */
						
						3'b001 : begin
											ex_flag <= 0;
											stack_en <=1'bx;
											reg_write_enable <= 0;
											state <= 3'b010;
											end
											
						3'b010 : begin
                                                                ex_flag <= 0;
                                                                stack_en <=1'bx;
                                                                reg_write_enable <= 0;
                                                                state <= 3'b011;
                                                                end
						
						3'b011 : begin
											ex_flag <= 0;
											stack_en <=1'bx;
											reg_write_enable <= 0;
											state <= 3'b100;
											end
						
						3'b100 : begin
											stack_en <=1'b1;
											
											reg_write_enable <= 0;
											ex_flag <= 1;
											state <= 3'b101;
											end
											
						3'b101 : begin
											stack_en <=1'bx;
											reg_write_enable <= 0;
											ex_flag <= 0;
											state <= 3'b001;
											end
	/*										
					    3'b101 : begin
											 data_write_enable <= 0;
											 ex_flag <= 0;
											 state <= 3'b000;
											 end
	*/
				endcase
			
		end
		
		else if(addr < 8'b11111111 && opcode1==4'b1100  && pc_counter < pc_temp_count) //POP A
		begin
			jmp_en <=2'b00;
			ret_flag<=0;
				case (state)
				/*		3'b000 : begin
											ex_flag <= 0;
											stack_en <=1'bx;
											reg_write_enable <= 0;
											state <= 3'b001;
											end 
					*/	
						3'b001 : begin
											ex_flag <= 0;
											stack_en <=1'bx;
											reg_write_enable <= 0;
											state <= 3'b010;
											end
						
						3'b010 : begin
											ex_flag <= 0;
											stack_en <=1'b0;
											reg_write_enable <= 0;
											state <= 3'b011;
											end
						
						3'b011 : begin
											ex_flag <= 0;
											stack_en <=1'b0;
											reg_write_enable <= 0;
											state <= 3'b100;
											end
											
						3'b100 : begin
											stack_en <=1'bx;
											reg_write_enable <= 1;
											ex_flag <= 1;
											state <= 3'b101;
											end
									
					    3'b101 : begin
											stack_en <=1'bx;
											reg_write_enable <= 0;
											ex_flag <= 0;
											state <= 3'b001;
											 end
	
				endcase
			
		end
		

		
		else if(addr < 8'b11111111 && (opcode1==4'b0100 )  && pc_counter < pc_temp_count) //JUMP
		begin
		ret_flag<=0;
				case (state)
						/*3'b000 : begin
											ex_flag <= 0;
											data_write_enable <= 0;
											state <= 3'b001;
											end */
						
						3'b001 : begin
											ex_flag <= 0;
											jmp_en <=2'b00;
											state <= 3'b010;
											end
						
						3'b010 : begin
											ex_flag <= 0;
											jmp_en <=2'b00;
											state <= 3'b011;
											end
						
						3'b011 : begin
											jmp_en <=2'b11;
											ex_flag <= 1;
											state <= 3'b100;
											end
											
						3'b100 : begin
											ex_flag <= 0;
											jmp_en <=2'b00;
											state <= 3'b001;
											end
	/*										
					    3'b101 : begin
											 data_write_enable <= 0;
											 ex_flag <= 0;
											 state <= 3'b000;
											 end
	*/
				endcase
		end
		
		else if(addr < 8'b11111111 && (opcode1==4'b1000 ) && pc_counter < pc_temp_count) //JSR
		begin
		ret_flag<=0;
				case (state)
						/*3'b000 : begin
											ex_flag <= 0;
											data_write_enable <= 0;
											state <= 3'b001;
											end */
						
						3'b001 : begin
											ex_flag <= 0;
											jmp_en <=2'b00;
											reg_write_enable <= 1'b0;
				                            data_write_enable <= 1'b0;
											state <= 3'b010;
											end
											
						3'b010 : begin
                                            ex_flag <= 0;
                                            jmp_en <=2'b00;
                                            reg_write_enable <= 1'b0;
                                            data_write_enable <= 1'b0;
                                            state <= 3'b011;
                                             end
						
						3'b011 : begin
											ex_flag <= 1;
											jmp_en<=2'b11;
											stack_en <=1'b1;
											reg_write_enable <= 1'b0;
				                            data_write_enable <= 1'b0;
											state <= 3'b100;
											end
						
						3'b100 : begin
											jmp_en <=2'b11;
											ex_flag <= 0;
											reg_write_enable <= 1'b0;
				                            data_write_enable <= 1'b0;
											state <= 3'b101;
											end
											
						3'b101 : begin
											ex_flag <= 0;
											jmp_en <=2'b00;
											reg_write_enable <= 1'b0;
				                            data_write_enable <= 1'b0;
											state <= 3'b001;
											end
	/*										
					    3'b101 : begin
											 data_write_enable <= 0;
											 ex_flag <= 0;
											 state <= 3'b000;
											 end
	*/
				endcase
		end
		
		else if(addr < 8'b11111111 && opcode1==4'b1110  && pc_counter < pc_temp_count) //RET
		begin
				case (state)

						3'b001 : begin
											ex_flag <= 0;
											ret_flag<=0;
											jmp_en <=2'b01;
											state <= 3'b010;
											end
						
						3'b010 : begin
											ex_flag <= 0;
											ret_flag<=0;
											jmp_en <=2'b01;
											state <= 3'b011;
											end
						
						3'b011 : begin
											ex_flag <= 0;
											ret_flag<=1;
											jmp_en <=2'b01;
											state <= 3'b100;
											end
											
						3'b100 : begin
											ex_flag <= 1;
											ret_flag<=1;
											jmp_en <=2'b01;
											state <= 3'b101;
											end
									
					    3'b101 : begin
											ex_flag <= 0;
											ret_flag<=0;
											jmp_en <=2'b01;
											state <= 3'b001;
											end
											 

	
				endcase
			
		end
	
	else if((opcode2==8'b01110001|| opcode2==8'b01110011 || opcode2==8'b01110010 || opcode2 == 8'b01111011 || opcode2 == 8'b01110100 || opcode2 == 8'b01110111 || opcode2 == 8'b01110110 || opcode2 == 8'b01110101|| opcode2 == 8'b01111000 || opcode2 == 8'b01111001)  && pc_counter < pc_temp_count)
		begin
			//	select=1;
		    //  select2=0;
		    //  select_demux = 0;
			 jmp_en <=2'b00;
			 ret_flag<=0;


				case (state)
						3'b001 : begin
											ex_flag <= 0;
											reg_write_enable <= 0;
											data_write_enable <= 0;
											state <= 3'b010;
											end
											
						3'b010 : begin
                                            ex_flag <= 0;
                                            reg_write_enable <= 0;
                                            data_write_enable <= 0;
                                            state <= 3'b011;
                                            end 
						
						3'b011 : begin
											ex_flag <= 0;
											reg_write_enable <= 0;
											data_write_enable <= 0;
											state <= 3'b100;
											end
					
						3'b100 : begin
											ex_flag <= 0;
											reg_write_enable <= 0;
											data_write_enable <= 0;
											state <= 3'b101;
											end
			
			
						3'b101 : begin
											reg_write_enable <= 1;
											data_write_enable <= 0;
											ex_flag <= 1;
											state <= 3'b110;
											end
											
						3'b110 : begin
											reg_write_enable <=0 ;
											data_write_enable <= 0;
											ex_flag <= 0;
											state <= 3'b001;
											end
											
	/*										
					    3'b101 : begin
											 reg_write_enable <= 0;
											 ex_flag<=0;
											 state <= 3'b000;
											 end
											 */
				endcase  
		end
		
	else if((opcode2==8'b01111010 || opcode2==8'b01111011)  && pc_counter < pc_temp_count)
            begin
                //    select=1;
                //  select2=0;
                //  select_demux = 0;
                 jmp_en <=2'b00;
                 ret_flag<=0;
    
    
                    case (state)
                            3'b001 : begin
                                                ex_flag <= 0;
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                state <= 3'b010;
                                                end
                                                
                            3'b010 : begin
                                                ex_flag <= 0;
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                state <= 3'b011;
                                                end 
                            
                            3'b011 : begin
                                                ex_flag <= 0;
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                state <= 3'b100;
                                                end
                        
                            3'b100 : begin
                                                ex_flag <= 0;
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                state <= 3'b101;
                                                end
                
                
                            3'b101 : begin
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                ex_flag <= 1;
                                                state <= 3'b110;
                                                end
                                                
                            3'b110 : begin
                                                reg_write_enable <=0 ;
                                                data_write_enable <= 0;
                                                ex_flag <= 0;
                                                state <= 3'b001;
                                                end
                                                
        /*                                        
                            3'b101 : begin
                                                 reg_write_enable <= 0;
                                                 ex_flag<=0;
                                                 state <= 3'b000;
                                                 end
                                                 */
                    endcase  
            end
		
			else if((opcode2 == 8'b01111100 || opcode2 == 8'b01111101)  && pc_counter < pc_temp_count)
            begin
                //    select=1;
                //  select2=0;
                //  select_demux = 0;
                 jmp_en <=2'b10;
                 ret_flag<=0; 
                    case (state)
                            3'b001 : begin
                                                ex_flag <= 0;
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                state <= 3'b010;
                                                end
                                                
                            3'b010 : begin
                                                ex_flag <= 0;
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                state <= 3'b011;
                                                end 
                            
                            3'b011 : begin
                                                ex_flag <= 0;
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                state <= 3'b100;
                                                end
                        
                            3'b100 : begin
                                                ex_flag <= 0;
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                state <= 3'b101;
                                                end
                
                
                            3'b101 : begin
                                                reg_write_enable <= 0;
                                                data_write_enable <= 0;
                                                ex_flag <= 1;
                                                state <= 3'b110;
                                                end
                                                
                            3'b110 : begin
                                                reg_write_enable <=0 ;
                                                data_write_enable <= 0;
                                                ex_flag <= 0;
                                                state <= 3'b001;
                                                end
                                                
        /*                                        
                            3'b101 : begin
                                                 reg_write_enable <= 0;
                                                 ex_flag<=0;
                                                 state <= 3'b000;
                                                 end
                                                 */
                    endcase  
		end
		
		else if (IFF==1 && interrupt_counter==3'b000 && ex_flag == 0)
		begin
				stack_en <= 1;
		end

end
endmodule
