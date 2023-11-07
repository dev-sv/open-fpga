transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib sdram_qsys
vmap sdram_qsys sdram_qsys
vlog -vlog01compat -work sdram_qsys +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/sdram_qsys.v}
vlog -vlog01compat -work sdram_qsys +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work sdram_qsys +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work sdram_qsys +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules/sdram_qsys_mm_interconnect_0.v}
vlog -vlog01compat -work sdram_qsys +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules/altera_avalon_mm_bridge.v}
vlog -vlog01compat -work work +incdir+/home/user/Projects/max10/sdram/avalon/hw_test {/home/user/Projects/max10/sdram/avalon/hw_test/pll.v}
vlog -vlog01compat -work work +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/db {/home/user/Projects/max10/sdram/avalon/hw_test/db/pll_altpll.v}
vlog -sv -work sdram_qsys +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules/altera_merlin_slave_translator.sv}
vlog -sv -work sdram_qsys +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules/altera_merlin_master_translator.sv}
vlog -sv -work sdram_qsys +incdir+/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_qsys/synthesis/submodules/sdram.sv}
vlog -sv -work work +incdir+/home/user/Projects/max10/sdram/avalon/hw_test {/home/user/Projects/max10/sdram/avalon/hw_test/sdram_test.sv}

