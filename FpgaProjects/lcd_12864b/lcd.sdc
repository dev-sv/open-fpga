create_clock -name clk -period 8000.000 -waveform {0 4000}
derive_pll_clocks -create_base_clocks
derive_clock_uncertainty