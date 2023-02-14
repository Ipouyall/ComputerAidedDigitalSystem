`timescale 1ns/1ns
module rv_Controller (
    clk,
    rst,
    start,

    ready,
    input_ld,
    output_ld
);  
    input clk, rst;
    input start;

    output reg ready;
    output reg input_ld, output_ld;

    parameter [1:0] 
        Start = 2'd0,
        Read = 2'd1,
        Write = 2'd2;

    reg [1:0] ps, ns;

    always @(ps, start) begin
        case (ps)
            Start:  ns = start ? Read : Start;
            Read:   ns = Write;
            Write:  ns = Start;
            default: ns = Start;
        endcase
    end

    always @(ps) begin
        {ready, input_ld, output_ld} = 0;
        case (ps)
            Start:      begin
                ready = 1'b1;
            end
            Read:       begin
                input_ld = 1'b1;
            end
            Write: begin
                output_ld = 1'b1;
            end 
        endcase
    end

    always @(posedge clk, posedge rst) begin
        if(rst)
            ps <= Start;
        else
            ps <= ns;
    end


endmodule