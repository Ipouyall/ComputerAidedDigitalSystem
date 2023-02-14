`timescale 1ns/1ns
module pr_CU (clk, rst, start, sel, ld, ready, read);
	parameter [2:0] Idle = 0, Init = 1, Load = 2, Calc = 3, Ready = 4;

    input clk, rst, start;
	output reg sel, ld, ready, read;
	
	wire co;
	reg [2:0] ps, ns;

	always @(ps or co or start) begin
		ns = Idle;
		case(ps)
			Idle:  ns = (start) ? Init : Idle;
			Init:  ns = Load;
			Load:  ns = Calc;
			Calc:  ns = Ready;
			Ready: ns = (co) ? Idle : Load;
		endcase
	end

	always @(ps or co or start)begin
		{sel, ld, ready, read} = 4'd0;
		case (ps)
			Idle: begin
				ready = 1'b1;
			end
			Load: begin
				sel = 1'b0;
				ld = 1'b1;
				read = 1'b1;
			end
			Calc: begin
				sel = 1'b1;
				ld = 1'b1;
			end
		endcase
	end

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			ps <= Idle;
		end else begin
			ps <= ns;
		end
	end

endmodule
