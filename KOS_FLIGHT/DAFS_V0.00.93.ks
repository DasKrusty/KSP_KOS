//PLANNED
    //- GUI                               - PLANNING
    // - Rewrite GUI to function form
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
local TITLE to g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.00.93" + "</i>").
//HEADER
//HEADER BOX
    //HEADER_TITLE_BOX
        //HEADER_TITLE
    //HEADER_NAME_BOX
        //HEADER_NAME
    // MIN_BUT
    // CAN_BUT
set HEADER_BOX to g:addhlayout.
    local HEADER_TITLE to HEADER_BOX:addhlayout.
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
                    set g:style:height to GUI_MIN.
                    // STATUS_BOX:hide.
                    // MAIN_BOX:hide.
                    // REF_BOX:hide.
                    // SCROLL_BOX:hide.
                }
                else {
                    set g:style:height to GUI_WID.
                    // STATUS_BOX:show.
                    // MAIN_BOX:show.
                    // REF_BOX:show.
                    // SCROLL_BOX:show.
                }
            }.
    set CAN_BUT to HEADER_BOX:addbutton ("X").
        set CAN_BUT:style:width to 50.
        set CAN_BUT:style:textcolor to yellow. 
        set CAN_BUT:onclick to {doCLOSEGUI().}.
//LEVEL 1
//LEVEL 2
//LEVEL 3

//FUNCTIONS
function doCLOSEGUI{
    // STATUS_BOX_STATUS:clear.
    // STATUS_BOX_STATUS:addlabel("Closing GUI").
    // SCROLL_BOX:addlabel("Closing GUI").
    wait 3.
    set EXITGUI to true.
    print "closing".
    g:hide().
}

wait until EXITGUI. // program will stay here until exit clicked.