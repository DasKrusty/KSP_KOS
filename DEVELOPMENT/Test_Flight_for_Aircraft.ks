// This script is to test new craft to find out their capabilities with regards to ceiling, speed and range.
// Version: 0.58
// POA:
// Engine test
// take off
// run test per 1000m, capturing ceiling, speed and range

function Main {
    doEngineSpec().
    wait 3.
    doSetHeading().
    doAutomaticThrottleControl().
    // doTakeOff().
    // doTestFlight().
}

function doEngineSpec {
    lock throttle to 1.
    brakes on.
    wait 1.
    stage.
    LIST ENGINES IN myVariable.
    FOR eng IN myVariable {print "Max Thrust: " + eng:thrust.}
    print ("Weight :" + ROUND((ship:mass*1000)) + "kg").
    wait 0.25.
    print ("Total Fuel: " + ROUND(ship:liquidfuel)).
    wait 0.25.
    print ("Thrust: " + ROUND(availableThrust) + " Kw").
    wait 0.25.
    set TWR to availableThrust / ship:mass.
    print ("TWR: " + ROUND(availableThrust / ship:mass)).
    wait 0.5.
    lock throttle to 0.
}

function doSetHeading {
    set NDIR to (ship:bearing - 180).   // Sets new direction for heading.
    sas off.
    lock steering to heading(NDIR,TWR * 1.5). // Sets new direction with TWR math degree climb.
}

function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
    }

// function doTakeOff {}

// function doTestFlight {}

main().