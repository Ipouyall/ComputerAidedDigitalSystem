`include "ISA.v"

module Revaluate(
    input clk,
    input rst,
    input start,

    input [`NUM_CELLS - 1:0] data_in,

    output done,
    output [`NUM_CELLS - 1:0] data_out
);
    wire controller_reset_signal, controller_write_signal, controller_count_signal;
    wire datapath_done_signal;
    RevaluateDP revaluate(
        .clk(clk),
        .rst(controller_reset_signal),
        .data_in(data_in),

        .count(controller_count_signal),
        .write(controller_write_signal),

        .done(datapath_done_signal),
        .data_out(data_out)
    );
    Controller controller(
        .clk(clk),
        .rst(rst),
        .start(start),
        .datapath_done(datapath_done_signal),

        .dataset_reset(controller_reset_signal),
        .done(done),
        .write(controller_write_signal),
        .count(controller_count_signal)
    );
endmodule
