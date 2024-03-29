//for a 2-stage to orbit vessel. Working for most of my rockets with some adjustments.
{
set TrgH to 15e4. //orbit altitude at starting body.
set tollerance to TrgH*.04.
Lock Myspeed to Verticalspeed.
set phaseiii_pitch to 45.
set pit_PID to PID_Init(0.03, 0.001, 0.0003, -phaseiii_pitch, phaseiii_pitch).
set phasei_pitch to 15.
set pit_noneg_PID to PID_Init(0.81, 0.0, 0.03, -phasei_pitch, phasei_pitch).
set pit_PID_p1 to PID_Init(0.0018, 0.001, 0.005, -phasei_pitch, 3).
Clearscreen.
set curT to 0.
Lock throttle to curT.
set curS TO Heading(90,90).
LOCK Steering to curS.
set n-Count to 3. //iterations for Countdown
global Flightprogram is lex(
	"sequence", list (
	"Init wait",phys_wait@,
	"Inclination wait",rel_Incl@,
	"Presys_checks", presys_checks@,
	"Countdown", Countdown@,
	"Pitchcontrol", Pitchcontrol@,
	"Phasei",Phasei@,
	"phaseii", Phaseii@,
	"Finalizing", Finalizing@
	), 
	"events", Lex()
	).
Function phys_wait { 
Parameter mission.
print "Physics settling in."at(0,1).
wait 5. //to make sure that the craft stands still and rel_incl isn't returning false results
mission["next"]().
}
Function rel_Incl { 
Parameter mission.
	set Dol to relativeInc(ship,target).
	wait 0.
	set Dac to relativeInc(ship,target).
	if Dol > Dac and relativeInc(ship,target) < 10 and relativeInc(ship,target) > 1.5 {
		if kuniverse:timewarp:warp <> 3 {
			set  kuniverse:timewarp:warp to 3.
		}
	}
		if Dol > Dac and relativeInc(ship,target) <= 1.5 {
		if kuniverse:timewarp:warp <> 1 {
			set  kuniverse:timewarp:warp to 1.
		}
	}
	if Dol < Dac or (Dol > Dac and relativeInc(ship,target) > 10) {
		if kuniverse:timewarp:warp <> 6 {
			set  kuniverse:timewarp:warp to 6.
		}
	}
	If relativeInc(ship,target) < 1 and Dol > Dac {
	set kuniverse:timewarp:warp to 0.
	set ship:control:pilotmainthrottle to 0.
	mission["next"]().
	}
}
Function Presys_checks{
	Parameter mission.
	if kuniverse:timewarp:warp = 0 and kuniverse:timewarp:issettled {
	set curT to 1.
	stagingfunc(). //staging
	dFair(). //Fairing decoupler
	pan_on(). //panel extender
	Notify ("Flightcomputer is running",2).
	wait 2.
	stage.
	mission["next"]().
	}
}
Function  Countdown {
	Parameter mission.
	FROM {local x is n-Count.} UNTIL x = 0 STEP {set x to x-1.} DO {
		NOTIFY("T - "+ x +" Seconds", 1).
		wait 1.
	}
	NOTIFY("Liftoff", 1).
	wait 1.
	stage.
	mission["next"]().
}
Function Pitchcontrol { 
	Parameter mission.
		If myspeed < 100 {
			set curS to Heading(90,90).
		}
		set curS to heading(90, MAX(90 * (constant:e ^ (-1.789e-5 * apoapsis )),12)).  //change the max pitch if your craft is still in a steep climb once Pe is above -100k
		If apoapsis > (TrgH + (tollerance * .5)) {
			mission["next"]().
		}
}
Function Phasei {
	Parameter mission.
	set curS to heading(compass_of_vel(ship:velocity:surface),PID_Seek(Pit_PID_p1, (TrgH + tollerance), Apoapsis)).
	If Periapsis < -1e6 and Periapsis > -4e6{
		mission["next"]().
	}
}
Function Phaseii {
	Parameter mission.
	if eta:Apoapsis < eta:Periapsis {
		set curS to heading(compass_of_vel(ship:velocity:orbit),PID_Seek(Pit_PID_p1, (TrgH + tollerance), Apoapsis)).
	}
	if myspeed < 20 {
			set curS to heading(compass_of_vel(ship:velocity:orbit),PID_Seek(Pit_noneg_PID, 5, myspeed)).
	}
//	if eta:Apoapsis > eta:Periapsis {
//		set curS to heading(90,PID_Seek(Pit_noneg_PID, (TrgH + tollerance), Apoapsis)).
//	}
	If Periapsis > -2e5 {
		mission["next"]().
	}
}
Function Finalizing {
	Parameter mission.
	set curT to 0.15.
	if eta:Apoapsis < eta:Periapsis and Periapsis < TrgH {
		set curS to heading(compass_of_vel(ship:velocity:orbit),PID_Seek(Pit_PID, (TrgH + tollerance), Apoapsis)).
	}
	if myspeed < 20 and Periapsis < TrgH {
			set curS to heading(compass_of_vel(ship:velocity:orbit),PID_Seek(Pit_noneg_PID, 5, myspeed)).
	}
	If Periapsis > TrgH or (Periapsis > body:atm:height and apoapsis > TrgH + constant:pi*tollerance) {	
		set curt to 0.
		wait 0.1.
		stage. //delete this is you want to keep your current stage
		wait 0.1.
		mission["terminate"]().
	}
}

}