`timescale 1ns/1ns
module addrc_Register (clk,rst,ld, PI, PO);
    input clk, rst, ld;
    input[24:0]PI;
    output reg[24:0]PO;

	always @(posedge clk , posedge rst) begin
		if(rst)
			PO <= 24'd0;
		else begin
			if(ld==1'b1) PO<=PI;
		end
	end
endmodule