// ---TEST BENCH--- //

function main {
    doTESTFLIGHT().
}

function doTESTFLIGHT{
    set NDIR to (ship:bearing - 180).   //Set new direction for steering
    set NSPE to airspeed.
    set NALT to 3000.
    doAutomaticThrottleControl().
    doENGINESPEC().
    sas off.
    lock steering to heading(NDIR,45).
    until altitude<NALT{
        print "Altitude: "+round(NALT)+" m".
        print "Speed: "+round((NSPE*100)/60)+" km/h".
        print "Thrust"+round(availableThrust)+" Kw".

    }

function doENGINESPEC{
LIST ENGINES IN myVariable.
FOR eng IN myVariable {print "Max Thrust: " + eng:thrust.}
wait 0.25.
INFO_BOX_CONTENT:addlabel("Total Fuel: " + ROUND(ship:liquidfuel)).
wait 0.25.
INFO_BOX_CONTENT:addlabel("Thrust: " + ROUND(availableThrust) + " Kw").
wait 0.25.
set TWR to availableThrust / ship:mass.
INFO_BOX_CONTENT:addlabel("TWR: " + ROUND(availableThrust / ship:mass)).
wait 0.5.
lock throttle to 0.
}

function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
    }

}

main().