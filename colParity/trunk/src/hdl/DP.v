module Datapath(clk, In,
                rst1, ld1, shift,
                rst2, ld2,
                rst3, ld3,
                id_rst, inc_i,
                done, Out);

    input clk;
    input [24:0] In;
    input rst1, ld1, shift;
    input rst2, ld2;
    input rst3, ld3;
    input id_rst, inc_i;
    output done;
    output [24:0] Out;

    wire [24:0] matrix;
    wire p_elem;
    ShiftLeftRegister mtx(.in(In), .ld(ld1), .rst(rst1), .clk(clk), .shift(shift), .shift_in(p_elem), .out(matrix));

    wire [2:0] i, j;
    wire i_co, j_co;

    CounterModulo5 cm_i(.clk(clk), .reset(id_rst), .inc(inc_i), .value(i), .co(i_co));
    CounterModulo5 cm_j(.clk(i_co), .reset(id_rst), .inc(1'b1), .value(j), .co(j_co));
    assign done = j_co;

    wire [4:0] curr_parity, prev_parity;
    wire parity_c1, parity_c2, parity_c3, parity_c4, parity_c5;
    Parity c1(.in({matrix[24],matrix[19],matrix[14],matrix[9],matrix[4]}), .out(parity_c1));
    Parity c2(.in({matrix[23],matrix[18],matrix[13],matrix[8],matrix[3]}), .out(parity_c2));
    Parity c3(.in({matrix[22],matrix[17],matrix[12],matrix[7],matrix[2]}), .out(parity_c3));
    Parity c4(.in({matrix[21],matrix[16],matrix[11],matrix[6],matrix[1]}), .out(parity_c4));
    Parity c5(.in({matrix[20],matrix[15],matrix[10],matrix[5],matrix[0]}), .out(parity_c5));

    Register cp(.in({parity_c1,parity_c2,parity_c3,parity_c4,parity_c5}), .ld(ld2), .clk(clk), .rst(rst2), .out(curr_parity));
    Register pp(.in(curr_parity), .ld(ld3), .clk(clk), .rst(rst3), .out(prev_parity));

    wire p_from_prev, p_from_curr;
    Mux5To1 fp(.in1(prev_parity[4]), .in2(prev_parity[3]), .in3(prev_parity[2]), 
                .in4(prev_parity[1]), .in5(prev_parity[0]), .sel((i + 1) % 5), .out(p_from_prev));
    Mux5To1 fc(.in1(curr_parity[4]), .in2(curr_parity[3]), .in3(curr_parity[2]), 
                .in4(curr_parity[1]), .in5(curr_parity[0]), .sel((i + 4) % 5), .out(p_from_curr));

    Parity #(3) elem(.in({p_from_curr, p_from_prev, matrix[24]}), .out(p_elem));
    assign Out = matrix;
endmodule
