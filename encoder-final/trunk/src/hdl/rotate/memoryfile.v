module memoryfile (
    clk, read, write, load, save, idx, input_lane, output_lane
);
    input clk, read, write, load, save;
    input [4:0] idx;
    input [63:0] input_lane;
    output reg [63:0] output_lane;

    reg [24:0] data [0:63];
    integer k, outFile;

    always @(posedge clk or posedge load or posedge save) begin
        if (load) begin
            $readmemb("memory_data.txt", data);
        end 
        else if (save) begin
            outFile = $fopen("memory_data.txt", "w");
            for (k = 0; k < 64 ; k = k+1) begin
                $fwrite(outFile, "%b\n", data[k]);
            end
            $fclose(outFile);
        end
        else if (read) begin
            for (k = 0;k <64 ;k =k+1 ) begin
                output_lane[63-k]=data[k][24-idx];
            end
        end
        else if (write) begin
            for (k = 0;k <64 ;k =k+1 ) begin
                    data[k][24-idx] = input_lane[63-k];
            end
        end
    end
endmodule
