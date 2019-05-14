# Real-Time-Counter
The inputs clk, rst are mapped to the Spartan-6 FPGA. When reset is disabled, the counter starts to count.
The outputs are mapped to the available 7-segment display on board. 2 segments are decicated fro seconds count, and the other 2 are dedicated for minute count.
A slowclock is created which allows the transistioning from one segment to another segment, displaying numbers on all segemnts without bleeding.
