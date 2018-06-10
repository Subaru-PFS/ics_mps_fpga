/**
 * \file
 * \author Joshua Schoolcraft <jschoolc@jpl.nasa.gov>
 * \author Thomas Werne <thomas.a.werne@jpl.nasa.gov>
 * \brief
 *
 * \copyright
 * Copyright 2009-2014, by the California Institute of Technology.
 * ALL RIGHTS RESERVED.  United States Government Sponsorship
 * acknowledged. Any commercial use must be negotiated with the Office
 * of Technology Transfer at the California Institute of Technology.
 * \copyright
 * This software may be subject to U.S. export control laws and
 * regulations.  By accepting this document, the user agrees to comply
 * with all U.S. export laws and regulations.  User has the
 * responsibility to obtain export licenses, or other export authority
 * as may be required before exporting such information to foreign
 * countries or providing access to foreign persons.
 ********************************************************************/

/*******************************************************************************
 * Includes
 ******************************************************************************/

#include "pfs_globals.h"
#include "queue.h"

/*******************************************************************************
 * Generated code
 ******************************************************************************/

// Queue definitions
DEFN_QUEUE(uint8_t);
DEFN_QUEUE(run_cmd);
DEFN_QUEUE(cal_cmd);
DEFN_QUEUE(setf_cmd);
DEFN_QUEUE(hk_cmd);
DEFN_QUEUE(motor_cmd);

// Creating queues in pfs_globals.h
CREATE_QUEUE(uint8_t, tcp_rx_q);
CREATE_QUEUE(run_cmd, run_q);
CREATE_QUEUE(cal_cmd, cal_q);
CREATE_QUEUE(setf_cmd, setf_q);
CREATE_QUEUE(hk_cmd, hk_q);
CREATE_QUEUE(motor_cmd, motor_cmd_q);


/*******************************************************************************
 * API function definitions
 ******************************************************************************/

void alloc_queues() {

    // Allocate storage for the TCP Rx data queue
    if (0 != tcp_rx_q.alloc(&tcp_rx_q, 512*1024)) {
        DBG_PRINTF(0, "Could not alloc TCP RX Q");
    }

    // Allocate storage for TCP command queues
    if (0 != run_q.alloc(&run_q, 3)) {
        DBG_PRINTF(0, "Could not alloc RUN Q");
    }
    if (0 != cal_q.alloc(&cal_q, 3)) {
        DBG_PRINTF(0, "Could not alloc CAL Q");
    }
    if (0 != setf_q.alloc(&setf_q, 3)) {
        DBG_PRINTF(0, "Could not alloc SETF Q");
    }
    if (0 != hk_q.alloc(&hk_q, 3)) {
        DBG_PRINTF(0, "Could not alloc HK Q");
    }

    // Allocate storage for motor command queues
	if (0 != motor_cmd_q.alloc(&motor_cmd_q, 50000)) {
        DBG_PRINTF(0, "Could not alloc MOTOR CMD Q");
    }

}
