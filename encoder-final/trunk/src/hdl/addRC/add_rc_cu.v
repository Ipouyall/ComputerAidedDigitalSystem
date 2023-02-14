`timescale 1ns/1ns
module add_rc_cu (clk, rst, start, co, sel, ld, done, write, counter_rst, inc_counter);
    input clk, rst, start, co;
	output reg sel, ld, done, write, counter_rst, inc_counter;
	
	wire co;
	reg[2:0] ps,ns;
	parameter [2:0] Idle = 0, Init=1, Load = 2, Calc = 3, Write = 4, Check = 5;

	always@(ps,co,start)begin
		ns=Idle;
		case(ps)
			Idle: ns = (start) ? Init : Idle;
			Init: ns = Load;
			Load: ns = Calc;
			Calc: ns = Write;
            Write: ns = Check;
			Check: ns = (co) ? Idle : Load;
		endcase
	end
	always@(ps,co,start)begin
		{sel, ld, done, write, counter_rst, inc_counter}=7'd0;
		case(ps)
			Idle: begin
				done = 1'b1;
			end
			Init: begin
				counter_rst = 1'b1;
			end
			Load: begin
				ld = 1'b1;
				sel = 1'b0;
			end
			Calc: begin
				sel = 1'b1;
				ld=1'b1;
			end
			Write: begin
				write = 1'b1;
			end
            Check: begin
                inc_counter = 1'b1;
            end

		endcase
	end
	always @(posedge clk , posedge rst) begin
		if(rst) begin
			ps <= Idle;
		end else begin
			ps <= ns;
		end
	end

endmodule