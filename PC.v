`include "./adder.v"

module PC (pc, clk);
    input           clk;
    output  [31:0]  pc;
    reg     [31:0]  pc;
    wire    [31:0]  tmp;

    initial pc = 32'h003F_FFFC;

    adder addby4(.i(pc), .o(tmp));

    always @(posedge clk) begin
        pc <= tmp;
    end
endmodule