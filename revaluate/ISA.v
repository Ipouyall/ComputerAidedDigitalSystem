`timescale 1ns/1ns

`define ENABLE 1'b1
`define DISABLE 1'b0

`define NUM_PAGE 64
`define NUM_ROW 5
`define NUM_COLUMN 5
`define NUM_CELLS `NUM_PAGE * `NUM_COLUMN * `NUM_ROW
`define NUM_TURNS 24
`define NUM_TURNS_BITS 5 

`define LEN_DATA `NUM_COLUMN * `NUM_ROW
`define LEN_COUNTER_DATA 32

`define COUNT_STEPS 24

`define LEN_STATE 2
`define LEN_ADDRESS 11
