module ColParity(clk, start, reset, In, Ready, Out, Done, page_index);
    input clk, start, reset;
    input [24:0] In;
    output Ready, Done;
    output [24:0] Out;
    output [5:0] page_index;


    cp_Datapath dp(clk, In,
                rst1,ld1,shift,
                rst2,ld2,
                rst3,ld3,
                id_rst,inc_i,
                done, Out);

    cp_Controller cu(clk, reset, start, done, 
                    Ready, Done,
                    ld1, ld2, ld3, 
                    rst1, rst2, rst3, shift,
                    id_rst, inc_i, page_index);

endmodule
