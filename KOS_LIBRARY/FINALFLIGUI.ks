clearguis().
clearscreen. print " running.".
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
local exit is false.

local window_wide is 500. //px
local window_collapsed is 380. //px

local g is gui(window_wide).
set g:x to 10. //window start position
set g:y to 60.
set g:style:padding:h to 5.
set g:style:padding:v to 5.

//TITLE HEADER
g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT MODE   V1.01" + "</b>").
//HEADER BOX
set BoxTitle to g:addhbox().
    local SHIPNAME is BoxTitle:addlabel("NAME:   " + "<b>" + ship:Name + "</b>").
    local HIDEBUTTON to BoxTitle:addbutton ("_").
        set HIDEBUTTON:style:width to 50.
        //set HIDEBUTTON:style:height to 15.
        set HIDEBUTTON:toggle to true.
        set HIDEBUTTON:style:textcolor to black.
        set HIDEBUTTON:ontoggle to { 
            parameter b. 
            if b {
                box_all:hide().
                set g:style:width to window_collapsed.
            }
            else {
                box_all:show().
                set g:style:width to window_wide.
            }
        }.
    local CLOSEBUTTON to BoxTitle:addbutton ("X").
        set CLOSEBUTTON:style:width to 50.
        //set CLOSEBUTTON:style:height to 15.
        set CLOSEBUTTON:style:textcolor to black.
        set CLOSEBUTTON:onclick to { set exit to true. }.
//STATUS BOX
set STATUSBOX to g:addhbox().
    set TITLESTATUS to STATUSBOX:addhbox. //complete
    set RUNSTATUS to STATUSBOX:addhbox. //complete
    TOPSTATUSBOX:addlabel ("<b>" + "CURRENT STATUS:   " + "</b>").
    local UPDATESTATUS to TOPSTATUSBOX:addlabel("WAITING").
//CENTRAL HOLDER BOX
set HOLDERBOX to g:addhbox().
    //RUNMODE BOX
    set RUNMODE to HOLDERBOX:addvbox().
        RUNMODE:addlabel("RUNMODE: ").
        set RUNMODE:style:width to 120.
        set RUNMODE:style:align to "left".
            local TKO to RUNMODE:addbutton ("Take Off").
            local AUP to RUNMODE:addbutton ("Auto Pilot").
            local FRE to RUNMODE:addbutton ("Free Flight").
            local LAN to RUNMODE:addbutton ("Land").
            local TES to RUNMODE:addbutton ("Test").
    //INFORMATION BOX
    set INFOBOX to HOLDERBOX:addvbox().
        INFOBOX:addlabel("INFORMATION:").
            sas off.
            lock throttle to 1.
            brakes on.
            wait 1.
            stage.
            LIST ENGINES IN myVariable.
            FOR eng IN myVariable {print "Max Thrust: " + eng:thrust.}
            local THR to INFOBOX:addlabel("Thrust: " + ROUND(availableThrust) + " Kw" + "      Weight :" + ROUND((ship:mass*1000)) + "kg").
            set TWR1 to availableThrust / ship:mass.
            local FUEL to INFOBOX:addlabel("Total Fuel: " + ROUND(ship:liquidfuel) + "      TWR: " + ROUND(availableThrust / ship:mass)).
            //local TWR2 to INFOBOX:addlabel("TWR: " + ROUND(availableThrust / ship:mass)).
            wait 2.
            lock throttle to 0.
        // INFOBOX:addlabel("Speed: " + ROUND(ASL) + " m/s" ).
    //SETTINGS BOX
    set SETTINGBOX to HOLDERBOX:addvbox().
        SETTINGBOX:addlabel("SETTINGS:").
        set SETTINGBOX:style:width to 140.
            //local AUT is SETTINGBOX:addhslider("Auto Throttle",false).
            // local TE2 is SETTINGBOX:addradiobutton("Test 2",false).
            // local TE3 is SETTINGBOX:addradiobutton("Test 3",false).
            // local TE4 is SETTINGBOX:addradiobutton("Test 4",false).
            // local TE5 is SETTINGBOX:addradiobutton("Test 5",false).
    //LAST STATUS BOX
    set BOTSTATUSBOX to g:addhbox().
        BOTSTATUSBOX:addlabel("LAST STATUS: ").

g:show().
//GUI END DESIGN

//TRIGGERS
LOCAL isDone IS FALSE.
set TKO:onclick to doTakeOff@. // Takeoff
set AUP:onclick to doAutoPilot@. // Auto Pilot
set FRE:onclick to doFreeFlight@. // Free Flight
set LAN:onclick to doLand@. // Land
set TES:onclick to doTest@. //Test
//set AUT:onchange to doAutomaticThrottleControl@.
wait until isDone.

//FUNCTIONS
function doTakeOff {
    //set flaps for quicker tko
    local UPDATESTATUS to TOPSTATUSBOX:clear.
    local UPDATESTATUS to TOPSTATUSBOX:addlabel("TAKING OFF").
    lights on.
    //get current heading
    lock steering to heading(90,0).    //Initial setting
    wait 3.
    print "precheck done".
    brakes off.
    wait 1.
    doAutomaticThrottleControl().
    //local TAOF to INFOBOX:addlabel("TKO PITCH: " + ROUND(TWR * 1.5) + " Degrees").
    lock steering to heading(90,TWR1 * 2).
    print "Starting Roll".
    when airspeed > 30 then {
        print "Taking Off".
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
        print "TAKEOFF COMPLETE".  
        unlock all.
    }
}
function doAutoPilot {}
function doFreeFlight {}
function doLand {}
function doTest {}
function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
}