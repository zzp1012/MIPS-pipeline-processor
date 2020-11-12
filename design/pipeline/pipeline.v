`timescale 1ns / 1ps

module pipeline (data, clk, reset, reg_num, pc_or_not);
    parameter word = 32;
    parameter half_w = 16;

    input                       clk,            reset,      pc_or_not;
    input   [4:0]               reg_num;
    output  [half_w - 1:0]      data;         

    // output
    wire    [word - 1:0]        full_data,      tmp_reg,    curr;
        
    assign      full_data = pc_or_not?curr:tmp_reg;
    assign      data = full_data[half_w - 1:0];

    // IF stage
    wire    [word - 1:0]        next,           IF_pcplus4,                     IF_instr,               jump_target;
    wire    [word - 1:0]        brc_target,     not_jump_target;
    wire                        PCWrite,        ID_real_brc,                    ID_jump,                IF_flush;

    PC          pc(curr, clk, next, PCWrite, reset);
    adder       pc_adder(IF_pcplus4, curr, 4);
    mux_by_2    brc_mux(not_jump_target, ID_real_brc, IF_pcplus4, brc_target);
    mux_by_2    jmp_mux(next, ID_jump, not_jump_target, jump_target);
    instr_mem   instrmem(IF_instr, curr);
    assign      IF_flush = ID_real_brc | ID_jump;

    // IF/ID stage register
    wire    [word - 1:0]        IFID_pcplus4,   IFID_instr;
    wire                        IFID_write;

    IF_ID       ifid(IFID_pcplus4, IFID_instr, IF_pcplus4, IF_instr, IF_flush, IFID_write, clk);

    // ID stage
    wire                        ID_regDs,       ID_branch,      ID_memRead,         ID_beq;
    wire                        ID_memtoReg,    ID_memWrite,    ID_ALUSrc,          ID_regWrite,        ID_brc_part;
    wire                        MEMWB_memtoReg, MEMWB_regWrite, reg_equal,          forward1,           forward2;
    wire    [1:0]               ID_ALUop;
    wire    [4:0]               MEMWB_regRd;
    wire    [word - 1:0]        ID_read_data1,  ID_read_data2,  ID_reg_data1,       ID_reg_data2,       ext_imt;
    wire    [word - 1:0]        sh_ext_imt;
    wire    [word - 1:0]        EXMEM_ALU_result,               EXMEM_val_regRt,    WB_write_data;
    wire    [27:0]              jump_part;

    control     ctrl(ID_regDst, ID_jump, ID_branch, ID_memRead, ID_memtoReg, ID_ALUop, ID_memWrite, ID_ALUSrc, ID_regWrite, ID_beq, IFID_instr[31:26]);
    reg_file    regfile(tmp_reg, ID_read_data1, ID_read_data2, IFID_instr[25:21], IFID_instr[20:16], MEMWB_regRd, WB_write_data, MEMWB_regWrite, clk, reset, reg_num);
    mux_by_2    read_data_mux1(ID_reg_data1, forward1, ID_read_data1, EXMEM_ALU_result); 
    mux_by_2    read_data_mux2(ID_reg_data2, forward2, ID_read_data2, EXMEM_ALU_result);
    comparator  comp(reg_equal, ID_reg_data1, ID_reg_data2);
    sign_ext    extended(ext_imt, IFID_instr[15:0]);
    shifter_1   sh1(jump_part, IFID_instr[25:0]);
    assign      jump_target = {IFID_pcplus4[31:28], jump_part};
    shifter_2   sh2(sh_ext_imt, ext_imt);
    adder       brc_addr_adder(brc_target, sh_ext_imt, IFID_pcplus4);
    mux_by_2 #1 beqOrbne(ID_brc_part, ID_beq, ~reg_equal, reg_equal);
    assign      ID_real_brc = ID_brc_part & ID_branch;

    // ID/EX stage register
    wire    [word - 1:0]        IDEX_ext_imt,   IDEX_reg_data1, IDEX_reg_data2;
    wire    [4:0]               IDEX_regRs,     IDEX_regRt,     IDEX_regRd;
    wire                        IDEX_regDst,    IDEX_memRead,   IDEX_memtoReg,      IDEX_memWrite;
    wire                        IDEX_ALUSrc,    IDEX_regWrite,  ID_flush;
    wire    [1:0]               IDEX_ALUOp;

    ID_EX       idex(IDEX_regDst, IDEX_memRead, IDEX_memtoReg, IDEX_ALUOp, IDEX_memWrite, IDEX_ALUSrc, 
                IDEX_regWrite, IDEX_reg_data1, IDEX_reg_data2, IDEX_ext_imt, IDEX_regRs, IDEX_regRt, IDEX_regRd, 
                clk, ID_flush, ID_regDst, ID_memRead, ID_memtoReg, ID_ALUop, ID_memWrite, ID_ALUSrc, 
                ID_regWrite, ID_reg_data1, ID_reg_data2, ext_imt, IFID_instr[25:21], IFID_instr[20:16], IFID_instr[15:11]);

    // EX stage
    wire    [word - 1:0]        ALU_operand1,   ALU_operand2,       ALU_operand2_part;
    wire    [4:0]               EX_regDst;
    wire    [word - 1:0]        EX_ALU_result;
    wire    [3:0]               ALU_control;
    wire    [1:0]               forwardA,       forwardB;

    mux_by_2 #5 regDst_mux(EX_regDst, IDEX_regDst, IDEX_regRt, IDEX_regRd);
    mux_by_3    ALU_mux1(ALU_operand1, forwardA, IDEX_reg_data1, WB_write_data, EXMEM_ALU_result);
    mux_by_3    ALU_mux2(ALU_operand2_part, forwardB, IDEX_reg_data2, WB_write_data, EXMEM_ALU_result);
    mux_by_2    ALU_mux3(ALU_operand2, IDEX_ALUSrc, ALU_operand2_part, IDEX_ext_imt);
    ALUcontrol  alu_ctrl(ALU_control, IDEX_ext_imt[5:0], IDEX_ALUOp);
    ALU         alu_com(EX_ALU_result, ALU_operand1, ALU_operand2, ALU_control);

    // EX/MEM stage register
    wire    [4:0]               EXMEM_regRd;   
    wire                        EXMEM_memRead,    EXMEM_memtoReg, EXMEM_memWrite,     EXMEM_regWrite;

    EX_MEM      exmem(EXMEM_memRead, EXMEM_memtoReg, EXMEM_memWrite, EXMEM_regWrite, EXMEM_ALU_result, EXMEM_val_regRt, EXMEM_regRd,
                clk, IDEX_memRead, IDEX_memtoReg, IDEX_memWrite, IDEX_regWrite, EX_ALU_result, ALU_operand2_part, EX_regDst);

    // MEM stage
    wire    [word - 1:0]        MEM_read_mem;

    data_mem    datamem(MEM_read_mem, EXMEM_ALU_result, EXMEM_val_regRt, EXMEM_memWrite, EXMEM_memRead, clk, reset);

    // MEM/WB stage register
    wire    [word - 1:0]        MEMWB_ALU_result,   MEMWB_read_mem;

    MEM_WB      memwb(MEMWB_memtoReg, MEMWB_regWrite, MEMWB_read_mem, MEMWB_ALU_result, MEMWB_regRd,
                clk, EXMEM_regWrite, EXMEM_memtoReg, MEM_read_mem, EXMEM_ALU_result, EXMEM_regRd);

    // WB stage
    mux_by_2    mem2reg(WB_write_data, MEMWB_memtoReg, MEMWB_ALU_result, MEMWB_read_mem);

    // branch hazard detection
    wire                        PCWrite1,       IFID_write1;
    wire                        ID_flush1;

    brc_hazard  brc_hazard_detect(forward1, forward2, PCWrite1, IFID_write1, ID_flush1, 
                ID_branch, IDEX_regWrite, EXMEM_regWrite, EXMEM_memRead, EX_regDst, EXMEM_regRd, IFID_instr[20:16], IFID_instr[25:21], clk);

    // lw hazard detection
    wire                        PCWrite2,       IFID_write2,    ID_flush2;

    lw_hazard   lw_hazard_detect(PCWrite2, IFID_write2, ID_flush2, IDEX_memRead, IFID_instr[25:21], IFID_instr[20:16], IDEX_regRt, clk);

    assign      PCWrite = PCWrite1 & PCWrite2;
    assign      IFID_write = IFID_write1 & IFID_write2;
    assign      ID_flush = ID_flush1 | ID_flush2;

    // R-type forwarding
    R_forward   forwarding(forwardA, forwardB, EXMEM_regWrite, MEMWB_regWrite, EXMEM_regRd, MEMWB_regRd, IDEX_regRs, IDEX_regRt, clk);
endmodule //pipeline