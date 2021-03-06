`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/02 06:25:54
// Design Name: 
// Module Name: instr_mem
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


module instr_mem(instruction, read_addr);
    parameter word = 32;
    parameter byte = 8;
    parameter line = 42;
    
    input   [word - 1:0]    read_addr;
    output  [word - 1:0]    instruction;
    
    reg     [byte - 1:0]    mem[4*line - 1:0];
    reg     [word - 1:0]    instruction;
    
    initial begin
        $readmemb("D:/JI/2020 fall/VE370 Intro to Computer Organization/Projects/P2/InstructionMem_for_P2_Demo.txt", mem);
    end
    
    always @ (read_addr) begin
        instruction = {mem[read_addr], mem[read_addr + 1], mem[read_addr+2], mem[read_addr+3]};
    end
endmodule
