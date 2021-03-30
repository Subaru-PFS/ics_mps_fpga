## Software prerequistes for development.

The only Xilinx package we need to compile, link, and upload new
images is the 2017.2 SDK, found at
https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_SDK_2017.2_0616_1_Lin64.bin,
and documented at
https://www.xilinx.com/html_docs/xilinx2017_2/SDK_Doc/index.html.

It is assumed that the installer puts things in
``/opt/Xilinx/SDK/2017.2``. If not, a couple of scripts will need to
be edited.

This document *only* addresses updating the HLS ("High-Level
Synthesis") C-code. It turns out that we do not need to change the
hardware design or generate any part of the ``.bit`` output
file. Among other things this means that we do not need to worry about
IP licenses. We only need to touch and compile C-code, and can do that
with make and gcc.

## Hardware prerequisites.

The Xilinx KC705 board has two external USB ports. The mini-USB port
is to the JTAG programmer, and the other is an output-only serial
console. Only the JTAG connection is required, and it needs to be
connected to the Linux PC.

### ``hw_server`` communication shim to the JTAG programmer.

Xilinx has a very nice hardware abstraction program, which lets you
connect to the JTAG locally (over the USB bus), or remotely (over
IP). I have had no problems loading and debugging over the Internet
with ~100ms ping time). I _believe_ that you only need to run
``/opt/XilinxSDK/2017.2/bin/hw_server`` to start that, but cannot
confirm that: I have only used a W10 host.

In any case, you need to get that running, and listening on port
3121. I will assume that you are either running the rest of this on
the same host, or that an ssh tunnel has been set up for port 3121.

## Install the ``pfs_ctrlr`` Communications Module image

Everything is in the https://github.com/Subaru-PFS/ics_mps_fpga.git
repo. Check that out and cd into it. Master is probably fine, but the
current tag is 3.1.0.

The ``pfs_ctrlr`` code, both for the the layout and for the HLS C, is
all in the ``pfs_ctrlr`` subdirectory, but all that is *required* to
install a new images are the two output files in the
``pfs_ctrlr/pfs_ctrlr.sdk`` subdirectory:

- The *hardware* image: ``/block_design_wrapper_hw_platform_0/download.bit``
- The library for the compiled C-code: ``pfs_ctrlr/Release/pfs_ctrlr.elf``

No part of the gui or Vivado is required to upload the image. There is
a wrapper shell script (``bin/upload_image``) which does what we need
to do. Under the covers this sets up a couple of environment variables
and calls xsct ("Xilinx Software Command-line Tool") with a
pre-written tcl script. Two environment variables can be set:

- HW_HOST (defaults to ``localhost``): the address where the ``hw_server`` is listening.
- ICS_MPS_FPGA_DIR (defaults to '.'): the root of the entire ics_mps_fpga tree.

If those are set or the default are ok, invoke `bin/upload_image` and
you should be rewarded with happy progress messages, after which the
system will be reset into the new image.

## Edit/recompile the C code

All the HLS ("High-Level Synthesis") C-code is in
``pfs_ctrlr/pfs_ctrlr.sdk/src``. By default, the output is in
``pfs_ctrlr/pfs_ctrlr.sdk/pfs_ctrlr/Release/``. If you want to develop
without a gui, you need to setup the Xilinx SDK environment, after
which you can simpy run `make all` inside the ``Release`` directory:

- source /opt/Xilinx/SDK/2017.2/settings64.sh
- edit in ``settings64.sh``
- make all

When happy, upload with the ``upload_image`` script.

The KC705 board has a _second_ USB port, which serves as an
output-only console running at 115200-8-N-1. That can be handy, but is
not necessary since we can use gdb.
