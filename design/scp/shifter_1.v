`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/02 07:26:39
// Design Name: 
// Module Name: shifter_1
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


module shifter_1(out, in);
    parameter in_size = 26;
    parameter by = 2;
    
    input [in_size - 1:0] in;
    output [in_size - 1 + by:0] out;
    
    assign out[in_size - 1+by:by] = in;
    assign out[by - 1:0] = 0;
endmodule
