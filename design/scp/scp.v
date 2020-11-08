`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/08 08:05:17
// Design Name: 
// Module Name: scp
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

module scp(clk);
    parameter word     = 32;
    parameter reg_addr = 5;

    input clk;

    wire    [word - 1:0]        curr_addr,      instruction,    next_addr;
    wire    [word - 1:0]        read_data1,     read_data2,     write_data;  
    wire    [word - 1:0]        extended,       ALU_input2,     ALU_result;
    wire    [word - 1:0]        mem_data,       pcplusfor,      jump_addr;  
    wire    [word - 1:0]        brc_addr_part,  branch_addr,    next_addr_part;    
    wire    [27:0]              jump_addr_part;
    wire    [reg_addr - 1:0]    write_addr;
    wire    [3:0]               ALU_control;
    wire    [1:0]               ALUop;
    wire                        RegDst,         Jump,           Branch,     MemRead,    MemtoReg; 
    wire                        MemWrite,       ALUSrc,         RegWrite,   Beq;
    wire                        zero,           real_brc,       brc_part;

    assign      jump_addr = {pcplusfor[31:28], jump_addr_part};
    assign      real_brc = brc_part & Branch;

    PC          pc(curr_addr, clk, next_addr);
    instr_mem   instrmem(instruction, curr_addr);
    control     ctrl(RegDst, Jump, Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite, Beq, instruction[31:26]);
    ALUcontrol  aluctrl(ALU_control, instruction[5:0], ALUop);
    mux      #5 regdst(write_addr, RegDst, instruction[20:16], instruction[15:11]);
    mux         alusrc(ALU_input2, ALUSrc, read_data2, extended);
    mux      #1 beq(brc_part, Beq, ~zero, zero);
    mux         branch(next_addr_part, real_brc, pcplusfor, branch_addr);
    mux         jump(next_addr, Jump, next_addr_part, jump_addr);
    mux         mem2reg(write_data, MemtoReg, ALU_result, mem_data);
    reg_file    regfile(read_data1, read_data2, instruction[25:21], instruction[20:16], write_addr, write_data, RegWrite, clk);
    sign_ext    ext(extended, instruction[15:0]);
    ALU         alu(zero, ALU_result, read_data1, ALU_input2, ALU_control);
    data_mem    datamem(mem_data, ALU_result, read_data2, MemWrite, MemRead, clk);    
    adder       first(pcplusfor, curr_addr, 4);        
    shifter_1   sh1(jump_addr_part, instruction[25:0]);
    shifter_2   sh2(brc_addr_part, extended);
    adder       second(branch_addr, pcplusfor, brc_addr_part);
    
    always @(posedge clk) begin
        $display("s0: %h", regfile.reg_mem[8]);
    end
endmodule