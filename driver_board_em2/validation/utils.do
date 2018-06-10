######################################################################
# \file
# \author Thomas A. Werne <thomas.a.werne@jpl.nasa.gov>
# \brief
#
# \copyright
# Copyright 2009-2014, by the California Institute of Technology.
# ALL RIGHTS RESERVED.  United States Government Sponsorship
# acknowledged. Any commercial use must be negotiated with the Office
# of Technology Transfer at the California Institute of Technology.
# \copyright
# This software may be subject to U.S. export control laws and
# regulations.  By accepting this document, the user agrees to comply
# with all U.S. export laws and regulations.  User has the
# responsibility to obtain export licenses, or other export authority
# as may be required before exporting such information to foreign
# countries or providing access to foreign persons.
######################################################################


# Default value for the top level module
set ::TOP /
set ::GRP ""
set ::VLOG_ARGS "+incdir+../../src"

proc analog {wave label} {
    add wave -noupdate -format analog-step -radix hex -expand -group $::GRP -height 100 -min 0 -max 65536 -label $label $::TOP/$wave
}

proc bin {wave label} {
    digital $wave $label bin
}

proc digital {wave label radix} {
    switch $radix {
        logic {set format Logic; set radix binary}
        hex {set format Literal; set radix hex}
        uint {set format Literal; set radix unsigned}
        int {set format Literal; set radix signed}
        bin {set format Literal; set radix binary}
    }

    # Absolute or relative?
    if { ! [string equal -length 1 "/" $wave]} {
        set wave $::TOP/$wave; list
    }

    add wave -noupdate -format $format -radix $radix -expand -group $::GRP -label $label $wave
}

proc div {} {
    add wave -noupdate -divider
}

proc do_compile {args} {
    onerror {break}
    vlib work

    foreach f $args {
        vlog -sv +acc=nprf +cover=f $::VLOG_ARGS $f
    }
}

proc hex {wave label} {
    digital $wave $label hex
}

proc int {wave label} {
    digital $wave $label int
}

proc logic {wave label} {
    digital $wave $label logic
}

proc set_context {new_top new_group} {
    set_top $new_top
    set_group $new_group
}

proc set_group {new_group} {
    set ::GRP $new_group; list
}

proc set_top {new_top} {
    set ::TOP $new_top; list
}

proc set_vlog_args {args} {
    set ::VLOG_ARGS $args; list
}

proc uint {wave label} {
    digital $wave $label uint
}

# vim: set syntax=tcl:
