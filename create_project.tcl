#*****************************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# create_project.tcl: Tcl script for re-creating project 'mips_processor'
#
# Generated by Vivado on Fri May 01 18:34:11 -0700 2020
# IP Build 2700528 on Thu Nov  7 00:09:20 MST 2019
#
# This file contains the Vivado Tcl commands for re-creating the project to the state*
# when this script was generated. In order to re-create the project, please source this
# file in the Vivado Tcl Shell.
#
# * Note that the runs in the created project will be configured the same way as the
#   original project, however they will not be launched automatically. To regenerate the
#   run results please launch the synthesis/implementation runs as needed.
#
#*****************************************************************************************
# NOTE: In order to use this script for source control purposes, please make sure that the
#       following files are added to the source control system:-
#
# 1. This project restoration tcl script (create_project.tcl) that was generated.
#
# 2. The following source(s) files that were local or imported into the original project.
#    (Please see the '$orig_proj_dir' and '$origin_dir' variable setting below at the start of the script)
#
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/multiplier.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/regfile.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/fpga/button_debouncer.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/fpga/led_mux.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/datapath.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/fpga/hex_to_7seg.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/cu/maindec.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/adder.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/mux3.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/mux6.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/shifter.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/cu/controlunit.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/signext.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/cu/auxdec.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/alu.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/dreg.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dp/mux2.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/fpga/clk_gen.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/factorial/MUX.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/factorial/REG.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/factorial/factorial_cu.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/factorial/factorial.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/factorial/MUL.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/factorial/factorial_dp.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/factorial/CMP.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/factorial/CNT.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/dreg_en.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/dmem.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/imem.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/mips.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/AddressDecoder.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/system.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/fpga/fpga_top.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/fpga/disp_hex_mux.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/fact_top.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/SR_reg.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/AddressDecoderGpio.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/gpio.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/mux4.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/system/fact_ad.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/inst_machine_code.dat"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/if_id_reg.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/mem_wb_reg.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/exe_mem_reg.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/id_exe_reg.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/hazard_unit.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sources_1/new/pl_datapath.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/constrs_1/new/mips_fpga.xdc"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sim_1/new/tb_mips_top.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sim_1/new/tb_mips_extended.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sim_1/new/tb_system_decoder.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sim_1/new/tb_fact_top.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sim_1/new/tb_gpio.v"
#    "C:/Users/Photo/Single-Cycle-MIPS-Processor-FPGA/mips_processor.srcs/sim_1/new/tb_system_integration.v"
#
# 3. The following remote source files that were added to the original project:-
#
#    <none>
#
#*****************************************************************************************

# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir [file dirname [file normalize [info script]]]
cd $origin_dir

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

# Set the project name
set _xil_proj_name_ "mips_processor"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

variable script_file
set script_file "create_project.tcl"

# Help information for this script
proc print_help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--project_name <name>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--project_name <name>\] Create project with the specified name. Default"
  puts "                       name is the name of the project from where this"
  puts "                       script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < $::argc} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir"   { incr i; set origin_dir [lindex $::argv $i] }
      "--project_name" { incr i; set _xil_proj_name_ [lindex $::argv $i] }
      "--help"         { print_help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/"]"

# Create project
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7a35tcpg236-1

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "part" -value "xc7a35tcpg236-1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "source_mgmt_mode" -value "DisplayOnly" -objects $obj
set_property -name "webtalk.activehdl_launch_sim" -value "3" -objects $obj
set_property -name "webtalk.xsim_launch_sim" -value "115" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
# Add local files from the original project (-no_copy_sources specified)
set files [list \
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/multiplier.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/regfile.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/fpga/button_debouncer.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/fpga/led_mux.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/datapath.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/fpga/hex_to_7seg.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/cu/maindec.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/adder.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/mux3.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/mux6.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/shifter.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/cu/controlunit.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/signext.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/cu/auxdec.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/alu.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/dreg.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dp/mux2.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/fpga/clk_gen.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/factorial/MUX.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/factorial/REG.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/factorial/factorial_cu.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/factorial/factorial.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/factorial/MUL.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/factorial/factorial_dp.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/factorial/CMP.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/factorial/CNT.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/dreg_en.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/dmem.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/imem.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/mips.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/AddressDecoder.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/system.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/fpga/fpga_top.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/fpga/disp_hex_mux.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/fact_top.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/SR_reg.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/AddressDecoderGpio.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/gpio.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/mux4.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/system/fact_ad.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/inst_machine_code.dat" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/if_id_reg.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/mem_wb_reg.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/exe_mem_reg.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/id_exe_reg.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/hazard_unit.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sources_1/new/pl_datapath.v" ]\
]
set added_files [add_files -fileset sources_1 $files]

# Set 'sources_1' fileset file properties for remote files
# None

# Set 'sources_1' fileset file properties for local files
set file "new/inst_machine_code.dat"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Data Files" -objects $file_obj


# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value "fpga_top" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/mips_processor.srcs/constrs_1/new/mips_fpga.xdc"]"
set file_added [add_files -norecurse -fileset $obj [list $file]]
set file "new/mips_fpga.xdc"
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property -name "target_part" -value "xc7a35tcpg236-1" -objects $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Add local files from the original project (-no_copy_sources specified)
set files [list \
 [file normalize "${origin_dir}/mips_processor.srcs/sim_1/new/tb_mips_top.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sim_1/new/tb_mips_extended.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sim_1/new/tb_system_decoder.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sim_1/new/tb_fact_top.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sim_1/new/tb_gpio.v" ]\
 [file normalize "${origin_dir}/mips_processor.srcs/sim_1/new/tb_system_integration.v" ]\
]
set added_files [add_files -fileset sim_1 $files]

# Set 'sim_1' fileset file properties for remote files
# None

# Set 'sim_1' fileset file properties for local files
# None

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "tb_system_integration" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj

# Set 'utils_1' fileset object
set obj [get_filesets utils_1]
# Empty (no sources present)

# Set 'utils_1' fileset properties
set obj [get_filesets utils_1]

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7a35tcpg236-1 -flow {Vivado Synthesis 2019} -strategy "Vivado Synthesis Defaults" -report_strategy {No Reports} -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2019" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Synthesis Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'synth_1_synth_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0] "" ] } {
  create_report_config -report_name synth_1_synth_report_utilization_0 -report_type report_utilization:1.0 -steps synth_design -runs synth_1
}
set obj [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0]
if { $obj != "" } {

}
set obj [get_runs synth_1]
set_property -name "part" -value "xc7a35tcpg236-1" -objects $obj
set_property -name "strategy" -value "Vivado Synthesis Defaults" -objects $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7a35tcpg236-1 -flow {Vivado Implementation 2019} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2019" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Implementation Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'impl_1_init_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_init_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps init_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_opt_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_drc_0 -report_type report_drc:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_place_report_io_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0] "" ] } {
  create_report_config -report_name impl_1_place_report_io_0 -report_type report_io:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0] "" ] } {
  create_report_config -report_name impl_1_place_report_utilization_0 -report_type report_utilization:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_control_sets_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0] "" ] } {
  create_report_config -report_name impl_1_place_report_control_sets_0 -report_type report_control_sets:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0]
if { $obj != "" } {
set_property -name "options.verbose" -value "1" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_1' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_1 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_place_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_post_place_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_place_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_place_power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_route_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_route_report_drc_0 -report_type report_drc:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_methodology_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0] "" ] } {
  create_report_config -report_name impl_1_route_report_methodology_0 -report_type report_methodology:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_power_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0] "" ] } {
  create_report_config -report_name impl_1_route_report_power_0 -report_type report_power:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_route_status_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0] "" ] } {
  create_report_config -report_name impl_1_route_report_route_status_0 -report_type report_route_status:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_route_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0]
if { $obj != "" } {
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_route_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_route_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_clock_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0] "" ] } {
  create_report_config -report_name impl_1_route_report_clock_utilization_0 -report_type report_clock_utilization:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_route_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0]
if { $obj != "" } {
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
# Create 'impl_1_post_route_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
# Create 'impl_1_post_route_phys_opt_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0]
if { $obj != "" } {
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
set obj [get_runs impl_1]
set_property -name "part" -value "xc7a35tcpg236-1" -objects $obj
set_property -name "strategy" -value "Vivado Implementation Defaults" -objects $obj
set_property -name "steps.phys_opt_design.is_enabled" -value "1" -objects $obj
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

puts "INFO: Project created:${_xil_proj_name_}"
# Create 'drc_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "drc_1" ] ] ""]} {
create_dashboard_gadget -name {drc_1} -type drc
}
set obj [get_dashboard_gadgets [ list "drc_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_drc_0" -objects $obj

# Create 'methodology_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "methodology_1" ] ] ""]} {
create_dashboard_gadget -name {methodology_1} -type methodology
}
set obj [get_dashboard_gadgets [ list "methodology_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_methodology_0" -objects $obj

# Create 'power_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "power_1" ] ] ""]} {
create_dashboard_gadget -name {power_1} -type power
}
set obj [get_dashboard_gadgets [ list "power_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_power_0" -objects $obj

# Create 'timing_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "timing_1" ] ] ""]} {
create_dashboard_gadget -name {timing_1} -type timing
}
set obj [get_dashboard_gadgets [ list "timing_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_timing_summary_0" -objects $obj

# Create 'utilization_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_1" ] ] ""]} {
create_dashboard_gadget -name {utilization_1} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_1" ] ]
set_property -name "reports" -value "synth_1#synth_1_synth_report_utilization_0" -objects $obj
set_property -name "run.step" -value "synth_design" -objects $obj
set_property -name "run.type" -value "synthesis" -objects $obj

# Create 'utilization_2' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_2" ] ] ""]} {
create_dashboard_gadget -name {utilization_2} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_2" ] ]
set_property -name "reports" -value "impl_1#impl_1_place_report_utilization_0" -objects $obj

move_dashboard_gadget -name {utilization_1} -row 0 -col 0
move_dashboard_gadget -name {power_1} -row 1 -col 0
move_dashboard_gadget -name {drc_1} -row 2 -col 0
move_dashboard_gadget -name {timing_1} -row 0 -col 1
move_dashboard_gadget -name {utilization_2} -row 1 -col 1
move_dashboard_gadget -name {methodology_1} -row 2 -col 1

close_project
file copy -force ${_xil_proj_name_}/${_xil_proj_name_}.xpr ${_xil_proj_name_}.xpr
file delete -force ${_xil_proj_name_}
open_project ${_xil_proj_name_}.xpr
