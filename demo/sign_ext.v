`timescale 1ns / 1ps

module sign_ext(out, in);
    parameter word = 32;
    parameter half_word = 16;
    
    input [half_word - 1:0] in;
    output [word - 1:0] out;
    
    assign out = {{half_word{in[half_word-1]}}, in};
endmodule
