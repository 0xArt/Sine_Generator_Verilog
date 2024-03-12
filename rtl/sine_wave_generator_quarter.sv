`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     www.circuitden.com
// Engineer:    Artin Isagholian
//              artinisagholian@gmail.com
// 
// Create Date: 07/05/2021 07:07:53 PM
// Design Name: 
// Module Name: sine_wave_generator_quarter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Use a quarter wave lookup table to generate a sine wave
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module sine_wave_generator_quarter#(
    parameter ROM_DEPTH = 32768,
    parameter ROM_WIDTH = 16
)(
    input   wire                clock,
    input   wire                reset_n,
    input   wire        [31:0]  phase_step,

    output  reg signed  [15:0]  generated_wave
);


reg signed [ROM_WIDTH-1:0] rom_memory [ROM_DEPTH-1:0];
initial begin
    $readmemh("./test/16x32768_sine_lut_quarter.mem", rom_memory);
end

logic           [31:0]      _accumulator;
reg             [31:0]      accumulator;
logic           [16:0]      index;
logic                       reverse;
logic                       invert;
logic           [14:0]      look_up_table_index;
logic signed    [15:0]      _generated_wave;

always_comb begin
    _accumulator    = accumulator + phase_step;
    index           = accumulator[31:15];
    reverse         = index[15];
    invert          = index[16];

    if (reverse) begin
        look_up_table_index =   (ROM_DEPTH-1) - index[14:0];
    end
    else begin
        look_up_table_index =   index[14:0];
    end

    if (invert) begin
        _generated_wave = -rom_memory[look_up_table_index];
    end
    else begin
        _generated_wave = rom_memory[look_up_table_index];
    end
end

always_ff @(posedge clock or negedge reset_n) begin
    if (!reset_n) begin
        accumulator     <=  0;
        generated_wave  <=  0;
    end
    else begin
        accumulator     <= _accumulator;
        generated_wave  <= _generated_wave;
    end
end

endmodule