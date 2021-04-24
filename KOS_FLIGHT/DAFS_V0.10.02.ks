//NOTES ON CHANGES
//Changed Scroll box


clearguis().
clearscreen. print " running.".
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
//local exit is false.

//WINDOW SIZING
local window_open is (500).//px
//local window_closed is (100).//px

local g is gui(window_open).

//TITLE 
local TITLE to g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                        0.10.22" + "</i>"). 
//HEADER BOX
set BOX1 to g:addhbox().
    BOX1:addlabel("NAME:   " + "<b>" + ship:Name + "</b>").
    local HIDE_B to BOX1:addbutton ("_").
        set HIDE_B:style:width to 50.
        set HIDE_B:style:textcolor to black.
    local CLOSE_B to BOX1:addbutton ("X").
        set CLOSE_B:style:width to 50.
        set CLOSE_B:style:textcolor to black.
//STATUS BOX
set BOX2 to g:addhbox().
    set BOX2SUB1 to BOX2:addhbox.
        BOX2SUB1:addlabel("CURRENT STATUS").
            set BOX2SUB1:style:width to 150.
    set BOX2SUB2 to BOX2:addhbox.
        BOX2SUB2:addlabel("Waiting").
//LEVEL2 SECTION
set BOX3 to g:addhbox().
    //LEFT SECTION BOX
    set RUNMODE to BOX3:addvbox().
        RUNMODE:addlabel("RUNMODE: ").
        set RUNMODE:style:width to 120.
        set RUNMODE:style:align to "left".
            set TKO to RUNMODE:addbutton ("Take Off").
            set AUP to RUNMODE:addbutton ("Auto Pilot").
            set FRE to RUNMODE:addbutton ("Free Flight").
            set LAN to RUNMODE:addbutton ("Land").
            set TES to RUNMODE:addbutton ("Test").
    //MIDDLE SECTION BOX
    set INFOBOX to BOX3:addvbox().
        INFOBOX:addlabel("INFORMATION:").
        set INFOBOXCONTENT to INFOBOX:addvbox().
            INFOBOXCONTENT:addlabel("TWR: 500kW").
            INFOBOXCONTENT:addlabel("THRUST: 1.5").
            //TO ADD
            //Thrust / TWR / 
    //RIGHT SECTION BOX
    set SETTINGBOX to BOX3:addvbox().
        SETTINGBOX:addlabel("SETTINGS:").
        set SETTINGBOX:style:width to 140.
            local AUT is SETTINGBOX:addcheckbox("Auto Throttle",false).
            local TWR is SETTINGBOX:addhslider(0.1,0.5,2).
            local TE2 is SETTINGBOX:addradiobutton("Test 2",false).
            local TE3 is SETTINGBOX:addradiobutton("Test 3",false).
            local TE4 is SETTINGBOX:addradiobutton("Test 4",false).
            local TE5 is SETTINGBOX:addradiobutton("Test 5",false).
//LEVEL3 BOX
set LEVEL3BOX to g:addvbox().
    local FEEDBACKBOXTITLE to LEVEL3BOX:addlabel("COMPUTING").
    set FEEDBACKBOXTITLE to LEVEL3BOX:addhbox().
        set SCROLLBOX to FEEDBACKBOXTITLE:addvbox().
            SCROLLBOX:addlabel("Test Content").
g:show().
//GUI END DESIGN