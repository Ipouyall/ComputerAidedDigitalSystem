module modulo24 (cnt, rst, clk, co, content);
    input cnt, rst, clk;
    output co;
    output reg [4:0] content;

    always@(posedge clk or posedge rst) begin
        if (rst)
            content <= 5'd0;
        else if(cnt)
            if (co)
                content <= 5'd0;
            else
                content <= content + 1;
    end

    assign co = content == 5'd23;
endmodule