`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Shen Yang
// 
// Create Date: 2020/11/04 18:53:46
// Design Name: 
// Module Name: forward
// Project Name: VE370 Project 2 Group 2 Pipeline Processor
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module forward(forward_A, forward_B, reg_write_MEM, reg_write_WB, reg_Rd_MEM, reg_Rd_WB, reg_Rs_EX, reg_Rt_EX, reset);
	input reset;
	input reg_write_MEM, reg_write_WB;
	input [4:0] reg_Rd_MEM, reg_Rd_WB, reg_Rs_EX, reg_Rt_EX;
	output [2:0] forward_A, forward_B;
	reg [2:0] forward_A, forward_B;
	
	always @(*) begin
		if (reset == 1) begin
			forward_A = 0;
			forward_B = 0;
		end
        // 1 & 2 hazard
        forward_A[1] = reg_write_MEM & reg_Rd_MEM & (reg_Rd_MEM == reg_Rs_EX);
        forward_B[1] = reg_write_MEM & reg_Rd_MEM & (reg_Rd_MEM == reg_Rt_EX);
        
        // 1 & 3 hazard (need to make sure no 1 & 2 hazard)
        forward_A[0] = reg_write_WB & reg_Rd_WB & (reg_Rd_WB == reg_Rs_EX) & (~forward_A[1]);
        forward_B[0] = reg_write_WB & reg_Rd_WB & (reg_Rd_WB == reg_Rt_EX) & (~forward_B[1]);
	end

endmodule
