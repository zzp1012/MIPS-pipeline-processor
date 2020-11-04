//assuming branch not taken
module Hazard_detection
(
     input       ID_EX_MemRead, jump, bne, beq, is_equal, 
     input [4:0] ID_EX_RegisterRt, IF_ID_RegisterRs, 
                 IF_ID_RegisterRt, 
     output      PC_Write, IF_ID_Write, Hazard_load, IF.Flush,
);
     //Load_use hazard detection：
     assign PC_Write =(
               (ID_EX_MemRead == 1'b1) && ((ID_EX_RegisterRt == 
               IF_ID_RegisterRs) || (ID_EX_RegisterRt == 
               IF_ID_RegisterRt))
               )? 1 : 0;
     assign IF_ID_Write = PC_Write;
     assign Hazard_load = PC_Write;
     //Branch hazard detection:
     assign IF_Flush=(jump||(bne&&(!is_equal)==1'b1)||(beq&&is_equal==1'b1))?1:0;
endmodule