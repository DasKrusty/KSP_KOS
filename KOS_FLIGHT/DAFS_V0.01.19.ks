//CURRENT ISSUES
//None
//COMPLETED
//Minimising Button

clearguis().
clearscreen. print "GUI starting up".
wait 1.
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
local EXITGUI is false.    


//WINDOW SIZING & STYLING
local WIN_OPEN is (500).
local WIN_MIN is (77).
local g is gui(WIN_OPEN).
set g:style:height to WIN_OPEN.

//GUI LAYOUT
//TITLE
local TITLE to g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.01.58" + "</i>").
//HEADER BOX
set HEADER_BOX to g:addhlayout.
    
    set HEADER_TITLE_BOX to HEADER_BOX:addhlayout.
        set HEADER_TITLE to HEADER_TITLE_BOX:addlabel ("<b>" + "NAME: " + "</b>").
    set HEADER_NAME_BOX to HEADER_BOX:addhlayout.
        set HEADER_NAME to HEADER_NAME_BOX:addlabel ("<b>" + ship:name + "</b>").
        set HEADER_NAME:style:textcolor to yellow.
    set MIN_BUT to HEADER_BOX:addbutton ("_").
        set MIN_BUT:style:width to 50. 
        set MIN_BUT:toggle to true.
            set MIN_BUT:ontoggle to { 
                parameter b. 
                if b {
                    set g:style:height to WIN_MIN.
                    STATUS_BOX:hide.
                    MAIN_BOX:hide.
                    REF_BOX:hide.
                    SCROLL_BOX:hide.
                }
                else {
                    set g:style:height to WIN_OPEN.
                    STATUS_BOX:show.
                    MAIN_BOX:show.
                    REF_BOX:show.
                    SCROLL_BOX:show.
                }
            }.
    set CAN_BUT to HEADER_BOX:addbutton ("X").
        set CAN_BUT:style:width to 50.
        set CAN_BUT:style:textcolor to yellow. 
        set CAN_BUT:onclick to {doCLOSEGUI().}.
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
    local INFO_BOX to MAIN_BOX:addvlayout.
        INFO_BOX:addlabel ("<b>" + "INFO" + "</b>").
        set INFO_BOX_CONTENT to INFO_BOX:addvbox.
        INFO_BOX_CONTENT:addlabel ("Text holder").
    local THIRD_CONTENT_BOX to MAIN_BOX:addvlayout.
        THIRD_CONTENT_BOX:addlabel ("<b>" + "SETTINGS" + "</b>").
        set SETTINGS_BOX to THIRD_CONTENT_BOX:addvbox.
            SETTINGS_BOX:addlabel ("Text holder").
//SCROLLING FEEDBACK
set REF_BOX to g:addvbox.
    REF_BOX:addlabel ("<b>" + "STATUS READOUT" + "</b>").
    set SCROLL_BOX to g:addscrollbox.

g:show().

//PREFLIGHT CHECK


//TRIGGERS
LOCAL isDone IS FALSE.
set TKO:onclick to doTakeOff@. // Takeoff
wait until EXITGUI.

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
    //set flaps for quicker take off
    //set engine mode for quicker take off
    wait 0.5.
    STATUS_BOX_STATUS:clear.
    STATUS_BOX_STATUS:addlabel ("Proceeding to take off").
    lights on.
    wait 3.
    STATUS_BOX_STATUS:clear.
    STATUS_BOX_STATUS:addlabel ("Precheck done").
    brakes off.
    wait 1.
    //doAutomaticThrottleControl().
    //local TAOF to INFOBOX:addlabel("TKO PITCH: " + ROUND(TWR * 1.5) + " Degrees").
    //lock steering to heading(90,TWR1 * 2).
    when airspeed > 30 then {
        STATUS_BOX_STATUS:clear.
        STATUS_BOX_STATUS:addlabel ("Taking Off").
    }
    wait until altitude > 500. {
        lock steering to heading(90,TWR1 * 3).
        ag1 off. //FLAPS
        gear off.
        lights off.
    }
    when altitude > 1000 then {
        lock steering to heading(90,2).
        wait 15.
        set thrott to ((thrott - ship:dynamicpressure) - 0.25).
        set ship:control:pilotmainthrottle to thrott.
        sas on. 
        STATUS_BOX_STATUS:clear.
        STATUS_BOX_STATUS:addlabel ("TAKEOFF COMPLETE"). 
        unlock all.
    }
    }
