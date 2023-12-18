global proj_dict
source -notrace ./script/proj_gen.tcl

proc create_target {} {
        global proj_dict

        # Get the current time as a Unix timestamp
        set currentTime [clock seconds]

        # Format the timestamp into the desired format
        set formattedTime [clock format $currentTime -format {%Y%m%d_%H%M%S}]

        set proj_name "kria_led_from_pl_example${formattedTime}_"
        
        set origin_dir "./led_from_pl"
        
        # Set project info
        set_proj_info                                    \
            -force                                       \
            -part "xck26-sfvc784-2LV-c"                  \
            -board_part "xilinx.com:kv260_som:part0:1.4" \
            -addr "$origin_dir"                          \
            -name "$proj_name"

        generate_project

        # Add source files
        create_src_filesets $origin_dir
        
        # Set top module
        set HDL_TOP_MODULE_NAME "kv260_top"
        set_top_wrapper $HDL_TOP_MODULE_NAME

        # Add constraint files
        create_constr_filesets $origin_dir
        update_compile_order -fileset sources_1

        # Build the project
        puts "--- Building project"
        
        wait_on_run impl_1

        puts "--- Export bitstream"
        set xil_proj [get_project_name]
        export_proj_bitstream "$origin_dir/build/export_${xil_proj}"
        
    }
