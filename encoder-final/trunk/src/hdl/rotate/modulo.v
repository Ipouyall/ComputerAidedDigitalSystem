module modulo64 (load_val, ld, cnt, rst, clk, co, content);
    input ld, cnt, rst, clk;
    input [5:0] load_val;
    output co;
    output reg [5:0] content;

    always@(posedge clk or posedge rst) begin
        if (rst)
            content <= 6'd0;
        else if (ld)
            content <= load_val;
        else if(cnt)
            if (co)
                content <= 6'd0;
            else
                content <= content + 1;
    end

    assign co = content == 6'd63;
endmodule

module modulo25 (load_val, ld, cnt, rst, clk, co, content);
    input ld, cnt, rst, clk;
    input [4:0] load_val;
    output co;
    output reg [4:0] content;

    always@(posedge clk or posedge rst) begin
        if (rst)
            content <= 5'd0;
        else if (ld)
            content <= load_val;
        else if(cnt)
            if (co)
                content <= 5'd0;
            else
                content <= content + 1;
    end

    assign co = content == 5'd24;
endmodule
