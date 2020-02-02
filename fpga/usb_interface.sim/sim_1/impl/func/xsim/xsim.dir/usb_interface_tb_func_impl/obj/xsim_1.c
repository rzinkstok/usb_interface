/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern void execute_2(char*, char *);
extern void execute_292(char*, char *);
extern void execute_297(char*, char *);
extern void execute_538(char*, char *);
extern void execute_539(char*, char *);
extern void execute_540(char*, char *);
extern void execute_541(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_298(char*, char *);
extern void execute_299(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_14(char*, char *);
extern void execute_15(char*, char *);
extern void execute_16(char*, char *);
extern void execute_302(char*, char *);
extern void execute_303(char*, char *);
extern void execute_304(char*, char *);
extern void execute_305(char*, char *);
extern void execute_22(char*, char *);
extern void execute_310(char*, char *);
extern void execute_24(char*, char *);
extern void execute_311(char*, char *);
extern void execute_312(char*, char *);
extern void execute_313(char*, char *);
extern void execute_42(char*, char *);
extern void execute_43(char*, char *);
extern void execute_47(char*, char *);
extern void execute_48(char*, char *);
extern void execute_59(char*, char *);
extern void execute_340(char*, char *);
extern void execute_341(char*, char *);
extern void execute_342(char*, char *);
extern void execute_343(char*, char *);
extern void execute_344(char*, char *);
extern void execute_345(char*, char *);
extern void execute_346(char*, char *);
extern void execute_347(char*, char *);
extern void execute_339(char*, char *);
extern void execute_66(char*, char *);
extern void execute_350(char*, char *);
extern void execute_351(char*, char *);
extern void execute_349(char*, char *);
extern void execute_69(char*, char *);
extern void execute_353(char*, char *);
extern void execute_354(char*, char *);
extern void execute_355(char*, char *);
extern void execute_356(char*, char *);
extern void execute_352(char*, char *);
extern void execute_483(char*, char *);
extern void execute_294(char*, char *);
extern void execute_295(char*, char *);
extern void execute_296(char*, char *);
extern void execute_542(char*, char *);
extern void execute_543(char*, char *);
extern void execute_544(char*, char *);
extern void execute_545(char*, char *);
extern void execute_546(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_54(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_59(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_193(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_198(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_258(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_263(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_268(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_273(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_278(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_283(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_288(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_293(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_372(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_377(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_382(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[75] = {(funcp)execute_2, (funcp)execute_292, (funcp)execute_297, (funcp)execute_538, (funcp)execute_539, (funcp)execute_540, (funcp)execute_541, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_298, (funcp)execute_299, (funcp)execute_7, (funcp)execute_8, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_14, (funcp)execute_15, (funcp)execute_16, (funcp)execute_302, (funcp)execute_303, (funcp)execute_304, (funcp)execute_305, (funcp)execute_22, (funcp)execute_310, (funcp)execute_24, (funcp)execute_311, (funcp)execute_312, (funcp)execute_313, (funcp)execute_42, (funcp)execute_43, (funcp)execute_47, (funcp)execute_48, (funcp)execute_59, (funcp)execute_340, (funcp)execute_341, (funcp)execute_342, (funcp)execute_343, (funcp)execute_344, (funcp)execute_345, (funcp)execute_346, (funcp)execute_347, (funcp)execute_339, (funcp)execute_66, (funcp)execute_350, (funcp)execute_351, (funcp)execute_349, (funcp)execute_69, (funcp)execute_353, (funcp)execute_354, (funcp)execute_355, (funcp)execute_356, (funcp)execute_352, (funcp)execute_483, (funcp)execute_294, (funcp)execute_295, (funcp)execute_296, (funcp)execute_542, (funcp)execute_543, (funcp)execute_544, (funcp)execute_545, (funcp)execute_546, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_54, (funcp)transaction_59, (funcp)transaction_193, (funcp)transaction_198, (funcp)transaction_258, (funcp)transaction_263, (funcp)transaction_268, (funcp)transaction_273, (funcp)transaction_278, (funcp)transaction_283, (funcp)transaction_288, (funcp)transaction_293, (funcp)transaction_372, (funcp)transaction_377, (funcp)transaction_382};
const int NumRelocateId= 75;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/usb_interface_tb_func_impl/xsim.reloc",  (void **)funcTab, 75);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/usb_interface_tb_func_impl/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/usb_interface_tb_func_impl/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/usb_interface_tb_func_impl/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/usb_interface_tb_func_impl/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/usb_interface_tb_func_impl/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
