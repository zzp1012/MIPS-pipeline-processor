`timescale 1ns / 1ps

module PC(curr, clk, next, PCWrite);
    parameter word = 32;
    
    input   [word - 1:0]    next;
    input                   clk,    PCWrite;
    output  [word - 1:0]    curr;
    
    reg     [word - 1:0]    PC_mem;
    
    initial begin
        PC_mem = 0;
    end

    always @(posedge clk) begin
        if (PCWrite) begin
            PC_mem = next;
        end
    end 
    
    assign curr = PC_mem;
endmodule
