// This script is to test new craft to find out their capabilities with regards to ceiling, speed and range.
// Version: 0.36
// POA:
// Engine test
// take off
// run test per 1000m, capturing ceiling, speed and range

function Main {
    doEngineSpec().
    doSetHeading().
    doAutomaticThrottleControl().
    doTakeOff().
    doTestFlight().
}

function doEngineSpec {}

function doSetHeading {
    set NDIR to (ship:bearing - 180).   // Sets new direction for heading.
    sas off.
    lock steering to heading(NDIR,20). // Sets new direction with 20 degree climb.
}

function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
    }

// function doTakeOff {}

// function doTestFlight {}

main().