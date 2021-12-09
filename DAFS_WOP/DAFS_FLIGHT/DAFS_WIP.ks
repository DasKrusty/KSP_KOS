//DASKRUSTY'S AUTOMATED FLIGHT SYSTEM 
//VERSION 0.4.41

//IDEAS
    //show / hide TKO based on status "landed"
    //slider to control dynamic auto throttle
    //switch between mach / km/h m/s - speed indicator

//[[[M A I N   F U N C T I O N]]]
function Main{
    doGUI().
}

//[[GUI FUNCTION]]
function doGUI{
    clearguis().
    clearscreen. print "GUI starting up".
    set EXITGUI to false.
    //local EXITGUI is false.
    wait 1.
    //core:part:getmodule("kOSProcessor"):doevent("Close Terminal").

    //[GUI BODY SETTINGS]
    set WIN_OPEN to 500.
    set WIN_MIN to 77.
    set G_MAIN to gui(WIN_OPEN).
    set G_MAIN:x to 50. //main gui starting position
    set G_MAIN:y to 50.	//main gui starting position
    set G_MAIN:style:padding:h to 5.    //main gui padding
    set G_MAIN:style:padding:v to 5.    //main gui padding
    set G_MAIN:style:height to WIN_OPEN.    //set gui to window open size 

    //[GUI FUNCTION SETUP]
    //[TITLE]
    set G_MAIN_TITLE to G_MAIN:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.03.08" + "</i>").
        set G_MAIN_TITLE:style:textcolor to rgb(1,1,0). //light orange
        set G_MAIN_TITLE:style:fontsize to 13.
        set G_MAIN_TITLE:style:margin:top to 10.
        //set G_MAIN_TITLE:style:margin:bottom to 15.
    //[HEADER BOX]
    set G_MAIN_HEADER to G_MAIN:addhlayout.
        set G_MAIN_HEADER_BOX1 to G_MAIN_HEADER:addhlayout. //Header title box
            set G_MAIN_HEADER_TITLE to G_MAIN_HEADER_BOX1:addlabel ("<b>" + "NAME: " + "</b>"). //Header title
                set G_MAIN_HEADER_TITLE:style:textcolor to rgb(1,1,0).
        set G_MAIN_HEADER_BOX2 to G_MAIN_HEADER:addhlayout. //Header name box
            set G_MAIN_HEADER_NAME to G_MAIN_HEADER_BOX2:addlabel ("<b>" + ship:name + "</b>"). //Header name
                set G_MAIN_HEADER_NAME:style:textcolor to white.
        set MIN_BUT to G_MAIN_HEADER:addbutton ("_"). //Minimise button
            set MIN_BUT:style:width to 50.
            set MIN_BUT:style:textcolor to red. 
            set MIN_BUT:toggle to true.
            set MIN_BUT:ontoggle to { 
                parameter b. 
                if b {
                    set G_MAIN:style:height to WIN_MIN.
                    G_MAIN_STATUS:hide.
                    G_MAIN_MAIN:hide.
                    // REF_BOX:hide.
                    // SCROLL_BOX:hide.
                }
                else {
                    set G_MAIN:style:height to WIN_OPEN.
                    G_MAIN_STATUS:show.
                    G_MAIN_MAIN:show.
                    // REF_BOX:show.
                    // SCROLL_BOX:show.
                }
            }.
        set CAN_BUT to G_MAIN_HEADER:addbutton ("X"). //Close
            set CAN_BUT:style:width to 50.
            set CAN_BUT:style:textcolor to red. 
            set CAN_BUT:onclick to {doCLOSEGUI().}.
    //[STATUS BAR]
    set G_MAIN_STATUS to G_MAIN:addhlayout.
        set G_MAIN_STATUS:style:padding:h to 5.
        set G_MAIN_STATUS:style:padding:v to 5.
        set G_MAIN_STATUS_TITLE to G_MAIN_STATUS:addhlayout.
            G_MAIN_STATUS_TITLE:addlabel ("<b>" + "CURRENT STATUS:" + "</b>").
                set G_MAIN_STATUS_TITLE:style:width to 152.
                set G_MAIN_STATUS_TITLE:style:textcolor to rgb(1,0,0).
        set G_MAIN_STATUS_STATUS to G_MAIN_STATUS:addhbox.
            G_MAIN_STATUS_STATUS:addlabel ("Waiting").
                set G_MAIN_STATUS:style:textcolor to yellow.
    //[MAIN CONTENT]
    set G_MAIN_MAIN to G_MAIN:addhlayout.
        set RUNMODE to G_MAIN_MAIN:addvlayout.
            RUNMODE:addlabel ("<b>" + "RUN MODE" + "</b>").
                set RUNMODE:style:textcolor to rgb(1,0,0).
                set RUNMODE:style:width to 120.
                set RUNMODE:style:align to "left".
                set TKO to RUNMODE:addbutton ("Take Off").
                set FRE to RUNMODE:addbutton ("Free Flight").
        local INFO_BOX to G_MAIN_MAIN:addvlayout.
            INFO_BOX:addlabel ("<b>" + "INFO" + "</b>").
            set INFO_BOX_CONTENT to INFO_BOX:addvbox.
        local THIRD_CONTENT_BOX to G_MAIN_MAIN:addvlayout.
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
                set DTC to SETTINGS_BOX:addhslider (4.75,30,1).


    G_MAIN:show().
}

function doCLOSEGUI{
    // STATUS_BOX_STATUS:clear.
    // STATUS_BOX_STATUS:addlabel("Closing GUI").
    // SCROLL_BOX:addlabel("Closing GUI").
    wait 3.
    set EXITGUI to true.
    //local EXITGUI is true.
    print "closing".
    G_MAIN:hide().
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
    }

//until false.
Main().