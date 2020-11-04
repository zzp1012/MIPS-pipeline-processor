module EX_MEM (MEM_MemRead, MEM_MemtoReg, MEM_MemWrite, MEM_RegWrite, MEM_ALU_result, MEM_MUX4_out, MEM_MUX6_out, Clock, EX_MemRead, EX_MemtoReg, EX_MemWrite, EX_RegWrite, EX_ALU_result, EX_MUX4_out, EX_MUX6_out);
    parameter rwidth = 5;
    parameter word = 32;
    input Clock, EX_MemRead, EX_MemtoReg, EX_MemWrite, EX_RegWrite;
    input [rwidth - 1:0] EX_MUX8_out;
    input [word - 1:0] EX_ALU_result, EX_MUX6_out;
    output MEM_MemRead, MEM_MemtoReg, MEM_MemWrite, MEM_RegWrite;
    output [rwidth - 1:0] MEM_MUX8_out;
    output [word - 1:0] MEM_ALU_result, MEM_MUX6_out;
    reg MEM_MemRead, MEM_MemtoReg, MEM_MemWrite, MEM_RegWrite;
    reg [rwidth - 1:0] MEM_MUX8_out;
    reg [word - 1:0] MEM_ALU_result, MEM_MUX6_out;
    always @ (posedge Clock) begin
        MEM_MemRead <= EX_MemRead;
        MEM_MemtoReg <= EX_MemtoReg;
        MEM_MemWrite <= EX_MemWrite;
        MEM_RegWrite <= EX_RegWrite;
        MEM_ALU_result <= EX_ALU_result;
        MEM_MUX6_out <= EX_MUX6_out;
        MEM_MUX8_out <= EX_MUX8_out;
    end
endmodule