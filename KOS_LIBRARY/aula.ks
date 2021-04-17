
//VARIABLES
set TA to ship:apoapsis = 100000. //Target apoapsis in meters
set TP to ship:periapsis = 100000. //Target periapsis in meters
set TO to (TA/90).
lock steering to heading (90,TO). //Target direction you want the craft to go
//ANGLE CONTROL - MATHS

until ship:apoapsis <= TA. {
    lock throttle to 0.
}



//Display
print "TARGET APOAPSIS:" + TA + "     " at (5,5).
print "TARGET PERIAPSIS:" + TP + "     " at (5,6).
print "m/degrees" + (TA/90) + "" at (5,7).
print "AP left:" + (TA-ship:altitude) + "" at (5,8).
print "PRESSURE" + round(ship:dynamicpressure) + "" at (5,9).
print "VERT SPEED: " + round(ship:verticalspeed) + "      " at (5,10).
print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,11).
print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,12).
print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,13).
print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,14).




//Variables
SET APOA TO SHIP:apoapsis = 80000.
SET PERI TO SHIP:periapsis = 100000.

//Auto Launch Script - Launch rocket into a orbit of 75000m,
clearScreen.
PRINT "ALP - Booting".
wait 1.
clearscreen.
PRINT "ALP - Starting up".
Wait 1.
clearscreen.
PRINT "Counting down:".
FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 2. 
}
LOCK THROTTLE TO 1.0.
WHEN MAXTHRUST = 0 THEN {
    PRINT "Staging".
    STAGE.
    PRESERVE.
}.
Lock steering to up.

SET MYSTEER TO HEADING(90,90).
LOCK STEERING TO MYSTEER. 
UNTIL SHIP:APOAPSIS = APOA. { //Remember, all altitudes will be in meters, not kilometers

    //For the initial ascent, we want our steering to be straight
    //up and rolled due east
    IF SHIP:VELOCITY:SURFACE:MAG < 100 {
        //This sets our steering 90 degrees up and yawed to the compass
        //heading of 90 degrees (east)
        SET MYSTEER TO HEADING(90,90).

    //Once we pass 100m/s, we want to pitch down ten degrees
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 100 AND SHIP:VELOCITY:SURFACE:MAG < 200 {
        SET MYSTEER TO HEADING(90,85).
        PRINT "Pitching to 85 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 200 AND SHIP:VELOCITY:SURFACE:MAG < 300 {
        SET MYSTEER TO HEADING(90,80).
        PRINT "Pitching to 80 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 300 AND SHIP:VELOCITY:SURFACE:MAG < 400 {
        SET MYSTEER TO HEADING(90,75).
        PRINT "Pitching to 75 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 400 AND SHIP:VELOCITY:SURFACE:MAG < 500 {
        SET MYSTEER TO HEADING(90,70).
        PRINT "Pitching to 70 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 500 AND SHIP:VELOCITY:SURFACE:MAG < 600 {
        SET MYSTEER TO HEADING(90,65).
        PRINT "Pitching to 65 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 600 AND SHIP:VELOCITY:SURFACE:MAG < 700 {
        SET MYSTEER TO HEADING(90,60).
        PRINT "Pitching to 60 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

} ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 800 AND SHIP:VELOCITY:SURFACE:MAG < 900 {
        SET MYSTEER TO HEADING(90,55).
        PRINT "Pitching to 60 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

} ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 900 AND SHIP:VELOCITY:SURFACE:MAG < 1000 {
        SET MYSTEER TO HEADING(90,45).
        PRINT "Pitching to 60 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 1100 AND SHIP:VELOCITY:SURFACE:MAG < 1200 {
        SET MYSTEER TO HEADING(90,11).
        PRINT "Pitching to 20 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    //Beyond 800m/s, we can keep facing towards 10 degrees above the horizon and wait
    //for the main loop to recognize that our apoapsis is above 100km
    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 1200 {
        SET MYSTEER TO HEADING(90,10).
        PRINT "Pitching to 10 degrees" AT(0,15).
        PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

    }.

}.

PRINT "100km apoapsis reached, cutting throttle".

//At this point, our apoapsis is above 100km and our main loop has ended. Next
//we'll make sure our throttle is zero and that we're pointed prograde
LOCK THROTTLE TO 0.

//This sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.