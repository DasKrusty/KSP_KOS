// DASKRUSTY AUTOMATED FLIGHT SYSTEM FOR AIRCRAFT
// VERSION 0.00.35

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
local TITLE to g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.00.35" + "</i>").
//     - HEADER
set HEADER_BOX to g:addhlayout.
//     - STATUS BAR
set STATUS_BOX to g:addhlayout.
//   - SECTION ONE - MAIN CONTENT
set MAIN_BOX to g:addhlayout.
    local RUNMODE to MAIN_BOX:addvlayout. // Button section
    local INFO_BOX to MAIN_BOX:addvlayout. // Main content to be updated continously
    local THIRD_CONTENT_BOX to MAIN_BOX:addvlayout. // Settings
//   - SECTION TWO - NAVIGATION
set NAV_BOX to g:addhlayout.
    local LEF_SEC to NAV_BOX:addvlayout.
    local MID_SEC to NAV_BOX:addvlayout.
    local RIG_SEC to NAV_BOX:addvlayout.   
//   - SECTION THREE - FEEDBACK
set REF_BOX to g:addvbox.

g:show().
// - TASKS
// - TRIGGERS
// - FUNCTIONS