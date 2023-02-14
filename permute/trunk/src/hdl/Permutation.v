module Permutation (in, clk, rst, start, total_ready, ready, read, out);
    input [24:0] in;
    input clk, rst, start;
    output total_ready, ready, read;
    output [24:0] out;

    wire load,sel;
    CU cu(.clk(clk), .rst(rst), .start(start), .sel(sel), .ld(load),
          .total_ready(total_ready), .ready(ready), .read(read));
    DP dp(.in(in), .clk(clk), .rst(rst), .sel(sel), .load(load) , .out(out));
endmodule