`timescale 1ns / 1ps

module PC(curr, clk, next, PCWrite, reset);
    parameter word = 32;
    
    input   [word - 1:0]    next;
    input                   clk,    PCWrite,    reset;
    output  [word - 1:0]    curr;
    
    reg     [word - 1:0]    PC_mem;
    

    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            PC_mem = 0;
        end
        else begin
            if (PCWrite) begin
                PC_mem = next;
            end
        end
    end 
    
    assign curr = PC_mem;
endmodule
