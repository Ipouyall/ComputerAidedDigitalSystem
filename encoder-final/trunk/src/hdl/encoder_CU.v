module encoder_CU (clk, reset, start, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, completed,
            Ready, sel, load, r_rst, save, next_round,
            cp_rst, cp_start, 
            rt_rst, rt_start,
            pr_rst, pr_start,
            rv_rst, rv_start,
            rc_rst, rc_start,
            );
    input   clk, reset, start, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, completed;
    output reg  Ready, sel, load, r_rst, save, next_round,
            cp_rst, cp_start, 
            rt_rst, rt_start,
            pr_rst, pr_start,
            rv_rst, rv_start,
            rc_rst, rc_start;

    reg[4:0] ps,ns;
    parameter [4:0] Idle=0, Get_Data=1, 
                    Init_cp=2,  Beg_cp=3,  Calc_cp=4,
                    Init_rt=5,  Beg_rt=6,  Calc_rt=7,
                    Init_pr=8,  Beg_pr=9,  Calc_pr=10,
                    Init_rv=11, Beg_rv=12, Calc_rv=13,
                    Init_rc=14, Beg_rc=15, Calc_rc=16,
                    Fetch_state=17, Next_round=18;
    
    always @(ps, start, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, completed) begin
        ns=Idle;
        case (ps)
            Idle:        ns = start ? Get_Data : Idle;
            Get_Data:    ns = Beg_cp; 
            Init_cp:     ns = Beg_cp;
            Beg_cp:      ns = Calc_cp;
            Calc_cp:     ns = cp_Ready ? Init_rt : Calc_cp;
            Init_rt:     ns = Beg_rt;
            Beg_rt:      ns = Calc_rt;
            Calc_rt:     ns = rt_Ready ? Init_pr : Calc_rt;
            Init_pr:     ns = Beg_pr;
            Beg_pr:      ns = Calc_pr;
            Calc_pr:     ns = pr_done ? Init_rv : Calc_pr;
            Init_rv:     ns = Beg_rv;
            Beg_rv:      ns = Calc_rv;
            Calc_rv:     ns = rv_done ? Init_rc : Calc_rv;
            Init_rc:     ns = Beg_rc;
            Beg_rc:      ns = Calc_rc;
            Calc_rc:     ns = rc_done ? Fetch_state : Calc_rc;
            Fetch_state: ns = completed ? Idle : Next_round;
            Next_round:  ns = Init_cp;
        endcase
    end

    always @(ps) begin
        {Ready, sel, load, r_rst, 
                save, next_round,
                cp_rst, cp_start, 
                rt_rst, rt_start,
                pr_rst, pr_start,
                rv_rst, rv_start,
                rc_rst, rc_start} = 16'd0;
        case (ps)
            Idle:       Ready = 1'b1;
            Get_Data:   {sel, load, cp_rst, r_rst} = 4'b0111; 
            Init_cp:    {sel, load, cp_rst} = 3'b111;
            Beg_cp:     cp_start = 1'b1;
            Calc_cp:    ;
            Init_rt:    {save, rt_rst} = 2'b11;
            Beg_rt:     rt_start = 1'b1;
            Calc_rt:    ;
            Init_pr:    pr_rst = 1'b1;
            Beg_pr:     pr_start = 1'b1;
            Calc_pr:    ;
            Init_rv:    rv_rst = 1'b1;
            Beg_rv:     rv_start = 1'b1;
            Calc_rv:    ;
            Init_rc:    rc_rst = 1'b1;
            Beg_rc:     rc_start = 1'b1;
            Calc_rc:    ;
            Fetch_state:;
            Next_round: next_round = 1'b1;
        endcase
    end

    always @(posedge clk , posedge reset) begin
        if(reset)
            ps <= Idle;
        else
            ps <= ns;
	end
endmodule
// module encoder_CU (clk, reset, start, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, completed,
//             Ready, sel, load, r_rst, save, next_round,
//             cp_rst, cp_start, 
//             rt_rst, rt_start,
//             pr_rst, pr_start,
//             rv_rst, rv_start,
//             rc_rst, rc_start,
//             );
//     input   clk, reset, start, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, completed;
//     output reg  Ready, sel, load, r_rst, save, next_round,
//             cp_rst, cp_start, 
//             rt_rst, rt_start,
//             pr_rst, pr_start,
//             rv_rst, rv_start,
//             rc_rst, rc_start;

//     reg[4:0] ps,ns;
//     parameter [4:0] Idle=0, Get_Data=1, 
//                     Init_cp=2,  Beg_cp=3,  Calc_cp=4,
//                     Init_rt=5,  Beg_rt=6,  Calc_rt=7,
//                     Init_pr=8,  Beg_pr=9,  Calc_pr=10,
//                     Init_rv=11, Beg_rv=12, Calc_rv=13,
//                     Init_rc=14, Beg_rc=15, Calc_rc=16,
//                     Fetch_state=17, Next_round=18;
    
//     always @(ps, start, cp_Ready, rt_Ready, pr_done, rv_done, rc_done, completed) begin
//         ns=Idle;
//         case (ps)
//             Idle:        ns = start ? Get_Data : Idle;
//             Get_Data:    ns = Beg_cp; 
//             Init_cp:     ns = Beg_cp;
//             Beg_cp:      ns = Calc_cp;
//             Calc_cp:     ns = cp_Ready ? Init_rt : Calc_cp;
//             Init_rt:     ns = Beg_rt;
//             Beg_rt:      ns = Calc_rt;
//             Calc_rt:     ns = rt_Ready ? Init_pr : Calc_rt;
//             Init_pr:     ns = Beg_pr;
//             Beg_pr:      ns = Calc_pr;
//             Calc_pr:     ns = pr_done ? Init_rv : Calc_pr;
//             Init_rv:     ns = Beg_rv;
//             Beg_rv:      ns = Calc_rv;
//             Calc_rv:     ns = rv_done ? Init_rc : Calc_rv;
//             Init_rc:     ns = Beg_rc;
//             Beg_rc:      ns = Calc_rc;
//             Calc_rc:     ns = rc_done ? Fetch_state : Calc_rc;
//             Fetch_state: ns =  Idle;
//             Next_round:  ns = Init_cp;
//         endcase
//     end

//     always @(ps) begin
//         {Ready, sel, load, r_rst, 
//                 save, next_round,
//                 cp_rst, cp_start, 
//                 rt_rst, rt_start,
//                 pr_rst, pr_start,
//                 rv_rst, rv_start,
//                 rc_rst, rc_start} = 16'd0;
//         case (ps)
//             Idle:       Ready = 1'b1;
//             Get_Data:   {sel, load, cp_rst, r_rst} = 4'b0111; 
//             Init_cp:    {sel, load, cp_rst} = 3'b111;
//             Beg_cp:     cp_start = 1'b1;
//             Calc_cp:    ;
//             Init_rt:    {save, rt_rst} = 2'b11;
//             Beg_rt:     rt_start = 1'b1;
//             Calc_rt:    ;
//             Init_pr:    pr_rst = 1'b1;
//             Beg_pr:     pr_start = 1'b1;
//             Calc_pr:    ;
//             Init_rv:    rv_rst = 1'b1;
//             Beg_rv:     rv_start = 1'b1;
//             Calc_rv:    ;
//             Init_rc:    rc_rst = 1'b1;
//             Beg_rc:     rc_start = 1'b1;
//             Calc_rc:    ;
//             Fetch_state:;
//             Next_round: next_round = 1'b1;
//         endcase
//     end

//     always @(posedge clk , posedge reset) begin
//         if(reset)
//             ps <= Idle;
//         else
//             ps <= ns;
//     end
// endmodule