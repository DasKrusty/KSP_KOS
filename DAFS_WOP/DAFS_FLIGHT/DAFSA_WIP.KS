// DASKRUSTY AUTOMATED FLIGHT SYSTEM FOR AIRCRAFT
// VERSION 0.00.46

// - GUI
clearguis().
clearscreen. print "GUI starting up".
wait 1.
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
local EXITGUI is false.    
//   - WINDOW & STYLING
local WIN_OPEN is (500).
local WIN_MIN is (77).
local g is gui(WIN_OPEN).
set g:style:height to WIN_OPEN.
//   - SECTION HEAD
//     - TITLE
local TIT to g:addlabel("<b>" + "DASKRUSTY'S AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.00.82" + "</i>").
//     - HEADER
set HEA_BOX to g:addhlayout.
    local HEA_TIT_BOX to HEA_BOX:addhlayout.
        HEA_TIT_BOX:addlabel ("<b>" + "NAME: " + "</b>").
    local HEA_NAM_BOX to HEA_BOX:addhlayout.
        HEA_NAM_BOX:addlabel ("<b>" + ship:name + "</b>").
            HEA_NAM:style:textcolor to yellow.
    local MIN_BUT to HEA_BOX:addbutton ("_").
    local CAN_BUT to HEA_BOX:addbutton ("X").
//     - STATUS BAR
set STA_BOX to g:addhlayout.
//   - SECTION ONE - MAIN CONTENT
set MAI_BOX to g:addhlayout.
    local RUNMODE to MAI_BOX:addvlayout. // Button section
        RUNMODE:addlabel ("<b>" + "RUN MODE" + "</b>").
        RUNMODE:style:width to 120.
        RUNMODE:style:align to "left".
            set TKO to RUNMODE:addbutton ("Take Off").
            set FRE to RUNMODE:addbutton ("Free Flight").
    local INF_BOX to MAI_BOX:addvlayout. // Main content to be updated continously
        INF_BOX:addlabel ("<b>" + "INFO" + "</b>").
        set INF_BOX_CON to INF_BOX:addvbox.
        // Updated info will go here, once I have figured out how to continously print
    local SET_BOX to MAI_BOX:addvlayout. // Settings
        SET_BOX:addlabel ("<b>" + "SETTINGS" + "</b>").
            set DAT to SET_BOX:addcheckbox ("Dynamic Auto Throttle").
                set DAT:toggle to true.
                    set DAT:ontoggle to {
                        parameter C.
                        if C {
                            doAutomaticThrottleControl().
                            STATUS_BOX_STATUS:clear.
                            STATUS_BOX_STATUS:addlabel ("DYNAMIC THROTTLE CONTROL - ACTIVATED"). 
                            SCROLL_BOX:addlabel ("Dynamic Throttle Control - Activated"). 
                        }
                        else {
                            unlock throttle.
                            STATUS_BOX_STATUS:clear.
                            STATUS_BOX_STATUS:addlabel ("DYNAMIC THROTTLE CONTROL - DEACTIVATED"). 
                            SCROLL_BOX:addlabel ("Dynamic Throttle Control - Deactivated"). 
                        }
                    }.
            set DTC to SET_BOX:addhslider (4.75,30,1).

//   - SECTION TWO - NAVIGATION
set NAV_BOX to g:addhlayout.
    local LEF_SEC to NAV_BOX:addvlayout.
    local MID_SEC to NAV_BOX:addvlayout.
    local RIG_SEC to NAV_BOX:addvlayout.   
//   - SECTION THREE - FEEDBACK
set REF_BOX to g:addvbox.
    REF_BOX:addlabel ("<b>" + "STATUS READOUT" + "</b>").
set SCR_BOX to g:addscrollbox.

g:show().
// - TASKS
// - TRIGGERS
// - FUNCTIONS