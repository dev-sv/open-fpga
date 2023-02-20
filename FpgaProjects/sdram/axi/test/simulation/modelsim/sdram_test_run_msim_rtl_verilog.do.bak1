transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib sdram_design
vmap sdram_design sdram_design
vlog -vlog01compat -work sdram_design +incdir+/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis {/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/sdram_design.v}
vlog -vlog01compat -work sdram_design +incdir+/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules {/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work sdram_design +incdir+/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules {/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work sdram_design +incdir+/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules {/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules/sdram_design_mm_interconnect_0.v}
vlog -vlog01compat -work work +incdir+/home/user/Projects/ip/sdram_micron/axi/test {/home/user/Projects/ip/sdram_micron/axi/test/pll.v}
vlog -vlog01compat -work work +incdir+/home/user/Projects/ip/sdram_micron/axi/test/db {/home/user/Projects/ip/sdram_micron/axi/test/db/pll_altpll.v}
vlog -sv -work sdram_design +incdir+/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules {/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules/altera_merlin_axi_translator.sv}
vlog -sv -work sdram_design +incdir+/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules {/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules/altera_axi_bridge.sv}
vlog -vlog01compat -work sdram_design +incdir+/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules {/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules/altera_avalon_st_pipeline_base.v}
vlog -sv -work sdram_design +incdir+/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules {/home/user/Projects/ip/sdram_micron/axi/test/sdram_design/synthesis/submodules/sdram.sv}
vlog -sv -work work +incdir+/home/user/Projects/ip/sdram_micron/axi/test {/home/user/Projects/ip/sdram_micron/axi/test/sdram_test.sv}

