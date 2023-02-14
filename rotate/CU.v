module rotate_cu (clk, reset, start, ended, Done, Ready, rst, r_rst, ld, cnt, r_ld, r_cnt, c_ld, shift);
    input clk, start, ended, Done, reset;
    output reg Ready, rst, r_rst, ld, cnt, r_ld, c_ld, r_cnt, shift;

    reg[2:0] ps,ns;
	parameter [2:0] Idle=0, Init=1, FetchData=2, 
                    FetchStage=3, RotateData=4, 
                    Write=5, NextData=6;
    
    always@(ps, start, ended, Done)begin
		ns=Idle;
		case(ps)
			Idle: ns = start ? Init : Idle;
            Init: ns = FetchData;
            FetchData: ns = FetchStage;
            FetchStage: ns = RotateData; 
            RotateData: ns = ended ? Write : RotateData;
            Write: ns = Done ? Idle : NextData;
            NextData: ns = FetchData;
		endcase
	end

    always@(ps)begin
        {Ready, rst, r_rst, ld, cnt, r_ld, c_ld, r_cnt, shift} = 9'd0;
        case(ps)
            Idle: Ready = 1'b1;
            Init: {rst, r_rst} = 2'b11;
            FetchData: r_ld = 1'b1;
            FetchStage: c_ld = 1'b1; 
            RotateData: {r_cnt, shift} = 2'b11;
            Write: ld = 1'b1;
            NextData: {cnt, r_rst} = 1'b1;
        endcase
    end

    always @(posedge clk , posedge reset) begin
    if(reset)
      ps <= Idle;
    else
      ps <= ns;
	end

endmodule
