lock throttle to 1.0.
lock steering to heading(90,90).

GLOBAL previous_max_thrust IS 0.

WHEN SHIP:MAXTHRUSTAT(0) < previous_max_thrust THEN
    {
    STAGE.
    SET previous_max_thrust TO SHIP:MAXTHRUSTAT(0).
    PRESERVE.
}

function SmartStage {
    list engines in myStage.
    for engines in myStage {
        if engines:in and engines:flameout {
            print ("Staging").  Print "Staging" at (0,0).
            wait .1. stage. wait .1.
            lock throttle to 1.
        }
    }
}

FUNCTION stage_check {	//a check for if the rocket needs to stage and stage if it does
	PARAMETER enableStage IS TRUE.
	LOCAL needStage IS FALSE.
	IF enableStage AND STAGE:READY {
		LOCAL engineList IS LIST().
		LIST ENGINES IN engineList.
		SET needStage TO MAXTHRUST = 0.
		FOR engine IN engineList {
			IF needStage { BREAK. }
			SET needStage TO needStage OR engine:FLAMEOUT.
		}
		IF needStage	{ STAGE. }
	}
	RETURN needStage.
}


set TargetAP to 100000. //Chosen target for ship to reach
when ship:apoapsis = TargetAP then {
	Lock throttle to 0.
	unlock steering.
}

//PRINTS
print ship:body:name. // shows kerbin
print ship:body:mass. // shows kerbin's mass
print ship:body:radius. // shows kerbin's radius
print ship:body:mu. // shows kerbin's gravitational parameter

wait until false.

//FOR SATTELITES
lock steering to heading(-90,0).
wait until false.

SET THROTT TO 1.
SET DTHROTT TO 0.
LOCK THROTTLE TO THROTT.
LOCK STEERING TO R(0,0,-90) + HEADING(90,90).
STAGE.
WHEN SHIP:ALTITUDE > 1000 THEN {
    SET g TO KERBIN:MU / KERBIN:RADIUS^2.
    LOCK accvec TO SHIP:SENSORS:ACC - SHIP:SENSORS:GRAV.
    LOCK gforce TO accvec:MAG / g.
    LOCK DTHROTT TO 0.05 * (1.2 - gforce).
}
UNTIL SHIP:ALTITUDE > 40000 {
    SET thrott to thrott + dthrott.
    WAIT 0.1.
}