`timescale 1ns / 1ps

module mux_by_2(F, sel, A, B);
    parameter N = 32;
    
    input               sel;
    input   [N-1 : 0]   A,  B;
    output  [N-1 : 0]   F; 
    
    reg     [N-1 : 0]   F;

    initial begin
        F = 0;
    end
    
    always @ (A, B, sel) begin
        case (sel)
            1'b0 : F = A;
            1'b1 : F = B;
            default : F = 0;
        endcase
    end
endmodule
