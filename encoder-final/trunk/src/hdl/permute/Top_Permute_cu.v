`timescale 1ns/1ns
module Top_Permute_cu(clk, rst, start, all_done, read_mem, start_instances, done);
    input clk, rst, start, all_done;
    output reg read_mem, start_instances, done;

	reg[1:0] ps,ns;
	parameter [1:0] Idle = 0, Init=1, Start = 2, Wait = 3;

	always@(ps,all_done,start)begin
		ns=Idle;
		case(ps)
			Idle: ns = (start) ? Init : Idle;
			Init: ns = Start;
			Start: ns = Wait;
			Wait: ns = (all_done) ? Idle : Wait;
		endcase
	end
	always@(ps, all_done, start)begin
		{done, read_mem, start_instances}=3'd0;
		case(ps)
			Idle: begin
				done = 1'b1;
			end
			Init: begin
				read_mem = 1'b1;
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