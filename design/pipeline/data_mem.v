`timescale 1ns / 1ps

module data_mem(read_data, read_addr, write_data, mem_write, mem_read, clk);
    parameter word   = 32;
    parameter byte   = 8;
    parameter number = 1000;
    
    input   [word - 1:0] read_addr, write_data;
    input                mem_write, mem_read,   clk;
    output  [word - 1:0] read_data;
    
    reg     [byte - 1:0] memory[number - 1:0];
    reg     [word - 1:0] read_data;

    integer                  n;

    initial begin
        for (n = 0; n < number; n = n + 1) begin
            memory[n] = 0;
        end
    end
    
    always @(negedge clk) begin
        if (mem_write)  begin
            memory[read_addr] = write_data[word - 1:word - byte];
            memory[read_addr + 1] = write_data[word - byte - 1:word - 2*byte];
            memory[read_addr + 2] = write_data[word - 2*byte - 1:word - 3*byte];
            memory[read_addr + 3] = write_data[word - 3*byte - 1:0];
        end
    end
    
    always @(mem_read or read_addr) begin
        read_data = 'bz;
        if (mem_read) begin
            read_data = {memory[read_addr], memory[read_addr+1], memory[read_addr+2], memory[read_addr+3]};
        end 
    end
endmodule
