`include "ISA.v"

module Counter #(parameter WORD_LENGTH = `LEN_COUNTER_DATA) (
    input clk,
    input rst,
    input en,
    input [WORD_LENGTH - 1:0] max,

    output overflow,
    output [WORD_LENGTH - 1:0] out
);
    wire [WORD_LENGTH - 1:0] pre;
    assign out = (pre + en) % max;
    assign overflow = ((pre == max - 1) & (en));

	Register #(.WORD_LENGTH(WORD_LENGTH)) counter_register(
		.clk(clk),
        .rst(rst),
		.ld(en),
		.in(out),

		.out(pre)
	);

endmodule
