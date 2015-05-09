module reg_tb;
    reg     [5:0]   index;
    wire    [31:0]  result, waste;
    reg             clk = 0;

    initial begin
        $dumpfile("reg_tb.vcd");
        $dumpvars(0, reg_tb);

        #1
        for (index = 0; index < 32 ; index = index + 1) begin
            #2 ;
        end

        #2 $finish;
    end

    always #1 clk <= !clk;

    register regtest (5'd0, 32'd0, index[4:0], result, 5'd0, waste, 1'b0, clk);

    initial begin
        $monitor("clk = %b : n = %d : result = %d", clk, index, result);
    end


endmodule