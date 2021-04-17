//Script to test planes
//PROCESS: Start / Climb at 10 and print every 1000m / When reach max alt go down to 1000m / find max climb rate

//START//
lock steering to heading(90,10).
lock throttle to 1.
set newalt to 1000.
set totfuel to ship:liquidfuel.

when altitude > newalt then {
    print "ALT: " + altitude + "m".
    print "SPE: " + airspeed + "m/s".
    print "Km/h: " + (airspeed * 3.6 / 60) + "km/h".
    print "MAT: " + maxThrust + "Kw".
    print "FUE: " + totfuel + "L".
    print "" + ship:liquidfuel + "".
    PRINT "There is " + SHIP:LIQUIDFUEL + " liquid fuel on the ship.".
    PRINT "There is " + STAGE:LIQUIDFUEL + " liquid fuel in this stage.".
    wait 3.
    set newalt to (newalt + 1000).
    preserve.
}

when 