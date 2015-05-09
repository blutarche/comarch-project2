module reg_tb;
    reg     [4:0]   i1, i2, wa;
    wire    [31:0]  o1, o2;
    reg             w;
    reg     [31:0]  wd;
    reg             clk = 0;

    initial begin
        $dumpfile("reg_tb.vcd");
        $dumpvars(0, reg_tb);

        #1
        w = 1;
        wa = 15;
        wd = 1234;
        #2
        i1 = 15;
        w = 0;
        wa = 0;
        wd = 0;
        #2
        w = 1;
        wa = 30;
        wd = 56781;
        #2
        i1 = 30;
        i2 = 15;
        w = 0;
        wa = 0;
        wd = 0;



        #2 $finish;
    end

    always #1 clk <= !clk;

    register regtest(wa, wd, i1, o1, i2, o2, w, clk);

    initial begin
        $monitor("reg1[%d] = %d : reg2[%d] = %d : write? = %b : regw[%d] = %d", i1, o1, i2, o2, w, wa, wd);
    end


endmodule