module to_lane(in, out);
    input [24:0]in [0:63];
    output [63:0] out[0:24];

    genvar i;
    genvar j;
    generate
        for (i=0;i<25;i=i+1)begin
            for (j = 0;j <64 ;j =j+1 ) begin
                assign out[i][63-j]=in[j][24-i];
            end
        end
    endgenerate
endmodule

module to_matrix(in, out);
    input [63:0] in[0:24];
    output [24:0]out [0:63];
    
    genvar i;
    genvar j;
    generate
        for (i=0;i<64;i=i+1)begin
            for (j = 0;j <25 ;j =j+1 ) begin
                assign out[i][24-j]=in[j][63-i];
            end
        end
    endgenerate
endmodule
