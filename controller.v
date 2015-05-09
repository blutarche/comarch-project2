module controller (opcode, funct, RegDst, MemRead, MemtoReg, ALUop, MemWrite, ALUsrc, RegWrite);
    input   [5:0]   opcode, funct;
    output          RegDst, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
    output  [5:0]   ALUop;
    reg             RegDst, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
    reg     [5:0]   ALUop;

    parameter R_FORMAT  = 6'b000000;
    parameter LW        = 6'b100011;
    parameter SW        = 6'b101011;
    parameter ADDI      = 6'b001000;
    parameter ANDI      = 6'b001100;
    parameter ORI       = 6'b001101;
    parameter XORI      = 6'b001110;
    parameter SLTI      = 6'b001010;

    parameter ADD       = 6'b100000;
    parameter SUB       = 6'b100010;
    parameter AND       = 6'b100100;
    parameter OR        = 6'b100101;
    parameter XOR       = 6'b100110;
    parameter SLT       = 6'b101010;

    always @(opcode) begin
        case (opcode)
            R_FORMAT: begin
                RegDst      = 1'b1; 
                ALUsrc      = 1'b0; 
                MemtoReg    = 1'b0; 
                RegWrite    = 1'b1; 
                MemRead     = 1'b0; 
                MemWrite    = 1'b0; 
                ALUop       = funct;
            end
            LW: begin
                RegDst      = 1'b0; 
                ALUsrc      = 1'b1; 
                MemtoReg    = 1'b1; 
                RegWrite    = 1'b1; 
                MemRead     = 1'b1; 
                MemWrite    = 1'b0;
                ALUop       = ADD; 
            end
            SW: begin
                RegDst      = 1'b1; 
                ALUsrc      = 1'b1; 
                MemtoReg    = 1'b1; 
                RegWrite    = 1'b0; 
                MemRead     = 1'b0; 
                MemWrite    = 1'b1;
                ALUop       = ADD; 
            end
            // Immediate function
            default: begin      
                RegDst      = 1'b0; 
                ALUsrc      = 1'b1; 
                MemtoReg    = 1'b0; 
                RegWrite    = 1'b1; 
                MemRead     = 1'b0; 
                MemWrite    = 1'b0; 
                case (opcode)
                    ADDI:   ALUop = ADD;
                    ANDI:   ALUop = AND;
                    ORI:    ALUop = OR;
                    XORI:   ALUop = XOR;
                    SLTI:   ALUop = SLT;
                endcase
            end
        endcase
    end



endmodule