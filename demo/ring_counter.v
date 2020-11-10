`timescale 1ns / 1ps

module ring_counter(Q, clk, reset);
    input clk, reset;
    output [3:0] Q;
    
    wire CE, load;
    assign CE = 1'b1;
    assign load = 1'b0;
    wire [1:0] D;
    
    counter_4_bit #2 bit_2(D, clk, reset, load, CE);
    
    decoder_2_to_4 deco(D, Q);
endmodule


module counter_4_bit(Q, clk, reset, load, CE);
    parameter N = 4;
    input clk, reset, load, CE;
    output [N - 1:0] Q;
    
    reg [N - 1:0] Q;
    
    always @ (posedge clk or posedge reset) begin
        if (reset == 1'b1) Q <= 0;
        else if (load == 1'b1) Q <= 0;
        else if (CE == 1'b1) Q <= Q + 1;
        else Q <= Q;
    end
endmodule

module decoder_2_to_4(I, D);
    input [1:0] I;
    output [3:0] D;
    
    reg [3:0] D;
    always @ (I) begin
        case(I)
            2'b00: D <= 4'b1110;
            2'b01: D <= 4'b1101;
            2'b10: D <= 4'b1011;
            2'b11: D <= 4'b0111;
            default: D <= 4'b1111;
        endcase
    end
endmodule
