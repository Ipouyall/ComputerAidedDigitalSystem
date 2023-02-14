module Parity (in, out); // xor input bits
    parameter N = 5;

    input [N-1:0] in;
    output out;
    
    assign out = ^in;
endmodule
