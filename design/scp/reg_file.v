`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/02 06:51:27
// Design Name: 
// Module Name: reg_file
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


module reg_file(read_data1, read_data2, read_addr1, read_addr2, write_addr, write_data, regwrite, clk);
    parameter addr_size = 5;
    parameter word = 32;
    
    input   [addr_size - 1:0] read_addr1, read_addr2, write_addr;
    input   [word - 1:0]      write_data;
    input                     regwrite,   clk;
    output  [word - 1:0]      read_data1, read_data2;
    
    reg     [word - 1:0]      reg_mem[2**addr_size - 1:0];
    integer                   n;
    
    initial begin
        for (n = 0; n < 2**addr_size; n = n + 1) begin
            reg_mem[n] = 0;
        end
    end

    always @(negedge clk) begin
        if (regwrite == 1'b1) begin
            reg_mem[write_addr] = write_data;
        end
    end
    
    assign read_data1 = reg_mem[read_addr1];
    assign read_data2 = reg_mem[read_addr2];
endmodule
