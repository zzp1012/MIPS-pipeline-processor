`timescale 1ns / 1ps

module lw_hazard (PCWrite, IFID_write, ID_flush, IDEX_memRead, IFID_regRs, IFID_regRt, IDEX_regRt, clk);
    input   [4:0]   IFID_regRs,     IFID_regRt,     IDEX_regRt;
    input           IDEX_memRead,   clk;
    output          PCWrite,        IFID_write,     ID_flush;

    reg             PCWrite,        IFID_write,     ID_flush;

    initial begin
        PCWrite     = 1;
        ID_flush    = 0;
        IFID_write  = 1;
    end
    
    always @(negedge clk) begin
        PCWrite     = 1;
        ID_flush    = 0;
        IFID_write  = 1;
        if (IDEX_memRead && (IFID_regRs == IDEX_regRt || IFID_regRt == IDEX_regRt)) begin
            PCWrite     = 0;
            ID_flush    = 1;
            IFID_write  = 0;
        end
    end
endmodule //lw_hazard