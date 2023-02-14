// values are like z = [0 1 2 3 4 ... 63]
module ShiftLeftRegister64(in_val, ld, rst, clk, shift, shift_in, content, shift_out);
    parameter N = 64;

    input [N-1:0] in_val;
    input ld, rst, clk, shift, shift_in;
    output reg [N-1:0] content;
    output shift_out;

    always @(posedge clk or posedge rst) begin
        if (rst)
            content <= {N{1'b0}};
        else if (ld)
            content <= in_val;
        else if (shift)
            content <= {shift_in, content[N-1:1]};
    end
    assign shift_out = content[0];
endmodule
