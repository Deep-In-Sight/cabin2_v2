set TOP_DIR [pwd]
set IP_REPO_DIR $TOP_DIR/../../vitis_hls/ip_repo

set PROJECT_NAME project
set PROJECT_DIR $TOP_DIR/$PROJECT_NAME
set PART_NAME xc7z020clg400-1

set BD_TCL $TOP_DIR/scripts/design_1.tcl
set XSA_NAME cabin2_v2.xsa

proc numberOfCPUs {} {
    # Windows puts it in an environment variable
    global tcl_platform env
    if {$tcl_platform(platform) eq "windows"} {                                                                                                                        
        return $env(NUMBER_OF_PROCESSORS)                                                                                                                              
    }                                                                                                                                                                  
                                                                                                                                                                       
    # Check for sysctl (OSX, BSD)
    set sysctl [auto_execok "sysctl"]
    if {[llength $sysctl]} {
        if {![catch {exec {*}$sysctl -n "hw.ncpu"} cores]} {
            return $cores
        }                                                                                                                                                              
    }                                                                                                                                                                  
                                                                                                                                                                       
    # Assume Linux, which has /proc/cpuinfo, but be careful
    if {![catch {open "/proc/cpuinfo"} f]} {
        set cores [regexp -all -line {^processor\s} [read $f]]
        close $f
        if {$cores > 0} {
            return $cores                                                                                                                                              
        }                                                                                                                                                              
    }                                                                                                                                                                  
                                                                                                                                                                       
    # No idea what the actual number of cores is; exhausted all our options
    # Fall back to returning 1; there must be at least that because we're running on it!
    return 1                                                                                                                                                           
}                                                                                                                                                                      
                                                                                                                                                                       
set numberOfCores [numberOfCPUs]

#Create project
create_project $PROJECT_NAME $PROJECT_DIR -part $PART_NAME

#add ip repo
set_property  ip_repo_paths $IP_REPO_DIR [current_project]
update_ip_catalog

#create block design
source $BD_TCL
make_wrapper -files [get_files $PROJECT_DIR/$PROJECT_NAME.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse $PROJECT_DIR/$PROJECT_NAME.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v

#add constraints
add_files -fileset constrs_1 -norecurse $TOP_DIR/xdc/mipi.xdc

#explore to meet timing
set_property STEPS.PLACE_DESIGN.ARGS.DIRECTIVE Explore [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.ARGS.DIRECTIVE Explore [get_runs impl_1]
set_property STEPS.ROUTE_DESIGN.ARGS.DIRECTIVE Explore [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.ARGS.DIRECTIVE Explore [get_runs impl_1]

#fire up bitstream generator
launch_runs impl_1 -to_step write_bitstream -jobs $numberOfCores
wait_on_run impl_1

#export xsa
write_hw_platform -fixed -include_bit -force -file $TOP_DIR/../xsa/$XSA_NAME
