`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/09 01:43:27
// Design Name: 
// Module Name: simulation
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


module simulation;
    parameter half_period = 50;

    reg       clk;
 
    pipeline  UUT(clk);
    
    initial #0 begin
        #0 clk <= 0;
    end

    always #half_period clk = ~clk;

    initial #1000 $finish;
endmodule
