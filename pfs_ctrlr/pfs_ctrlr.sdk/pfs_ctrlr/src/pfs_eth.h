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


#ifndef PFS_ETH_H_
#define PFS_ETH_H_


#include "pfs_high_api.h"
#include "pfs_globals.h"
#include "queue.h"

#define HK_TLM_HEADER_BYTES 12 // opcode, count, resp_code, board num, temp1, temp2, voltage


void parse_tcp(QUEUE(uint8_t) *q);

void send_hk_tlm(const pfs_header *hdr, pfs_response_code code);
void send_tlm(const pfs_header *hdr, pfs_response_code code, uint16_t detail);

#endif /* PFS_ETH_H_ */
