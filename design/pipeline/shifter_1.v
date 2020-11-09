`timescale 1ns / 1ps

module shifter_1(out, in);
    parameter in_size = 26;
    parameter by = 2;
    
    input [in_size - 1:0] in;
    output [in_size - 1 + by:0] out;
    
    assign out[in_size - 1+by:by] = in;
    assign out[by - 1:0] = 0;
endmodule
