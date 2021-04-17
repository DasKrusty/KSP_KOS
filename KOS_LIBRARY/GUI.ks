

//TRIGGERS
LOCAL isDone IS FALSE.
set TKO:onclick to doTakeOff@. // Takeoff
set XBU:onclick to doGUIHide@. // Hides GUI
set ATC:ONCHANGE to doAutomaticThrottleControl@.
wait until isDone.
//TRIGGERS





//TAKEOFF
function doTakeOff {
    //add check to see if airborne - apply true/false
    //HUDTEXT("TAKE OFF MODE: Activated", 5, 2, 15, red, false).
    clearScreen.
    doPreCheck().
    doLift().
}

function doPreCheck {
    if ship:altitude > 10 {
        print "AIRBORNE ALREADY DUMBASS".
    }
    sas off.
    Print "NAME:" + ship:name.
    print "READING CRAFT STATS".
    wait 1.
    print "starting precheck".
    lock throttle to 1.
    brakes on.
    stage.
    LIST ENGINES IN myVariable.
    FOR eng IN myVariable {print "Thrust: " + eng:thrust.}
    print "Available Thrust: " + availableThrust.
    set TWR to availableThrust / ship:wetmass.
    print "TWR: " + ROUND(availableThrust / ship:wetmass).
    print "Total Fuel: " + ROUND(ship:liquidfuel).
    print "TKO PITCH: " + ROUND(TWR * 1.5) + " Degrees".
    wait 2.
    lock throttle to 0.
    ag1 on.                             //AG1 is flaps
    lights on.
    lock steering to heading(90,0).    //Initial setting
    wait 3.
    print "precheck done".
}

function doThrott {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
}

function doLift {
    sas off.
    Print "NAME:" + ship:name.
    print "READING CRAFT STATS".
    wait 1.
    print "starting precheck".
    lock throttle to 1.
    brakes on.
    stage.
    LIST ENGINES IN myVariable.
    FOR eng IN myVariable {print "Thrust: " + eng:thrust.}
    print "Available Thrust: " + availableThrust.
    set TWR to availableThrust / ship:wetmass.
    print "TWR: " + ROUND(availableThrust / ship:wetmass).
    print "Total Fuel: " + ROUND(ship:liquidfuel).
    print "TKO PITCH: " + ROUND(TWR * 1.5) + " Degrees".
    wait 2.
    lock throttle to 0.
    ag1 on.                             //AG1 is flaps
    lights on.
    lock steering to heading(90,0).    //Initial setting
    wait 3.
    print "precheck done".
    brakes off.
    wait 1.
    doThrott().
    lock steering to heading(90,TWR * 2).
    print "Starting Roll".
    when airspeed > 30 then {
        print "Taking Off".
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
        print "TAKEOFF COMPLETE".  
        unlock all.
    }
}

doTakeOff().
//TAKEOFF

//AUTOMATIC THROTTLE CONTROL
function doAutomaticThrottleControl {
    parameter newValue.

  print "Value is " +
         round(100*(newValue-mySlider:min)/(mySlider:max-mySlider:min)) +
         "percent of the way between min and max.".
}
//AUTOMATIC THROTTLE CONTROL

//HIDE GUI
function doGUIHide {
    gui:hide(). //hides GUI
}
//HIDE GUI
wait until false.