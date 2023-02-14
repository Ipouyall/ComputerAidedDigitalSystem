`timescale 1ns/1ns
module my_memory (
    clk, write, load, save, init_data, page, data, out
);
    input clk,  write, load, save;
    input [1599:0] init_data;
    input[5:0]page;
    input [24:0]data;
    output [24:0] out;

    wire[24:0]conv_out[0:63];
    input_convertor conv(.in(init_data), .out(conv_out));

    reg [24:0] mem [0:63];
    integer k, outFile;

    assign out=mem[page];

    always @(posedge clk or posedge load or posedge save) begin
        if (load) begin
            for (k = 0;k <64 ;k =k+1 ) begin
                mem[k]=conv_out[k];
            end
        end
        else if (save) begin
            outFile = $fopen("memory_data.txt", "w");
            for (k = 0; k < 64 ; k = k+1) begin
                $fwrite(outFile, "%b\n", mem[k]);
            end
            $fclose(outFile);
        end
        else if (write) begin
            mem[page]=data;
        end
    end
endmodule
