function doTakeOff {
    //set flaps for quicker take off
    //set engine mode for quicker take off
    wait 0.5.
    lights on.
    wait 3.
    brakes off.
    wait 1.
    doAutomaticThrottleControl(). //Dynamic Throttle Control required
    //INFO_BOX_CONTENT:addlabel("TKO PITCH: " + ROUND(TWR * 1.5) + " Degrees").
    set TWR to availableThrust / ship:mass.
    lock steering to heading(90,TWR * 2).
    when airspeed > 30 then {
    }
    wait until altitude > 500. {
        lock steering to heading(90,TWR * 3).
        ag1 off. //FLAPS
        gear off.
        lights off.
    }
    when altitude > 1000 then {
        lock steering to heading(90,2).
        wait 15.
        set thrott to ((thrott - ship:dynamicpressure) - 0.25).
        set ship:control:pilotmainthrottle to thrott.
        sas on. 
        unlock all.
        wait 1. 
    }
    }