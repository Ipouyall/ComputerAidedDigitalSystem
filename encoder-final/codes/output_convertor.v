`timescale 1ns/1ns
module output_convertor(in, out);
  
    input [24:0]in [0:63];
    output [1599:0] out;


    genvar i;
    genvar j;
    generate
        for (i=0;i<64;i=i+1)begin
          assign out[1599-25*i:1599-25*(i+1)+1]=in[i];
        end
    endgenerate
					
	
endmodule