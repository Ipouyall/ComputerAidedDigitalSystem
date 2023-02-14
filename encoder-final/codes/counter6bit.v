`timescale 1ns/1ns
module counter6bit(clk, rst, counter_rst, inc_counter, count, co);
    input clk, rst, counter_rst, inc_counter;
    output reg[5:0] count;
    output co;

    always @(posedge clk , posedge rst) begin
        if (rst) begin
            count <= 6'b0;
        end
        else begin
            if(counter_rst) begin
                count <= 6'b0;
            end
            else if(inc_counter) begin
                count <= count+1;
            end
        end
    end
    assign co = &count;

endmodule
