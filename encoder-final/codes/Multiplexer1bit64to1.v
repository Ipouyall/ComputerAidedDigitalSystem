`timescale 1ns/1ns
module Multiplexer1bit64to1(in, sel, out);
    input[63:0] in;
    input[5:0] sel;
    output out;

    assign out=in[6'd63-sel];

endmodule