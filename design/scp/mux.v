`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/02 07:08:16
// Design Name: 
// Module Name: mux
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


module mux(F, sel, A, B);
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
