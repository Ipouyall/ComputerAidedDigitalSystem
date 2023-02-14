`timescale 1ns/1ns
`include "encoder_DP.v"
`include "encoder_CU.v"
module encoder(clk, reset, start, raw_data, encoded, Ready);
    input clk, reset, start;
    input [1599:0]raw_data;
    output [1599:0]encoded;
    output Ready;

    wire load, save, next_round, r_rst, cp_start, cp_rst,
     rt_rst, rt_start, pr_rst, pr_start, rv_rst, rv_start, rc_rst, rc_start,
     sel, completed, cp_Ready, rt_Ready, pr_done, rv_done, rc_done;
    
    encoder_DP dp(clk, reset, load, save, next_round, r_rst, cp_start, cp_rst,
     rt_rst, rt_start, pr_rst, pr_start, rv_rst, rv_start, rc_rst, rc_start,
      raw_data, sel, completed, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, encoded);

    encoder_CU cu(clk, reset, start, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, completed,
        Ready, sel, load, r_rst, save, next_round,
        cp_rst, cp_start, 
        rt_rst, rt_start,
        pr_rst, pr_start,
        rv_rst, rv_start,
        rc_rst, rc_start,
        );

endmodule