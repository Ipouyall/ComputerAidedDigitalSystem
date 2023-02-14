`timescale 1ps/1ps

module rotate_TB ();

    reg clk = 1'b0, reset = 1'b1, start = 1'b0;
    wire Ready;

    wire [24:0] mem [0:63];

    integer inputFile, i, outFile, inputFileCounts = 2, k;
    reg [8*18:0] inputFileName = ""; 
    reg [8*19:0] outputFileName = "";

    rotate ins(clk, reset, start, mem, Ready, mem);

    always #5 clk = ~clk;

    initial begin
        for (k = 0; k < inputFileCounts ; k = k+1) begin
            $sformat(inputFileName, "./input_%0d.txt", k); 
            $sformat(outputFileName, "./output_%0d.txt", k); 
            $readmemb(inputFileName, mem);
            #10 reset = 1'b0;
            #15 start = 1'b1;
            #30 start = 1'b0;
            outFile = $fopen(outputFileName, "w");
            while (~Ready) #1;
            $fwrite(outFile, "%b\n", mem);
            while (Ready) #1;
            $fclose(outFile);
        end
        #100;
        $stop;
    end
endmodule
