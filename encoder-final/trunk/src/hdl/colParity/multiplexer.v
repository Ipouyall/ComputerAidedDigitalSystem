module Mux2To1(in1, in2, sel, out);
    parameter N = 25;

    input [N-1:0] in1, in2;
    input sel;
    output [N-1:0] out;

    assign out = sel ? in2 : in1;
endmodule

module Mux5To1(in1, in2, in3, in4, in5, sel, out);
    parameter N = 5;

    input [N-1:0] in1, in2, in3, in4, in5;
    input [2:0] sel;
    output [N-1:0] out;

    assign out = 
    sel==3'b000 ? in1 :
    sel==3'b001 ? in2 : 
    sel==3'b010 ? in3 : 
    sel==3'b011 ? in4 : 
    in5;
endmodule