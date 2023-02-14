module Register (in, ld, clk, rst, out);
    parameter N = 5;

    input [N-1:0] in;
    input ld, clk, rst;
    output reg [N-1:0] out;

    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= {N{1'b0}};
        else if (ld)
            out <= in;
    end
endmodule