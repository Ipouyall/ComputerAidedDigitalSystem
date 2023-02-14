module rotate_dp (
    tensot_in, clk, cnt, rst, shift, r_ld, c_ld, r_cnt, r_rst, 
    tensot_out, Done, ended);

    input [24:0]tensot_in [0:63];
    input clk, cnt, rst, shift, r_ld, c_ld, r_cnt, r_rst;
    output [24:0]tensot_out [0:63];
    output Done, ended;

    wire [63:0] memory_mapped_in  [0:24];
    wire [63:0] memory_mapped_out [0:24];
    wire [63:0] lane, out_lane;
    wire [4:0]  index;

    to_lane lc(tensot_in, memory_mapped_in);
    modulo25 cm(5'd0, 1'b0, cnt, rst, clk, Done, index);
    assign lane = memory_mapped_in[index];

    rotator rtr(lane, index, shift, r_ld, c_ld, r_cnt, r_rst, clk, ended, out_lane);

    // always @(posedge clk)
    // assign memory_mapped_out[index] = out_lane;
    muxi mm(memory_mapped_out, index, out_lane);


    // memory to tensor out
    to_matrix cl(memory_mapped_out, tensot_out);
endmodule

module muxi (mem, idx, data);
    output reg  [63:0] mem [0:24];
    input  [4:0]  idx;
    input  [63:0] data;


    assign mem[idx] = data;
    
endmodule