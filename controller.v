module controller (op, RegDst, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);
    input   [5:0]   op;
    output          RegDst, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
    output  [5:0]   ALUop;

    parameter R_FORMAT  = 6'b000000;
    parameter LW        = 6'b100011;
    parameter SW        = 6'b101011;
    parameter BEQ       = 6'b000100;
    parameter BNE       = 6'b000101;
    parameter J         = 6'b000010;
    parameter ADDI      = 6'b001000;

    always @(op)
    begin
        case (op)
            R_FORMAT : 
            begin
              RegDst=1'b1; 
              ALUSrc=1'b0; 
              MemtoReg=1'b0; 
              RegWrite=1'b1; 
              MemRead=1'b0; 
              MemWrite=1'b0; 
              ALUOp = 2'b10;
            end
            LW :
            begin
              RegDst=1'b0; 
              ALUSrc=1'b1; 
              MemtoReg=1'b1; 
              RegWrite=1'b1; 
              MemRead=1'b1; 
              MemWrite=1'b0; 
              ALUOp = 6'b100000;
            end
            SW :
            begin
              RegDst=1'bx; 
              ALUSrc=1'b1; 
              MemtoReg=1'bx; 
              RegWrite=1'b0; 
              MemRead=1'b0; 
              MemWrite=1'b1; 
              ALUOp = 6'b100000;
            end
            ADDI :
            begin
              RegDst=1'b0; ALUSrc=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOp = 2'b00;
            end


        endcase
    end

endmodule