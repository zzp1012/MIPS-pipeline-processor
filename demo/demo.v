`timescale 1ns / 1ps

module demo(anode, cathode, reset, ctrl, reg_num, pc_or_not, clk);
    input           reset,      ctrl,        pc_or_not,      clk;
    input   [4:0]   reg_num;
    output  [3:0]   anode;
    output  [6:0]   cathode;
    
    wire            div_clk;
    clk_divider     cd(div_clk, clk, reset);
    
    ring_counter    rc(anode, div_clk, reset);
    
    wire    [15:0]  data;
    pipeline        pipe(data, ctrl, reset, reg_num, pc_or_not);
    
    wire    [3:0]   digit;
    tri_buffer      tb0(digit, data[15:12], anode[0]);
    tri_buffer      tb1(digit, data[11:8], anode[1]);
    tri_buffer      tb2(digit, data[7:4], anode[2]);
    tri_buffer      tb3(digit, data[3:0], anode[3]);
    
    ssd_driver      sd(cathode, digit);
endmodule
