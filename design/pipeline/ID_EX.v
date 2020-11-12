module ID_EX(EX_RegDst, EX_MemRead, EX_MemtoReg, EX_ALUOp, EX_MemWrite, EX_ALUSrc, 
            EX_RegWrite, EX_Registers_Read_data_1, EX_Registers_Read_data_2, 
            EX_Sign_extend_out, ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd, 
            Clock, ID_EX_Flush, ID_RegDst, ID_MemRead, ID_MemtoReg, ID_ALUOp, 
            ID_MemWrite, ID_ALUSrc, ID_RegWrite, ID_Registers_Read_data_1, 
            ID_Registers_Read_data_2, ID_Sign_extend_out, IF_ID_RegisterRs, IF_ID_RegisterRt, IF_ID_RegisterRd);
    parameter sel = 2;      // sel means the width of ALUOp
    parameter rwidth = 5;   // rwidth means the width of the a register number
    parameter word = 32;
    input                       Clock, ID_EX_Flush,         ID_RegDst,                  ID_MemRead,         ID_MemtoReg,    ID_MemWrite,    ID_ALUSrc,  ID_RegWrite;
    input   [sel - 1:0]         ID_ALUOp;
    input   [rwidth - 1:0]      IF_ID_RegisterRs,           IF_ID_RegisterRt,           IF_ID_RegisterRd;
    input   [word - 1:0]        ID_Registers_Read_data_1,   ID_Registers_Read_data_2,   ID_Sign_extend_out;
    output                      EX_RegDst,                  EX_MemRead, EX_MemtoReg,    EX_MemWrite,        EX_ALUSrc,      EX_RegWrite;
    output  [sel - 1:0]         EX_ALUOp;
    output  [rwidth - 1:0]      ID_EX_RegisterRs,           ID_EX_RegisterRt,           ID_EX_RegisterRd;
    output  [word - 1:0]        EX_Registers_Read_data_1,   EX_Registers_Read_data_2,   EX_Sign_extend_out;
    reg                         EX_RegDst,                  EX_MemRead, EX_MemtoReg,    EX_MemWrite,        EX_ALUSrc,      EX_RegWrite;
    reg     [sel - 1:0]         EX_ALUOp;
    reg     [rwidth - 1:0]      ID_EX_RegisterRs,           ID_EX_RegisterRt,           ID_EX_RegisterRd;
    reg     [word - 1:0]        EX_Registers_Read_data_1,   EX_Registers_Read_data_2,   EX_Sign_extend_out;

    initial begin
        EX_RegDst   <= 0;
        EX_MemRead  <= 0;
        EX_MemtoReg <= 0;
        EX_ALUOp    <= 0;
        EX_MemWrite <= 0;
        EX_ALUSrc   <= 0;
        EX_RegWrite <= 0;
        EX_Registers_Read_data_1    <= 0;
        EX_Registers_Read_data_2    <= 0;
        EX_Sign_extend_out          <= 0;
        ID_EX_RegisterRs            <= 0;
        ID_EX_RegisterRt            <= 0;
        ID_EX_RegisterRd            <= 0;
    end

    always @ (posedge Clock) begin
        if (ID_EX_Flush == 1'b1) begin
            EX_RegDst   <= 0;
            EX_MemRead  <= 0;
            EX_MemtoReg <= 0;
            EX_ALUOp    <= 0;
            EX_MemWrite <= 0;
            EX_ALUSrc   <= 0;
            EX_RegWrite <= 0;
        end
        else begin
            EX_RegDst   <= ID_RegDst;
            EX_MemRead  <= ID_MemRead;
            EX_MemtoReg <= ID_MemtoReg;
            EX_ALUOp    <= ID_ALUOp;
            EX_MemWrite <= ID_MemWrite;
            EX_ALUSrc   <= ID_ALUSrc;
            EX_RegWrite <= ID_RegWrite;
        end
        EX_Registers_Read_data_1    <= ID_Registers_Read_data_1;
        EX_Registers_Read_data_2    <= ID_Registers_Read_data_2;
        EX_Sign_extend_out          <= ID_Sign_extend_out;
        ID_EX_RegisterRs            <= IF_ID_RegisterRs;
        ID_EX_RegisterRt            <= IF_ID_RegisterRt;
        ID_EX_RegisterRd            <= IF_ID_RegisterRd;
    end
endmodule