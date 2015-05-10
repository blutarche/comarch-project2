module mux_tb;
    reg     [31:0]  n32_0;
    reg     [31:0]  n32_1;
    reg             select;

    reg     [3:0]   n4_0;
    reg     [3:0]   n4_1;

    wire    [31:0]  out32;
    wire    [3:0]  out4;

    initial begin
        $dumpfile("mux_tb.vcd");
        $dumpvars(0, mux_tb);    

        #1
        n32_0   = 1234;
        n32_1   = 5678;
        n4_0    = 5;
        n4_1    = 11;

        #1
        select  = 0;

        #1
        select  = 1;


        #2 $finish;
    end

    mux #(32) m32 (.n0(n32_0), .n1(n32_1), .select(select), .result(out32));
    mux #(4) m4 (.n0(n4_0), .n1(n4_1), .select(select), .result(out4));

    initial begin
        $monitor("n32_0 = %d : n32_1 = %d : select = %d : output = %d ... n4_0 = %d : n4_1 = %d : select = %d : output = %d", 
            n32_0, n32_1, select, out32, n4_0, n4_1, select, out4);
    end


endmodule