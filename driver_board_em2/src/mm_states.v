/*********************************************************************
 * \file
 * \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
 * \brief
 *
 * \copyright
 * Copyright 2009-2015, by the California Institute of Technology.
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

package MM_STATES;

// Motor multiplexer FSM states
typedef enum {
    RESET,          //% State after reset
    IDLE,           //% Idle, ready to start
    START_MUX,      //% Starting the motor multiplexer
    GET_SETUP_REGS,
    GET_MOTOR_REGS,
    FINISH_SETUP,
    START_MOTOR,    //% Starting a row of motors
    DRIVE,          //% Driving a row of motors
	UPDATE_COUNTS,
    WAIT_FOR_THROTTLE,
    CHECK_IF_FINISHED,
    FINALIZE
} mm_state_t;

endpackage: MM_STATES

/* vim: set syntax=systemverilog: */
