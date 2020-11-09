`timescale 1ns / 1ps


module ALU(result, a, b, ALU_control);
    parameter word = 32;
    input   [word - 1:0]    a,           b;
    input   [3:0]           ALU_control;
    output  [word - 1:0]    result;
    
    reg     [word - 1:0]    result;
    
    initial begin
        result = 0;
    end
    
    always @(a or b or ALU_control) begin
        case (ALU_control)
            // add
            4'b0010: result = a + b;
            // sub
            4'b0110: result = a - b;
            // and
            4'b0000: result = a & b;
            // or
            4'b0001: result = a | b;
            // slt
            4'b0111: result = (a < b)?1:0;
            default: result = 0;
        endcase
    end
endmodule
