#ifndef PFS_HIGH_API_H
#define PFS_HIGH_API_H

#include <stdint.h>

#include "pfs_low_api.h"

#define CODE_DATE "2020-03-15"
#define MAJOR_VERSION 2
#define MINOR_VERSION 0

#define NUM_PFS_MODULES 42
#define COBRAS_PER_MODULE 57
 
/// Maximum number of cobra commands (from ethernet)
#define PFS_MAX_CMDS  (NUM_PFS_MODULES * COBRAS_PER_MODULE)

/// Calibration run time (usec)
#define CAL_TIME_US 280// EM1: 2500us

/// Calibration interval time (usec)
#define CAL_INTERLEAVE_TIME_US 168 // 9/15ths of CAL_TIME_US gives 10% On-time for a motor during cal

typedef enum {
    READY       = 0,
    WD_GOING    = 1,
    PINGING     = 2
} sector_state_t;

typedef struct {
    sector_state_t state;
    uint32_t boards_busy;
    uint32_t board_count;
    uint32_t t_ping_end;
    uint32_t t_wd_end;
    uint32_t t_next_query;
    uint32_t num;
} sector_t;

enum {
    CMD_RUN   = 0x01,
    CMD_CAL   = 0x02,
    CMD_SETF  = 0x03,
    CMD_HK    = 0x04,
    CMD_POWER = 0x05,
    CMD_DIAG  = 0x06,
    CMD_ADMIN = 0x07
};

typedef enum {
    PFS_NO_ERROR = 0,
    PFS_TIMEOUT = 1,
    PFS_BAD_EXEC = 2,
    PFS_CKSUM_INVAL = 3,
    PFS_CBR_INVAL = 4,
    PFS_BRD_INVAL = 5,
    PFS_FRQ_INVAL = 6,
    PFS_RUN_TIME_INVAL = 7,
    PFS_INTERLEAVE_TIME_INVAL = 8,
    PFS_TOO_MANY_CMDS = 9,
    PFS_EMPTY = 10
} pfs_response_code;

/// Standard command header
typedef struct {
    uint8_t opcode;
    uint8_t count;
    uint16_t ncmds;
    uint16_t timeout;
    uint16_t checksum;
} pfs_header;

/// Hk response data of 2nd tlm
typedef struct {
	uint16_t temp1;
	uint16_t temp2;
	uint16_t voltage;
	uint16_t freqs[MAX_COBRAS_PER_BOARD][2];
	uint16_t currents[MAX_COBRAS_PER_BOARD][2];
} hk_resp_info;

// Command payload definitions

/// Run command payload
typedef struct {
    uint8_t cobra;
    uint8_t board;
    uint8_t mtr2_run;
    uint8_t mtr1_run;
    uint8_t mtr2_dir;
    uint8_t mtr1_dir;
    uint16_t mtr1_pulse_len;
    uint16_t mtr1_steps;
    uint16_t mtr1_sleeps;
    uint16_t mtr2_pulse_len;
    uint16_t mtr2_steps;
    uint16_t mtr2_sleeps;
} run_cmd_payload;

/// Calibrate command payload
typedef struct {
    uint8_t cobra;
    uint8_t board;
    uint8_t mtr2_run;
    uint8_t mtr1_run;
    uint8_t mtr2_dir;
    uint8_t mtr1_dir;
    uint16_t mtr1_start;
    uint16_t mtr1_end;
    uint16_t mtr2_start;
    uint16_t mtr2_end;
} cal_cmd_payload;

/// Set frequency command payload
typedef struct {
    uint8_t cobra;
    uint8_t board;
    uint8_t reserved;
    uint8_t mtr2_en;
    uint8_t mtr1_en;
    uint16_t mtr1_freq;
    uint16_t mtr2_freq;
} setf_cmd_payload;

// Command packet definitions

/// Run command
typedef struct {
    pfs_header hdr;
    uint16_t step_len;
    run_cmd_payload pld[PFS_MAX_CMDS];
} run_cmd;

/// Calibrate command
typedef struct {
    pfs_header hdr;
    cal_cmd_payload pld[PFS_MAX_CMDS];
} cal_cmd;

/// Set frequency command
typedef struct {
    pfs_header hdr;
    setf_cmd_payload pld[PFS_MAX_CMDS];
} setf_cmd;

/// Request housekeeping
typedef struct {
    pfs_header hdr;
} hk_cmd;

/// Admin command: get status, adjust logging.
typedef struct {
    pfs_header hdr;
    uint8_t debug_level;
    uint8_t pad;
} admin_cmd;


#endif
