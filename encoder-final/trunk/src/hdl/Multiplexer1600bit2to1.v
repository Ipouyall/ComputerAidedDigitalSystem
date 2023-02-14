`timescale 1ns/1ns
module Multiplexer1600bit2to1 (a0, a1, sel, w);
    input [1599:0]a0,a1;
    input sel;
    output [1599:0]w;

	assign w = ~sel ? a0:a1;
endmodule