`timescale 1ns/1ns
module Top_permute(clk, rst, start, out, done);
    input clk, rst, start;
    output[24:0]out[0:63];
    output done;

    wire read_mem, start_instances, all_done;

    Top_Permute_dp dp(clk, rst, read_mem, start_instances, out, all_done);
    Top_Permute_cu cu(clk, rst, start, all_done, read_mem, start_instances, done);


endmodule