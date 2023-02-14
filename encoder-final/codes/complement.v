module complement2 (in, out);
    parameter N = 6;
    input [N-1:0] in;
    output [N-1:0] out;

    assign out = (~in) + 1;
    
endmodule