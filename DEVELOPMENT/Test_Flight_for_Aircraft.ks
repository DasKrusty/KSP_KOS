// This script is to test new craft to find out their capabilities with regards to ceiling, speed and range.
// Version: 1.04
// POA:
// status check - check if aircraft is landed or currently flying
// take off
// run test per 1000m, capturing ceiling, speed and range

function Main {
    doFlightStatus().
    // doEngineSpec().
    // doAutomaticThrottleControl().
    // doSetHeading().
    // doTakeOff().
    // doTestFlight().
    print "Test Ended"
    wait 10.
}

function doFlightStatus {
    print "Checking status".
    if SHIP:STATUS = "LANDED" {
        print "Aircraft Status: LANDED".
    }
    if ship:status = "Flying" {
        sas off.
        print "Aircraft Status: FLYING".
        wait 1.
        print "Adjusting Altitude".
        lock throttle to 0.
	    lock steering to heading(NDIR,-20).
        wait until altitude < 1000.
        lock steering to heading(NDIR,0).
    }
}

function doEngineSpec {
    print "Testing engines".
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

function doAutomaticThrottleControl {
    print "Throttle set to Auto".
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
}

function doSetHeading {
    set NDIR to (ship:bearing - 180).   // Sets new direction for heading.
    sas off.
    lock steering to heading(NDIR,0). // Sets new direction with 0 degree climb.
}

function doTakeOff {
    if SHIP:STATUS = "LANDED" {
        brakes off
        when airspeed > 60 then {
            lock steering to heading(NDIR,TWR * 1.5).
        }
        when ship:altitude > 100 then {
            gear off
        }
    }
}

function doTestFlight {}

main().