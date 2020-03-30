# Master clock: 100 MHz
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN Y6 [get_ports clk]
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# Reset signal
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN L22 [get_ports rst_n]
set_property PULLUP true [get_ports rst_n]

# FT2232H signals
set_property IOSTANDARD LVCMOS33 [get_ports {data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data[0]}]
set_property PACKAGE_PIN T22 [get_ports {data[0]}]
set_property PACKAGE_PIN T21 [get_ports {data[1]}]
set_property PACKAGE_PIN U22 [get_ports {data[2]}]
set_property PACKAGE_PIN U21 [get_ports {data[3]}]
set_property PACKAGE_PIN V22 [get_ports {data[4]}]
set_property PACKAGE_PIN W22 [get_ports {data[5]}]
set_property PACKAGE_PIN AA22 [get_ports {data[6]}]
set_property PACKAGE_PIN AB22 [get_ports {data[7]}]
set_property DRIVE 8 [get_ports {data[7]}]
set_property DRIVE 8 [get_ports {data[6]}]
set_property DRIVE 8 [get_ports {data[5]}]
set_property DRIVE 8 [get_ports {data[4]}]
set_property DRIVE 8 [get_ports {data[3]}]
set_property DRIVE 8 [get_ports {data[2]}]
set_property DRIVE 8 [get_ports {data[1]}]
set_property DRIVE 8 [get_ports {data[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports clkout]
set_property PACKAGE_PIN L18 [get_ports clkout]
create_clock -period 16.667 -name clkout -waveform {0.000 8.334} [get_ports clkout]

set_property IOSTANDARD LVCMOS33 [get_ports rd_n]
set_property PACKAGE_PIN Y20 [get_ports rd_n]

set_property IOSTANDARD LVCMOS33 [get_ports rxf_n]
set_property PACKAGE_PIN W20 [get_ports rxf_n]

set_property IOSTANDARD LVCMOS33 [get_ports siwu]
set_property PACKAGE_PIN V20 [get_ports siwu]

set_property IOSTANDARD LVCMOS33 [get_ports txe_n]
set_property PACKAGE_PIN Y21 [get_ports txe_n]

set_property IOSTANDARD LVCMOS33 [get_ports wr_n]
set_property PACKAGE_PIN W21 [get_ports wr_n]

set_property IOSTANDARD LVCMOS33 [get_ports oe_n]
set_property PACKAGE_PIN U20 [get_ports oe_n]

# NHALGA
set_property IOSTANDARD LVCMOS33 [get_ports nhalga]
set_property DRIVE 4 [get_ports nhalga]
set_property PACKAGE_PIN J22 [get_ports nhalga]

# MNHRPT
set_property IOSTANDARD LVCMOS33 [get_ports mnhrpt]
set_property DRIVE 4 [get_ports mnhrpt]
set_property PACKAGE_PIN G22 [get_ports mnhrpt]
