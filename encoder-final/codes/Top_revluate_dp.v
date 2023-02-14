`timescale 1ns/1ns
module Top_revaluate_dp(clk, rst, start_instances, in, out, all_ready);
    input clk, rst, start_instances;
    input [24:0]in [0:63];
    output [24:0]out[0:63];
    output all_ready;

    wire [63:0]readyes;
    genvar i;
    generate
        for (i=0;i<64;i=i+1)begin
            Revaluate_combine uut(.clk(clk), .rst(rst), .start(start_instances), .data(in[i]), .new_data(out[i]),.ready(readyes[i]));
        end
    endgenerate

    assign all_ready= &readyes;

endmodule