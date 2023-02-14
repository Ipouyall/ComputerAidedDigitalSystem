`timescale 1ns/1ns
module Top_revaluate(clk, rst, start, in, out, done);
    input clk, rst, start;
    input [24:0]in [0:63];
    output [24:0]out[0:63];
    output done;

    wire start_instances, all_ready;
    Top_revluate_cu cu(.clk(clk), .rst(rst), .start(start),
     .all_ready(all_ready), .start_instances(start_instances), .ready(done));
    Top_revaluate_dp dp(.clk(clk), .rst(rst), .start_instances(start_instances),
     .in(in), .out(out), .all_ready(all_ready));

endmodule