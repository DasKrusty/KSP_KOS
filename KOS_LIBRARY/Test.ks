LIST ENGINES IN engines.
 
 
 
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      ### 
                      # # 
                      ### 
                        # 
                      ### ".
wait 1.
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      ### 
                      # # 
                      ### 
                      # # 
                      ### ".
wait 1.
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      ### 
                        # 
                        # 
                        # 
                        # ".
wait 1.
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      ### 
                      #   
                      ### 
                      # # 
                      ### ".
wait 1.
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      ### 
                      #   
                      ### 
                        # 
                      ### ".
wait 1.
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      # # 
                      # # 
                      ### 
                        # 
                        # ".
wait 1.
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      ### 
                        # 
                      ### 
                        # 
                      ### ".
wait 1.
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      ### 
                        # 
                      ### 
                      #   
                      ### ".
wait 1.
lock steering to up + R(0,0,180).
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                        # 
                        # 
                        # 
                        # 
                        # ".
wait 1.
lock throttle to 1.
clearscreen.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                      ### 
                      # # 
                      # # 
                      # # 
                      ### ".
wait 1.
clearscreen.
stage.
print "
 
 
 
 
 
 
 
 
 
 
 
 
 
 
                                                  
            #    #  # # ###  ## # #  #  
            #   # # # # # # #   # #  #  
            #   ### # # # # #   ###  #  
            #   # # # # # # #   # #     
            ### # # ### # #  ## # #  # ".
wait 1.
clearscreen.
 
set orbitalt to 2868.75*1000.
 
until altitude > 1000
{
clearscreen.
print "##################CONTROL PANEL##################".
print " First step: reach middle atmosphere.".
print " ".
print "      ALTITUDE: " + round(ALTITUDE, 2).
print "     TO GROUND: " + round(ALT:RADAR,2).
print "-------------------------------------------------".
print "VERTICAL SPEED: " + round(VERTICALSPEED,2).
print "      APOAPSIS: " + round(APOAPSIS,2).
wait .5.
if maxthrust = 0 { stage. print "Staging...". wait 2. stage.}
 
SET stageneeded TO false.
FOR eng IN engines {
    
    if eng:flameout and eng:thrust = 0
    {
        set stageneeded to true.
    }
}.
if stageneeded {stage. print "Stage separeted.". wait 2. list engines in engines.}.
}
lock steering to up + R(0,0,180) + R(0,-30,0).
 
until altitude > 20000
{
clearscreen.
print "##################CONTROL PANEL##################".
print " Second step: begin gravity turn.".
print " ".
print "      ALTITUDE: " + round(ALTITUDE, 2).
print "     TO GROUND: " + round(ALT:RADAR,2).
print "-------------------------------------------------".
print "VERTICAL SPEED: " + round(VERTICALSPEED,2).
print "      APOAPSIS: " + round(APOAPSIS,2).
wait .5.
if maxthrust = 0 { stage. print "Staging...". wait 2. stage.}
 
SET stageneeded TO false.
FOR eng IN engines {
    
    if eng:flameout and eng:thrust = 0
    {
        set stageneeded to true.
    }
}.
if stageneeded {stage. print "Stage separeted.". wait 2. list engines in engines.}.
}
lock steering to up + R(0,0,180) + R(0,-60,0).
 
until apoapsis > orbitalt-orbitalt/5
{
clearscreen.
print "##################CONTROL PANEL##################".
print " Third step: target apoapsis = "+ round(orbitalt/1000,0) + "km".
print " ".
print "      ALTITUDE: " + round(ALTITUDE, 2).
print "     TO GROUND: " + round(ALT:RADAR,2).
print "-------------------------------------------------".
print "VERTICAL SPEED: " + round(VERTICALSPEED,2).
print "      APOAPSIS: " + round(APOAPSIS,2).
wait .5.
if maxthrust = 0 { stage. print "Staging...". wait 2. stage.}
 
SET stageneeded TO false.
FOR eng IN engines {
    
    if eng:flameout and eng:thrust = 0
    {
        set stageneeded to true.
    }
}.
if stageneeded {stage. print "Stage separeted.". wait 2. list engines in engines.}.
}
clearscreen.
print "Wait please...".
 
lock throttle to 0.3.
wait until apoapsis > orbitalt-orbitalt/10.
lock throttle to 0.05.
wait until apoapsis >= orbitalt-orbitalt/20.
lock throttle to 0.01.
wait until apoapsis >= orbitalt.
 
print "ENGINE OFF".
lock throttle to 0.
print "STANDBY UNTIL APOAPSIS.".
wait until altitude > 76000.
 
print "Extending solar panels...".
PANELS ON.
 
print "Start orbit adjustament program...".
 
set orbitalvelocity to sqrt(((3.5316*10^12)/(orbitalt+600000)^2)*(600000+orbitalt)).
 
print "Orbital Velocity = " + round(orbitalvelocity,1) + "m/s".
 
SET deltav TO orbitalvelocity-(velocityat(ship, time:seconds+(eta:apoapsis)):orbit:mag).
 
SET node TO NODE(time:seconds+eta:apoapsis, 0, 0, deltav).
ADD node.
 
print "Maneuver node planned.".
 
lock throttle to 0.
unlock throttle.
unlock steering.
 
run execnode.
 
lock throttle to 0.
unlock throttle.
unlock steering.
if ship:maxthrust < 1. {stage.}

when altitude = APOA then {
    lock throttle to 0.
}

//TARGETING
set APOA to ship:apoapsis = 75000. //Initial apoapsis to reach - can but dont change
//TARGETING


when TA = (TA) then {
    lock throttle to 0.
    preserve.
}


set EA to 75000. //END APOAPSIS - Desired Apoapsis
set AD to (EA)/90. //ALTITUDE DEGREE - This is END APOAPSIS divided by starting degree = 833.33
set CD to (90-(ship:altitude/(AD))). //CURRENT DEGREE - Example (90-(10000/833.33)) = 77 degrees
lock steering to heading(90,CD). //Heading should now be Heading(90,77)

PRINT "THESE ARE ALL THE RESOURCES active in this stage:".
SET RESLIST TO STAGE:RESOURCES.
FOR RES IN RESLIST {
    PRINT "Resource " + RES:NAME.
    PRINT "    value = " + RES:AMOUNT.
    PRINT "    which is "
          + ROUND(100*RES:AMOUNT/RES:CAPACITY)
          + "% full.".
}.

// Continuous informational printouts
    PRINT ROUND(ALTITUDE/1000,2)+" "   AT (8,4).
    SET downRangeDist TO SQRT(launchLoc:Distance^2 - (ALTITUDE-launchAlt)^2). // #@ should update to use curvature
    PRINT ROUND(downRangeDist/1000,2)+" " AT (25,4).
    PRINT ROUND(SHIP:OBT:INCLINATION,1)+"  " AT (44,4).
    PRINT ROUND(APOAPSIS/1000,2)+" " AT (8,8).
    PRINT ROUND(ETA:APOAPSIS) + "s " AT (9,9).
    PRINT ROUND(PERIAPSIS/1000,2)+"  " AT (24,8).
    PRINT ROUND(ETA:PERIAPSIS) + "s " AT (26,9).
    SET engInfo TO activeEngineInfo().
    SET currentTWR TO engInfo[0]/(SHIP:MASS*BODY:MU/(ALTITUDE+BODY:RADIUS)^2).
    SET maxTWR TO engInfo[1]/(SHIP:MASS*BODY:MU/(ALTITUDE+BODY:RADIUS)^2).
    PRINT ROUND(currentTWR,2)+"   " AT (44,7).
    PRINT ROUND(maxTWR,2) + "  " AT (44,8).
    IF pctTerminalVel = "N/A" OR pctTerminalVel = "NoAcc" {
        PRINT pctTerminalVel + "  " AT (44,9).
    }.
    ELSE {
        PRINT ROUND(pctTerminalVel,0) + "  " AT (44,9).
    }.
    SET shipDeltaV TO "TBD". // ## TODO
    PRINT shipDeltaV AT (9,12).
    SET stageDeltaV TO deltaVStage().
    PRINT ROUND(stageDeltaV)+" " AT (26,12).
    IF lastDVTime < TIME:SECONDS AND finalBurnTime = 0 {
        SET dVSpent TO dVSpent + ((engInfo[0]/SHIP:MASS) * (TIME:SECONDS - lastDVTime)).
        SET lastDVTime TO TIME:SECONDS.
    }
    ELSE IF finalBurnTime > 0 {
        SET dVSpent TO dVSpent + ((engInfo[1]/SHIP:MASS) * finalBurnTime).
    }.
    PRINT ROUND(dVSpent,0) + "   " AT (44,12).

    //first.ks
// This program launches a ship from the KSC and flies it into orbit

//Set the ship to a known configuration
SAS off.
RCS on.
lights on.
lock throttle to 0. //Throttle is a decimal from 0.0 to 1.0
gear off.

clearscreen.

set targetApoapsis to 150000. //Target apoapsis in meters
set targetPeriapsis to 150000. //Target periapsis in meters

set runmode to 2. //Safety in case we start mid-flight
if ALT:RADAR < 50 { //Guess if we are waiting for take off
    set runmode to 1.
    }



until runmode = 0 { //Run until we end the program

    if runmode = 1 { //Ship is on the launchpad
        lock steering to UP.  //Point the rocket straight up
        set TVAL to 1.        //Throttle up to 100%
        stage.                //Same thing as pressing Space-bar
        set runmode to 2.     //Go to the next runmode
        }

    else if runmode = 2 { // Fly UP to 10,000m
        lock steering to heading (90,90). //Straight up.
        set TVAL to 1.
        if SHIP:ALTITUDE > 10000 { 
            //Once altitude is higher than 10km, go to Gravity Turn mode
            set runmode to 3.
            }
        } //Make sure you always close out your if statements.

    else if runmode = 3 { //Gravity turn
        set targetPitch to max( 5, 90 * (1 - ALT:RADAR / 50000)). 
            //Pitch over gradually until levelling out to 5 degrees at 50km
        lock steering to heading ( 90, targetPitch). //Heading 90' (East), then target pitch
        set TVAL to 1.

        if SHIP:APOAPSIS > targetApoapsis {
            set runmode to 4.
            }
        }
    
    else if runmode = 4 { //Coast to Ap
        lock steering to heading ( 90, 3). //Stay pointing 3 degrees above horizon
        set TVAL to 0. //Engines off.
        if (SHIP:ALTITUDE > 70000) and (ETA:APOAPSIS > 60) and (VERTICALSPEED > 0) {
            if WARP = 0 {        // If we are not time warping
                wait 1.         //Wait to make sure the ship is stable
                SET WARP TO 3. //Be really careful about warping
                }
            }.
        else if ETA:APOAPSIS < 60 {
            SET WARP to 0.
            set runmode to 5.
            }
        }

    else if runmode = 5 { //Burn to raise Periapsis
        if ETA:APOAPSIS < 5 or VERTICALSPEED < 0 { //If we're less 5 seconds from Ap or loosing altitude
            set TVAL to 1.
            }
        if (SHIP:PERIAPSIS > targetPeriapsis) or (SHIP:PERIAPSIS > targetApoapsis * 0.95) {
            //If the periapsis is high enough or getting close to the apoapsis
            set TVAL to 0.
            set runmode to 10.
            }
        }

    else if runmode = 10 { //Final touches
        set TVAL to 0. //Shutdown engine.
        panels on.     //Deploy solar panels
        lights on.
        unlock steering.
        print "SHIP SHOULD NOW BE IN SPACE!".
        set runmode to 0.
        }

    //Housekeeping
    if stage:Liquidfuel < 1 { //Stage if the stage is out of fuel
        lock throttle to 0.
        wait 2.
        stage.
        wait 3.
        lock throttle to TVAL.
        }

    set finalTVAL to TVAL.
    lock throttle to finalTVAL. //Write our planned throttle to the physical throttle

    //Print data to screen.
    print "RUNMODE:    " + runmode + "      " at (5,4).
    print "ALTITUDE:   " + round(SHIP:ALTITUDE) + "      " at (5,5).
    print "APOAPSIS:   " + round(SHIP:APOAPSIS) + "      " at (5,6).
    print "PERIAPSIS:  " + round(SHIP:PERIAPSIS) + "      " at (5,7).
    print "ETA to AP:  " + round(ETA:APOAPSIS) + "      " at (5,8).
    
    }