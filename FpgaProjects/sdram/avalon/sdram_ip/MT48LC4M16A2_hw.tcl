# TCL File Generated by Component Editor 18.0
# Wed Apr 12 13:18:57 MSK 2023
# DO NOT MODIFY


# 
# MT48LC4M16A2_AVL "MT48LC4M16A2_AVL" v1.0
#  2023.04.12.13:18:57
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module MT48LC4M16A2_AVL
# 
set_module_property DESCRIPTION ""
set_module_property NAME MT48LC4M16A2_AVL
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME MT48LC4M16A2_AVL
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL sdram
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file sdram.sv SYSTEM_VERILOG PATH sdram.sv TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter WRITE_RECOVERY_TIME INTEGER 2
set_parameter_property WRITE_RECOVERY_TIME DEFAULT_VALUE 2
set_parameter_property WRITE_RECOVERY_TIME DISPLAY_NAME WRITE_RECOVERY_TIME
set_parameter_property WRITE_RECOVERY_TIME TYPE INTEGER
set_parameter_property WRITE_RECOVERY_TIME UNITS None
set_parameter_property WRITE_RECOVERY_TIME ALLOWED_RANGES -2147483648:2147483647
set_parameter_property WRITE_RECOVERY_TIME HDL_PARAMETER true
add_parameter PRECHARGE_COMMAND_PERIOD INTEGER 2
set_parameter_property PRECHARGE_COMMAND_PERIOD DEFAULT_VALUE 2
set_parameter_property PRECHARGE_COMMAND_PERIOD DISPLAY_NAME PRECHARGE_COMMAND_PERIOD
set_parameter_property PRECHARGE_COMMAND_PERIOD TYPE INTEGER
set_parameter_property PRECHARGE_COMMAND_PERIOD UNITS None
set_parameter_property PRECHARGE_COMMAND_PERIOD ALLOWED_RANGES -2147483648:2147483647
set_parameter_property PRECHARGE_COMMAND_PERIOD HDL_PARAMETER true
add_parameter AUTO_REFRESH_PERIOD INTEGER 7
set_parameter_property AUTO_REFRESH_PERIOD DEFAULT_VALUE 7
set_parameter_property AUTO_REFRESH_PERIOD DISPLAY_NAME AUTO_REFRESH_PERIOD
set_parameter_property AUTO_REFRESH_PERIOD TYPE INTEGER
set_parameter_property AUTO_REFRESH_PERIOD UNITS None
set_parameter_property AUTO_REFRESH_PERIOD ALLOWED_RANGES -2147483648:2147483647
set_parameter_property AUTO_REFRESH_PERIOD HDL_PARAMETER true
add_parameter LOAD_MODE_REGISTER INTEGER 3
set_parameter_property LOAD_MODE_REGISTER DEFAULT_VALUE 3
set_parameter_property LOAD_MODE_REGISTER DISPLAY_NAME LOAD_MODE_REGISTER
set_parameter_property LOAD_MODE_REGISTER TYPE INTEGER
set_parameter_property LOAD_MODE_REGISTER UNITS None
set_parameter_property LOAD_MODE_REGISTER ALLOWED_RANGES -2147483648:2147483647
set_parameter_property LOAD_MODE_REGISTER HDL_PARAMETER true
add_parameter ACTIVE_READ_WRITE INTEGER 2
set_parameter_property ACTIVE_READ_WRITE DEFAULT_VALUE 2
set_parameter_property ACTIVE_READ_WRITE DISPLAY_NAME ACTIVE_READ_WRITE
set_parameter_property ACTIVE_READ_WRITE TYPE INTEGER
set_parameter_property ACTIVE_READ_WRITE UNITS None
set_parameter_property ACTIVE_READ_WRITE ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ACTIVE_READ_WRITE HDL_PARAMETER true
add_parameter REFRESH_PERIOD INTEGER 6400000
set_parameter_property REFRESH_PERIOD DEFAULT_VALUE 6400000
set_parameter_property REFRESH_PERIOD DISPLAY_NAME REFRESH_PERIOD
set_parameter_property REFRESH_PERIOD TYPE INTEGER
set_parameter_property REFRESH_PERIOD UNITS None
set_parameter_property REFRESH_PERIOD ALLOWED_RANGES -2147483648:2147483647
set_parameter_property REFRESH_PERIOD HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point sdram
# 
add_interface sdram conduit end
set_interface_property sdram associatedClock clock
set_interface_property sdram associatedReset reset
set_interface_property sdram ENABLED true
set_interface_property sdram EXPORT_OF ""
set_interface_property sdram PORT_NAME_MAP ""
set_interface_property sdram CMSIS_SVD_VARIABLES ""
set_interface_property sdram SVD_ADDRESS_GROUP ""

add_interface_port sdram dq dq Bidir 16
add_interface_port sdram address address Output 12
add_interface_port sdram ba ba Output 2
add_interface_port sdram dqm dqm Output 2
add_interface_port sdram osc osc Output 1
add_interface_port sdram cs cs Output 1
add_interface_port sdram we we Output 1
add_interface_port sdram ras ras Output 1
add_interface_port sdram cas cas Output 1


# 
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock
set_interface_property avalon_slave associatedReset reset
set_interface_property avalon_slave bitsPerSymbol 8
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 64
set_interface_property avalon_slave maximumPendingWriteTransactions 0
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitTime 1
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave writeWaitTime 0
set_interface_property avalon_slave ENABLED true
set_interface_property avalon_slave EXPORT_OF ""
set_interface_property avalon_slave PORT_NAME_MAP ""
set_interface_property avalon_slave CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave s_read read Input 1
add_interface_port avalon_slave s_write write Input 1
add_interface_port avalon_slave s_address address Input 22
add_interface_port avalon_slave s_writedata writedata Input 16
add_interface_port avalon_slave s_burstcount burstcount Input 9
add_interface_port avalon_slave s_byteenable byteenable Input 2
add_interface_port avalon_slave s_waitrequest waitrequest Output 1
add_interface_port avalon_slave s_readdatavalid readdatavalid Output 1
add_interface_port avalon_slave s_readdata readdata Output 16
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0

