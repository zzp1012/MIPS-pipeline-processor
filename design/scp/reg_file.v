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
        $display("[$s0] = %h, [$s1] = %h, [$s2] = %h", reg_mem[16], reg_mem[17], reg_mem[18]);
        $display("[$s3] = %h, [$s4] = %h, [$s5] = %h", reg_mem[19], reg_mem[20], reg_mem[21]);
        $display("[$s6] = %h, [$s7] = %h, [$t0] = %h", reg_mem[22], reg_mem[23], reg_mem[8]);
        $display("[$t1] = %h, [$t2] = %h, [$t3] = %h", reg_mem[9], reg_mem[10], reg_mem[11]);
        $display("[$t4] = %h, [$t5] = %h, [$t6] = %h", reg_mem[12], reg_mem[13], reg_mem[14]);
        $display("[$t7] = %h, [$t8] = %h, [$t9] = %h", reg_mem[15], reg_mem[24], reg_mem[25]);
        for (n = 0; n < 2**addr_size; n = n + 1) begin
            reg_mem[n] = 0;
        end
    end

    always @(clk) begin
        if (clk == 1'b0 && regwrite == 1'b1) begin
            reg_mem[write_addr] = write_data;
        end
        $display("[$s0] = %h, [$s1] = %h, [$s2] = %h", reg_mem[16], reg_mem[17], reg_mem[18]);
        $display("[$s3] = %h, [$s4] = %h, [$s5] = %h", reg_mem[19], reg_mem[20], reg_mem[21]);
        $display("[$s6] = %h, [$s7] = %h, [$t0] = %h", reg_mem[22], reg_mem[23], reg_mem[8]);
        $display("[$t1] = %h, [$t2] = %h, [$t3] = %h", reg_mem[9], reg_mem[10], reg_mem[11]);
        $display("[$t4] = %h, [$t5] = %h, [$t6] = %h", reg_mem[12], reg_mem[13], reg_mem[14]);
        $display("[$t7] = %h, [$t8] = %h, [$t9] = %h", reg_mem[15], reg_mem[24], reg_mem[25]);
        if (clk != 1'b1) begin
            $display("===============================================");
        end
    end
    
    assign read_data1 = reg_mem[read_addr1];
    assign read_data2 = reg_mem[read_addr2];
endmodule
