Print "NAME:" + vessel:name + "" at (5,2).
print "Total Fuel" + ship:liquidfuel + "" at (5,3).

set TOTALFUEL to ship:liquidfuel.

lock throttle to 1.
wait 1.
stage.
lock steering to heading(90,10).

//Next section will print the following: Alitude / Speed / Fuel Consumption / Range - ((Speed*3.6)/60)*((Total Fuel/Consumption)/60) 
when ship:altitude <= 3000 then.{
    print "3000m" at (5,4).
    print "S" + vessel:airspeed + "" at (6,4).
    print "C" + ship: + "" at (7,4).
    print "R" + (((vessel:airspeed*3.6)/60)*((TOTALFUEL/engines:Consumption)/60)) + "" at (8,4).
}

PRINT "liquidfuel capacity: " + ROUND(ship_resource("liquidfuel"):CAPACITY,1).

FUNCTION ship_resource {
	PARAMETER resName.
	FOR res in SHIP:RESOURCES {
		IF res:NAME = resName {
			RETURN res.
		}
	}
}

SET myColor TO RGBA(r,g,b,a).
SET myarrow TO VECDRAW.
SET myarrow:VEC to V(10,10,10).
SET myarrow:COLOR to YELLOW.
SET mycolor TO YELLOW.
SET myarrow:COLOR to mycolor.
SET myarrow:COLOR to RGB(1.0,1.0,0.0).

// COLOUR spelling works too
SET myarrow:COLOUR to RGB(1.0,1.0,0.0).

// half transparent yellow.
SET myarrow:COLOR to RGBA(1.0,1.0,0.0,0.5).

PRINT GREEN:HTML. // prints #00ff00

PANELS ON.

WHEN (NOT CHUTESSAFE) THEN {
    CHUTESSAFE ON.
    RETURN (NOT CHUTES).
}

LEGS ON.

PANELS ON.
IF BAYS PRINT "Payload/service bays are ajar!".
SET RADIATORS TO LEGS.

SET GEAR TO ALT:RADAR<1000.
SET LIGHTS TO GEAR.
SET BRAKES TO NOT BRAKES.
RADIATORS ON.
LADDERS ON.
BAYS ON.
DEPLOYDRILLS ON.

//LIQUIDFUEL
// OXIDIZER
// ELECTRICCHARGE
// MONOPROPELLANT
// INTAKEAIR
// SOLIDFUEL

PRINT "There is " + SHIP:LIQUIDFUEL + " liquid fuel on the ship.".
PRINT "There is " + STAGE:LIQUIDFUEL + " liquid fuel in this stage.".
PRINT "There is " + TARGET:LIQUIDFUEL + " liquid fuel in the target ship.".

PRINT SESSIONTIME.        // Returns amount of time, in seconds, from vessel load.

SET PREV_TIME to TIME:SECONDS.
SET PREV_VEL to SHIP:VELOCITY.
SET ACCEL to V(9999,9999,9999).
PRINT "Waiting for accellerations to stop.".
UNTIL ACCEL:MAG < 0.5 {
    SET ACCEL TO (SHIP:VELOCITY - PREV_VEL) / (TIME:SECONDS - PREV_TIME).
    SET PREV_TIME to TIME:SECONDS.
    SET PREV_VEL to SHIP:VELOCITY.

    WAIT 0.001.  // This line is Vitally Important.
}

PRINT "Counting flamed out engines:".
SET numOUT to 0.
LIST ENGINES IN MyList.
FOR eng IN MyList {
    IF ENG:FLAMEOUT {
        set numOUT to numOUT + 1.
    }
}
PRINT "There are " + numOut + "Flamed out engines.".

//circularization script, starts immediately when called.
set th to 0.
lock throttle to th.
set dV to ship:facing:vector:normalized.
lock steering to lookdirup(dV, ship:facing:topvector).
ag1 off. //ag1 to abort

local timeout is time:seconds + 9000.
when dV:mag < 0.05 then set timeout to time:seconds + 3.
until ag1 or dV:mag < 0.02 or time:seconds > timeout {
	set posVec to ship:position - body:position.
	set vecNormal to vcrs(posVec,velocity:orbit).
	set vecHorizontal to -1 * vcrs(ship:position-body:position, vecNormal).
	set vecHorizontal:mag to sqrt(body:MU/(body:Radius + altitude)). //this is the desired velocity vector to obtain circular orbit at current altitude
	
	set dV to vecHorizontal - velocity:orbit. //deltaV as a vector
	
	//Debug vectors
	//set mark_n to VECDRAWARGS(ship:position, vecNormal:normalized * (velocity:orbit:mag / 100), RGB(1,0,1), "n", 1, true).
	set mark_h to VECDRAWARGS(ship:position, vecHorizontal / 100, RGB(0,1,0), "h", 1, true).
	set mark_v to VECDRAWARGS(ship:position, velocity:orbit / 100, RGB(0,0,1), "dv", 1, true).
	set mark_dv to VECDRAWARGS(ship:position + velocity:orbit / 100, dV, RGB(1,1,1), "dv", 1, true).
	
	//throttle control
	if vang(ship:facing:vector,dV) > 1 { set th to 0. }
	else { set th to max(0,min(1,dV:mag/10)). }
	wait 0.
}