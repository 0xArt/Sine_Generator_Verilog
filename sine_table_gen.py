# -*- coding: utf-8 -*-
"""
Created on Sat Oct  2 14:23:31 2021

@author: Artin Isagholian

Generate .mem file sine wave look up table
"""

import numpy as np;

num_samples = 32768;


start_time = 0;
end_time_full_table = 2*np.pi;
end_time_quarter_table = (np.pi/2);


discrete_time_values_quarter = np.arange(start_time,end_time_quarter_table,end_time_quarter_table/num_samples);
quarter_sine_values = np.sin(discrete_time_values_quarter)

discrete_time_values_full = np.arange(start_time,end_time_full_table,end_time_full_table/num_samples);
full_sine_values = np.sin(discrete_time_values_full)

#normalize to Int16
quarter_sine_values_normalized = np.short(quarter_sine_values*(32767));
full_sine_values_normalized = np.short(full_sine_values*(32767));

#make mem file
quarter_mem_file = open("16x" + str(num_samples)+"_sine_lut_quarter.mem","w+")
for i in range(len(quarter_sine_values_normalized)):
    quarter_mem_file.write(str(hex(quarter_sine_values_normalized[i])).replace("0x","").upper() + "\n")
quarter_mem_file.close()

