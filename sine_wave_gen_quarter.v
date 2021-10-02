`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     www.circuitden.com
// Engineer:    Artin Isagholian
//              artinisagholian@gmail.com
// 
// Create Date: 07/05/2021 07:07:53 PM
// Design Name: 
// Module Name: sine_wave_gen_quarter
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

module sine_wave_gen_quarter#(parameter ROM_WIDTH = 32768)
(
        input wire                  i_clk,
        input wire                  i_rst,
        input wire  [31:0]          i_phase_adder, //freq will  increase as i_phase_adder increases
        output reg signed [15:0]    o_gen_out = 0

);


    reg signed [15:0] rom_memory [ROM_WIDTH-1:0];
    initial begin
        $readmemh("16x32768_sine_lut_quarter.mem", rom_memory);
    end
    
    reg  [31:0] accumulator = 0;
    wire [14:0] lut_index;
    wire [16:0] index;
    wire [15:0] sine_out;
    wire invert;
    wire reverse;
    
    assign index = accumulator[31:15];
    //if index[15] is set we want to read backwards
    assign reverse = index[15];
    assign invert = index[16];
    assign lut_index = (reverse) ? ((ROM_WIDTH-1) - accumulator[29:15]) : accumulator[29:15];
    //if index[16] is set we want to negate the result
    assign sine_out  =  (invert) ? -rom_memory[lut_index] : rom_memory[lut_index];
   
    //phase accumulator
    always@(posedge i_clk) begin
        if(i_rst)begin
            o_gen_out <= 0;
            accumulator <= 0;
        end         
        else begin
            accumulator <= accumulator + i_phase_adder;
            o_gen_out <= sine_out;
        end
    end



endmodule
