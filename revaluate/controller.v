`include "ISA.v"

module Controller(
    input clk,
    input rst,
    input start,
    input datapath_done,

    output reg dataset_reset,
	output reg done,
	output reg write,
	output reg count
);
    reg [`LEN_STATE - 1:0] ns, ps;
    parameter [`LEN_STATE - 1:0]
        IDLE = 0,
        START = 1,
        COUNT = 2,
        DONE = 3;

    always @(posedge clk, posedge rst) begin
        if (rst) ps <= IDLE;
        else ps <= ns;
    end

    always @ (ps, start, datapath_done) begin
        case (ps)
            IDLE      : ns = start ? START : IDLE;
            START     : ns = COUNT;
            COUNT     : ns = datapath_done ? DONE : COUNT;
            DONE      : ns = IDLE;
            default: ns = IDLE;
        endcase
    end

    always @ (ps) begin
        dataset_reset = `DISABLE;
        done = `DISABLE;
        write = `DISABLE;
        count = `DISABLE;
        case (ps)
            IDLE: begin
                dataset_reset = `ENABLE;
            end
            START: begin
                write = `ENABLE;
            end
            COUNT: begin
                write = `ENABLE;
                count = `ENABLE;
            end
            DONE: begin
                done = `ENABLE;
            end
        endcase
    end
endmodule
