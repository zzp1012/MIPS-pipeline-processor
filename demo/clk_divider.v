`timescale 1ns / 1ps

module clk_divider(gate, clk, reset);
    input clk, reset;
    output gate;
    reg [19:0] Q;
    
    assign gate = (&Q[5:0]) & (&Q[10:7]) & Q[13] & Q[16] & Q[19]; 
    
    always @ (posedge reset or posedge clk) begin
        if (reset == 1'b1) Q <= 0;
        else if (gate == 1'b1) Q <= 0;
        else Q <= Q + 1;
    end
endmodule
