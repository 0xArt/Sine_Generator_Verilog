onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/sine_wave_generator_quarter/clock
add wave -noupdate /testbench/sine_wave_generator_quarter/reset_n
add wave -noupdate /testbench/sine_wave_generator_quarter/phase_step
add wave -noupdate /testbench/sine_wave_generator_quarter/_accumulator
add wave -noupdate /testbench/sine_wave_generator_quarter/accumulator
add wave -noupdate /testbench/sine_wave_generator_quarter/index
add wave -noupdate /testbench/sine_wave_generator_quarter/look_up_table_index
add wave -noupdate /testbench/sine_wave_generator_quarter/_generated_wave
add wave -noupdate /testbench/sine_wave_generator_quarter/reverse
add wave -noupdate /testbench/sine_wave_generator_quarter/invert
add wave -noupdate -format Analog-Step -height 100 -max 32766.0 -radix decimal /testbench/sine_wave_generator_quarter/generated_wave
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14780995000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {339547126 ps} {32817862874 ps}
