
//Printing content
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

//Consumption
I'm able to calculate the fuel flow rate given by the dialog box that appears by right clicking on the engine by the formula thrust/(ISP*g). Which means for a mainsail at full throttle near the ground with a ISP of 281 gives a fuel flow 0.5436U accordingly.
LIST ENGINES IN myVariable.
FOR eng IN myVariable {
    print "An engine exists with ISP = " + eng:ISP.
}.

print Eng:fuelflow.



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


    //Printing
    function displayWidgetFactory {
  parameter parentWidget, labelName, updateDisplay.

  // set up widgets  
  local hBox to parentWidget:addHBox().
  local labelBox to hBox:addLabel("Altitude").
  local valueBox to hBox:addLabel(updateDisplay()).
  
  function update {
    set valueBox:text to updateDisplay().
  } 

  return lexicon( "update", update@ ).
}

// used like this:
local mygui to GUI(500).
local altitudeDisplay to displayWidgetFactory(mygui, "altitude", {return ship:altitude.}).
mygui:show().

// then later to refresh the display:
altitudeDisplay:update().