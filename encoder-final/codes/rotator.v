module rotator (lane, l_n, shift, r_ld, c_ld, cnt, rst, clk, co, rotated);
    input [63:0] lane;
    input [4:0] l_n;
    input shift, r_ld, c_ld, cnt, rst, clk;
    output co;
    output[63:0] rotated;

    wire [5:0] rot_value, rot_needed;
    wire [5:0] modulo_value;

    RotateRoM rr(clk, l_n, rot_value);
    complement2 c2(rot_value, rot_needed);
    modulo64 m64(rot_needed, c_ld, cnt, rst, clk, co, modulo_value);

    wire shift_in, shift_out;
    wire [63:0] content;
    ShiftLeftRegister64 srg(lane, r_ld, rst, clk, shift, shift_in, content, shift_out);

    assign shift_in = shift_out;
    assign rotated = content;

endmodule
