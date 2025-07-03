// These functions are simple setups for copy paste functionality to set a craft in a specific direction and climb rate.

// This function version uses a set degree to establish the rate of climb //
// Version 0.05 - Not tested
function doSetHeading {
    set NDIR to (ship:bearing - 180).   // Sets new direction for heading.
    sas off.
    lock steering to heading(NDIR,20). // Sets new direction with 20 degree climb.
}

// This function version uses the TWR of the craft to decide on climb degree //
// Version 0.10 - Not tested
function doSetHeading {
    set NDIR to (ship:bearing - 180).   // Sets new direction for heading.
    sas off.
    lock steering to heading(NDIR,TWR * 1.5). // Sets new direction with TWR math climb degree.
}