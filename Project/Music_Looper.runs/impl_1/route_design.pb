
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px? 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px? 
y
BMultithreading enabled for route_design using a maximum of %s CPUs97*route2
22default:defaultZ35-254h px? 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px? 
C
.Phase 1 Build RT Design | Checksum: 163d98976
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:37 ; elapsed = 00:00:33 . Memory (MB): peak = 1250.395 ; gain = 145.6452default:defaulth px? 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px? 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px? 
B
-Phase 2.1 Create Timer | Checksum: 163d98976
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:38 ; elapsed = 00:00:33 . Memory (MB): peak = 1250.395 ; gain = 145.6452default:defaulth px? 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px? 
N
9Phase 2.2 Fix Topology Constraints | Checksum: 163d98976
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:38 ; elapsed = 00:00:33 . Memory (MB): peak = 1250.395 ; gain = 145.6452default:defaulth px? 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px? 
G
2Phase 2.3 Pre Route Cleanup | Checksum: 163d98976
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:38 ; elapsed = 00:00:33 . Memory (MB): peak = 1250.395 ; gain = 145.6452default:defaulth px? 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px? 
B
-Phase 2.4 Update Timing | Checksum: c0b6d756
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:45 ; elapsed = 00:00:37 . Memory (MB): peak = 1253.316 ; gain = 148.5662default:defaulth px? 
?
Intermediate Timing Summary %s164*route2K
7| WNS=0.276  | TNS=0.000  | WHS=-0.662 | THS=-242.288|
2default:defaultZ35-416h px? 
H
3Phase 2 Router Initialization | Checksum: 94ba42b7
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:47 ; elapsed = 00:00:39 . Memory (MB): peak = 1254.633 ; gain = 149.8832default:defaulth px? 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px? 
C
.Phase 3 Initial Routing | Checksum: 1a3eced47
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:02:10 ; elapsed = 00:01:21 . Memory (MB): peak = 1302.324 ; gain = 197.5742default:defaulth px? 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px? 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
4.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 4.1.1 Update Timing | Checksum: 29ac17848
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:22 ; elapsed = 00:02:08 . Memory (MB): peak = 1302.324 ; gain = 197.5742default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-0.794 | TNS=-15.261| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
v

Phase %s%s
101*constraints2
4.1.2 2default:default2%
GlobIterForTiming2default:defaultZ18-101h px? 
t

Phase %s%s
101*constraints2
4.1.2.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
F
1Phase 4.1.2.1 Update Timing | Checksum: a27443cb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:23 ; elapsed = 00:02:09 . Memory (MB): peak = 1302.324 ; gain = 197.5742default:defaulth px? 
u

Phase %s%s
101*constraints2
4.1.2.2 2default:default2"
Fast Budgeting2default:defaultZ18-101h px? 
G
2Phase 4.1.2.2 Fast Budgeting | Checksum: b32a54a5
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:03:23 ; elapsed = 00:02:09 . Memory (MB): peak = 1302.324 ; gain = 197.5742default:defaulth px? 
I
4Phase 4.1.2 GlobIterForTiming | Checksum: 177ad1c11
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:57 ; elapsed = 00:03:52 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
H
3Phase 4.1 Global Iteration 0 | Checksum: 177ad1c11
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:57 ; elapsed = 00:03:52 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
4.2.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 4.2.1 Update Timing | Checksum: 1780b8b2d
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:07:23 ; elapsed = 00:04:52 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-0.596 | TNS=-12.759| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
v

Phase %s%s
101*constraints2
4.2.2 2default:default2%
GlobIterForTiming2default:defaultZ18-101h px? 
t

Phase %s%s
101*constraints2
4.2.2.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
G
2Phase 4.2.2.1 Update Timing | Checksum: 10055b06d
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:07:24 ; elapsed = 00:04:52 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
u

Phase %s%s
101*constraints2
4.2.2.2 2default:default2"
Fast Budgeting2default:defaultZ18-101h px? 
G
2Phase 4.2.2.2 Fast Budgeting | Checksum: 92fbad20
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:07:24 ; elapsed = 00:04:52 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
I
4Phase 4.2.2 GlobIterForTiming | Checksum: 101b47723
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:09:43 ; elapsed = 00:06:21 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
H
3Phase 4.2 Global Iteration 1 | Checksum: 101b47723
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:09:43 ; elapsed = 00:06:21 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
u

Phase %s%s
101*constraints2
4.3 2default:default2&
Global Iteration 22default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
4.3.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 4.3.1 Update Timing | Checksum: 18f63f507
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:11:24 ; elapsed = 00:07:33 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-0.477 | TNS=-9.514 | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.3 Global Iteration 2 | Checksum: 1ea9aac9b
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:11:24 ; elapsed = 00:07:33 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
F
1Phase 4 Rip-up And Reroute | Checksum: 1ea9aac9b
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:11:24 ; elapsed = 00:07:33 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 5.1.1 Update Timing | Checksum: 184badd0c
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:11:25 ; elapsed = 00:07:34 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-0.477 | TNS=-9.514 | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
C
.Phase 5.1 Delay CleanUp | Checksum: 184badd0c
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:11:25 ; elapsed = 00:07:34 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px? 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 184badd0c
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:11:25 ; elapsed = 00:07:34 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
O
:Phase 5 Delay and Skew Optimization | Checksum: 184badd0c
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:11:25 ; elapsed = 00:07:34 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 6.1.1 Update Timing | Checksum: 2164107e6
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:11:26 ; elapsed = 00:07:35 . Memory (MB): peak = 1316.563 ; gain = 211.8132default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-0.477 | TNS=-9.514 | WHS=-0.331 | THS=-5.268 |
2default:defaultZ35-416h px? 
?

Phase %s%s
101*constraints2
6.1.2 2default:default25
!Lut RouteThru Assignment for hold2default:defaultZ18-101h px? 
Y
DPhase 6.1.2 Lut RouteThru Assignment for hold | Checksum: 13ecc47c4
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:06 ; elapsed = 00:08:02 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
C
.Phase 6.1 Hold Fix Iter | Checksum: 13ecc47c4
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:06 ; elapsed = 00:08:02 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
v

Phase %s%s
101*constraints2
6.2 2default:default2'
Additional Hold Fix2default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-0.582 | TNS=-12.272| WHS=-0.288 | THS=-1.527 |
2default:defaultZ35-416h px? 
I
4Phase 6.2 Additional Hold Fix | Checksum: 1c5678352
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:09 ; elapsed = 00:08:05 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
?
?The router encountered %s pins that are both setup-critical and hold-critical and tried to fix hold violations at the expense of setup slack. Such pins are:
%s201*route2
62default:default2?
?	Ram/ram_a_int_reg[2]/D
	Ram/ram_a_int_reg[0]/D
	Ram/ram_a_int_reg[1]/D
	Ram/ram_cen_int_reg/D
	Ram/ram_oen_int_reg/D
	Ram/ram_wen_int_reg/D
2default:defaultZ35-468h px? 
A
,Phase 6 Post Hold Fix | Checksum: 1c5678352
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:09 ; elapsed = 00:08:05 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px? 
B
-Phase 7 Route finalize | Checksum: 162501cd9
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:09 ; elapsed = 00:08:05 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px? 
I
4Phase 8 Verifying routed nets | Checksum: 162501cd9
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:10 ; elapsed = 00:08:05 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px? 
D
/Phase 9 Depositing Routes | Checksum: bd305983
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:10 ; elapsed = 00:08:06 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px? 
?
Estimated Timing Summary %s
57*route2J
6| WNS=-0.582 | TNS=-12.272| WHS=-0.288 | THS=-1.527 |
2default:defaultZ35-57h px? 
B
!Router estimated timing not met.
128*routeZ35-328h px? 
F
1Phase 10 Post Router Timing | Checksum: bd305983
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:11 ; elapsed = 00:08:06 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
?
?Router was unable to fix hold violation on %s pins. This could be due to a combination of congestion, blockages and run-time limitations. Such pins are:
%s192*route2
12default:default2<
(	memory_control/ram_dq_i_int[15]_i_1/I1
2default:defaultZ35-459h px? 
=
Router Completed Successfully
16*routeZ35-16h px? 
?

%s
*constraints2q
]Time (s): cpu = 00:12:11 ; elapsed = 00:08:06 . Memory (MB): peak = 1335.316 ; gain = 230.5662default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
592default:default2
112default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:12:122default:default2
00:08:072default:default2
1335.3162default:default2
235.2702default:defaultZ17-268h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:062default:default2
00:00:022default:default2
1335.3162default:default2
0.0002default:defaultZ17-268h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
MD:/Ray/Vivado/Music_Looper/Music_Looper.runs/impl_1/Looper_Top_drc_routed.rptMD:/Ray/Vivado/Music_Looper/Music_Looper.runs/impl_1/Looper_Top_drc_routed.rpt2default:default8Z2-168h px? 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 
?
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px? 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px? 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px? 


End Record