#ifndef PFS_GLOBALS_H_
#define PFS_GLOBALS_H_

#include "xil_printf.h"

#include "pfs_low_api.h"
#include "pfs_high_api.h"
#include "queue.h"
//#include "ushell_stdio.h"

//#include <ushell.h>

/*
#define DBG_PRINTF(lvl, fmt, ...)                       \
    if ((lvl == 0) || (debug_level & lvl)) {            \
        ushell_printf("\r\n<%d> %s:%d " fmt "\r\n",     \
                lvl, __FILE__, __LINE__, ##__VA_ARGS__);\
    }
*/

#define DBG_PRINTF(lvl, fmt, ...)                       \
    if ((lvl == 0) || (debug_level & lvl)) {            \
        ushell_printf(fmt "\r\n",     \
                ##__VA_ARGS__);\
    }

#define ushell_printf(fmt, ...) \
	xil_printf(fmt, ##__VA_ARGS__);


// def'd in pfs_eth.c
int pfs_start_application();

// def'd in pfs_queues.c
void alloc_queues();
DECL_QUEUE(uint8_t);
DECL_QUEUE(run_cmd);
DECL_QUEUE(cal_cmd);
DECL_QUEUE(setf_cmd);
DECL_QUEUE(hk_cmd);
DECL_QUEUE(motor_cmd);
extern QUEUE(uint8_t) tcp_rx_q;
extern QUEUE(run_cmd) run_q;
extern QUEUE(cal_cmd) cal_q;
extern QUEUE(setf_cmd) setf_q;
extern QUEUE(hk_cmd) hk_q;
extern QUEUE(motor_cmd) motor_cmd_q;

// def'd in project.c
void ping(sector_t *sector);
extern sector_t sectors[NUM_SECTORS];
extern unsigned int debug_level;

// def'd in pfs_translate.c
extern hk_resp_info hk_data;
extern uint8_t hk_done;


#endif /* PFS_GLOBALS_H_ */
