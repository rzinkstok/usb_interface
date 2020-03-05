# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/rzinkstok/usb_interface/fpga/usb_interface.cache/wt [current_project]
set_property parent.project_path /home/rzinkstok/usb_interface/fpga/usb_interface.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part numato.com:styx:part0:1.0 [current_project]
set_property ip_output_repo /home/rzinkstok/usb_interface/fpga/usb_interface.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/new/monitor_defs.v
set_property file_type "Verilog Header" [get_files /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/new/monitor_defs.v]
read_verilog -library xil_defaultlib {
  /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/new/cmd_receiver.v
  /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/new/usb_interface.v
  /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/new/toplevel.v
}
read_ip -quiet /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/ip/cmd_fifo/cmd_fifo.xci
set_property used_in_implementation false [get_files -all /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/ip/cmd_fifo/cmd_fifo.xdc]
set_property used_in_implementation false [get_files -all /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/ip/cmd_fifo/cmd_fifo_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/sources_1/ip/cmd_fifo/cmd_fifo_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/constrs_1/new/usb_interface.xdc
set_property used_in_implementation false [get_files /home/rzinkstok/usb_interface/fpga/usb_interface.srcs/constrs_1/new/usb_interface.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top toplevel -part xc7z020clg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef toplevel.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file toplevel_utilization_synth.rpt -pb toplevel_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
