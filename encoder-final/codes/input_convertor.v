`timescale 1ns/1ns
module input_convertor(in, out);
  
    input [1599:0] in;
    output [24:0]out [0:63];

    genvar i;
    genvar j;
    generate
        for (i=0;i<64;i=i+1)begin
          assign out[i]=in[1599-25*i:1599-25*(i+1)+1];
        end
    endgenerate
					
	
endmodule