module MEM_WB (Clock, MEM_RegWrite, MEM_MemtoReg, MEM_Data_memory_Read_data, MEM_ALU_result, MEM_MUX8_out, WB_MemtoReg, WB_RegWrite, WB_Data_memory_Read_data, WB_ALU_result, WB_MUX8_out);
    parameter rwidth = 5;
    parameter word = 32;
    input Clock, MEM_RegWrite, MEM_MemtoReg;
    input [rwidth - 1:0] MEM_MUX8_out;
    input [word - 1:0] MEM_Data_memory_Read_data, MEM_ALU_result;
    output WB_MemtoReg, WB_RegWrite;
    output [rwidth - 1:0] WB_MUX8_out;
    output [word - 1:0] WB_Data_memory_Read_data, WB_ALU_result;
    reg WB_MemtoReg, WB_RegWrite;
    reg [rwidth - 1:0] WB_MUX8_out;
    reg [word - 1:0] WB_Data_memory_Read_data, WB_ALU_result;
    always @ (posedge Clock) begin
        WB_MemtoReg <= MEM_MemtoReg;
        WB_RegWrite <= MEM_RegWrite;
        WB_Data_memory_Read_data <= MEM_Data_memory_Read_data;
        WB_ALU_result <= MEM_ALU_result;
        WB_MUX8_out <= MEM_MUX8_out;
    end
endmodule