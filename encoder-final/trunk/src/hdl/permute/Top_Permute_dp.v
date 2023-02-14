`timescale 1ns/1ns
`include "Permutation.v"
module Top_Permute_dp(clk, rst, read_mem, start_instances, out, all_done);
    input clk, rst, read_mem, start_instances;
    output [24:0]out[0:63];
    output all_done;

    reg [24:0]in [0:63];
    always @(read_mem) begin
        if(read_mem)begin
            $readmemb("memory_data.txt", in);
        end
    end
    wire [63:0]dones;

    genvar i;
    generate
        for (i=0;i<64;i=i+1)begin
            Permutation uut(.in(in[i]), .clk(clk), .rst(rst), .start(start_instances), .ready(dones[i]), .out(out[i]));
        end
    endgenerate

    assign all_done= &dones;


endmodule