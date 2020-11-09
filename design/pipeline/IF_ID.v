`timescale 1ns / 1ps

module IF_ID(IFID_pcplus4, IFID_instr, IF_pcplus4, IF_instr, IF_flush, IFID_write, clk);
    parameter word = 32;

    input   [word - 1:0]  IF_pcplus4,     IF_instr;
    input                 IF_flush,       IFID_write,   clk;
    output  [word - 1:0]  IFID_pcplus4,   IFID_instr;
    
    reg     [word - 1:0]  IFID_pcplus4,   IFID_instr;

    initial begin
        IFID_instr   = 0;
        IFID_pcplus4 = 0;
    end

    always @(posedge clk) begin
        if (IF_flush) begin
            IFID_pcplus4 = 0;
            IFID_instr   = 0;
        end
        else if (IFID_write) begin
            IFID_pcplus4 = IF_pcplus4;
            IFID_instr   = IF_instr;
        end 
    end
endmodule