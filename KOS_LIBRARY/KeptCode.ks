//TWR
lock throttle to DesiredTWR * Ship:Mass * g / Ship:AvailableThrust  //TWR code
If ship:availablethrust > 0 { do what I said up there } else lock throttle to 0.
//
set throttle to SHIP.MASS / SHIP.MAXTHRUST 
Function Findg
{
	Parameter A.
	Set GM to Constant():G * Body:Mass.
	Set R to A + Body:Radius.
	Set g to GM/(R^2).
	Return g.
}

Function SetThrottleTWR
{
	Parameter TWR.
	If Ship:AvailableThrust > 0
	{
		Set tVal to TWR * Findg(Altitude) * (Ship:Mass/Ship:AvailableThrust).
		If tVal > 1	{Set tVal to 1.}
		Lock Throttle to tVal.
	}
}
//
//TWR

//GUI
local gui is gui(400).
gui:addlabel("enter target apoapsis height").
gui:addtextfield("70000").
local somebutton is gui:addbutton("confirm").

set somebutton:onclick to Continue@.

gui:show()
set DoneYet to false.
wait until DoneYet is true.

Function Continue {
  gui:hide().
  set DoneYet to true.
}


//Consumption
I'm able to calculate the fuel flow rate given by the dialog box that appears by right clicking on the engine by the formula thrust/(ISP*g). Which means for a mainsail at full throttle near the ground with a ISP of 281 gives a fuel flow 0.5436U accordingly.
LIST ENGINES IN myVariable.
FOR eng IN myVariable {
    print "An engine exists with ISP = " + eng:ISP.
}.

print Engine:fuelflow.


// Scrolling print
SET printList TO LIST().
FUNCTION scrollPrint {
    DECLARE PARAMETER nextPrint.
    printList:ADD(nextPrint).
    UNTIL printList:LENGTH <= maxLinesToPrint {printList:REMOVE(0).}.
    LOCAL currentLine IS listLineStart.
    FOR printLine in printList {
        PRINT "                                                 " AT (0,currentLine).
        PRINT printLine AT (0,currentLine).
        SET currentLine TO currentLine+1.
    }.
}.

PRINT " Current Mode =" AT (1,0).
PRINT "==================================================" AT (0,2).
PRINT "Sea Lvl.        | Ground         | Orbit" AT (0,3).
PRINT "  Alt.          |  Dist.         | Incl." AT (0,4).
PRINT "  [km]          |  [km]          | [deg]" AT (0,5).
PRINT "----------------+----------------+----------------" AT (0,6).
PRINT "Apoap.          |Periap.         |  TWR" AT (0,7).
PRINT " [km]           | [km]           |Max TWR" AT (0,8).
PRINT " (ETA)          | (ETA)          |% Term V" AT (0,9).
PRINT "----------------+----------------+----------------" AT (0,10).
PRINT " Total          | Stage          | Spent" AT (0,11).
PRINT "Vac. dV         |  dV            |  dV" AT (0,12).
PRINT " [m/s]          | [m/s]          | [m/s]" AT (0,13).
PRINT "==================================================" AT (0,14).

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