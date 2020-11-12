`timescale 1ns / 1ps

module reg_file(reg_tmp, read_data1, read_data2, read_addr1, read_addr2, write_addr, write_data, regwrite, clk, reset, reg_num);
    parameter addr_size = 5;
    parameter word = 32;
    
    input   [addr_size - 1:0] read_addr1, read_addr2, write_addr,   reg_num;
    input   [word - 1:0]      write_data;
    input                     regwrite,   clk,        reset;
    output  [word - 1:0]      read_data1, read_data2, reg_tmp;
    
    reg     [word - 1:0]      reg_mem[2**addr_size - 1:0];
    integer                   n;

    always @(negedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            for (n = 0; n < 2**addr_size; n = n + 1) begin
                reg_mem[n] = 0;
            end
        end
        else if (regwrite == 1'b1) begin
            reg_mem[write_addr] = write_data;
        end
    end
    
    assign read_data1 = reg_mem[read_addr1];
    assign read_data2 = reg_mem[read_addr2];
    assign reg_tmp    = reg_mem[reg_num];
endmodule
