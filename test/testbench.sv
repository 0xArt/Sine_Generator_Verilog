`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:     www.circuitden.com
// Engineer:    Artin Isagholian
//              artinisagholian@gmail.com
// Create Date: 10/02/2021 03:15:37 PM
// Design Name: 
// Module Name: sine_wave_gen_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module testbench;

localparam  CLOCK_FREQUENCY             =   100_000_000;
localparam  CLOCK_PERIOD                =   1e9/CLOCK_FREQUENCY;

logic           clock                   = 0;
logic           reset_n                 = 1;
logic [31:0]    test_phase_step         = 50;
integer         i;
integer         sine_wave_file;

initial begin
    clock   =   0;

    forever begin
        #(CLOCK_PERIOD/2);
        clock   =   ~clock;
    end
end

initial begin
    reset_n =   0;
    repeat(100) @(posedge clock);
    reset_n =   1;
end

initial begin
    wait(reset_n);
    repeat(100) @(posedge clock);
    sine_wave_file = $fopen("sine_wave_file.csv", "w");
    
    //sweep up in frequency and record data to csv for further analysis
    for(i=0; i<200000; i=i+1000)begin
        test_phase_step = i;

        repeat (100000)begin
            @(posedge clock);
            $fwrite(sine_wave_file,"%d,%d\n", sine_wave_generator_quarter_generated_wave, test_phase_step);
        end 
    end
    $fclose(sine_wave_file);
    $stop();
end


wire            sine_wave_generator_quarter_clock;
wire            sine_wave_generator_quarter_reset_n;
wire    [31:0]  sine_wave_generator_quarter_phase_step;

wire    [15:0]  sine_wave_generator_quarter_generated_wave;

sine_wave_generator_quarter sine_wave_generator_quarter(
    .clock          (sine_wave_generator_quarter_clock),
    .reset_n        (sine_wave_generator_quarter_reset_n),
    .phase_step     (sine_wave_generator_quarter_phase_step),

    .generated_wave (sine_wave_generator_quarter_generated_wave)
);

assign sine_wave_generator_quarter_clock        = clock;
assign sine_wave_generator_quarter_reset_n      = reset_n;
assign sine_wave_generator_quarter_phase_step   = test_phase_step;


endmodule