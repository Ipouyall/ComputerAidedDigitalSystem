
module CounterModulo5 (clk, reset, inc, value, co);
    input clk, reset, inc;
    output reg co;
    output reg [2:0] value;

    always @(posedge clk , posedge reset) begin
        co <= 1'b0;
        if (reset)
            value <= 3'd0;
        else
        if(inc) begin
            if(value == 3'd4)
                co <= 1'b1;
            value <= (value + 1) % 5;
        end
    end
endmodule