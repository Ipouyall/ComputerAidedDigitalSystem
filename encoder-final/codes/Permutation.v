`timescale 1ns/1ns
`include "pr_DP.v"
`include "pr_CU.v"
module Permutation (in, clk, rst, start, ready, read, out);
    input [24:0] in;
    input clk, rst, start;
    output ready, read;
    output [24:0] out;

    wire load,sel;
    pr_CU cu(.clk(clk), .rst(rst), .start(start), .sel(sel), .ld(load),
           .ready(ready), .read(read));
    pr_DP dp(.in(in), .clk(clk), .rst(rst), .sel(sel), .load(load) , .out(out));
endmodule