`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 23:01:16
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

    reg     clk;
 
    scp     UUT(clk);
    
    initial #0 begin
        #0 clk <= 0;
    end

    always #half_period clk = ~clk;

    initial #1000 $finish;
endmodule
