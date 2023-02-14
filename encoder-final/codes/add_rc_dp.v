`timescale 1ns/1ns
`include "counter6bit.v"
`include "Data_mem.v"
`include "LUT.v"
`include "Multiplexer1bit64to1.v"
`include "Multiplexer25bit2to1.v"
`include "addrc_Register.v"

module add_rc_dp(clk, rst, ld, in, sel_in, address, inc_counter, counter_rst, write, out, co);
    input clk, rst, ld;
    input [24:0]in [0:63];
    input sel_in;
    input[4:0]address;
    input inc_counter, counter_rst, write;
    output [24:0]out[63:0];
    output co;

    wire[24:0] reg_in, reg_out, read_data;
    wire[63:0] lut_out;
    wire [5:0]counter_out;
    wire rc;
    Data_mem out_memory(.clk(clk), .mem_write(write), .addr(counter_out), .write_data(reg_out),.read_data(read_data),.out(out));
    counter6bit counter(.clk(clk), .rst(rst), .counter_rst(counter_rst), .inc_counter(inc_counter), .count(counter_out), .co(co));

    LUT lut(.clk(clk), .addr(address), .q(lut_out));

    Multiplexer1bit64to1 mux64(.in(lut_out), .sel(counter_out), .out(rc));

    assign xor_out=reg_out[12]^rc;

    Multiplexer25bit2to1 mux25(.a0(in[counter_out]), .a1({reg_out[24:13],xor_out,reg_out[11:0]}), .sel(sel_in), .w(reg_in));

    addrc_Register regist(.clk(clk), .rst(rst), .ld(ld), .PI(reg_in), .PO(reg_out));



endmodule