`timescale 1ns / 1ps

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