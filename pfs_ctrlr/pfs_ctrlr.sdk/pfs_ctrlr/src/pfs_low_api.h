#ifndef PFS_LOW_API_H
#define PFS_LOW_API_H

#include <stdint.h>

#define DRIVER_FREQ_KHZ         16000
#define MAX_COBRAS_PER_BOARD    29
#define NUM_SECTORS             6
#define BOARDS_PER_SECTOR       14

// inval cobra num
#define IVCN                    0x1f 
// inval motor num
#define INVALID_MOTOR_NUM       0x2f 

//offsets
#define PFS_TIMER_OFFS          48
#define PFS_SECTOR_OFFS         8

// register offset from a sector's baseaddr
#define SECTOR_CONTROL          0
#define SECTOR_STATUS           1
#define SECTOR_TX               2
#define SECTOR_RX               3
#define SECTOR_TX_CNT           4
#define SECTOR_RX_CNT           5
#define SECTOR_PARITY_FAILS     6
#define SECTOR_STOPBIT_FAILS    7


/// Motor command
typedef struct {
    uint32_t board;
	uint32_t sector; // Sector not actually sent, needed because board is not unique!
    uint32_t motor;
    uint32_t reg;
    uint32_t val;
    uint32_t rnw;
} motor_cmd;

/// Motor registers
typedef enum {
    PFS_PULSE_PERIOD = 0,
    PFS_PULSE_LEN = 1,
    PFS_NUM_STEPS = 2,
    PFS_PERIOD_MIN = 3,
    PFS_PERIOD_MAX = 4,
    PFS_PERIOD_STP = 5,
    PFS_RES_FREQ = 6,
    PFS_RES_ADC = 7,
    PFS_NUM_SLEEPS = 8
} pfs_motor_reg_t;

/// Control registers
typedef enum {
    PFS_CTRL_VERSION = 0,
    PFS_CTRL_SANDBOX = 1,
    PFS_CTRL_CONTROL = 2,
    PFS_CTRL_STATUS = 3,
    PFS_CTRL_MTR_ENA0 = 4,
    PFS_CTRL_MTR_ENA1 = 5,
    PFS_CTRL_MTR_ENA2 = 6,
    PFS_CTRL_MTR_ENA3 = 7,
    PFS_CTRL_MTR_DIR0 = 8,
    PFS_CTRL_MTR_DIR1 = 9,
    PFS_CTRL_MTR_DIR2 = 10,
    PFS_CTRL_MTR_DIR3 = 11,
    PFS_CTRL_STEP_LEN = 12,
    PFS_CTRL_CAL_SLEEP = 13
} pfs_ctrl_reg_t;

/// ADC Registers
typedef enum {
	PFS_ADC0_CTRL_REG = 0,
	PFS_ADC0_VAL_REG = 1,
	PFS_TEMP0_REG = 2,
	PFS_TEMP1_REG = 3,
	PFS_VOLTAGE_REG = 4
} pfs_adc_reg_t;

/// Control register bit definitions
typedef enum {
    PFS_CTRL_RUN_BIT = 0,
    PFS_CTRL_CAL_BIT = 1
} pfs_ctrl_bit_t;

/// The pseudo-motor that holds the control registers
enum {
	ADC_MOTOR = 0x3B,
    CONTROL_MOTOR = 0x3f
};


// tables/LUT's/masks
uint64_t cobra2mask(uint8_t board, uint8_t cobra, uint8_t small);
uint8_t cobra2motor(uint8_t board, uint8_t cobra, uint8_t small);
uint8_t motor2cobra(uint8_t board, uint8_t motor, uint8_t *cobra, uint8_t *small);

// Commands
int emit(const motor_cmd *cmd);
int capture(uint8_t sector, motor_cmd *cmd);
void sector_power(uint8_t sector, uint8_t pwr_on);
void sector_rst(uint8_t sector);
uint8_t sector_tx_full(uint8_t sector);
uint8_t sector_rx_empty(uint8_t sector);
uint32_t sector_rx_count(uint8_t sector);
uint32_t sector_tx_count(uint8_t sector);
void get_pfs_time(uint32_t *time);


#endif
