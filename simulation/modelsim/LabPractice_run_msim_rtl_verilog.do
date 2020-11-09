transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/sax/code/Quartus/Practica4 {C:/Users/sax/code/Quartus/Practica4/alu.sv}

