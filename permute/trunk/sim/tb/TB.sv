`timescale 1ns/1ns

module TB ();
    reg [24:0] in;
    wire [24:0] out;
    reg clk= 1'b0 ,rst = 1'b0, start = 1'b0;
    wire read, ready, total_ready;

    Permutation UUT(.in(in), .clk(clk), .rst(rst), .start(start),
                    .total_ready(total_ready), .ready(ready), .read(read), .out(out));

    integer inputFile, i, outFile, inputFileCounts = 3, k;

    reg [8*18:0] inputFileName = "./file/input_0.txt";
    reg [8*19:0] outputFileName = "./file/output_0.txt";

    always #20 clk = ~clk;

    initial begin
        for (k = 0; k < inputFileCounts ; k = k+1) begin
            $sformat(inputFileName, "./file/input_%0d.txt", k);
            $sformat(outputFileName, "./file/output_%0d.txt", k);
            #20 rst = 1'b0;
            #22 start = 1'b1;
            inputFile = $fopen(inputFileName, "r");
            outFile = $fopen(outputFileName, "w");
            for(i = 0; i < 64; i = i+1) begin  
                while (~read) #1;
                $fscanf(inputFile, "%b\n", in);
                while (~ready) #1;
                $fwrite(outFile, "%b\n", out);
            end
            #20 start = 1'b0;   
            $fclose(inputFile);
            $fclose(outFile);
        end
        #10000;
        $stop;
    end
endmodule