`timescale 1ns/1ns
module Top_revluate_cu(clk, rst, start, all_ready, start_instances, ready);
    input clk, rst, start, all_ready;
    output reg start_instances, ready;

	reg[1:0] ps,ns;
	parameter [1:0] Idle = 0,  Start = 1, Wait = 2;

	always@(ps,all_ready,start)begin
		ns=Idle;
		case(ps)
			Idle: ns = (start) ? Start : Idle;
			Start: ns = Wait;
			Wait: ns = (all_ready) ? Idle : Wait;
		endcase
	end
	always@(ps, all_ready, start)begin
		{ready, start_instances}=3'd0;
		case(ps)
			Idle: begin
				ready = 1'b1;
			end
			Start: begin
                start_instances=1'b1;
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