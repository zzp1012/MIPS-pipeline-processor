`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/02 07:32:42
// Design Name: 
// Module Name: PC
// Project Name: 
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


module PC(curr, clk, next);
    parameter word = 32;
    
    input   [word - 1:0]    next;
    input                   clk;
    output  [word - 1:0]    curr;
    
    reg     [word - 1:0]    PC_mem;
    
    initial begin
        PC_mem = 0;
    end

    always @(posedge clk) begin
        if (clk == 1'b1) begin
            PC_mem = next;
        end
    end 
    
    assign curr = PC_mem;
endmodule
