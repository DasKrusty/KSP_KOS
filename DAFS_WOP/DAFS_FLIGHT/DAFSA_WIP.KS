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
local TIT to g:addlabel("<b>" + "DASKRUSTY'S AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.00.46" + "</i>").
//     - HEADER
set HEA_BOX to g:addhlayout.
    local HEA_TIT_BOX to HEA_BOX:addhlayout.
        local HEA_TIT to HEA_TIT_BOX:addlabel ("<b>" + "NAME: " + "</b>").
    local HEA_NAM_BOX to HEA_BOX:addhlayout.
        set HEA_NAM to HEA_NAM_BOX:addlabel ("<b>" + ship:name + "</b>").
    local MIN_BUT to HEA_BOX:addbutton ("_").
    local CAN_BUT to HEA_BOX:addbutton ("X").
//     - STATUS BAR
set STA_BOX to g:addhlayout.
//   - SECTION ONE - MAIN CONTENT
set MAI_BOX to g:addhlayout.
    local RUNMODE to MAIN_BOX:addvlayout. // Button section
    local INFO_BOX to MAIN_BOX:addvlayout. // Main content to be updated continously
    local SETTINGS_BOX to MAIN_BOX:addvlayout. // Settings
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