`timescale 1ns/1ns
`include "add_rc_dp.v"
`include "add_rc_cu.v"
module add_rc(in, address, clk, rst, start, out, done);
    input [24:0]in [0:63];
    input[4:0]address;
    input clk, rst, start;
    output [24:0]out[0:63];
    output done;

    wire ld, sel, inc_counter, counter_rst, write, co;

    add_rc_dp dp(.clk(clk), .rst(rst), .ld(ld), .in(in), .sel_in(sel), .address(address),
     .inc_counter(inc_counter), .counter_rst(counter_rst), .write(write), .out(out), .co(co));

     add_rc_cu cu(.clk(clk), .rst(rst), .start(start), .co(co), .sel(sel), .ld(ld), .done(done),
      .write(write), .counter_rst(counter_rst), .inc_counter(inc_counter));

endmodule