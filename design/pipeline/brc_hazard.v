`timescale 1ns / 1ps

module brc_hazard(forward1, forward2, PCWrite, IFID_write, ID_flush, 
                 ID_branch, IDEX_regWrite, EXMEM_regWrite, EXMEM_memRead, EX_regDst, EXMEM_regRd, ID_regRt, ID_regRs, clk);
    input           ID_branch,  IDEX_regWrite,  EXMEM_regWrite,     EXMEM_memRead,  clk;
    input [4:0]     EX_regDst,  EXMEM_regRd,    ID_regRt,           ID_regRs;
    output          forward1,   forward2,       PCWrite,            IFID_write,     ID_flush;

    reg             forward1,   forward2,       PCWrite,            IFID_write,     ID_flush;

    initial begin
        forward1 = 0; forward2 = 0; PCWrite = 1; IFID_write = 1; ID_flush = 0;
    end
    
    always @(posedge clk) begin
        forward1 = 0; forward2 = 0; PCWrite = 1; IFID_write = 1; ID_flush = 0;
    end

    always @(negedge clk) begin
        forward1 = 0; forward2 = 0; PCWrite = 1; IFID_write = 1; ID_flush = 0;
        if (IDEX_regWrite && ID_branch) begin
            if (EX_regDst == ID_regRs || EX_regDst == ID_regRt) begin
                PCWrite = 0; IFID_write = 0; ID_flush = 1;
            end
        end
        if (EXMEM_regWrite && !EXMEM_memRead && ID_branch) begin
            if (EXMEM_regRd == ID_regRs) forward1 = 1;
            if (EXMEM_regRd == ID_regRt) forward2 = 1;
        end
        if (EXMEM_memRead && ID_branch) begin
            if (EXMEM_regRd == ID_regRs || EXMEM_regRd == ID_regRt) begin
                PCWrite = 0; IFID_write = 0; ID_flush = 1;
            end
        end
    end

endmodule //brc_hazard