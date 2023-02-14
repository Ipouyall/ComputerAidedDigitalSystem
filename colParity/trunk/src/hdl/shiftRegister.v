module ShiftLeftRegister(in, ld, rst, clk, shift, shift_in, out);
    parameter N = 25;

    input [N-1:0] in;
    input ld, rst, clk, shift, shift_in;
    output reg [N-1:0] out;

    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= {N{1'b0}};
        else if (ld)
            out <= in;
        else if (shift)
            out <= {out[N-2:0], shift_in};
    end
endmodule