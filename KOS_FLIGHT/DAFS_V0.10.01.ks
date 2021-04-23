clearguis().
clearscreen. print " running.".
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
//local exit is false.

//WINDOW SIZING
local window_open is (500).//px
//local window_closed is (100).//px

local g is gui(window_open).

//TITLE 
local TITLE is g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "0.10.02" + "</i>"). 
//HEADER BOX
set HEADERBOX to g:addhbox().
    local HEADERTITLE to HEADERBOX:addlabel("NAME:   " + "<b>" + ship:Name + "</b>").
    local HIDEBUTTON to HEADERBOX:addbutton ("_").
        set HIDEBUTTON:style:width to 50.
        set HIDEBUTTON:style:textcolor to black.
    local CLOSEBUTTON to HEADERBOX:addbutton ("X").
        set CLOSEBUTTON:style:width to 50.
        set CLOSEBUTTON:style:textcolor to black.
//STATUS BOX
set STATUSBOX to g:addhbox().
    set STATUSTITLEBOX to STATUSBOX:addhbox.
        local STATUSTITLE to STATUSTITLEBOX:addlabel("CURRENT STATUS").
    set STATUSPRINT to STATUSBOX:addhbox.
        local STATUSREAD to STATUSBOX:addlabel("Waiting").
//LEVEL2 SECTION
set MAINSECTION to g:addhbox().
    local MAINSECTIONTITLE is MAINSECTION:addlabel("Main Section Title Holder").
    //LEFT SECTION BOX
    set RUNMODE to MAINSECTION:addvbox().
        RUNMODE:addlabel("RUNMODE: ").
        set RUNMODE:style:width to 120.
        set RUNMODE:style:align to "left".
            set TKO to RUNMODE:addbutton ("Take Off").
            set AUP to RUNMODE:addbutton ("Auto Pilot").
            set FRE to RUNMODE:addbutton ("Free Flight").
            set LAN to RUNMODE:addbutton ("Land").
            set TES to RUNMODE:addbutton ("Test").
    //MIDDLE SECTION BOX
    set INFOBOX to MAINSECTION:addvbox().
        INFOBOX:addlabel("INFORMATION:").
    //RIGHT SECTION BOX
    set SETTINGBOX to MAINSECTION:addvbox().
        SETTINGBOX:addlabel("SETTINGS:").
        set SETTINGBOX:style:width to 140.
            //local AUT is SETTINGBOX:addhslider("Auto Throttle",false).
            // local TE2 is SETTINGBOX:addradiobutton("Test 2",false).
            // local TE3 is SETTINGBOX:addradiobutton("Test 3",false).
            // local TE4 is SETTINGBOX:addradiobutton("Test 4",false).
            // local TE5 is SETTINGBOX:addradiobutton("Test 5",false).
//LEVEL3 BOX
set LEVEL3BOX to g:addvbox().
    local FEEDBACKBOXTITLE to LEVEL3BOX:addlabel("COMPUTING").
    set FEEDBACKBOXTITLE to LEVEL3BOX:addhbox().
        set SCROLLBOX to FEEDBACKBOXTITLE:addscrollbox().
g:show().
//GUI END DESIGN