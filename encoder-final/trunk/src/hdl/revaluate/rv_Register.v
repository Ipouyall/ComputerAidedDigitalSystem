`timescale 1ns/1ns
module rv_Register (
    clk,
    rst,
    ld,
    input_data,

    output_data,
);
    parameter size = 3;

    input clk, rst;
    input ld;
    input [size-1:0] input_data;

    output reg [size-1:0] output_data;

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            output_data = {size{1'b0}};
        end

        else if (ld) begin
            output_data = input_data;
        end
        
    end

endmodule