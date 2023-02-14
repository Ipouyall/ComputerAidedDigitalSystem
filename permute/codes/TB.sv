`timescale 1ns/1ns

module TB ();
    reg [24:0]in=25'b0;
    wire [24:0]out;
    reg clk=0,rst=0,start=0;
    wire read,ready,totalReady;
    Permutation UUT(.in(in),.clk(clk),.rst(rst),.start(start),
                    .totalReady(totalReady),.ready(ready),.read(read),.out(out));
    integer inputFile, i, outFile, inputFileCounts=3, k;
    reg [8*11:0]inFileName = "input_0.txt";
    reg [8*12:0]outFileName = "output_0.txt";
    always #20 clk=~clk;
    initial begin
        for (k = 0; k < inputFileCounts ; k = k+1) begin
            $sformat(inFileName, "input_%0d.txt", k);
            $sformat(outFileName, "output_%0d.txt", k);
            #20 rst = 1'b0;
            start = 1'b1;
            inputFile = $fopen(inFileName, "r");
            outFile = $fopen(outFileName, "w");
            for(i = 0; i < 64; i= i+1) begin  
                while(~read) #1;
                $fscanf(inputFile,"%b\n",in);
                while(~ready) #1;
                $fwrite(outFile, "%b\n",out);
            end  
            $fclose(inputFile);
            $fclose(outFile);
        end
        #10000;
        $stop;
    end

endmodule