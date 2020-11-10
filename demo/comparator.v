`timescale 1ns / 1ps

module comparator (equal, a, b);
    parameter word = 32;
    input   [word - 1:0] a,     b;
    output               equal;

    reg                  equal;

    initial begin
        equal = 1'b0;
    end
    always @(a or b) begin
        if (a == b) equal = 1'b1;
        else        equal = 1'b0;
    end

endmodule //comparator