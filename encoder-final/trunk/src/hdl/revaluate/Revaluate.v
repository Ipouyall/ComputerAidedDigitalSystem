`timescale 1ns/1ns
module Revaluate (
    p_in,

    p_out
);

    input [24:0] p_in;

    output [24:0] p_out;

    genvar i, j;
    

    generate 
        for(j = 4; j >= 0; j=j-1)
            for(i = 4; i >= 0; i=i-1)
                assign p_out[j*5+i] = p_in[i+5*j] ^ (!p_in[((5+i-1)%5)+j*5] && p_in[j*5+(5+i-2)%5]);
    endgenerate
    
endmodule
