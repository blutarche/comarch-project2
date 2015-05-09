module adder_tb;
    reg     [31:0]  n;
    wire    [31:0]  result;

    initial begin
        $dumpfile("adder_tb.vcd");
        $dumpvars(0, adder_tb);

        #1
        n = 32'd143;


        #2 $finish;
    end

    adder add4 (.i(n), .o(result));

    initial begin
        $monitor("n = %d : result = %d", n, result);
    end


endmodule