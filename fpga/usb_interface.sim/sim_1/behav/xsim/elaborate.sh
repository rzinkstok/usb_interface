#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sun Mar 29 14:20:08 CEST 2020
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto fb59eb25ef0e4f54847876d2cca6a036 --incr --debug typical --relax --mt 8 -L fifo_generator_v13_2_4 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot toplevel_tb_behav xil_defaultlib.toplevel_tb xil_defaultlib.glbl -log elaborate.log"
xelab -wto fb59eb25ef0e4f54847876d2cca6a036 --incr --debug typical --relax --mt 8 -L fifo_generator_v13_2_4 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot toplevel_tb_behav xil_defaultlib.toplevel_tb xil_defaultlib.glbl -log elaborate.log

