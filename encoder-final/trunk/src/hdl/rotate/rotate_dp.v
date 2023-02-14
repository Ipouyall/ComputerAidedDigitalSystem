module rotate_dp (
    clk, cnt, rst, shift, r_ld, c_ld, r_cnt, r_rst, 
    read, write, load, save,
    Done, ended
    );

    input clk, cnt, rst, shift, r_ld, c_ld, r_cnt, r_rst;
    input read, write, load, save;
    output Done, ended;

    wire [63:0] in_lane, out_lane;
    wire [4:0]  index;

    memoryfile mm(
        clk, read, write, load, save, index, in_lane, out_lane
        );
    modulo25 cm(5'd0, 1'b0, cnt, rst, clk, Done, index);
    rotator rtr(out_lane, index, shift, r_ld, c_ld, r_cnt, r_rst, clk, ended, in_lane);
endmodule
