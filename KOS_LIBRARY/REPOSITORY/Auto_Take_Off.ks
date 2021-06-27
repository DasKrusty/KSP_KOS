function doTakeOff {
    wait 0.5.
    lights on.
    wait 3.
    brakes off.
    wait 1.
    doAutomaticThrottleControl().
    set NDIR to (ship:bearing - 180).   //Set new direction for steering
    sas off.
    lock steering to heading(NDIR,TWR * 1.5).
    when airspeed > 30 then {
    }
    wait until altitude > 500. {
        lock steering to heading(NDIR,TWR * 2).
        ag1 off. //FLAPS
        gear off.
        lights off.
    }
    when altitude > 1000 then {
        lock steering to heading(NDIR,2).
        wait 20.
        set thrott to ((thrott - ship:dynamicpressure) - 0.35).
        set ship:control:pilotmainthrottle to thrott.
        sas on. 
        unlock all.
        wait 1.
    }
    }