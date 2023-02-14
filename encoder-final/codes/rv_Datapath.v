`timescale 1ns/1ns
module rv_Datapath (
    clk,
    rst,
    input_ld,
    output_ld,

    data,

    new_data
);
    input clk, rst;
    input input_ld, output_ld;
    input [24:0] data;

    output [24:0] new_data;

    wire [24:0] p_in;
    wire [24:0] p_out;

    rv_Register #(25) input_val(.clk(clk), .rst(rst), .ld(input_ld), .input_data(data), 
        .output_data(p_in));

    Revaluate permuter(.p_in(p_in), 
        .p_out(p_out));

    rv_Register #(25) output_val(.clk(clk), .rst(rst), .ld(output_ld), .input_data(p_out), 
        .output_data(new_data));

    
endmodule