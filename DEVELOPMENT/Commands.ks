//Editing / Running / Finding Scripts in Game
    edit DAFS.ks.           //Allows you to edit the script
    edit DAFS.              //Same as above
    run DAFS.ks.            //Allows you to run the script
    list files.             //Lists all files
    switch to 0.            //Switch between 0 and 1, 0 is your pc's script list and 1 is on the craft script list
    copypath("0:/DAFS", "").//copies from 0 (archive) to current default location (local drive (1))

//Printing
    clearScreen.            //Clears screen of everything
    print "Hello World".    //Basic print
    PRINT ROUND(SHIP:APOAPSIS,0) AT (0,16).

//This is our countdown loop, which cycles from 10 to 0
PRINT "Counting down:".
FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1. // pauses the script here for 1 second.
}

//Lock Commands
lock throttle to 1.         //Sets throttle to 100% - 0 is 0% - 0.5 is 50%
lock steering to up.        //Locks steering to face up away from planet
lock steering to heading(90,45).    //locks heading to 90 degrees from North and 45 degrees Pitch

//Until Commands
until ship:maxthrust > 0 {}. //
wait until ship:altitude > 70000.
until apoapsis > 1000 {}.

//When & Then Commands
when maxthrust = 0 then {stage. preserve.}.

//Set Command
set MYSTEER to heading(90,45).  //Creates a variable to use
    lock steering to MYSTEER.   //Uses varible 

set CurrentTime to time:seconds.
print CurrentTime. // shows: 60
wait 10.
print CurrentTime. // shows: 60

lock TimeSecondsPlusTen to time:seconds + 10.

set Adder to 0.
lock Multiplier to Adder * 2.
set TimePlusFive to time:seconds + 5.

until time:seconds > TimePlusFive {
  print Multiplier.
  set Adder to Adder + 1.
  wait 1.
}

//VECTORS
SET vec TO V(x,y,z).

set DIR to V(ship:direction:north - ship:facing).
lock steering to heading(DIR,90).

ship:direction:fore.    //Look AT - Fore - Z Axis
ship:direction:up.      //Look UP - Top - Y Axis

// Aim up the SOI's north axis (V(0,1,0)), rolling the roof to point to the sun.
LOCK STEERING TO LOOKDIRUP( V(0,1,0), SUN:POSITION ).
//
// A direction that aims normal to orbit, with the roof pointed down toward the planet:
LOCK normVec to VCRS(SHIP:BODY:POSITION,SHIP:VELOCITY:ORBIT).  // Cross-product these for a normal vector
LOCK STEERING TO LOOKDIRUP( normVec, SHIP:BODY:POSITION).

// Pick a new rotation that is pitched 30 degrees from the current one, taking into account
// the ship's current orientation to decide which direction is the 'pitch' rotation:
//
SET pitchUp30 to ANGLEAXIS(-30,SHIP:STARFACING).
SET newDir to pitchUp30*SHIP:FACING.
LOCK STEERING TO newDir.
