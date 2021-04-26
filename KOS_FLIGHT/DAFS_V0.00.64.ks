
clearguis().
clearscreen. print "GUI starting up".
wait 1.
//core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
local EXITGUI is false.    


//WINDOW SIZING & STYLING
local WIN_OPEN is (500).
local g is gui(WIN_OPEN).

//GUI LAYOUT
//TITLE
add g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.00.64" + "</i>").
//HEADER BOX
set HEADER_BOX to g:addhlayout.
    HEADER_BOX:addlabel ("NAME:   " + "<b>" + ship:Name + "</b>").
    set MIN_BUT to HEADER_BOX:addbutton ("_").
        set MIN_BUT:style:width to 50.
        set MIN_BUT:style:textcolor to black. 
    set CAN_BUT to HEADER_BOX:addbutton ("X").
        set CAN_BUT:style:width to 50.
        set CAN_BUT:style:textcolor to black. 
        set CAN_BUT:onclick to {doCLOSEGUI().}.
//STATUS BAR
set STATUS_BOX to g:addhlayout.
    set STATUS_BOX_LABEL to STATUS_BOX:addhlayout.
        STATUS_BOX_LABEL:addlabel ("CURRENT STATUS: ").
            set STATUS_BOX_LABEL:style:width to 150. 
    set STATUS_BOX_STATUS to STATUS_BOX:addhbox.
        STATUS_BOX_STATUS:addlabel ("Waiting").
//MAIN CONTENT
set MAIN_BOX to g:addhlayout.
    set RUNMODE to MAIN_BOX:addvbox.
        add RUNMODE:addlabel ("<b>" + "RUN MODE" + "</b>").
        set RUNMODE:style:width to 120.
        set RUNMODE:style:align to "left".
    set INFO_BOX to MAIN_BOX:addvlayout.
        add INFO_BOX:addlabel ("<b>" + "INFO" + "</b>").
        set INFO_BOX_CONTENT to INFO_BOX:addvbox.
        add INFO_BOX_CONTENT:addlabel ("Text holder").
    set THIRD_CONTENT_BOX to MAIN_BOX:addvlayout.
        set SETTINGS_BOX to THIRD_CONTENT_BOX:addvbox.
            SETTINGS_BOX:addlabel ("<b>" + "SETTINGS" + "</b>").
            SETTINGS_BOX:addlabel ("Text holder").
//SCROLLING FEEDBACK
g:addlabel ("STATUS READOUT").
set SCROLL_BOX to g:addscrollbox:valways.
    set SCROLL_BOX:style:height to 400.

g:show().
//GUI END DESIGN


//FUNCTIONS
function doCLOSEGUI{
    STATUS_BOX_STATUS:clear.
    STATUS_BOX_STATUS:addlabel("Closing GUI").
    //SCROLLBOX:addlabel("Closing GUI").
    wait 3.
    set EXITGUI to true.
    print "closing".
    g:hide().
}