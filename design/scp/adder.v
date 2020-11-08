`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/08 08:05:17
// Design Name: 
// Module Name: adder
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

module adder(result, a, b);
    parameter word = 32;

    input   [word - 1:0]    a,     b;
    output  [word - 1:0]    result;
    
    reg     [word - 1:0]    result;
    
    initial begin
        result = 0;
    end
    
    always @(a, b) begin
        result = a + b;
    end
endmodule