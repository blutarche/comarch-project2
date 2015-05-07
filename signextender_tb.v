module signextender_tb;
    reg     [15:0]  n;
    wire    [31:0]  result;

    initial begin
        $dumpfile("signextender_tb.vcd");
        $dumpvars(0, signextender_tb);

        #1
        n = 16'b0001101010101011;

        #1
        n = 16'b1001101010101011;        

        #2 $finish;
    end

    signextender ex (.in(n), .out(result));

    initial begin
        $monitor("n = %b : result = %b", n, result);
    end


endmodule