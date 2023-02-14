`timescale 1ns/1ns
module TB ();

    reg clk=1'b0, rst=1'b1, start=1'b0;
    wire done;
    reg [24:0]in [0:63];
    wire [24:0]out[0:63];

    reg [8*18:0] inFileName = "./file/input_0.txt"; 
    reg [8*19:0] outputFileName = "./file/output_0.txt"; 

    integer inputFile, i, outFile, test_counts=3, k, start_tests=0;
    wire[1599:0]in_conv;
    wire[1599:0]encoded;

    output_convertor ot(.in(in), .out(in_conv));
    input_convertor it(.in(encoded),.out(out));

   encoder uut(.clk(clk), .reset(rst), .start(start), .raw_data(in_conv), .encoded(encoded), .Ready(done));


    always #20 clk = ~clk;

    initial begin
        #20 rst = 1'b0;
        for(k=0;k<test_counts;k=k+1)begin
            $sformat(inFileName, "./file/input_%0d.txt", k+start_tests);
            inputFile = $fopen(inFileName, "r");
            $readmemb(inFileName, in);
            #20 start = 1'b1;
            #50 start = 1'b0;
            $sformat(outputFileName, "./file/output_%0d.txt", k+start_tests);
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