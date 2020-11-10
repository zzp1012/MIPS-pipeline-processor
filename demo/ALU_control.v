`timescale 1ns / 1ps

module ALUcontrol(ALU_control, funct, ALU_op);
    input   [1:0]   ALU_op;
    input   [5:0]   funct;
    output  [3:0]   ALU_control;
    
    reg     [3:0]   ALU_control;
    
    initial begin
        ALU_control = 0;
    end
    
    always @ (funct or ALU_op) begin
        case (ALU_op)
            2'b00: ALU_control = 4'b0010;
            2'b01: ALU_control = 4'b0110;
            2'b11: ALU_control = 4'b0000;
            2'b10: begin
                case (funct)
                    6'b100000: ALU_control = 4'b0010;
                    6'b100010: ALU_control = 4'b0110;
                    6'b100101: ALU_control = 4'b0001;
                    6'b101010: ALU_control = 4'b0111;
                    6'b100100: ALU_control = 4'b0000; 
                    default:   ALU_control = 4'b0000;
                endcase
            end
            default: ALU_control <= 4'b0000;
        endcase
    end
endmodule
