`timescale 1ns/1ns
module Data_mem(clk,mem_write,addr,write_data,read_data,out);
    input clk,mem_write;
    input [5:0]addr;
    input [24:0]write_data;
    output [24:0]read_data;
    output [24:0] out [0:63];
    // initial begin
    //     $readmemb("Data_mem.mem",mem);
    // end
    reg [24:0] mem [0:63];
    assign read_data=mem[addr];
    always @(posedge clk) begin
        if(mem_write)begin
            mem[addr]=write_data;
        end
    end
    genvar i;
    generate
        for (i=0;i<64;i=i+1)begin
            assign out[i]=mem[i];
        end
    endgenerate
endmodule