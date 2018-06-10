/**
 * \file
 * \author Joshua Schoolcraft <jschoolc@jpl.nasa.gov>
 * \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
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

#ifndef PFS_TRANSLATE_H_
#define PFS_TRANSLATE_H_

#include "queue.h"
#include "pfs_high_api.h"
#include "pfs_low_api.h"
#include "pfs_globals.h"

int requeue_cal(QUEUE(motor_cmd) *q, const cal_cmd *cmd);
int requeue_run(QUEUE(motor_cmd) *q, const run_cmd *cmd);
int requeue_setf(QUEUE(motor_cmd) *q, const setf_cmd *cmd);
int requeue_hk(QUEUE(motor_cmd) *q, const hk_cmd *cmd);

void hk_response_cb(const motor_cmd *cmd);

#endif /* PFS_TRANSLATE_H_ */
