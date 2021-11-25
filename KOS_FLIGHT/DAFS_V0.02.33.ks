//PLANNED
    //- GUI                               - PLANNING
        // - Open GUI and hold (Dont close or end program)
        // - Minimise button to close all boxes excluding main and Title
        // - Close button to close GUI
        // - STRUCTURE
        //     - Title / Header
        //     - Level 1
        //         - Buttons / Stats / Settings
        //     - Level 2
        //         - Guidance / Settings for guidance
        //     - Level 3
        //         - Readout
//WORKING ON
    //- GUI
        
//COMPLETED

clearguis().
clearscreen. print "GUI starting up".
wait 1.
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal"). 
local EXITGUI is false.

local GUI_WID is 500. //gui width in px
local GUI_MIN is 77. //gui minimised in px
local g is gui(GUI_WID).
set g:style:height to GUI_WID.
set g:x to 10.
set g:y to 60.
set g:style:padding:h to 5.
set g:style:padding:v to 5.


//GUI LAYOUT
//TITLE
g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.02.33" + "</i>"). //Title
//HEADER
set HEADER_BOX to g:addhlayout.
    local HEADER_TITLE_BOX to HEADER_BOX:addhlayout.
        HEADER_TITLE_BOX:addlabel ("<b>" + "NAME: " + "</b>"). //Header Name
    local HEADER_NAME_BOX to HEADER_BOX:addhlayout.
        HEADER_NAME_BOX:addlabel ("<b>" + ship:name + "</b>"). //Ship Name
        set HEADER_NAME_BOX:style:textcolor to yellow.
    local MIN_BUT to HEADER_BOX:addbutton ("_").
        set MIN_BUT:style:width to 50. 
        set MIN_BUT:toggle to true.
            set MIN_BUT:ontoggle to { 
                parameter b. 
                if b {
                    set g:style:height to GUI_MIN.
                    STATUS_BOX:hide.
                    MAIN_BOX:hide.
                    REF_BOX:hide.
                    SCROLL_BOX:hide.
                }
                else {
                    set g:style:height to GUI_WID.
                    STATUS_BOX:show.
                    MAIN_BOX:show.
                    REF_BOX:show.
                    SCROLL_BOX:show.
                }
            }.
    local CAN_BUT to HEADER_BOX:addbutton ("X").
        set CAN_BUT:style:width to 50.
        set CAN_BUT:style:textcolor to yellow. 
        set CAN_BUT:onclick to {doCLOSEGUI().}.
//LEVEL 1
//STATUS BAR
set STATUS_BOX to g:addhlayout.
    set STATUS_BOX_LABEL to STATUS_BOX:addhlayout.
        STATUS_BOX_LABEL:addlabel ("<b>" + "CURRENT STATUS:" + "</b>").
            set STATUS_BOX_LABEL:style:width to 150. 
    set STATUS_BOX_STATUS to STATUS_BOX:addhbox.
        STATUS_BOX_STATUS:addlabel ("Waiting").
        set STATUS_BOX_STATUS:style:textcolor to yellow.
//MAIN CONTENT
set MAIN_BOX to g:addhlayout.
    local RUNMODE to MAIN_BOX:addvlayout.
        RUNMODE:addlabel ("<b>" + "RUN MODE" + "</b>").
        set RUNMODE:style:width to 120.
        set RUNMODE:style:align to "left".
            set TKO to RUNMODE:addbutton ("Take Off").
            set FRE to RUNMODE:addbutton ("Free Flight").
    local INFO_BOX to MAIN_BOX:addvlayout.
        INFO_BOX:addlabel ("<b>" + "INFO" + "</b>").
        set INFO_BOX_CONTENT to INFO_BOX:addvbox.
    local THIRD_CONTENT_BOX to MAIN_BOX:addvlayout.
        THIRD_CONTENT_BOX:addlabel ("<b>" + "SETTINGS" + "</b>").
        set SETTINGS_BOX to THIRD_CONTENT_BOX:addvbox.
            set DAT to SETTINGS_BOX:addcheckbox ("Dynamic Auto Throttle").
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
            // set DTC to SETTINGS_BOX:addhslider (4.75,30,1).
//LEVEL 2
//AUTO NAVIGATION SECTION
// set NAV_BOX to g:addhlayout.
//     local LEF_SEC to NAV_BOX:addvlayout.
//     local MID_SEC to NAV_BOX:addvlayout.
//         //HEADING
//             //Setup - B1"<<" B2"<" T"" B3">" B4">>" 
//         //HEIGHT
//     local RIG_SEC to NAV_BOX:addvlayout.
//LEVEL 3
//SCROLLING FEEDBACK
set REF_BOX to g:addvbox.
    REF_BOX:addlabel ("<b>" + "STATUS READOUT" + "</b>").
    set SCROLL_BOX to g:addscrollbox.

g:show().

//PREFLIGHT CHECK
sas off.
lock throttle to 1.
brakes on.
wait 1.
stage.
LIST ENGINES IN myVariable.
FOR eng IN myVariable {print "Max Thrust: " + eng:thrust.}
INFO_BOX_CONTENT:addlabel("Weight :" + ROUND((ship:mass*1000)) + "kg").
wait 0.25.
INFO_BOX_CONTENT:addlabel("Total Fuel: " + ROUND(ship:liquidfuel)).
wait 0.25.
INFO_BOX_CONTENT:addlabel("Thrust: " + ROUND(availableThrust) + " Kw").
wait 0.25.
set TWR to availableThrust / ship:mass.
INFO_BOX_CONTENT:addlabel("TWR: " + ROUND(availableThrust / ship:mass)).
wait 0.5.
lock throttle to 0.

//TRIGGERS
LOCAL isDone IS FALSE.
set TKO:onclick to doTakeOff@. // Takeoff
set FRE:onclick to doFreeFlight@. //Free Flight Mode
set DAT:onclick to doAutomaticThrottleControl@. //Dynamic Throttle Control

//FUNCTIONS
function doCLOSEGUI{
    STATUS_BOX_STATUS:clear.
    STATUS_BOX_STATUS:addlabel("Closing GUI").
    SCROLL_BOX:addlabel("Closing GUI").
    wait 3.
    set EXITGUI to true.
    print "closing".
    g:hide().
}

function doTakeOff {
    wait 0.5.
    STATUS_BOX_STATUS:clear.
    STATUS_BOX_STATUS:addlabel ("Proceeding to take off").
    SCROLL_BOX:addlabel ("Proceeding to take off").
    lights on.
    wait 3.
    STATUS_BOX_STATUS:clear.
    STATUS_BOX_STATUS:addlabel ("Precheck done").
    SCROLL_BOX:addlabel ("Precheck done").
    brakes off.
    wait 1.
    doAutomaticThrottleControl().
    set NDIR to (ship:bearing - 180).   //Set new direction for steering
    sas off.
    lock steering to heading(NDIR,TWR * 1.5).
    when airspeed > 30 then {
        STATUS_BOX_STATUS:clear.
        STATUS_BOX_STATUS:addlabel ("Taking Off").
        SCROLL_BOX:addlabel ("Taking Off").
    }
    wait until altitude > 500. {
        lock steering to heading(NDIR,TWR * 2).
        ag1 off. //FLAPS
        gear off.
        lights off.
    }
    when altitude > 1000 then {
        lock steering to heading(NDIR,2).
        wait 20.
        set thrott to ((thrott - ship:dynamicpressure) - 0.35).
        set ship:control:pilotmainthrottle to thrott.
        sas on. 
        STATUS_BOX_STATUS:clear.
        STATUS_BOX_STATUS:addlabel ("TAKEOFF COMPLETE"). 
        SCROLL_BOX:addlabel ("TAKEOFF COMPLETE"). 
        unlock all.
        wait 1.
        STATUS_BOX_STATUS:clear.
        STATUS_BOX_STATUS:addlabel ("CONTROL IS YOURS"). 
        SCROLL_BOX:addlabel ("CONTROL IS YOURS"). 
    }
    wait 10.
    TKO:hide.
    }

function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
    }

function doFreeFlight {
    Unlock all.
}

wait until EXITGUI. // program will stay here until exit clicked.