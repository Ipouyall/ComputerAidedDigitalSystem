`timescale 1ps/1ps

module TestBench();
    wire [24:0] In;
    wire [24:0] Out;
    reg clk= 1'b0 ,reset = 1'b1, start = 1'b0;
    wire Done, Ready;
    wire [5:0] page_index;


    integer inputFile, i, outFile, inputFileCounts = 3, k;

    reg [8*18:0] inputFileName = "./file/input_0.txt"; 
    reg [8*19:0] outputFileName = "./file/output_0.txt"; 
    reg [24:0] data [0:63];

    ColParity uut(clk, start, reset, In, Ready, Out, Done, page_index);

    assign In = data[page_index];

    always #5 clk = ~clk;

    initial begin
        for (k = 0; k < inputFileCounts ; k = k+1) begin
            $sformat(inputFileName, "./file/input_%0d.txt", k); 
            $sformat(outputFileName, "./file/output_%0d.txt", k); 
            $readmemb(inputFileName, data);
            #10 reset = 1'b0;
            #15 start = 1'b1;
            #30 start = 1'b0;
            outFile = $fopen(outputFileName, "w");
            for(i = 0; i < 64; i = i+1) begin
                while (~Done) #1;
                    $fwrite(outFile, "%b\n", Out);
                while (Done) #1;
            end
            $fclose(outFile);
        end
        #100;
        $stop;
    end
endmodule
