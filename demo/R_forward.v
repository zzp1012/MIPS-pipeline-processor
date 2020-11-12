`timescale 1ns / 1ps

module R_forward(forward_A, forward_B, EXMEM_regWrite, MEMWB_regWrite, EXMEM_regRd, MEMWB_regRd, IDEX_regRs, IDEX_regRt, clk);
	input 	                EXMEM_regWrite, 	                MEMWB_regWrite,     clk;
	input 	[4:0] 			EXMEM_regRd, 	MEMWB_regRd, 		IDEX_regRs, 		IDEX_regRt;
	output 	[1:0] 			forward_A, 		forward_B;
	reg 	[1:0] 			forward_A, 		forward_B;
	
	initial begin
		forward_A = 0;
		forward_B = 0;
	end

	always @(negedge clk) begin
        // 1 & 2 hazard
        forward_A[1] = EXMEM_regWrite & (EXMEM_regRd != 0) & (EXMEM_regRd == IDEX_regRs);
        forward_B[1] = EXMEM_regWrite & (EXMEM_regRd != 0) & (EXMEM_regRd == IDEX_regRt);
        
        // 1 & 3 hazard (need to make sure no 1 & 2 hazard)
        forward_A[0] = MEMWB_regWrite & (MEMWB_regRd != 0) & (MEMWB_regRd == IDEX_regRs) & (~(EXMEM_regWrite & EXMEM_regRd & (EXMEM_regRd == IDEX_regRs)));
        forward_B[0] = MEMWB_regWrite & (MEMWB_regRd != 0) & (MEMWB_regRd == IDEX_regRt) & (~(EXMEM_regWrite & EXMEM_regRd & (EXMEM_regRd == IDEX_regRt)));
	end

endmodule
