`timescale 1ns/1ns
`include "encoder.v"
module TB ();

    reg clk=1'b0, rst=1'b1, start=1'b0;
    reg [24:0] data;
    wire [24:0] new_data;
    wire done;
    reg [24:0]in [0:63];
    wire [24:0]out[0:63];

    reg [8*11:0]inFileName = "input_0.txt";
    reg [8*12:0]outputFileName = "output_0.txt";

    integer inputFile, i, outFile, test_counts=2, k=0, start_tests=1;
    wire[1599:0]in_conv;
    wire[1599:0]encoded;

    output_convertor ot(.in(in), .out(in_conv));
    input_convertor it(.in(encoded),.out(out));

   encoder uut(.clk(clk), .reset(rst), .start(start), .raw_data(in_conv), .encoded(encoded), .Ready(done));


    always #20 clk = ~clk;
   
    initial begin
        #20 rst = 1'b0;
        for(k=0;k<test_counts;k=k+1)begin
            $sformat(inFileName, "input_%0d.txt", k+start_tests);
            inputFile = $fopen(inFileName, "r");
            $readmemb(inFileName, in);
            #22 start = 1'b1;
            #40 start = 1'b0; 
            $sformat(outputFileName, "output_%0d.txt", k+start_tests);
            outFile = $fopen(outputFileName, "w");
            #40;
            while (~done) #1;
            for(i = 0; i < 64; i= i+1) begin  
                $fwrite(outFile, "%b\n", out[i]);
            end
            $fclose(outFile);
            $fclose(inputFile);
        end
        #1000;
        $stop;
    end

endmodule