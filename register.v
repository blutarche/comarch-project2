module register (write_addr, write_data, read_addr1, read_data1, read_addr2, read_data2, write, clk); 
    input   [4:0]   write_addr, read_addr1, read_addr2;
    input   [31:0]  write_data;
    input           write, clk;
    output  [31:0]  read_data1,read_data2;
    reg     [31:0]  registers [0:31];
    reg     [5:0]   k;

    initial begin
        for (k = 0; k < 32; k = k + 1) begin
            registers[k] = k;
        end
    end

    always @(posedge clk) begin
        if (write) begin
            registers[write_addr] = write_data;
        end
    end
    
    assign read_data1 = registers[read_addr1]; 
    assign read_data2 = registers[read_addr2];
endmodule