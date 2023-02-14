`include "ISA.v"

module MUX3Dto1 #(parameter I_RANGE = `NUM_ROW, parameter J_RANGE = `NUM_COLUMN, parameter K_RANGE = `NUM_PAGE) (
    input [I_RANGE * J_RANGE * K_RANGE - 1:0] mat,
    input [2:0] i, j,
    input [5:0] k,

    output out
);
    assign out = mat[k * I_RANGE * J_RANGE + j * I_RANGE + i];
endmodule
