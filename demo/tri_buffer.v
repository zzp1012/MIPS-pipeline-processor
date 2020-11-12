`timescale 1ns / 1ps

module tri_buffer(D, I ,sel);
    parameter N = 4;
    input [N - 1:0] I;
    input sel;
    output [N - 1:0] D;
    
    assign D = sel ? 'bz: I;
endmodule
