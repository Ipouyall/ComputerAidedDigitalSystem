module CU (clk, rst, start, sel, ld, totalReady, ready, read);
    input clk,rst,start;
	output reg sel,ld,totalReady,ready,read;
	
	wire co;
	reg[2:0] ps,ns;
	parameter [2:0]Idle=0,Init=1,Load=2,Calc=3,Ready=4;
    reg[5:0]count;
    reg counter_rst, inc_counter;
	always@(ps,co,start)begin
		ns=Idle;
		case(ps)
			Idle: ns=(start)?Init:Idle;
			Init: ns=Load;
			Load: ns=Calc;
			Calc: ns=Ready;
			Ready: ns=(co)?Idle:Load;
		endcase
	end
	always@(ps,co,start)begin
		{sel,ld,totalReady,ready,read}=5'd0;
		case(ps)
			Idle:begin
				totalReady=1'b1;
			end
			Init:begin
				counter_rst=1'b1;
				sel=1'b0;
			end
			Load:begin
				ld=1'b1;
				read=1'b1;
			end
			Calc:begin
				sel=1'b1;
				ld=1'b1;
			end
			Ready:begin
				ready=1'b1;
				sel=1'b0;
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
    always @(posedge clk , posedge rst) begin
        if (rst) begin
            count<=6'b0;
        end
        else
            if(counter_rst) count<=6'b0;
            else if(inc_counter) count<=count+1;
    end
    assign co=&count;

endmodule