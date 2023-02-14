module rotate (clk, reset, start, Ready);
    input clk, reset, start;
    output Ready;

    wire Done, ended, cnt, rst, shift, r_ld, c_ld, r_cnt, r_rst;
    wire read, write, load, save;

    rotate_dp dp(
        clk, cnt, rst, shift, r_ld, c_ld, r_cnt, r_rst, 
        read, write, load, save,
        Done, ended
        );

    rotate_cu cu(clk, reset, start, ended, Done, Ready, 
        rst, r_rst, ld, cnt, r_ld, r_cnt, c_ld, shift,
        read, write, load, save
        );
endmodule