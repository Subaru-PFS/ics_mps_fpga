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

/*******************************************************************************
 * Includes
 ******************************************************************************/

#include "xparameters.h"
#include "netif/xadapter.h"

#include "pfs_eth.h"
#include "pfs_high_api.h"
#include "pfs_low_api.h"
#include "queue.h"
#include "pfs_globals.h"

#include "lwip/err.h"
#include "lwip/inet.h"
#include "lwip/tcp.h"

#include <stdint.h>
#include <xil_assert.h>

extern struct netif server_netif;

static err_t pfs_accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err);
static err_t pfs_recv_callback(void *arg, struct tcp_pcb *tpcb,
        struct pbuf *p, err_t err);
 
static int parse_hdr(QUEUE(uint8_t) *q, pfs_header *cmd_hdr, uint16_t *chksum);

static void cal(QUEUE(uint8_t) *q);
static int parse_cal_pld(QUEUE(uint8_t) *q, cal_cmd *cmd, uint16_t *chksum);

static void run(QUEUE(uint8_t) *q);
static int parse_run_pld(QUEUE(uint8_t) *q, run_cmd *cmd, uint16_t *chksum);

static void setf(QUEUE(uint8_t) *q);
static int parse_setf_pld(QUEUE(uint8_t) *q, setf_cmd *cmd, uint16_t *chksum);

static void diag(QUEUE(uint8_t) *q);
static void hk(QUEUE(uint8_t) *q);
static void power(QUEUE(uint8_t) *q);
static void admin(QUEUE(uint8_t) *q);


// The most recent open TCP connection
static struct tcp_pcb *tcp_connection;

static pfs_response_code code;

/******************************************************************************/

int pfs_start_application() {
	struct tcp_pcb *pcb;
	err_t err;
	unsigned port = 4001;

	/* create new TCP PCB structure */
	pcb = tcp_new();
	if (!pcb) {
		ushell_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}

	/* bind to specified @port */
	err = tcp_bind(pcb, IP_ADDR_ANY, port);
	if (err != ERR_OK) {
		ushell_printf("Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	/* we do not need any arguments to callback functions */
	tcp_arg(pcb, NULL);

	/* listen for connections */
	pcb = tcp_listen(pcb);
	if (!pcb) {
		ushell_printf("Out of memory while tcp_listen\n\r");
		return -3;
	}

	/* specify callback to use for incoming connections */
	tcp_accept(pcb, pfs_accept_callback);

	ushell_printf("TCP echo server started @ port %d\n\r", port);

	return 0;
}

/******************************************************************************/

void parse_tcp(QUEUE(uint8_t) *q) {
	uint8_t seek_byte;
	uint8_t n;
    n = q->deq(q, &seek_byte);

    if (n) {
        switch(seek_byte) {
          case CMD_RUN:
            DBG_PRINTF(2, "Found RUN opcode");
	    run(q);
            break;
          case CMD_CAL:
            DBG_PRINTF(2, "Found CAL opcode");
            cal(q);
            break;
          case CMD_SETF:
            DBG_PRINTF(2, "Found SETF opcode");
            setf(q);
            break;
          case CMD_HK:
            DBG_PRINTF(2, "Found HK opcode");
            hk(q);
            break;
          case CMD_POWER:
            DBG_PRINTF(2, "Found POWER opcode");
            power(q);
            break;
          case CMD_DIAG:
            DBG_PRINTF(2, "Found DIAG opcode");
            diag(q);
            break;
          case CMD_ADMIN:
            DBG_PRINTF(2, "Found ADMIN opcode");
            admin(q);
            break;
          default:
            DBG_PRINTF(0, "Found invalid opcode");
        }
    }
}

static int require_tcp_bytes(QUEUE(uint8_t) *q, unsigned int need_bytes) {
  // Read from the Ethernet packet queue until we have the required amount of data.
  //
  // - The Ethernet packet queue is _below_ the lwip layer, and is
  //   populated by the Xilinx interrupt handler.
  //
  // - In order for us to get the data, as processed by the lwip IP
  //   and TCP layers, we need to actively request that lwip check the
  //   ethernet queue for new packets, by calling
  //   `xemacif_input()`. This is ordinarily done by the main
  //   loop. Peek/push-back would be messy because of the command
  //   header parsing, so I'm electing to call for new data when when
  //   needed during parsing.
  //
  // - In order to handle real truncated input, we only try "a few
  //   times". I have NO idea how to chose that, but I want to avoid
  //   using _time_ whose properties I do not understand in this
  //   world. Thests show that we usually get data after 1-10 calls,
  //   so I'm setting the limit to 100.

  unsigned int have_bytes;
  unsigned int try_cnt = 100;

  do {
    have_bytes = q->navail(q);
    if (have_bytes >= need_bytes)
      return 0;

    DBG_PRINTF(2, "getting more TCP data. have=%d, need=%d",
               have_bytes, need_bytes);
    xemacif_input(&server_netif);
  } while (try_cnt-- > 0);

  DBG_PRINTF(0, "timed out before getting enough TCP data");
  return -1;
}

/******************************************************************************/

void send_hk_tlm(const pfs_header *hdr, pfs_response_code resp_code) {
	uint8_t hk_response_buf[HK_TLM_HEADER_BYTES + 8*MAX_COBRAS_PER_BOARD];
    uint8_t cobra;
    uint16_t offset;
    
    hk_done = 1;

    hk_response_buf[0] = hdr->opcode;
	hk_response_buf[1] = hdr->count;
	hk_response_buf[2] = resp_code >> 8;
    hk_response_buf[3] = resp_code & 0xFf;
    hk_response_buf[4] = 0;
    // return to 1-index'd board number
	hk_response_buf[5] = 0x7f & (hdr->ncmds + 1);

    hk_response_buf[6] = hk_data.temp1 >> 8 ;
    hk_response_buf[7] = hk_data.temp1 & 0xFf;
    hk_response_buf[8] = hk_data.temp2 >> 8 ;
    hk_response_buf[9] = hk_data.temp2 & 0xFf;
    hk_response_buf[10] = hk_data.voltage >> 8 ;
    hk_response_buf[11] = hk_data.voltage & 0xFF;

    // Fill the response buffer with the frequency responses
    offset = HK_TLM_HEADER_BYTES;
    for (cobra = 0; cobra < MAX_COBRAS_PER_BOARD; cobra++) {
        hk_response_buf[offset++] = hk_data.freqs[cobra][0] >> 8;
        hk_response_buf[offset++] = hk_data.freqs[cobra][0] >> 0;
        hk_response_buf[offset++] = hk_data.currents[cobra][0] >> 8;
        hk_response_buf[offset++] = hk_data.currents[cobra][0] >> 0;
        
        hk_response_buf[offset++] = hk_data.freqs[cobra][1] >> 8;
        hk_response_buf[offset++] = hk_data.freqs[cobra][1] >> 0;
        hk_response_buf[offset++] = hk_data.currents[cobra][1] >> 8;
        hk_response_buf[offset++] = hk_data.currents[cobra][1] >> 0;
    }

    if (0 != tcp_write(tcp_connection, hk_response_buf,
            sizeof(hk_response_buf), 1)) 
    {
        DBG_PRINTF(0, "Some problem writing TCP!");
    }
    tcp_output(tcp_connection);
	DBG_PRINTF(2, "Hk Tlm Sent!");

}


void send_tlm(const pfs_header *hdr, pfs_response_code resp_code, uint16_t detail) {
    uint8_t buf[6];

    buf[0] = hdr->opcode;
    buf[1] = hdr->count;
    buf[2] = 0xFf & (resp_code >> 8);
    buf[3] = 0xFf & (resp_code);
    buf[4] = 0xFf & (detail >> 8);
    buf[5] = 0xFf & (detail >> 0);

    if (0 != tcp_write(tcp_connection, buf, sizeof(buf), 1)) {
        DBG_PRINTF(0, "Some problem writing TCP!")
    }
    tcp_output(tcp_connection);
    DBG_PRINTF(2, "Standard Tlm Sent!");
}

/******************************************************************************/

static err_t pfs_accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err) {
	static int connection = 1;

    DBG_PRINTF(0, "Accepting connection");
    tcp_connection = newpcb;

	/* set the receive callback for this connection */
	tcp_recv(newpcb, pfs_recv_callback);

	/* just use an integer number indicating the connection id as the
	   callback argument */
	tcp_arg(newpcb, (void*)connection);

	/* increment for subsequent accepted connections */
	connection++;

	return ERR_OK;
}

static err_t pfs_recv_callback(void *arg, struct tcp_pcb *tpcb,
                               struct pbuf *p, err_t err) {

    /* do not read the packet if we are not in ESTABLISHED state */
	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
	    ushell_printf("\r\nTCP connection closed.\r\n");
		return ERR_OK;
	}

	/* indicate that the packet has been received */
	tcp_recved(tpcb, p->len);

    tcp_rx_q.enq_n(&tcp_rx_q, p->payload, p->len);
    //DBG_PRINTF(4, "TCP Enqueuing %d bytes", p->len);

	/* free the received pbuf */
	pbuf_free(p);

	return err;
}

/******************************************************************************/

static int parse_hdr(QUEUE(uint8_t) *q, pfs_header *cmd_hdr, uint16_t *chksum) {
    uint8_t tlm_hdr[7];

    // Try to get header
    require_tcp_bytes(q, sizeof(tlm_hdr));
    if ( q->deq_n(q, tlm_hdr, sizeof(tlm_hdr)) != sizeof(tlm_hdr) ) {
      code = PFS_EMPTY;
      DBG_PRINTF(0, "Error! Could not deque cmd hdr from TCP Queue.");
      return -1;
    }

    cmd_hdr->count = tlm_hdr[0];
    cmd_hdr->ncmds = (tlm_hdr[1] << 8) | tlm_hdr[2];
    cmd_hdr->timeout = (tlm_hdr[3] << 8) | tlm_hdr[4];
    cmd_hdr->checksum = (tlm_hdr[5] << 8) | tlm_hdr[6];

    // setup the checksum
    *chksum = cmd_hdr->opcode;
    *chksum += tlm_hdr[0];
    *chksum += tlm_hdr[1];
    *chksum += tlm_hdr[2];
    *chksum += tlm_hdr[3];
    *chksum += tlm_hdr[4];
    *chksum += cmd_hdr->checksum;

    return 0;
}

/******************************************************************************/

static void cal(QUEUE(uint8_t) *q) {
    static cal_cmd cmd = { .hdr = { .opcode = CMD_CAL}};
    uint16_t local_chksum;

    // We use the global "code" to decide whether to continue.
    // If that become bad before running the command, only return
    // _one_ TLM response, with the error code.

    code = PFS_NO_ERROR;

    parse_hdr(q, &cmd.hdr, &local_chksum);
    if (code != PFS_NO_ERROR) {
      send_tlm(&cmd.hdr, code, 0);
      return;
    }
    parse_cal_pld(q, &cmd, &local_chksum);
    if (code != PFS_NO_ERROR) {
      send_tlm(&cmd.hdr, code, 0);
      return;
    }

    code = (local_chksum != 0) ? PFS_CKSUM_INVAL:code;

    // First tlm
    send_tlm(&cmd.hdr, code, 0);

    if (code == PFS_NO_ERROR) {
      DBG_PRINTF(2, "Enqueing CAL command");
      cal_q.enq(&cal_q, &cmd);
    }
}

static int parse_cal_pld(QUEUE(uint8_t) *q, cal_cmd *cmd, uint16_t *chksum) {
    int i, j;
    uint8_t tcp_pld[10];
    cal_cmd_payload *cal_pld;
    uint16_t buf;

    //
    // parse payload from tcp one cobra at a time
    for (i = 0; i < cmd->hdr.ncmds; i++) {
        require_tcp_bytes(q, sizeof(tcp_pld));
        if (q->deq_n(q, tcp_pld, sizeof(tcp_pld)) != sizeof(tcp_pld)) {
            DBG_PRINTF(0, "Failed to dequeue Cal Payload %d!", i);
            code = PFS_EMPTY;
            return -1;
        }

        // update chksum
        for (j = 0; j < sizeof(tcp_pld); j++) {
            *chksum += tcp_pld[j];
        }

        if (i < PFS_MAX_CMDS) {
            cal_pld = &cmd->pld[i];

            buf = (tcp_pld[0] << 8) | tcp_pld[1];
            cal_pld->cobra = (buf>>11) - 1;
            cal_pld->board = (0x7F & (buf>>4)) - 1;
            cal_pld->mtr2_run = 0x01 & (buf>>3);
            cal_pld->mtr1_run = 0x01 & (buf>>2);
            cal_pld->mtr2_dir = 0x01 & (buf>>1);
            cal_pld->mtr1_dir = 0x01 & (buf>>0);
            cal_pld->mtr1_start = (tcp_pld[2]<<8) | tcp_pld[3];
            cal_pld->mtr1_end = (tcp_pld[4]<<8) | tcp_pld[5];
            cal_pld->mtr2_start = (tcp_pld[6]<<8) | tcp_pld[7];
            cal_pld->mtr2_end = (tcp_pld[8]<<8) | tcp_pld[9];

            if (cal_pld->cobra >= MAX_COBRAS_PER_BOARD) {code = PFS_CBR_INVAL;}
            // the board is still 0-83, not converted to sector/board
            if (cal_pld->board >= 84) { code = PFS_BRD_INVAL; }
            if (cal_pld->mtr1_start == 0) { code = PFS_FRQ_INVAL; }
            if (cal_pld->mtr1_end == 0) { code = PFS_FRQ_INVAL; }
            if (cal_pld->mtr2_start == 0) { code = PFS_FRQ_INVAL; }
            if (cal_pld->mtr2_end == 0) { code = PFS_FRQ_INVAL; }
        } else {
            code = PFS_TOO_MANY_CMDS;
        }
    }

    return 0;
}

/******************************************************************************/

static void run(QUEUE(uint8_t) *q) {
    static run_cmd cmd = { .hdr = { .opcode = CMD_RUN}};
    uint16_t local_chksum;
    uint8_t tlm_hdr[9];

    code = PFS_NO_ERROR;

    // Try to get header
    require_tcp_bytes(q, sizeof(tlm_hdr));
    if ( q->deq_n(q, tlm_hdr, sizeof(tlm_hdr)) != sizeof(tlm_hdr) ) {
      DBG_PRINTF(0, "Error! Could not deque cmd hdr from TCP Queue.");
      code = PFS_EMPTY;
      send_tlm(&cmd.hdr, code, 0);
      return;
    }

    cmd.hdr.count = tlm_hdr[0];
    cmd.hdr.ncmds = (tlm_hdr[1] << 8) | tlm_hdr[2];
    cmd.hdr.timeout = (tlm_hdr[3] << 8) | tlm_hdr[4];
    cmd.step_len = (tlm_hdr[5] << 8) | tlm_hdr[6];
    cmd.hdr.checksum = (tlm_hdr[7] << 8) | tlm_hdr[8];

    // setup the checksum
    local_chksum = cmd.hdr.opcode;
    local_chksum += tlm_hdr[0];
    local_chksum += tlm_hdr[1];
    local_chksum += tlm_hdr[2];
    local_chksum += tlm_hdr[3];
    local_chksum += tlm_hdr[4];
    local_chksum += tlm_hdr[5];
    local_chksum += tlm_hdr[6];
    local_chksum += cmd.hdr.checksum;

    parse_run_pld(q, &cmd, &local_chksum);
    if (code != PFS_NO_ERROR) {
      send_tlm(&cmd.hdr, code, 0);
      return;
    }

    code = (local_chksum != 0) ? PFS_CKSUM_INVAL:code;

    // First tlm
    send_tlm(&cmd.hdr, code, 0);

    if (code == PFS_NO_ERROR) {
      DBG_PRINTF(2, "Enqueing RUN command");
      run_q.enq(&run_q, &cmd);
    }
}

static int parse_run_pld(QUEUE(uint8_t) *q, run_cmd *cmd, uint16_t *chksum) {
    int i, j;
    uint8_t tcp_pld[14];
    run_cmd_payload *run_pld;
    uint16_t buf;

    // parse payload from tcp one cobra at a time
    for (i = 0; i < cmd->hdr.ncmds; i++) {
        require_tcp_bytes(q, sizeof(tcp_pld));
        if (q->deq_n(q, tcp_pld, sizeof(tcp_pld)) != sizeof(tcp_pld)) {
            DBG_PRINTF(0, "Failed to dequeue Run Payload %d!", i);
            code = PFS_EMPTY;
            return -1;
        }

        // update chksum
        for (j = 0; j < sizeof(tcp_pld); j++) {
            *chksum += tcp_pld[j];
        }

        if (i < PFS_MAX_CMDS) {
            run_pld = &cmd->pld[i];

            buf = (tcp_pld[0] << 8) | tcp_pld[1];
            run_pld->cobra = (buf>>11) - 1;
            run_pld->board = (0x7F & (buf>>4)) - 1;
            run_pld->mtr2_run = 0x01 & (buf>>3);
            run_pld->mtr1_run = 0x01 & (buf>>2);
            run_pld->mtr2_dir = 0x01 & (buf>>1);
            run_pld->mtr1_dir = 0x01 & (buf>>0);
            run_pld->mtr1_pulse_len = (tcp_pld[2]<<8) | tcp_pld[3];
            run_pld->mtr1_steps = (tcp_pld[4]<<8) | tcp_pld[5];
            run_pld->mtr1_sleeps = (tcp_pld[6]<<8) | tcp_pld[7];
            run_pld->mtr2_pulse_len = (tcp_pld[8]<<8) | tcp_pld[9];
            run_pld->mtr2_steps = (tcp_pld[10]<<8) | tcp_pld[11];
            run_pld->mtr2_sleeps = (tcp_pld[12]<<8) | tcp_pld[13];

            if (run_pld->cobra >= MAX_COBRAS_PER_BOARD) {code = PFS_CBR_INVAL;}
            // the board is still 0-83, not converted to sector/board
            if (run_pld->board >= 84) {code = PFS_BRD_INVAL;}

        } else {
            code = PFS_TOO_MANY_CMDS;
        }
    }

    return 0;
}

/******************************************************************************/

static void setf(QUEUE(uint8_t) *q) {
    static setf_cmd cmd = { .hdr = { .opcode = CMD_SETF}};
    uint16_t local_chksum;

    code = PFS_NO_ERROR;

    parse_hdr(q, &cmd.hdr, &local_chksum);
    if (code != PFS_NO_ERROR) {
      send_tlm(&cmd.hdr, code, 0);
      return;
    }

    parse_setf_pld(q, &cmd, &local_chksum);
    if (code != PFS_NO_ERROR) {
      send_tlm(&cmd.hdr, code, 0);
      return;
    }

    code = (local_chksum != 0) ? PFS_CKSUM_INVAL:code;

    // First tlm
    send_tlm(&cmd.hdr, code, 0);

    if (code == PFS_NO_ERROR) {
      DBG_PRINTF(2, "Enqueing SETF command");
      setf_q.enq(&setf_q, &cmd);
    }
}

static int parse_setf_pld(QUEUE(uint8_t) *q, setf_cmd *cmd, uint16_t *chksum) {
    int i, j;
    uint8_t tcp_pld[6];
    setf_cmd_payload *setf_pld;
    uint16_t buf;

    // parse payload from tcp one cobra at a time
    for (i = 0; i < cmd->hdr.ncmds; i++) {
        require_tcp_bytes(q, sizeof(tcp_pld));
        if (q->deq_n(q, tcp_pld, sizeof(tcp_pld)) != sizeof(tcp_pld)) {
            DBG_PRINTF(0, "Failed to dequeue Setf Payload %d!", i);
            code = PFS_EMPTY;
            return -1;
        }

        // update chksum
        for (j = 0; j < sizeof(tcp_pld); j++) {
            *chksum += tcp_pld[j];
        }

        if (i < PFS_MAX_CMDS) {
            setf_pld = &cmd->pld[i];

            buf = (tcp_pld[0] << 8) | tcp_pld[1];
            setf_pld->cobra = (buf>>11) - 1;
            setf_pld->board = (0x7F & (buf>>4)) - 1;
            setf_pld->reserved = 0x03 & (buf>>2);
            setf_pld->mtr2_en = 0x01 & (buf>>1);
            setf_pld->mtr1_en = 0x01 & (buf>>0);
            setf_pld->mtr1_freq = (tcp_pld[2]<<8) | tcp_pld[3];
            setf_pld->mtr2_freq = (tcp_pld[4]<<8) | tcp_pld[5];

            if (setf_pld->cobra >= MAX_COBRAS_PER_BOARD) {code = PFS_CBR_INVAL;}
            // the board is still 0-83, not converted to sector/board
            if (setf_pld->board >= 84) {code = PFS_BRD_INVAL;}
            if (setf_pld->mtr1_freq == 0) {code = PFS_FRQ_INVAL;}
            if (setf_pld->mtr2_freq == 0) {code = PFS_FRQ_INVAL;}

        } else {
            code = PFS_TOO_MANY_CMDS;
        }
    }
    return 0;
}

/******************************************************************************/

static void diag(QUEUE(uint8_t) *q) {
    uint8_t buf[5];
    uint8_t response[12];
    uint16_t local_chksum;
    int sect;

    require_tcp_bytes(q, sizeof(buf));
    if ( q->deq_n(q, buf, sizeof(buf)) != sizeof(buf) ) {
      static hk_cmd cmd = { .hdr = { .opcode = CMD_DIAG}};
      DBG_PRINTF(0, "Failed to dequeue Diag header!");
      send_tlm(&cmd.hdr, PFS_EMPTY, 0);
      return;
    }

    local_chksum = CMD_DIAG;
    local_chksum += buf[0];
    local_chksum += buf[1];
    local_chksum += buf[2];
    local_chksum += (buf[3] << 8) | buf[4];

    response[0] = CMD_DIAG; // opcode
    response[1] = buf[0]; // count
    response[2] = (uint8_t) sectors[0].board_count;
    response[3] = (uint8_t) sectors[1].board_count;
    response[4] = (uint8_t) sectors[2].board_count;
    response[5] = (uint8_t) sectors[3].board_count;
    response[6] = (uint8_t) sectors[4].board_count;
    response[7] = (uint8_t) sectors[5].board_count;
    response[8] = 0;
    response[9] = (local_chksum == 0) ? PFS_NO_ERROR : PFS_CKSUM_INVAL;
    response[10] = 0;
    response[11] = 0;
    
    for (sect=0; sect < NUM_SECTORS; sect++) {
      DBG_PRINTF(2, "Sect%d num Tx,Rx %d,%d",
		 sect, sector_tx_count(sect), sector_rx_count(sect));
    }
	
    DBG_PRINTF(2, "Diagnostic command");

    if (0 != tcp_write(tcp_connection, response, sizeof(response), 1)) {
      DBG_PRINTF(0, "Some problem writing TCP!");
    }
    tcp_output(tcp_connection);
}


static void hk(QUEUE(uint8_t) *q) {
    static hk_cmd cmd = { .hdr = { .opcode = CMD_HK}};
    uint16_t local_chksum;
    
    code = PFS_NO_ERROR;
    
    parse_hdr(q, &cmd.hdr, &local_chksum);
    if (code != PFS_NO_ERROR) {
    	send_tlm(&cmd.hdr, code, 0);
    	return;
    }

    code = (local_chksum != 0) ? PFS_CKSUM_INVAL:code;
    
    // ncmd's is really board #, need to -1 to make 0-indexed
    cmd.hdr.ncmds -= 1;
    
    // First tlm
    send_tlm(&cmd.hdr, code, 0);
    if (code == PFS_NO_ERROR) {
      DBG_PRINTF(2, "Enqueing Hk command");
      hk_q.enq(&hk_q, &cmd);
    }
}

static void power(QUEUE(uint8_t) *q) {
    static pfs_header hdr = { .opcode = CMD_POWER };
    uint8_t buf[7];
    uint16_t local_chksum;
    uint8_t sector_powers, sector_resets;
    int sect;

    require_tcp_bytes(q, sizeof(buf));
    if ( q->deq_n(q, buf, sizeof(buf)) != sizeof(buf) ) {
      DBG_PRINTF(0, "Failed to dequeue Power header!");
      send_tlm(&hdr, PFS_EMPTY, 0);
      return;
    }

    hdr.count = buf[0];
    sector_powers = buf[1];
    sector_resets = buf[2];
    hdr.checksum = (uint16_t) ((buf[5] << 8) | buf[6]);
    
    local_chksum = CMD_POWER;
    local_chksum += buf[0];
    local_chksum += buf[1];
    local_chksum += buf[2];
    local_chksum += buf[3];
    local_chksum += buf[4];
    local_chksum += hdr.checksum;
    
    code = (local_chksum != 0) ? PFS_CKSUM_INVAL:PFS_NO_ERROR;
    
    send_tlm(&hdr, code, 0);
    
    if (code != PFS_NO_ERROR) {
        DBG_PRINTF(0, "Error! Pwr Cmd bad! code %d.", code);
        return;
    }
    
    DBG_PRINTF(2, "Pwr cmd");
    
    for (sect=0; sect < NUM_SECTORS; sect++) {
        if ((sector_resets >> sect) & 0x01) { sector_rst(sect); }
        sector_power(sect, (sector_powers >> sect) & 0x01);
    }
    
    for (sect=0; sect < NUM_SECTORS; sect++) {
        ping(&sectors[sect]);
    }
}

static void admin(QUEUE(uint8_t) *q) {
    static admin_cmd cmd = { .hdr = { .opcode = CMD_ADMIN}};
    uint16_t local_chksum;
    uint8_t buf[7];
    uint8_t response[12];
    uint32_t t_now;
    
    code = PFS_NO_ERROR;

    require_tcp_bytes(q, sizeof(buf));
    if (q->deq_n(q, buf, sizeof(buf)) != sizeof(buf)) {
      DBG_PRINTF(0, "Failed to dequeue Admin header!");
      send_tlm(&cmd.hdr, PFS_EMPTY, 0);
      return;
    }

    cmd.hdr.count = buf[0];
    debug_level = (unsigned int)buf[1];
    cmd.hdr.checksum = (uint16_t) ((buf[5] << 8) | buf[6]);

    local_chksum = CMD_ADMIN;
    local_chksum += buf[0];
    local_chksum += buf[1];
    local_chksum += buf[2];
    local_chksum += buf[3];
    local_chksum += buf[4];
    local_chksum += cmd.hdr.checksum;

    code = (local_chksum != 0) ? PFS_CKSUM_INVAL:code;

    get_pfs_time(&t_now);

    response[0] = CMD_ADMIN; // opcode
    response[1] = buf[0]; // count
    response[2] = MAJOR_VERSION;
    response[3] = MINOR_VERSION;
    response[4] = (uint8_t)((t_now & 0xff000000) >> 24);
    response[5] = (uint8_t)((t_now & 0x00ff0000) >> 16);
    response[6] = (uint8_t)((t_now & 0x0000ff00) >> 8);
    response[7] = (uint8_t) (t_now & 0x000000ff);
    response[8] = 0;
    response[9] = PFS_NO_ERROR;
    response[10] = 0;
    response[11] = 0;
    
    if (0 != tcp_write(tcp_connection, response, sizeof(response), 1)) {
    	DBG_PRINTF(0, "Some problem writing TCP!");
    }
    tcp_output(tcp_connection);
}

