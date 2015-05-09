module mux  #(parameter wd=1) (
    input   [wd-1:0]    n0,
    input   [wd-1:0]    n1,
    input               select,
    output  [wd-1:0]    result
    );

    assign result = (select) ? n1 : n0;

endmodule