module cp_Controller (clk, reset, start, done, 
                    Ready, Done,
                    ld1, ld2, ld3, rst1, rst2, rst3, shift,
                    id_rst, inc_i, stage_counter);
	input clk, reset, start, done;
  output reg Ready, Done;
  output reg ld1, ld2, ld3, rst1, rst2, rst3, shift;
  output reg id_rst, inc_i;
  output [5:0] stage_counter;

	reg[3:0] ps,ns;
	parameter [3:0] Idle=0, Prepare=1, Load_Init=2, 
                  PrepareParity1=3, PrepareParity2=4, 
                  Init=5, Load=6, CalulateCurrentParity=7, 
                  ProcessParity=8, Next=9, Stablizer=10, NextMatrix=11; 
    
  wire ended;
  reg counter_ld, counter_rst, cnt;

  cp_Counter sc(.clk(clk), .inc(cnt), .reset(counter_rst), .load(counter_ld), .load_data(6'd63), .value(stage_counter), .co(ended));

  always@(ps, start, done, ended)begin
		ns=Idle;
		case(ps)
			Idle: ns = start ? Prepare : Idle;
      Prepare: ns = Load_Init;
      Load_Init: ns = PrepareParity1;
      PrepareParity1: ns = PrepareParity2;
      PrepareParity2: ns = Init;
      Init: ns = Load;
      Load: ns = CalulateCurrentParity;
      CalulateCurrentParity: ns = ProcessParity;
      ProcessParity: ns = Next;
      Next: ns = Stablizer;
      Stablizer: ns = done ? NextMatrix : ProcessParity;
      NextMatrix: ns = ended ? Idle : Load;
		endcase
	end

  always@(ps)begin
    {Ready, ld1, ld2, ld3, rst1, rst2, rst3, shift, id_rst, inc_i, counter_rst, counter_ld, cnt, Done} = 14'd0;
    case(ps)
      Idle: Ready = 1'b1;
      Prepare: counter_ld = 1'b1;
      Load_Init: ld1 = 1'b1;
      PrepareParity1: ld2 = 1'b1;
      PrepareParity2: ld3 = 1'b1;
      Init: {counter_rst, id_rst} = 2'b11;
      Load: ld1 = 1'b1;
      CalulateCurrentParity: ld2 = 1'b1;
      ProcessParity: {inc_i,shift} = 2'b01;
      Next: {ld3,inc_i} = 2'b01;
      NextMatrix: {cnt, Done, ld3, id_rst} = 4'b1111;
    endcase
  end

  always @(posedge clk , posedge reset) begin
    if(reset)
      ps <= Idle;
    else
      ps <= ns;
	end
endmodule
