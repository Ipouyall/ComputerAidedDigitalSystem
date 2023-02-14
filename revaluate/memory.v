
`include "ISA.v"

module Memory(
	input clk,
	input rst,

	input mem_write,
	input [`LEN_ADDRESS - 1:0] address_in,
	input data_in,

	output reg [`NUM_CELLS - 1:0] data_out
);
	always@(negedge clk, rst) begin
		if(rst)
			data_out <= 0;
		else if(mem_write)
			data_out[address_in] <= data_in;
	end

endmodule
