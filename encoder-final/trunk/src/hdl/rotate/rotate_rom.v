module RotateRoM (
    clk, lane_num, value
);
    input clk;
    input [4:0] lane_num;
    output reg [5:0] value;

    always @(clk, lane_num) begin
        case(lane_num)
            5'd0: value = 6'd21;
            5'd1: value = 6'd8;
            5'd2: value = 6'd41;
            5'd3: value = 6'd45;
            5'd4: value = 6'd15;
            5'd5: value = 6'd56;
            5'd6: value = 6'd14;
            5'd7: value = 6'd18;
            5'd8: value = 6'd2;
            5'd9: value = 6'd61;
            5'd10: value = 6'd28;
            5'd11: value = 6'd27;
            5'd12: value = 6'd0;
            5'd13: value = 6'd1;
            5'd14: value = 6'd62;
            5'd15: value = 6'd55;
            5'd16: value = 6'd20;
            5'd17: value = 6'd36;
            5'd18: value = 6'd44;
            5'd19: value = 6'd6;
            5'd20: value = 6'd25;
            5'd21: value = 6'd39;
            5'd22: value = 6'd3;
            5'd23: value = 6'd10;
            5'd24: value = 6'd43;
            default: value = 6'd0;
        endcase
    end
endmodule
