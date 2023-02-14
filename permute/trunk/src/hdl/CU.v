module CU (clk, rst, start, sel, ld, total_ready, ready, read);
	parameter [2:0] Idle = 0, Init = 1, Load = 2, Calc = 3, Ready = 4;

    input clk, rst, start;
	output reg sel, ld, total_ready, ready, read;
	
	wire co;
	reg [2:0] ps, ns;
    reg [5:0] count;
    reg counter_rst, inc_counter;

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
		{sel, ld, total_ready, ready, read, counter_rst, inc_counter} = 7'd0;
		case (ps)
			Idle: begin
				total_ready = 1'b1;
			end
			Init: begin
				counter_rst = 1'b1;
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
			Ready: begin
				ready = 1'b1;
				inc_counter = 1'b1;
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

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 6'd0;
        end
        else begin
            if (counter_rst) begin
				count <= 6'd0;
			end
            else if (inc_counter) begin
				count <= count+1;
			end
		end
    end

    assign co = &count;
endmodule
