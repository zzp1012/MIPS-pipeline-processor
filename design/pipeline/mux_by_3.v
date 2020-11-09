`timescale 1ns / 1ps

module mux_by_3(F, sel, A, B, C);
    parameter N = 32;
    
    input   [1:0]       sel;
    input   [N-1 : 0]   A,  B,  C;
    output  [N-1 : 0]   F; 
    
    reg     [N-1 : 0]   F;

    initial begin
        F = 0;
    end
    
    always @ (A, B, sel) begin
        case (sel)
            2'b00 : F = A;
            2'b01 : F = B;
            2'b10 : F = C;
            2'b11 : F = C;
            default : F = 0;
        endcase
    end
endmodule
