module Permutation (in, clk, rst, start, totalReady, ready, read, out);
    input [24:0]in;
    input clk,rst,start;
    output totalReady,ready,read;
    output [24:0]out;


    wire load,sel;
    CU cu(.clk(clk),.rst(rst),.start(start),.sel(sel),.ld(load),
            .totalReady(totalReady),.ready(ready),.read(read));
    DP dp(.in(in), .clk(clk), .rst(rst), .sel(sel), .load(load) , .out(out));
endmodule