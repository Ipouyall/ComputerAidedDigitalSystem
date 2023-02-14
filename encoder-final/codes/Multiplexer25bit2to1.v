`timescale 1ns/1ns
module Multiplexer25bit2to1 (a0, a1, sel, w);
    input [24:0]a0,a1;
    input sel;
    output [24:0]w;

	assign w = ~sel ? a0:a1;
endmodule