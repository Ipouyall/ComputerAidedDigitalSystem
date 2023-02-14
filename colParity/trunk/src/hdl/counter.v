module Counter (clk, inc, reset, load, load_data, value, co);
    parameter N = 6;
    input clk, inc, reset, load;
    input [N-1:0] load_data;
    output co;
    output reg [N-1:0] value;

    assign co = &value;
    
    always @(posedge clk , posedge reset) begin
        if (reset)
            value <= {N{1'b0}};
        else 
            if(load)
                value <= load_data;
        else 
            if(inc)
                value <= value + 1;
    end
endmodule
