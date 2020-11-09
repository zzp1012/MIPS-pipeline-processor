`timescale 1ns / 1ps

module control(RegDst, Jump, Branch, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite, Beq, op);
    input   [5:0]   op;
    output          RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Beq;
    output  [1:0]   ALUop;

    reg             RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Beq;
    reg     [1:0]   ALUop;
    
    initial begin
        ALUop = 2'b00; RegDst = 0; Jump = 0; Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; Beq = 0;
    end

    always @(op) begin
        case (op)
            // lw
            6'b100011: begin
                ALUop = 2'b00; RegDst = 0; Jump = 0; Branch = 0; MemRead = 1; MemtoReg = 1; MemWrite = 0; ALUSrc = 1; RegWrite = 1; Beq = 0;
            end

            // sw
            6'b101011: begin
                ALUop = 2'b00; RegDst = 0; Jump = 0; Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 1; ALUSrc = 1; RegWrite = 0; Beq = 0;
            end

            // R-type
            6'b000000: begin
                ALUop = 2'b10; RegDst = 1; Jump = 0; Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 1; Beq = 0;
            end

            // addi
            6'b001000: begin
                ALUop = 2'b00; RegDst = 0; Jump = 0; Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; Beq = 0;
            end

            // andi
            6'b001100: begin
                ALUop = 2'b11; RegDst = 0; Jump = 0; Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 1; RegWrite = 1; Beq = 0;
            end

            // beq
            6'b000100: begin
                ALUop = 2'b01; RegDst = 0; Jump = 0; Branch = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; Beq = 1;
            end

            // bne
            6'b000101: begin
                ALUop = 2'b01; RegDst = 0; Jump = 0; Branch = 1; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; Beq = 0;
            end

            // j
            6'b000010: begin
                ALUop = 2'b00; RegDst = 0; Jump = 1; Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; Beq = 0;
            end
            
            default: begin
                ALUop = 2'b00; RegDst = 0; Jump = 0; Branch = 0; MemRead = 0; MemtoReg = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; Beq = 0;
            end
        endcase
    end
endmodule
