module rotate (clk, reset, start, mem_in, Ready, mem_out);
    input clk, reset, start;
    input [24:0]mem_in [0:63];
    output Ready;
    output [24:0]mem_out [0:63];

    wire Done, ended, cnt, rst, shift, r_ld, c_ld, r_cnt, r_rst;

    rotate_dp dp (
        mem_in, clk, cnt, rst, shift, r_ld, c_ld, r_cnt, r_rst, 
        mem_out, Done, ended
        );
    rotate_cu cu(clk, reset, start, ended, Done, Ready, rst, r_rst, ld, cnt, r_ld, r_cnt, c_ld, shift);
endmodule