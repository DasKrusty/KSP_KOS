// DASlaunch.ks - DasKrusty Ver.1.0 Automated Launch System - STATUS - Incomplete
// Modules COMPLETED    - Prelaunch / Launch / GravTurn / Autostage / Throttle / Orbit
// Modules INCOMPLETE   - Print - Continously print info

//TARGET FLIGHT
set TDi to 90.          //Target Direction - 90 = East / 180 = South...
set TAo to 150000.      //Target Aoapsis
set TCT to 1.0.      //Throttle Control for Thrust
//TARGET FLIGHT

function Main{
    doPreLaunch().
    doLaunch().
    doAscent().
    doAutoStage().
    until apoapsis > (TAo + (TAo / 100 * 0.5)). {doShutDown().}
    wait 3.
    set mapview to true.
    doORBIT().
    set mapview to false.
}

function doPreLaunch{ //Sets up the script for launch and prettys
    wait 1.
    print "".
    print "========================================".
    print "Script is based off Cheers Kevin Youtube ".
    print "series, thanks Kev!".
    print "========================================".
    wait 5.
    clearScreen.
    wait 1.
    print "=========================================" at (3,0).
    print "DasKrusty Ver.1.0 Automated Launch System " at (3,1).
    print "=========================================" at (3,2).
    wait 1.
    print "VESSEL NAME: " + shipName at (3,3).
    wait 1.
    print "STATUS: Pre Launch" at(3,4).
    wait 2.
    print "STATUS: Setting Dynamic Throttle" at(3,4). 
    doThrottle().
}

function doLaunch { //Handles the launch and direction
    wait 2.
    print "".
    PRINT "STATUS: Counting Down: ...." at (3,4).
    Wait 1. print "STATUS: Counting Down: 3......" at(3,4).
    wait 1. print "STATUS: Counting Down: 2......" at(3,4).
    wait 1. print "STATUS: Counting Down: 1......" at(3,4).
    wait 1.
    doSafeStage ().
    print "STATUS: Launch!" at(3,4).
    wait 3.
    print "STATUS: Aligning Direction and Pitch" at(3,4).
    lock steering to heading(TDi,90).
}

function doPrint{
    print "STAGE: " + stage:number at(5,6).
    print "Apoapsis ETA: " + ETA:apoapsis + "m" at(5,6).
}

function doAscent { //Handles turn into space 
    wait 3.
    print "" at(3,4).
    print "STATUS: Gravity Turn Initiated" at(3,4).
    lock TPi to 88.963 - 1.03287 * alt:radar^0.359511.
    lock steering to heading(TDi,TPi).
    doPrint().
}

function doThrottle { //Controls the Throttle
    SET srfGrav TO BODY:mu / BODY:RADIUS^2.
    SET desiredSrfTWR TO TCT.
    LOCK THROTTLE TO SHIP:AVAILABLETHRUST/(SHIP:MASS*srfGrav*desiredSrfTWR).
}

function doAutoStage {
    set OMT to SHIP:availablethrust. // OMT = Old MaxThrust
    when ship:availablethrust < (OMT) then {
        wait 1.
        print "STATUS: STAGING" at(3,4).
        stage.
        doThrottle().
        wait 2.
        print "STATUS: WAITING" at(3,4).
        wait 1.
        set OMT to ship:availablethrust.
        wait 1.
        preserve.
    }
    when ship:maxthrust = 0 then {
        wait 1.
        stage.
        preserve.
    }
}

function doSafeStage {
    wait until stage:READY.
    stage.
}

function doShutDown {
print "STATUS: REACHED AP" at(3,4).
lock throttle to 0.
lock steering to prograde.

}

function doOrbit {
  local circ is list(0).
  set circ to improveConverge(circ, eccentricityScore@).
  wait until altitude > 70000.
  executeManeuver(list(time:seconds + eta:apoapsis, 0, 0, circ[0])).
}

function eccentricityScore {
  parameter data.
  local mnv is node(time:seconds + eta:apoapsis, 0, 0, data[0]).
  addManeuverToFlightPlan(mnv).
  local result is mnv:orbit:eccentricity.
  removeManeuverFromFlightPlan(mnv).
  return result.
}

function improveConverge {
  parameter data, scoreFunction.
  for stepSize in list(100, 10, 1) {
    until false {
      local oldScore is scoreFunction(data).
      set data to improve(data, stepSize, scoreFunction).
      if oldScore <= scoreFunction(data) {
        break.
      }
    }
  }
  return data.
}

function addManeuverToFlightPlan {
  parameter mnv.
  add mnv.
}

function improve {
  parameter data, stepSize, scoreFunction.
  local scoreToBeat is scoreFunction(data).
  local bestCandidate is data.
  local candidates is list().
  local index is 0.
  until index >= data:length {
    local incCandidate is data:copy().
    local decCandidate is data:copy().
    set incCandidate[index] to incCandidate[index] + stepSize.
    set decCandidate[index] to decCandidate[index] - stepSize.
    candidates:add(incCandidate).
    candidates:add(decCandidate).
    set index to index + 1.
  }
  for candidate in candidates {
    local candidateScore is scoreFunction(candidate).
    if candidateScore < scoreToBeat {
      set scoreToBeat to candidateScore.
      set bestCandidate to candidate.
    }
  }
  return bestCandidate.
}

function executeManeuver {
  parameter mList.
  local mnv is node(mList[0], mList[1], mList[2], mList[3]).
  addManeuverToFlightPlan(mnv).
  local startTime is calculateStartTime(mnv).
  warpto(startTime - 15).
  rcs on.
  wait until time:seconds > startTime - 10.
  lockSteeringAtManeuverTarget(mnv).
  wait until time:seconds > startTime.
  lock throttle to 1.
  until isManeuverComplete(mnv) {
    doAutoStage().
    wait 60.
    if ismaneuvercomplete(mnv) = false {
      doEnd().
    }
  }
  removeManeuverFromFlightPlan(mnv).
  doEnd().
}

function calculateStartTime {
  parameter mnv.
  return time:seconds + mnv:eta - maneuverBurnTime(mnv) / 2.
}

function lockSteeringAtManeuverTarget {
  parameter mnv.
  lock steering to mnv:burnvector.
}

function isManeuverComplete {
  parameter mnv.
  if not(defined originalVector) or originalVector = -1 {
    declare global originalVector to mnv:burnvector.
  }
  if vang(originalVector, mnv:burnvector) > 90 {
    declare global originalVector to -1.
    return true.
  }
  return false.
}

function maneuverBurnTime {
  parameter mnv.
  local dV is mnv:deltaV:mag.
  local g0 is 9.80665.
  local isp is 0.

  list engines in myEngines.
  for en in myEngines {
    if en:ignition and not en:flameout {
      set isp to isp + (en:isp * (en:availableThrust / ship:availableThrust)).
    }
  }

  local mf is ship:mass / constant():e^(dV / (isp * g0)).
  local fuelFlow is ship:availableThrust / (isp * g0).
  local t is (ship:mass - mf) / fuelFlow.

  return t.
}

function removeManeuverFromFlightPlan {
  parameter mnv.
  remove mnv.
}

function doEnd {
    set mapview to false.
    rcs off.
    wait 1.
    sas on.
    print "LOCKING TO PROGRADE".
    lock steering to prograde.
    print "PROCEDURES COMPLETED".
    wait 1.
    print "GOODBYE".
    wait 1.
    core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
    removeManeuverFromFlightPlan(mnv).
    wait 1.
    shutdown.
    
}

main().