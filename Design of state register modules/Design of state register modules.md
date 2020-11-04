---
Author: Yihua Liu
Date: Nov 4, 2020 [Draft 1]
---

## The first design of state register modules

### ID/EX

```verilog
ID_EX UUTx(EX_RegDst, EX_MemRead, EX_MemtoReg, EX_ALUOp, EX_MemWrite, EX_ALUSrc, EX_RegWrite, EX_Registers_Read_data_1, EX_Registers_Read_data_2, EX_Sign_extend_out, ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd, Clock, ID_EX_Flush, ID_RegDst, ID_MemRead, ID_MemtoReg, ID_ALUOp, ID_MemWrite, ID_ALUSrc, ID_RegWrite, ID_Registers_Read_data_1, ID_Registers_Read_data_2, ID_Sign_extend_out, IF_ID_RegisterRs, IF_ID_RegisterRt, IF_ID_RegisterRd);
```

### EX/MEM

```verilog
EX_MEM UUTx(MEM_MemRead, MEM_MemtoReg, MEM_MemWrite, MEM_RegWrite, MEM_ALU_result, MEM_MUX6_out, MEM_MUX8_out, Clock, EX_MemRead, EX_MemtoReg, EX_MemWrite, EX_RegWrite, EX_ALU_result, EX_MUX6_out, EX_MUX8_out);
```

### MEM/WB

```verilog
MEM_WB UUTx(Clock, MEM_RegWrite, MEM_MemtoReg, MEM_Data_memory_Read_data, MEM_ALU_result, MEM_MUX8_out, WB_MemtoReg, WB_RegWrite, WB_Data_memory_Read_data, WB_ALU_result, WB_MUX8_out);
```

