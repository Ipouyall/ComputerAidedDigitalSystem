	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
#	set run_time			"1 us"
	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder_CU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/encoder_DP.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/input_convertor.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/modulo24.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Multiplexer1600bit2to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/my_memory.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/output_convertor.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/add_rc.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/add_rc_cu.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/add_rc_dp.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/addrc_Register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/counter6bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/Data_mem.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/LUT.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/Multiplexer1bit64to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRC/Multiplexer25bit2to1.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/colParity.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/cp_Controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/cp_Counter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/cp_Datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/moduloCounter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/multiplexer.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/parity.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/shiftRegister.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/Permutation.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/pr_CU.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/pr_DP.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/Top_Permute.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/Top_Permute_cu.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/Top_Permute_dp.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/Revaluate.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/Revaluate_combine.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/rv_Controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/rv_Datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/rv_Register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/Top_revluate.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/Top_revluate_cu.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/Top_revluate_dp.v

	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/complement.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/memoryfile.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/modulo.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate_cu.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate_dp.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate_rom.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotator.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/ShiftLeftRegister64.v

		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.sv
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	