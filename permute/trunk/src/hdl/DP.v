module Multiplexer25bit2to1 (a0, a1, sel, w);
    input [24:0] a0, a1;
    input sel;
    output [24:0] w;

	assign w = ~sel ? a0 : a1;
endmodule

module Register (clk, rst, ld, in, out);
    input clk, rst, ld;
    input [24:0] in;
    output reg [24:0] out;

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			out <= 24'd0;
        end
		else begin
			if(ld == 1'b1) begin
                out <= in;
            end
		end
	end
endmodule

module Mapper (in, out);
    parameter N = 5;

    input [24:0] in;
    output [24:0] out;

    genvar i, j;

    generate
        for (i = 0; i < N; i = i+1) begin
          for (j = 0; j < N; j = j+1) begin
            assign out[(((j+2)%5))+(((((2*i)+(3*j))%5)+2)%5)*5] = in[((j+2)%5)*5+((i+2)%5)];
          end
        end
    endgenerate
endmodule

module DP (in, clk, rst, sel, load , out);
    input [24:0] in;
    input clk, rst, sel, load;
    output [24:0] out;

    wire[24:0]registerIn, maperOut, registerOut;
    Multiplexer25bit2to1 mux(.a0(in), .a1(maperOut), .sel(sel), .w(registerIn));
    Mapper mapper(.in(registerOut), .out(maperOut));
    Register register(.clk(clk), .rst(rst), .ld(load), .in(registerIn), .out(registerOut));
    assign out = registerOut;
endmodule