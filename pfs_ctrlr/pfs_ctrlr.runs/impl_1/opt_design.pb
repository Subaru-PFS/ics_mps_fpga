
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2#
xc7k325t-ffg9002default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2#
xc7k325t-ffg9002default:defaultZ17-349h px� 
�
�The version limit for your license is '%s' and will expire in %s days. A version limit expiration means that, although you may be able to continue to use the current version of tools or IP with this license, you will not be eligible for any updates or new releases.
519*common2
2017.082default:default2
-72default:defaultZ17-1223h px� 
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px� 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px� 
t
Command: %s
53*	vivadotcl2C
/report_drc (run_mandatory_drcs) for: opt_checks2default:defaultZ4-113h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
q
%s completed successfully
29*	vivadotcl23
report_drc (run_mandatory_drcs)2default:defaultZ4-42h px� 
U
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461h px� 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:03 ; elapsed = 00:00:00.99 . Memory (MB): peak = 2709.594 ; gain = 64.020 ; free physical = 582 ; free virtual = 93992default:defaulth px� 
�
$%s: '%s' is not a valid startpoint.
402*constraints2"
set_false_path2default:default2O
9block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/Q2default:default2_
I/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/constrs_1/new/timing.xdc2default:default2
52default:default8@Z18-402h px� 
�
$%s: '%s' is not a valid startpoint.
402*constraints2"
set_false_path2default:default2P
:block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/CE2default:default2_
I/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/constrs_1/new/timing.xdc2default:default2
52default:default8@Z18-402h px� 
�
$%s: '%s' is not a valid startpoint.
402*constraints2"
set_false_path2default:default2O
9block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/D2default:default2_
I/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/constrs_1/new/timing.xdc2default:default2
52default:default8@Z18-402h px� 
�
$%s: '%s' is not a valid startpoint.
402*constraints2"
set_false_path2default:default2O
9block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/R2default:default2_
I/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/constrs_1/new/timing.xdc2default:default2
52default:default8@Z18-402h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px� 
i

Phase %s%s
101*constraints2
1 2default:default2
Retarget2default:defaultZ18-101h px� 
x
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
122default:default2
5382default:defaultZ31-138h px� 
K
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49h px� 
<
'Phase 1 Retarget | Checksum: 1dfd3e11d
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:04 . Memory (MB): peak = 2709.594 ; gain = 0.000 ; free physical = 531 ; free virtual = 93502default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2
Retarget2default:default2
12default:default2
14352default:defaultZ31-389h px� 
u

Phase %s%s
101*constraints2
2 2default:default2(
Constant propagation2default:defaultZ18-101h px� 
w
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
112default:default2
112default:defaultZ31-138h px� 
H
3Phase 2 Constant propagation | Checksum: 1cf3fc8b4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:12 ; elapsed = 00:00:08 . Memory (MB): peak = 2709.594 ; gain = 0.000 ; free physical = 537 ; free virtual = 93572default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2(
Constant propagation2default:default2
6542default:default2
24692default:defaultZ31-389h px� 
f

Phase %s%s
101*constraints2
3 2default:default2
Sweep2default:defaultZ18-101h px� 
9
$Phase 3 Sweep | Checksum: 1b00d94a5
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:14 ; elapsed = 00:00:11 . Memory (MB): peak = 2709.594 ; gain = 0.000 ; free physical = 547 ; free virtual = 93662default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2
Sweep2default:default2
112default:default2
24432default:defaultZ31-389h px� 
r

Phase %s%s
101*constraints2
4 2default:default2%
BUFG optimization2default:defaultZ18-101h px� 
E
0Phase 4 BUFG optimization | Checksum: 1b00d94a5
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:16 ; elapsed = 00:00:12 . Memory (MB): peak = 2709.594 ; gain = 0.000 ; free physical = 549 ; free virtual = 93682default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2%
BUFG optimization2default:default2
02default:default2
02default:defaultZ31-389h px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px� 
O
:Phase 5 Shift Register Optimization | Checksum: 1b00d94a5
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:16 ; elapsed = 00:00:13 . Memory (MB): peak = 2709.594 ; gain = 0.000 ; free physical = 549 ; free virtual = 93682default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2/
Shift Register Optimization2default:default2
02default:default2
02default:defaultZ31-389h px� 
a

Starting %s Task
103*constraints2&
Connectivity Check2default:defaultZ18-103h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.20 ; elapsed = 00:00:00.20 . Memory (MB): peak = 2709.594 ; gain = 0.000 ; free physical = 551 ; free virtual = 93702default:defaulth px� 
J
5Ending Logic Optimization Task | Checksum: 1b00d94a5
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:17 ; elapsed = 00:00:13 . Memory (MB): peak = 2709.594 ; gain = 0.000 ; free physical = 551 ; free virtual = 93702default:defaulth px� 
a

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103h px� 
s
7Will skip clock gating for clocks with period < %s ns.
114*pwropt2
2.002default:defaultZ34-132h px� 
�
$%s: '%s' is not a valid startpoint.
402*constraints2"
set_false_path2default:default2O
9block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/Q2default:default2_
I/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/constrs_1/new/timing.xdc2default:default2
52default:default8@Z18-402h px� 
�
$%s: '%s' is not a valid startpoint.
402*constraints2"
set_false_path2default:default2P
:block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/CE2default:default2_
I/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/constrs_1/new/timing.xdc2default:default2
52default:default8@Z18-402h px� 
�
$%s: '%s' is not a valid startpoint.
402*constraints2"
set_false_path2default:default2O
9block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/D2default:default2_
I/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/constrs_1/new/timing.xdc2default:default2
52default:default8@Z18-402h px� 
�
$%s: '%s' is not a valid startpoint.
402*constraints2"
set_false_path2default:default2O
9block_design_i/pfs_daughtercard_0/inst/counter_roll_reg/R2default:default2_
I/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.srcs/constrs_1/new/timing.xdc2default:default2
52default:default8@Z18-402h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
=
Applying IDT optimizations ...
9*pwroptZ34-9h px� 
?
Applying ODC optimizations ...
10*pwroptZ34-10h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
KInvalid Voltage Source %s for the family %s. Ignoring the voltage setting.
266*designutils2
VCCINTIO2default:default2
kintex72default:defaultZ20-266h px� 
�
KInvalid Voltage Source %s for the family %s. Ignoring the voltage setting.
266*designutils2
VCCINTIO2default:default2
kintex72default:defaultZ20-266h px� 
�
KInvalid Voltage Source %s for the family %s. Ignoring the voltage setting.
266*designutils2
VCCINTIO2default:default2
kintex72default:defaultZ20-266h px� 
�
KInvalid Voltage Source %s for the family %s. Ignoring the voltage setting.
266*designutils2
VCCINTIO2default:default2
kintex72default:defaultZ20-266h px� 


*pwropth px� 
e

Starting %s Task
103*constraints2*
PowerOpt Patch Enables2default:defaultZ18-103h px� 
�
�WRITE_MODE attribute of %s BRAM(s) out of a total of %s has been updated to save power.
    Run report_power_opt to get a complete listing of the BRAMs updated.
129*pwropt2
12default:default2
2762default:defaultZ34-162h px� 
d
+Structural ODC has moved %s WE to EN ports
155*pwropt2
42default:defaultZ34-201h px� 
�
CNumber of BRAM Ports augmented: %s newly gated: %s Total Ports: %s
65*pwropt2
1302default:default2
92default:default2
5522default:defaultZ34-65h px� 
i
1Number of Flops added for Enable Generation: %s

23*pwropt2
122default:defaultZ34-23h px� 
N
9Ending PowerOpt Patch Enables Task | Checksum: 1318ca45b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.37 ; elapsed = 00:00:00.36 . Memory (MB): peak = 3593.680 ; gain = 0.000 ; free physical = 908 ; free virtual = 92232default:defaulth px� 
J
5Ending Power Optimization Task | Checksum: 1318ca45b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:44 ; elapsed = 00:00:25 . Memory (MB): peak = 3593.680 ; gain = 884.086 ; free physical = 968 ; free virtual = 92832default:defaulth px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
732default:default2
622default:default2
02default:default2
02default:defaultZ4-41h px� 
\
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
opt_design: 2default:default2
00:01:142default:default2
00:00:452default:default2
3593.6802default:default2
948.1052default:default2
9682default:default2
92832default:defaultZ17-722h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:00.192default:default2
00:00:00.052default:default2
3593.6802default:default2
0.0002default:default2
9692default:default2
92872default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2h
T/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.runs/impl_1/block_design_wrapper_opt.dcp2default:defaultZ17-1381h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2&
write_checkpoint: 2default:default2
00:00:172default:default2
00:00:122default:default2
3593.6802default:default2
0.0002default:default2
9552default:default2
92902default:defaultZ17-722h px� 
x
Command: %s
53*	vivadotcl2G
3report_drc -file block_design_wrapper_drc_opted.rpt2default:defaultZ4-113h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
Z/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.runs/impl_1/block_design_wrapper_drc_opted.rptZ/storage/syncthing/work/pfs_ctrlr/pfs_ctrlr.runs/impl_1/block_design_wrapper_drc_opted.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
report_drc: 2default:default2
00:00:152default:default2
00:00:072default:default2
3593.6802default:default2
0.0002default:default2
9542default:default2
92892default:defaultZ17-722h px� 


End Record