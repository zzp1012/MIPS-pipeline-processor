`timescale 1ns / 1ps

module shifter_2(out, in);
    parameter word = 32;
    parameter by = 2;
    
    input [word - 1:0] in;
    output [word - 1:0] out;
    
    assign out[word - 1:by] = in[word - 1 - by:0];
    assign out[by - 1:0] = 0;
endmodule