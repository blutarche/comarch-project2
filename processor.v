`timescale 1ns / 1ps

`include "./adder.v"
`include "./inst_rom.v"
`include "./controller.v"
`include "./mux.v"
`include "./signextender.v"
`include "./register.v"
`include "./alu.v"
`include "./data_memory.v"

module processor(clock, reset, serial_in, serial_valid_in, serial_ready_in, serial_rden_out, serial_out, serial_wren_out);
    input           clock, reset;
    input   [7:0]   serial_in;
    input           serial_ready_in;
    input           serial_valid_in;
    output  [7:0]   serial_out;
    output          serial_rden_out;
    output          serial_wren_out;
    reg     [31:0]  pc;
    wire    [31:0]  tmp_pc;

    parameter PC_START = 32'h003FFFFC;

    initial pc = PC_START;
    adder add4 (.i(pc), .o(tmp_pc));

    always @(negedge clock or posedge reset) begin
        if (reset) begin
            pc <= PC_START;
        end
        else if (inst==32'h00000000) begin
            $finish;
        end
        else begin
            pc <= tmp_pc;
        end
    end

    wire    [31:0]  inst;
    inst_rom get_inst(
        .clock(clock), 
        .reset(reset), 
        .addr_in(pc), 
        .data_out(inst)
        );


    wire            RegDst, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
    wire    [5:0]   ALUfunc;
    controller control(
        .opcode(inst[31:26]), 
        .funct(inst[5:0]), 
        .RegDst(RegDst), 
        .MemRead(MemRead), 
        .MemtoReg(MemtoReg), 
        .ALUop(ALUfunc), 
        .MemWrite(MemWrite),
        .ALUsrc(ALUsrc), 
        .RegWrite(RegWrite)
        );

    wire    [4:0]   write_reg;
    mux #(5) mux_reg (
        .n0(inst[20:16]),
        .n1(inst[15:11]),
        .select(RegDst),
        .result(write_reg)
        );

    wire    [31:0]  extended;
    signextender extend (
        .in(inst[15:0]),
        .out(extended)
        );

    wire    [31:0]  read_data1, read_data2, write_data;
    register regis_mod (
        .write_addr(write_reg), 
        .write_data(write_data), 
        .read_addr1(inst[25:21]), 
        .read_data1(read_data1), 
        .read_addr2(inst[20:16]), 
        .read_data2(read_data2), 
        .write(RegWrite), 
        .clk(clock)
        );
    
    wire    [31:0]  aluB;
    mux #(32) mux_alu (
        .n0(read_data2),
        .n1(extended),
        .select(ALUsrc),
        .result(aluB)
        );

    wire    [31:0]  aluOUT;
    wire            branch, jump;
    alu alu_god (
        .Func_in(ALUfunc), 
        .A_in(read_data1), 
        .B_in(aluB),
        .O_out(aluOUT),
        .Branch_out(branch), 
        .Jump_out(jump)
        );

    wire    [31:0]  memOUT;
    data_memory mem (
        .clock(clock),
        .reset(reset),
        .addr_in(aluOUT),
        .writedata_in(read_data2),
        .re_in(MemRead),
        .we_in(MemWrite),
        .size_in(2'b11),
        .readdata_out(memOUT),
        
        .serial_in(serial_in),
        .serial_ready_in(serial_ready_in),
        .serial_valid_in(serial_valid_in),
        .serial_out(serial_out),
        .serial_rden_out(serial_rden_out),
        .serial_wren_out(serial_wren_out)
        );

    mux #(32) mux_mem (
        .n0(aluOUT),
        .n1(memOUT),
        .select(MemtoReg),
        .result(write_data)
        );


endmodule