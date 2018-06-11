# ics_mps_fpga
The FPGA code for the cobras

There are two parts to this: 

 - the C + FPGA code for the Kintex controller board. I believe it is something like the https://www.xilinx.com/products/boards-and-kits/ek-k7-kc705-g.html#hardware . These have embeddable CPUs, hence the C code for the protocol parsing. Nice and simple. This is in `pfs_ctrlr`

 - the FPGA code for the motor boards. This is in `driver_board_em2`. Also nice and simple.
