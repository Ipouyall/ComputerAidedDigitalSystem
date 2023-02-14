module Revaluate_combine(clk, rst, start, data, new_data,ready);
    input clk, rst, start;
    input [24:0] data;
    output [24:0] new_data;
    output ready;

    wire input_ld, output_ld;
    rv_Controller c(
        clk,
        rst,
        start,
        ready,
        input_ld,
        output_ld
    );

    rv_Datapath dp(
        clk,
        rst,
        input_ld,
        output_ld,
        data,
        new_data
    );

endmodule