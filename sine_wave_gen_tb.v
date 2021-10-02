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


module sine_wave_gen_tb(

    );
    
    reg clk = 0;
    wire signed [15:0] sine_wave;
    reg [31:0] freq_control = 16'd50;
    reg rst = 0;
    
    //clock gen
    always begin
        #2
        clk = ~clk;
    end
    
    integer i, sine_wave_file;

    
    initial begin
        sine_wave_file = $fopen("sine_wave_file.csv", "w");
        
        //sweep up in frequency and record data to csv for further analysis
        for(i=0; i<200000; i=i+1000)begin
            freq_control = i;
            repeat (100000)begin
                @(posedge clk);
                $fwrite(sine_wave_file,"%d,%d\n",sine_wave,freq_control);
            end 
        end
        $fclose(sine_wave_file);
        $stop;

    end
    
    

    sine_wave_gen_quarter sine_wave_gen_quarter_inst(
        .i_clk(clk),
        .i_rst(rst),
        .i_phase_adder(freq_control),
        .o_gen_out(sine_wave)
    );
    
endmodule
