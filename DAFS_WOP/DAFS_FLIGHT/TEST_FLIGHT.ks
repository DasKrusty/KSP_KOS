//POA
// start at 3000 > set climb to 10D > measure at 3000m current speed / alt / fuel consump

function MAIN {
print "TEST FLIGHT".
print "Starting in 3".
wait 1.
print "Starting in 2".
wait 1.
print "Starting in 1".
wait 1.
sas off.
doAutomaticThrottleControl@.
}


function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
}

function doTestFlight {
    sas off.
    set NDIR to (ship:bearing - 180).   //Set new direction for steering
    print "ship bearing is " + ship:bearing.
    set NALT to 2000.
    
    if ship:altitude < 3000. {
        lock steering to heading(NDIR,NALT).
    }
    print "end of test function".
    wait 5.

}

// wait until false.
main().