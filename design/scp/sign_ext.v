`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/02 07:01:23
// Design Name: 
// Module Name: sign_ext
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


module sign_ext(out, in);
    parameter word = 32;
    parameter half_word = 16;
    
    input [half_word - 1:0] in;
    output [word - 1:0] out;
    
    assign out = {{half_word{in[half_word-1]}}, in};
endmodule
