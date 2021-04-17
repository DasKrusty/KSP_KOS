//POA -
//Staging correctly
//gravity turn
//make orbit at desired height
//control speed to not overspeed
//print info

//TARGETS
set TAAP to 75000. //This is the target Ap
set TAPO to 75000. //This is the target Po
set DIR to 135.      //This is the desired direction required
//TARGETS

//VARIABLES
//set ITAP to 75000. //This is the initial Ap
//set ITPO to 75000. //This is the initial Po
//VARIABLES

//PRE-LAUNCH SETUP
clearscreen.
print "ALP - SYSTEMS BOOTING" at (3,3).
wait 3.
//PRE-LAUNCH SETUP

//LAUNCH
print "ALP - SYSTEMS ENGAGED" at (3,4).
wait 1.
lock throttle to 1.
PRINT "COUNTING DOWN:" at (3,5).
FROM {local countdown is 3.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown at (3,6).
wait 3.
lock steering to heading(DIR,90).
}
wait 2.
clearScreen.
//LAUNCH

//STAGING SYSTEM
set OMT to SHIP:availablethrust. // OMT = Old MaxThrust
when ship:availablethrust < (OMT) then {
    print "STAGING" at (1,1).
    wait 1.
    stage.
    wait 2.
    set OMT to ship:availablethrust.
    wait 3.
    print "WAITING" at (1,1).
    preserve.
}

when ship:maxthrust = 0 then {
    wait 1.
    stage.
    print "ERROR... CHECK STAGING" at (1,1).
    preserve.
}
//STAGING SYSTEM

//TURN SYSTEM
set MODE to 2.
if alt:radar < 50 {
    set MODE to 1.
}

until MODE = 0 {
    if MODE = 1 {
        lock steering to heading(DIR,90).
        set TVAL to 1.                       
        set MODE to 2.
    }
    else if MODE = 2 {
        lock steering to heading (DIR,90).
        set TVAL to 1.
        if SHIP:ALTITUDE > 10000 { 
            set MODE to 3.
            }
        }
    else if MODE = 3 {
        set targetPitch to max( 5, 90 * (1 - ALT:RADAR / 50000)). 
        lock steering to heading ( DIR, targetPitch).
        set TVAL to 1.
        if SHIP:APOAPSIS > TAAP {
            set MODE to 4.
            }
        }
    else if MODE = 4 {
        lock steering to heading ( DIR, 3). 
        set TVAL to 0.
        if (SHIP:ALTITUDE > 70000) and (ETA:APOAPSIS > 60) and (VERTICALSPEED > 0) {
            if WARP = 0 {
                wait 1.         
                SET WARP TO 3.
                }
            }.
        else if ETA:APOAPSIS < 60 {
            SET WARP to 0.
            set MODE to 5.
            }
        }
    else if MODE = 5 {
        if ETA:APOAPSIS < 5 or VERTICALSPEED < 0 {
            }
        if (SHIP:PERIAPSIS > TAPO) or (SHIP:PERIAPSIS > TAAP * 0.95) {
            set TVAL to 0.
            set MODE to 10.
            }
        } 
    else if MODE = 10 { 
        set TVAL to 0. 
        panels on. 
        lights on.
        unlock steering.
        print "SHIP SHOULD NOW BE IN SPACE!".
        set MODE to 0.
        }    
    if stage:Liquidfuel < 1 {
        lock throttle to 1.
        wait 1.
        stage.
        wait 1.
        lock throttle to TVAL.
        }
    set finalTVAL to TVAL.
    lock throttle to finalTVAL.  
//PRINTOUTS
Print "SHIP NAME: " + shipName + "" at (3,3).
Print "TARGET AP = " + TAAP + "m" at (3,5).
Print "TARGET PE = " + TAPO + "m" at (3,6).
print "DYNAMIC PRESS = " + round(ship:dynamicpressure) + "KpA" at (3,8).
print "MODE:    " + MODE + "      " at (3,9).
print "VERT SPEED: " + round(ship:verticalspeed) + "      " at (3,10).
print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "m" at (3,11).
print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "m" at (3,12).
print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "m" at (3,13).
print "ETA to AP:  " + round(ETA:APOAPSIS) + "seconds" at (3,14).
//PRINTOUTS 
}

until false.