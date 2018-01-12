transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Final\ Projesi {D:/Final Projesi/mips_core.v}
vlog -vlog01compat -work work +incdir+D:/Final\ Projesi {D:/Final Projesi/alu.v}
vlog -vlog01compat -work work +incdir+D:/Final\ Projesi {D:/Final Projesi/control_unit.v}
vlog -vlog01compat -work work +incdir+D:/Final\ Projesi {D:/Final Projesi/alu_control_unit.v}
vlog -vlog01compat -work work +incdir+D:/Final\ Projesi {D:/Final Projesi/mips_registers.v}
vlog -vlog01compat -work work +incdir+D:/Final\ Projesi {D:/Final Projesi/mips_instr_mem.v}
vlog -vlog01compat -work work +incdir+D:/Final\ Projesi {D:/Final Projesi/mips_data_mem.v}

