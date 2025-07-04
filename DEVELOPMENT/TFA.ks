// DusKrusty's Test Flight Aircraft Script
// This script is to test new aircraft to find out their capabilities with regards to speed vs ceiling.
// Version: 1.29

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
        set NDIR to (ship:bearing - 180).
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
    set NALT to 1000
    lock steering to heading(NDIR,0). // Sets new direction with 0 degree climb.
}

function doTakeOff {
    if SHIP:STATUS = "LANDED" {
        brakes off.
        when airspeed > 60 then {
            lock steering to heading(NDIR,TWR * 1.5).
        }
        when ship:altitude > 100 then {
            gear off.
        }
    }
}

function doTestFlight {
    set OSPE to airspeed.
    lock steering to heading(NDIR,TWR * 1.5).
    when ship:altitude >= NALT then {
        lock steering to heading(NDIR,0).
        wait 60.
        print ("Alt: " + ship:altitude).
        print ("Spe: " + airspeed).
        set OALT to ship:altitude.
        set NSPE to airspeed.
            if OSPE > NSPE {
                print "Aircraft has reached optimal speeds and ceiling".
                wait 1.
                print "Test Completed".
                wait 1.
                print ("Alt: " + ship:altitude).
                print ("Spe: " + airspeed).
            }
            if NSPE > OSPE {
                print "Preparing next test".
                wait 1.
                set NALT to OALT + 1000.
                doTestFlight().
            }   
    }
}

main().