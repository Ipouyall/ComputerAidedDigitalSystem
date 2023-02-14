module rotate_cu (clk, reset, start, ended, Done, Ready, 
  rst, r_rst, ld, cnt, r_ld, r_cnt, c_ld, shift,
  read, write, load, save);

  input clk, start, ended, Done, reset;
  output reg Ready, rst, r_rst, ld, cnt, r_ld, c_ld, r_cnt, shift;
  output reg read, write, load, save;

  reg[3:0] ps,ns;
	parameter [3:0] Idle=0, Init=1, ReqData=2 ,FetchData=3, 
                    FetchStage=4, RotateData=5, 
                    Write=6, NextData=7, Save=8;
    
  always@(ps, start, ended, Done)begin
		ns=Idle;
		case(ps)
			Idle: ns = start ? Init : Idle;
      Init: ns = ReqData;
      ReqData: ns = FetchData;
      FetchData: ns = FetchStage;
      FetchStage: ns = RotateData; 
      RotateData: ns = ended ? Write : RotateData;
      Write: ns = Done ? Save : NextData;
      NextData: ns = ReqData;
      Save: ns = Idle;
		endcase
	end

  always@(ps)begin
      {Ready, rst, r_rst, ld, cnt, r_ld, c_ld, r_cnt, shift, read, write, load, save} = 13'd0;
      case(ps)
          Idle: Ready = 1'b1;
          Init: {rst, r_rst, load} = 3'b111;
          ReqData: read = 1'b1;
          FetchData: r_ld = 1'b1;
          FetchStage: c_ld = 1'b1; 
          RotateData: {r_cnt, shift} = 2'b11;
          Write: {ld, write} = 2'b11;
          NextData: {cnt, r_rst} = 2'b11;
          Save: save = 1'b1;
      endcase
  end

    always @(posedge clk , posedge reset) begin
    if(reset)
      ps <= Idle;
    else
      ps <= ns;
	end
endmodule
