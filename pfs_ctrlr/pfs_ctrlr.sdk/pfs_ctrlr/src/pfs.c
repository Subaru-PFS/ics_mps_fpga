#include "pfs_low_api.h"
#include "pfs_globals.h"

#include <stdint.h>
#include <xparameters.h>

static volatile uint32_t *baseaddr = (volatile uint32_t *) XPAR_PFS_DAUGHTERCARD_0_BASEADDR;

uint64_t cobra2mask(uint8_t board, uint8_t cobra, uint8_t small) {
    uint64_t rv;
    uint8_t is_side_b;
    
    // NOTE: Cobra, and board are 0-indexed
    // board 0 (the first board) is a side A and can use the LUT directly
    // board 1 and any other odd boards are side B and need to index LUT in reverse
    is_side_b = board & 0x01;

    const uint64_t cobra2mask_lut[MAX_COBRAS_PER_BOARD] = {
    	0x0000000000000001LL, 0x0000000000000002LL, 0x0000000000000010LL, 0x0000000000000020LL,
    	0x0000000000000100LL, 0x0000000000000200LL, 0x0000000000001000LL, 0x0000000000002000LL,
    	0x0000000000010000LL, 0x0000000000020000LL, 0x0000000000100000LL, 0x0000000000200000LL,
    	0x0000000001000000LL, 0x0000000002000000LL, 0x0000000010000000LL, 0x0000000020000000LL,
    	0x0000000100000000LL, 0x0000000200000000LL, 0x0000001000000000LL, 0x0000002000000000LL,
    	0x0000010000000000LL, 0x0000020000000000LL, 0x0000100000000000LL, 0x0000200000000000LL,
    	0x0001000000000000LL, 0x0002000000000000LL, 0x0010000000000000LL, 0x0020000000000000LL,
    	0x0100000000000000LL
    };

    if (cobra >= MAX_COBRAS_PER_BOARD) {
        return 0;
    }
    
    rv = (is_side_b) ? cobra2mask_lut[28 - cobra]:cobra2mask_lut[cobra];
    rv <<= (small) ? 2 : 0;

    return rv;
}

uint8_t cobra2motor(uint8_t board, uint8_t cobra, uint8_t small) {
	uint8_t motor;
    uint8_t is_side_b;
    
    // NOTE: Cobra, and board are 0-indexed
    is_side_b = board & 0x01;

    const uint8_t cobra2motor_lut[MAX_COBRAS_PER_BOARD] = {
    		0x00, 0x04, 0x10, 0x14,
    		0x20, 0x24, 0x30, 0x34,
    		0x01, 0x05, 0x11, 0x15,
    		0x21, 0x25, 0x31, 0x35,
    		0x02, 0x06, 0x12, 0x16,
    		0x22, 0x26, 0x32, 0x36,
    		0x03, 0x07, 0x13, 0x17,
    		0x23
    };

    if (cobra >= MAX_COBRAS_PER_BOARD) {
        return INVALID_MOTOR_NUM;
    }
    
    motor = (is_side_b) ? cobra2motor_lut[28 - cobra]:cobra2motor_lut[cobra];
    motor += small ? 0x08 : 0x0;

    return motor;
}

uint8_t motor2cobra(uint8_t board, uint8_t motor, uint8_t *cobra, uint8_t *small) {
    uint8_t is_side_b;
    
    // NOTE: Board, Motor are 0-indexed
    is_side_b = board & 0x01;

    const uint8_t motor2cobra_lut[] = {
    		0, 8, 16, 24, 1, 9, 17, 25,
    		0, 8, 16, 24, 1, 9, 17, 25,
    		2, 10, 18, 26, 3, 11, 19, 27,
    		2, 10, 18, 26, 3, 11, 19, 27,
    		4, 12, 20, 28, 5, 13, 21, IVCN,
    		4, 12, 20, 28, 5, 13, 21, IVCN,
    		6, 14, 22, IVCN, 7, 15, 23, IVCN,
    		6, 14, 22, IVCN, 7, 15, 23, IVCN
		};


    motor &= 0x3f;
    
    *cobra = motor2cobra_lut[motor];
    *small = (motor & 0x08) ? 1 : 0;
    
    if (*cobra >= MAX_COBRAS_PER_BOARD) {
        return 0;
    }
    
    *cobra = (is_side_b) ? (28 - *cobra):*cobra;
    
    return 1;
}

/******************************************************************************/

int emit(const motor_cmd *cmd) {
    volatile uint32_t *addr = baseaddr + 
            (PFS_SECTOR_OFFS * cmd->sector) + SECTOR_TX;
    uint32_t tx_reg;
    
    if ((cmd->sector >= NUM_SECTORS) | (cmd->board >= BOARDS_PER_SECTOR)) {
        DBG_PRINTF(0, "Can't emit to sector,board pair %d,%d", cmd->sector, cmd->board);
        return -1;
    }
    
    tx_reg = cmd->val;
    tx_reg |= (cmd->reg << 16);
    tx_reg |= (cmd->motor << 20);
    tx_reg |= (cmd->rnw << 26);
    tx_reg |= (cmd->board << 27);
    
    // skip emitting if sector tx fifo full
    if (sector_tx_full(cmd->sector)){
        DBG_PRINTF(0, "Error! Sector %d Tx Full", cmd->sector);
        return -1;
    }
    
    if (cmd->rnw) {
        DBG_PRINTF(1, "%d-%d rd (%d,%d)",
            cmd->sector, cmd->board, cmd->motor, cmd->reg);
    } else {
        DBG_PRINTF(1, "%d-%d wr (%d,%d) <- %d",
            cmd->sector, cmd->board, cmd->motor, cmd->reg, cmd->val);
    }
    
    *addr = tx_reg;
    return 0;
    
}


int capture(uint8_t sector, motor_cmd *cmd) {
    volatile uint32_t *addr = baseaddr + 
            (PFS_SECTOR_OFFS * sector) + SECTOR_RX;
    uint32_t rx_reg;
    
    // nothing to capture if sector rx fifo empty
    if (sector_rx_empty(sector)) {
        return -1;
    }
    
    rx_reg = *addr;
    
    cmd->sector = sector;
    cmd->val = rx_reg & 0x0000Ffff;
    cmd->reg = (rx_reg >> 16) & 0x0f;
    cmd->motor = (rx_reg >> 20) & 0x3f;
    cmd->rnw = (rx_reg >> 26) & 0x01;
    cmd->board = (rx_reg >> 27) & 0x1f;
    
    DBG_PRINTF(1, "@ %d-%d (%d,%d) -> %d",
            cmd->sector, cmd->board, cmd->motor, cmd->reg, cmd->val);

    return 0;  
}

void sector_power(uint8_t sector, uint8_t pwr_on) {
    volatile uint32_t *addr = baseaddr + 
            (PFS_SECTOR_OFFS * sector) + SECTOR_CONTROL;
    
    *addr = (pwr_on) ? 0:2;
}

void sector_rst(uint8_t sector) {
    volatile uint32_t *addr = baseaddr + 
            (PFS_SECTOR_OFFS * sector) + SECTOR_CONTROL;
    uint32_t ctrl_val;
    
    // need to capture the ctrl reg before flagging reset bit
    ctrl_val = *addr;
    // set the ctrl reg with same value but set reset bit
    *addr = ctrl_val | 0x01;
}

uint8_t sector_tx_full(uint8_t sector) {
	volatile uint32_t *addr = baseaddr + 
            (PFS_SECTOR_OFFS * sector) + SECTOR_STATUS;

    return (*addr & 0x02) >> 1;
}

uint8_t sector_rx_empty(uint8_t sector) {
    volatile uint32_t *addr = baseaddr + 
            (PFS_SECTOR_OFFS * sector) + SECTOR_STATUS;
    
    return (*addr & 0x04) >> 2;
}

uint32_t sector_rx_count(uint8_t sector) {
    volatile uint32_t *addr = baseaddr + 
            (PFS_SECTOR_OFFS * sector) + SECTOR_RX_CNT;            
    return *addr;
}

uint32_t sector_tx_count(uint8_t sector) {
    volatile uint32_t *addr = baseaddr + 
            (PFS_SECTOR_OFFS * sector) + SECTOR_TX_CNT;            
    return *addr;
}

void get_pfs_time(uint32_t *time) {
	volatile uint32_t *addr = baseaddr + PFS_TIMER_OFFS;
    
    *time = *addr;
}




