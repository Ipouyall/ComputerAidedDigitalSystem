`timescale 1ns/1ns
module encoder_DP (clk, reset, load, save, next_round, r_rst, cp_start, cp_rst,
     rt_rst, rt_start, pr_rst, pr_start, rv_rst, rv_start, rc_rst, rc_start,
      raw_data, sel, completed, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, encoded);
    input clk, reset, load, save, next_round, r_rst, cp_start, cp_rst, rt_rst, rt_start,
     pr_rst, pr_start, rv_rst, rv_start, rc_rst, rc_start;
    input[1599:0]raw_data;
    input sel;
    output completed, cp_Ready, rt_Ready, pr_done, rv_done, rc_done;
    output [1599:0]encoded;


    wire [1599:0]mux_out;
    wire [1599:0]cycle_data;
    wire write_done;
    wire[5:0]page;
    wire[4:0]round;
    wire[24:0]data;
    wire[24:0]page_data;
    wire[24:0]addrc_out[0:63];
    wire[24:0]pr_out[0:63];
    wire[24:0]rev_out[0:63];

    Multiplexer1600bit2to1 mux(.a0(raw_data), .a1(cycle_data), .sel(sel), .w(mux_out));
    my_memory memory(.clk(clk), .write(write_done), .load(load), .save(save),
     .init_data(mux_out), .page(page), .data(data), .out(page_data));
     ColParity colparity(.clk(clk), .start(cp_start), .reset(cp_rst),
      .In(page_data), .Ready(cp_Ready), .Out(data), .Done(write_done), .page_index(page));


    rotate rt(.clk(clk), .reset(rt_rst), .start(rt_start), .Ready(rt_Ready));

    Top_permute tp(.clk(clk), .rst(pr_rst), .start(pr_start), .out(pr_out), .done(pr_done));

    Top_revaluate rev(.clk(clk), .rst(rv_rst), .start(rv_start), .in(pr_out), .out(rev_out), .done(rv_done));

    modulo24 counter(.cnt(next_round), .rst(r_rst), .clk(clk), .co(completed), .content(round));

    add_rc arc(.in(rev_out), .address(round), .clk(clk), .rst(rc_rst), .start(rc_start), .out(addrc_out), .done(rc_done));

    output_convertor deconv(.in(addrc_out), .out(encoded));

    assign cycle_data=encoded;

    
endmodule