//
// Starship SSTO Flight Control System kOS Script
//
//
// Place this script in Kerbal Space Program/Ships/Script/ or Kerbal Space Program/Ships/Script/boot/ (for a boot file).
// name it 'fcs.ks' and in the first case (located in the Script folder) run it with the following kOS commands:
// switch to 0.
// run fcs.
//
// or in the second case (using the boot file):
// load the savefile for the Starship SSTO kOS version. Check it has been selected in the kOS unit (located on the Lab).
// Fly, and the GUI should show up!
//
//
// Required Mods:
// - Breaking Grounds DLC
// - Tweakscale (for the ship)
// - Trajectories Mod
// - kOS
//
// Have Fun!
//
//
// Tested and succesfully completed Scenarios:
// 
// [x] Normal Mun return Re-Entry.
// [x] High energy retrograde Re-Entry (beyond the point where it would overheat).
// [x] Slightly off Polar Re-Entry (re-entry from the north, impact 30km south, 10km east of KSC).
// [x] Big Error normal Re-Entry (impact 25km west, 35km south of KSC).
// [x] High altitude hop, normal final approach (10km altitude). Here it has to navigate to the Landing Pad.
// [x] High altitude hop, retrograde final approach (20km altitude).
// [x] High altitude hop, polar final approach (20km altitude).
//
//
// Version 1.2 - GNUGPL3
// Janus92
//
//
//

        // Initial Program Start-Up.
set exit to false.
wait until ship:unpacked.
clearguis().
clearscreen.

        // Finds ships parts for later use.
set hinges to SHIP:PARTSNAMED("hinge.03").
list ENGINES in allengines.

        // Sets Trajectories Mods initial settings.
set landingzone to latlng(-000.0972,-074.5577).
SET ADDONS:TR:DESCENTANGLES TO list(65,65,65,65).
SET ADDONS:TR:DESCENTMODES TO list(true,true,true,true).
ADDONS:TR:SETTARGET(landingzone).

//-------------Graphic User Interface----------------------//


        // Defines GUI.
local g is GUI(400).

        // Adds Title Box.
local TitleBox is g:addhlayout().                                                                
    
        // Adds Title to Title Box.
local Title is TitleBox:addlabel("<size=22><b>Flight Control System</b></size>").
    set Title:style:align to "CENTER".
    set Title:style:hstretch to True.
    set Title:style:margin:h to 0.
    set Title:style:margin:v to 1.
    set Title:style:textcolor to white.

        // Adds Hide Button to Title Box.
local g_hide is TitleBox:addbutton("<size=18>_</size>").
    set g_hide:style:margin:h to 0.
    set g_hide:style:margin:v to 1.
    set g_hide:toggle to true.
    set g_hide:style:width to 25.
    set g_hide:style:height to 25.
    set g_hide:style:vstretch to true.

        // Adds Close Button to Title Box.
local g_close is TitleBox:addbutton("<size=18>X</size>").
        set g_close:style:margin:h to 0.
        set g_close:style:margin:v to 1.
        set g_close:style:width to 25.
        set g_close:style:height to 25.
        set g_close:style:vstretch to true.
        set g_close:onclick to {g:hide(). set exit to true. }.

        // Adds a Box to the GUI.
local box_all is g:addvlayout().
    set box_all:style:padding:v to 0.
    set box_all:style:padding:h to 0.
    set box_all:style:margin:v to 0.
    set box_all:style:margin:h to 0.

        // Adds Launch, Land and a Status Label to before mentioned Box.
local button1hbox is box_all:addhlayout().
local launchbutton to button1hbox:addbutton("<size=20>Launch</size>").
    set launchbutton:toggle to true.
    set launchbutton:style:width to 80.
    set launchbutton:style:on:textcolor to green.
    set launchbutton:style:hover_on:textcolor to green.
local edlbutton to button1hbox:addbutton("<size=20>Land</size>").
    set edlbutton:toggle to true.
    set edlbutton:style:width to 80.
    set edlbutton:style:on:textcolor to green.
    set edlbutton:style:hover_on:textcolor to green.
local statuslabel to button1hbox:addlabel("").
    set statuslabel:style:fontsize to 18.
    set statuslabel:style:textcolor to white.
    set statuslabel:style:align to "center".
    set statuslabel:style:vstretch to true.

        // Adds a Text Box with 3 message fields to before mentioned Box.
local textbox is box_all:addvbox().    
local message1 is textbox:addlabel().
    set message1:style:fontsize to 18.
    set message1:style:textcolor to green.
local message2 is textbox:addlabel().
    set message2:style:fontsize to 18.
    set message2:style:textcolor to green.
local message3 is textbox:addlabel().
    set message3:style:fontsize to 18.
    set message3:style:textcolor to green.

        // Sets Launch Button Actions. First what happens when the button is pushed in, then what it should do if it could not start the Launch() function, and finally what happens when the button is pushed out.
set launchbutton:ontoggle to {
    parameter click.
    if click {if alt:radar < 50 or verticalspeed > 1 and periapsis < 70000 {Droppriority(). set edlbutton:pressed to False. Launch().}.
        else {
            set message1:text to "Launch aborted..".
            set message2:text to "Are you flying?".
            set message3:text to "".
            set message1:style:textcolor to yellow.
            set message2:style:textcolor to yellow.
            set message3:style:textcolor to yellow.}}
    else {
        lock throttle to 0.
        unlock steering.
        unlock throttle. 
        wait 0.1.
        set statuslabel:text to "Manual Control".
        set message1:text to "".
        set message2:text to "".
        set message3:text to "".}
    }.
    
        // Sets Land Button Actions. First what happens when the button is pushed in, then what it should do if it could not start the EDL() function, and finally what happens when the button is pushed out.
set edlbutton:ontoggle to {
    parameter click.
    if click {if altitude > 1000 {Droppriority(). set launchbutton:pressed to False. EDL().}
        else {
            set message1:text to "EDL Cancelled..".
            set message2:text to "Are you on the ground?".
            set message3:text to "".
            set message1:style:textcolor to yellow.
            set message2:style:textcolor to yellow.
            set message3:style:textcolor to yellow.}}
    else {
        set statuslabel:text to "Manual Control".
        set message1:text to "".
        set message2:text to "".
        set message3:text to "".
        lock throttle to 0.
        unlock steering.
        unlock throttle.}
    }.

        // Sets the Hide Button Actions.
set g_hide:ontoggle to {
    parameter b. 
    if b {box_all:hide().}
    else {box_all:show().}}.
    
        // Show succesful Start-Up Message.
set message1:text to "Flight Control System initialized..".
set statuslabel:text to "Hi there!".

        // Show GUI.
g:show().

        // Waits for Close Button to be pushed, and thereafter disposes the GUI and closes the Program.
wait until exit.
g:dispose().



//--------------Launch Program--------------------------------//
        // Launches to an estimated 71km orbit. This launch profile provides maximum Delta-V.

    

        // Starts the Launch() function and sets the Launch Pad Coordinates. Resets the GUI messages to green color, in case the function could not be started when the Launch Button was pressed priorly (then they turn yellow).
function Launch {
    set landingzone to latlng(-000.0972,-074.5577).
    set message1:style:textcolor to green.
    set message2:style:textcolor to green.
    set message3:style:textcolor to green.
    
            // Clears the screen, sets flaps, starts engines.
    clearscreen.
    setfwdflap(180). setaftflap(180).
    wait 1.
    for eng in allengines {eng:activate.}.
    
            // When you're starting the function from the ground, it sets Guidance to Up, Throttle to full, and then waits 2 seconds.
    if alt:radar < 50 {
        lock throttle to 1.
        lock steering to up + r(0, 0, -90).
        stage.  
        set statuslabel:text to "Lift-off!".
        wait 2.}
        
            // When you're starting the function while already flying, it sets Throttle to full only.
    if apoapsis < 71500 {lock throttle to 1.}.
    
            // Sets the Guidance for Launch, dependant on current Altitude.
    lock targetpitch to 62 - 10 * SQRT(altitude/1000).
    lock steering to heading(90, targetpitch).
        
            // The Climb-out Loop. Runs until achieving an Apoapsis of 71.5km.
    until apoapsis > 71500 {                                                                          //ascent-loop
        when alt:radar > 5 then {gear off.
        set statuslabel:text to "Launching to Orbit..".
        set message1:text to "Actual/Target Apoapsis: " + round(apoapsis/1000,1) + "/71.0km".
        set message2:text to "Target Pitch: " + round(targetpitch, 1).
        set message3:text to "Down Range: " + round(landingzone:distance/1000, 1) + "km".}.
        }.
        
            // After reaching 71.5km Apoapsis, it sets throttle to 0 and steers Prograde. Then it waits until 8 seconds to Apoapsis. Also sets appropriate GUI messages.
    lock throttle to 0.
    lock steering to velocity:surface.
    
            // Coasting to orbit.
    until ETA:APOAPSIS < 7 {
        set statuslabel:text to "On the way to Orbit..".
        set message1:text to "Standing by for Circularization Burn..".
        set message2:text to "Start Burn in " + round(ETA:APOAPSIS - 7, 0) + " seconds".
        set message3:text to "Current Apoapsis: " + round(APOAPSIS / 1000, 1) + "km".
        if ETA:APOAPSIS < 8 {lock throttle to 0.55.}}
        
            // Orbit Circularization Burn.
    until PERIAPSIS > 71100 {
        if periapsis > 71000 {lock throttle to 0.}
        set statuslabel:text to "Definitely in Space..".
        set message1:text to "Circularizing Orbit..".
        set message2:text to "Apoapsis: " + round(APOAPSIS / 1000, 1) + "km".
        set message3:text to "Periapsis: " + round(PERIAPSIS / 1000, 1) + "km".}
        
            // Orbit Achieved. End of the Launch Program.
    lock throttle to 0.
    unlock throttle.
    set SHIP:CONTROL:PILOTMAINTHROTTLE to 0.
    set statuslabel:text to "Welcome to Kerbin Orbit!".
    set message1:text to "Launch Program Ended.".
    set message2:text to "Have a safe journey!".
    set message3:text to "".
    unlock steering.
    

}.



//--------------Entry, Descent and Landing Program--------------//
        // creates the whole EDL() function from Re-Entry down to the Landing maneuvre and After-Landing checkouts.



        // Starts the EDL() function. Resets the GUI messages to green color, in case the function could not be started when the Launch Button was pressed before but the function was not allowed to start (due to not fulfilling a requirement).
function EDL {
    if addons:tr:hasimpact{
    set message1:style:textcolor to green.
    set message2:style:textcolor to green.
    set message3:style:textcolor to green.

            // initial preparation.
    sas off.
    rcs off.
    ag4 off.
    for eng in allengines {eng:activate.}.
    setfwdflap(130). setaftflap(132).

            // prepare Trajectories mod for Re-Entry. Enters launchpad coordinates into the Trajectories Mod.
    set landingzone to latlng(-000.0972,-074.5577).
    SET ADDONS:TR:DESCENTANGLES TO list(65,65,65,65).
    SET ADDONS:TR:DESCENTMODES TO list(true,true,true,true).
    ADDONS:TR:SETTARGET(landingzone).

            // set of updating variables for finding Flip Altitude and the Error Vector to the Landing Pad.
    lock maxDecel to 0.8 * (ship:availablethrust / ship:mass) - 9.81.
    lock stopTime to (0.5 * ship:verticalspeed) / maxDecel.
    lock trueRadar to alt:radar - 26.
    lock stopDist to (ship:verticalspeed * stopTime) + (0.5 * maxDecel * stopTime * stopTime).
    lock landingthrottle to stopDist / trueRadar.
    lock ErrorVector to ADDONS:TR:IMPACTPOS:POSITION - landingzone:POSITION.
    
            // Re-Entry Pitch PID settings.
    set PitchPID to PIDLOOP(0.05, 0.03, 0.04, -15, 10). //was 0.05, 0.015, 0.03
    set PitchPID:SETPOINT to 0.
    
            // Body Flaps PID settings. Maximum 20 degrees up and down range.
    set BodyFlapsPID to PIDLOOP(1, 0, 0, -20, 20).
    set BodyFlapsPID:SETPOINT to 0.

            // Sets Angle-of-Attack for Landing. Also defines the variable which (later on) controls a persistent out-of-bounds signal when landing too far away from the Landing Pad.
    set aoa to 65.
    set LandSomewhereElse to 0.

    
    
//------------------Re-Entry Loops-----------------------///
    
    
    
            // calls the ReEntrySteering() Function.
    set statuslabel:text to "Re-Entry Control..".
    until trueRadar < stopDist or trueRadar < 1000 {lock steering to ReEntrySteering.}


        // Re-Entry Control Function. This provides the steering through a 'Direction' that will correct the track and x-track errors on the way to the Landing Pad.
function ReEntrySteering {
    if kuniverse:timewarp:warp > 0 and altitude < 35000 {set kuniverse:timewarp:warp to 0.}
    
            // Make the PIDs work with LngLatError inputs. pitch is a variable providing a basic pitch correction based on error alone. PitchCtrl is the PID-output that does more advanced controlling. pitch, yaw and PitchCtrl (PitchCtrlFactored) are also tuned for the re-entry airspeed range.
    set LngLatErrorList to LngLatError().
    set pitch to (LngLatErrorList[0] / 100 / (airspeed / 200)).
    if pitch > (airspeed / 150) {set pitch to max(10, (airspeed / 150)).}
    if pitch < - (airspeed / 150) {set pitch to min(-10, - (airspeed / 150)).}
    set PitchCtrl to PitchPID:UPDATE(TIME:SECONDS, LngLatErrorList[0]).
    set PitchCtrlFactored to PitchCtrl / (0.5 + (airspeed / 300)).
    set DesiredAoA to aoa + pitch - PitchCtrlFactored.
    if DesiredAoA > 90 {set DesiredAoA to 90.}
    set yaw to (LngLatErrorList[1] / (10 + (airspeed / 100)) / (1 + ((90 - DesiredAoA ) / 90))). if yaw > 60 {set yaw to 60.} else if yaw < -60 {set yaw to -60.}
    
            // Get the required values for flaps control. AoAError is the difference between desired Angle of Attack and Actual Angle of Attack. DesiredPitchRate sets the rate of pitch-correction using the flaps. The BodyFlapsPID:SETPOINT is being reset constantly in this loop to make the goal to achieve this desired Pitch Rate. I need to check if changing Pitch Rate positive or negative according heading to target is working consistently. This might not be working as expected at angles close to north or south with a yaw correction applied.
    set AoAError to vang(vxcl(facing:starvector, facing:forevector), vxcl(facing:starvector, velocity:surface:vec)) - DesiredAoA.
    set PitchRate to -1 * angularmomentum:x /100.
    set DesiredPitchRate to - AoAError / (1 + (airspeed/1000)).
    set BodyFlapsPID:SETPOINT to DesiredPitchRate.
    
            // Here the Flaps PID is updated with its input "PitchRate", which it should control back to DesiredPitchRate. Then the PIDs output is being fed into the FlapControl() Function, which takes first the normal control, then the roll control, and finally the yaw control parameter.
    set BodyFlapsCtrl to BodyFlapsPID:UPDATE(TIME:SECONDS, PitchRate).
    if yaw > 0 {
        set YawError to -1 * vang(vxcl(facing:topvector, facing:forevector), vxcl(facing:topvector, (srfprograde * R(- DesiredAoA * cos(yaw), DesiredAoA * sin(yaw), 0)):vector)).}
    else {
        set YawError to vang(vxcl(facing:topvector, facing:forevector), vxcl(facing:topvector, (srfprograde * R(- DesiredAoA * cos(yaw), DesiredAoA * sin(yaw), 0)):vector)).}
    FlapControl(BodyFlapsCtrl, LngLatErrorList[1]/10, YawError / 6).
    
            // In case you need Telemetry, activate these.
    //clearscreen.
    //print "GOAL AoA: " + round(DesiredAoA,2).
    //print "AoA Error: " + round(AoAError,2).
    //print "pitch: " + round(pitch,2).
    //print "yaw: " + round(yaw,2).
    //print "YawError: " + round(YawError,2).
    //print "lng error: " + round(LngLatErrorList[0],0).
    //print "lat error: " + round(LngLatErrorList[1],0).
    //print "Pitch PID: " + round(PitchCtrl,2).
    //print "Pitch Ctrl Factored: " + round(PitchCtrlFactored,2).
    //print "P: " + round(PitchPID:pterm,2).
    //print "I: " + round(PitchPID:iterm,2).
    //print "D: " + round(PitchPID:dterm,2).
    //print "Desired Pitch Rate: " + round(DesiredPitchRate,2).
    //print "Pitch Rate: " + round(PitchRate,3).
    //print "Flaps PID: " + round(BodyFlapsCtrl,2).
    //print "P: " + round(BodyFlapsPID:pterm,2).
    //print "I: " + round(BodyFlapsPID:iterm,2).
    //print "D: " + round(BodyFlapsPID:dterm,2).

            // Update GUI text.
    if airspeed > 300 {
        set message1:text to "Remaining Flight Time:  " + round(ADDONS:TR:TIMETILLIMPACT, 0) + " seconds".
        set message2:text to "Distance to Target:        " + round(landingzone:distance/1000, 0) + "km".
        set message3:text to "Track/X-Trk Error:        " + round(LngLatErrorList[0] / 1000, 2) + "km  " + round((LngLatErrorList[1] / 1000), 2) + "km".}
    else {
        set statuslabel:text to "Subsonic Control..".
        set message1:text to "Flip Altitude:                  " + round(max(stopDist, 1000), 0) + "m".
        set message2:text to "Distance to Target:        " + round(landingzone:distance/1000, 0) + "km".
        set message3:text to "Track/X-Trk Error:        " + round(LngLatErrorList[0] / 1000, 2) + "km  " + round((LngLatErrorList[1] / 1000), 2) + "km".}
    
            //calculate the Re-Entry 'Direction'.
    set result to srfprograde * R(- DesiredAoA * cos(yaw), DesiredAoA * sin(yaw), 0).
    set result to lookdirup(result:vector, vxcl(velocity:surface, result:vector)).
    if DesiredAoA > 89.5 {set result to heading(CompassHeading, DesiredAoA).}

            //Engages RCS when the ship is not oriented within 45 degrees of the target direction (large error detected) or when pitching at an undesired rate. Below 5000m RCS is also activated.
    if vang(result:vector, facing:forevector) > 45 or altitude < 5000 or PitchRate - DesiredPitchRate > 5 or PitchRate - DesiredPitchRate < -5 {rcs on.}
    else if altitude > 5000 {rcs off.}
    
    return result.}


    
//------------------Landing-----------------------///



        // Sets the Landing PID.
set LandingPID to PIDLOOP(0.15, 0.03, 0.03, -1, 1).
set LandingPID:SETPOINT to 0.

        // Sets the boundaries for a Pad Landing, and calls on the Landing() function. If the ship is outside the boundaries at the moment of the flip, the LandSomewhereElse variable will supply the ship with a retrograde course for landing from within the Landing() Function.
set LngLatErrorList to LngLatError().
set LngError to LngLatErrorList[0].
set LatError to LngLatErrorList[1].
if LngError > 35 or LngError < -50 or LatError > 25 or LatError < -25 {
    set LandSomewhereElse to 1.}
Landing().

        // controls the flip and guidance for landing on the Landing Pad or somewhere else if the ship fails to meet the required parameters for a safe landing.
function Landing {

            // Creates a 'Direction' which will be the ships guidance after the first 2 seconds of the Flip.
    function LandingVector {
        if kuniverse:timewarp:warp > 0 {set kuniverse:timewarp:warp to 0.}
        if addons:tr:hasimpact {
                    // Sets the PID to input 'ErrorVector Magnitude', creates a result from retrograde and the error.
            set controller to LandingPID:UPDATE(TIME:SECONDS, ErrorVector:MAG).
            set result to -1 * VELOCITY:SURFACE + 0.3 * controller * ErrorVector.
            
            if ErrorVector:MAG > 25 + 0.5 * trueRadar {set LandSomewhereElse to 1.}
            
                    // GUI message. When the boundaries at the start of the flip were exceeded, this will guide the ship to a retrograde landing anywhere without regard for the Landing Pad.
            if LandSomewhereElse = 0 {
                set message2:text to "Distance from Target: " + round(ErrorVector:MAG,0) + "m".}
            else {
                set result to -1 * VELOCITY:SURFACE.
                set message1:text to "Can't reliably reach Landing Pad..".
                set message2:text to "Distance from Target: " + round(ErrorVector:MAG / 1000,2) + "km".
                set message3:text to "Watch out for obstacles!".
                set message1:style:textcolor to yellow.
                set message2:style:textcolor to yellow.
                set message3:style:textcolor to yellow.}
            if landingthrottle > 1 and trueRadar < 200 {
                set message1:text to "WARNING!".
                set message3:text to "IMPACT IMMINENT! (good luck..)".
                set message1:style:textcolor to red.
                set message3:style:textcolor to red.}
        }
        
                // Levels the ship prior to touchdown.
        if ship:verticalspeed > -15 {LOCK STEERING TO lookDirUp(ship:up:vector, facing:topvector).}.
        return lookDirUp(result, facing:topvector).
    }

            // Here the flip will start.
    rcs on.
    unlock steering.
    setfwdflap(180).
    setaftflap(90).
    
            // Sets the GUI Messages.
    set statuslabel:text to "Landing..".
    set message1:text to "Performing Flip Maneuvre..".
    set message3:text to "Hold on to your Hats, Boys!".

            // Flips the ship by first steering up for 1 second, then down for 1 second, and then requesting guidance from the LandingVector() function. Required Throttle is calculated from the distance (variable = Offset) to the launchpad at the start of the flip (calculated with slant range, radio altimeter and the cosine of the angle towards the pad). This avoids major overshooting. Pitch and times have also been corrected for a variety of weights and angles.
    set SlantRange to landingzone:distance.
    set SlantAngle to vang(-1 * ship:up:vector, velocity:surface).
    set Offset to SQRT((SlantRange * SlantRange + alt:radar * alt:radar) - (2 * alt:radar * SlantRange * cos(SlantAngle))).

            // Landing Telemetry.
    //print "Offset: " + round(offset,0).
    //print "Weight: " + round(ship:mass,1).
    //print "Max Deceleration: " + round(maxDecel,1).
    //print "Flip Throttle: " + round((((Offset / 30) * (ship:mass / 200)) / maxDecel) * maxDecel,1).
    //print "Landing Throttle: " + round(landingthrottle,2).
    
    set ship:control:pitch to 1 - ((Offset - 400) / 1900).
    set FlipThrottle to (((Offset / 30) * (ship:mass / 190)) / maxDecel).
    if LandSomewhereElse = 1 {set FlipThrottle to 10 / maxDecel.}
    lock throttle to FlipThrottle.
    if LandSomewhereElse = 0 {wait (1.4 - (Offset / 900)).} else {wait 1.}
    set ship:control:pitch to -1.
    lock throttle to landingthrottle.
    wait 1.
    set ship:control:neutralize to true.
    LOCK STEERING TO LandingVector().
    gear on.
    setfwdflap(135).
    setaftflap(135).
    }

        // This stops the Landing() function. Landing Complete.
wait until verticalspeed > -1.



//----------------After Landing------------------//



        // calls the function written below.
AfterLanding().


        // Shuts the engines down after landing, tries to stabilize the craft with SAS and RCS, and shuts down after 30 seconds. The Flaps will then be folded as well. This ends the EDL() function.
function AfterLanding {
    for eng in allengines {eng:shutdown.}.
    set statuslabel:text to "Welcome to Kerbin!".
    set message1:text to "Succesful Landing Confirmed!  (" + (round(landingzone:distance, 0)-9) + "m)".
    set message2:text to "Performing Vehicle Self-Check..".
    set message3:text to "Please Standby..(30s)".
    unlock steering.
    sas on.
    wait 30.
    rcs off.
    sas off.
    setfwdflap(90).
    setaftflap(90).
    set message1:text to "Vehicle Self-Check OK!".
    set message2:text to "Land Program ended..".
    set message3:text to "You may now disembark!".
    set message1:style:textcolor to green.
    set message2:style:textcolor to green.
    set message3:style:textcolor to green.
    ADDONS:TR:CLEARTARGET().
    }

    
    
        // bracket ends the 'Has Impact' check.
}
        // When no Impact location can be found, I assume the ship is still in orbit.
else {
    set message1:text to "Error: Ship has no Impact Position..".
    set message2:text to "Adjust your Orbit!".
    set message3:text to "Ideal Accuracy: < 100km from target".
    set message1:style:textcolor to yellow.
    set message2:style:textcolor to yellow.
    set message3:style:textcolor to yellow.}.
}.
        // EDL() function officially ended.



//----------------Other Functions---------------------//

    
    
        // Calculates Track Error and X-Track Error from the ship to the Landing Pad for Re-Entry Guidance. The Longitudinal Distance is being calculated in two ways. For large distances it takes the distance between the ship and the Landing Pad, and the distance between the ship and the Impact Position. The difference (Track Error) between the two is representative for the FCS to do its calculations, though not very exact (especially when situated exactly overhead the Landing Pad). Therefore at 15km altitude it changes to the next mode: It calculates the longitudinal part of the Error Vector that is along the front facing line of the ship. This provides more accurate control at low altitudes and it fixed most loss-of-control situations I encountered when overshooting (which should not happen in the first place).
function LngLatError {
    if addons:tr:hasimpact {
        set lngresult to ((ship:position - addons:tr:impactpos:position):mag - (ship:position - landingzone:position):mag).
        if landingzone:distance/1000 < 15 {
            set LongVector to facing:forevector.
            set lngresult to (vdot(LongVector, ErrorVector)).}

        set LatVector to heading(landingzone:heading - 90, 0):vector.
        set latresult to (vdot(LatVector, ErrorVector)).
        if landingzone:bearing > 90 or landingzone:bearing < - 90 {set latresult to - latresult.}
        if addons:tr:impactpos:bearing > 90 or addons:tr:impactpos:bearing < -90 {
            set lngresult to ErrorVector:mag.
            set latresult to 0.}
        return list(lngresult, latresult).}
}


        // Set Forward Body Flaps to the angle that can be passed with this function.
function setfwdflap {
    parameter angle.
    hinges[0]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", angle).
    hinges[1]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", angle).
}
    
    
        // Set Aft Body Flaps to the angle that can be passed with this function.
function setaftflap {
    parameter angle.
    hinges[2]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", angle).
    hinges[3]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", angle).
    hinges[4]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", angle).
    hinges[5]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", angle).
    hinges[6]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", angle).
    hinges[7]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", angle).
}


        // Provides Flap Control. First parameter controls with both Forward and Aft Flaps at the same time. Second Parameter controls roll (different left flap from right flap). The third parameter provides yaw control (Forward Flaps different from Aft Flaps).
function FlapControl {
    parameter FlapCtrl.
    parameter roll.
    parameter yaw.
    if FlapCtrl > 20 {set FlapCtrl to 20.}
    if FlapCtrl < -20 {set FlapCtrl to -20.}
    if roll > 5 {set roll to 5.}
    if roll < -5 {set roll to -5.}
    if yaw > 5 {set yaw to 5.}
    if yaw < -5 {set yaw to -5.}
    if LngLatErrorList[0] > 100 and airspeed < 1000 and altitude < 15000 {set FWDFlap to 155. set AFTFlap to 140.}
    else {set FWDFlap to 140. set AFTFlap to 140.}
    
            // Left Flaps, hinges[0] = Forward Flap. Rest Aft.
    hinges[0]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", FWDFlap + FlapCtrl - roll - yaw).
    hinges[2]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", AFTFlap - FlapCtrl - roll + yaw).
    hinges[4]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", AFTFlap - FlapCtrl - roll + yaw).
    hinges[6]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", AFTFlap - FlapCtrl - roll + yaw).
    
            // Right Flaps, hinges[1] = Forward Flap. Rest Aft.
    hinges[1]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", FWDFlap + FlapCtrl + roll + yaw).
    hinges[3]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", AFTFlap - FlapCtrl + roll - yaw).
    hinges[5]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", AFTFlap - FlapCtrl + roll - yaw).
    hinges[7]:getmodule("ModuleRoboticServoHinge"):setfield("Target Angle", AFTFlap - FlapCtrl + roll - yaw).
}


        // Provides Compass Heading.
function CompassHeading {
    set EastVel to vdot(ship:facing:forevector, vcrs(up:vector, north:vector)).
    set NorthVel to vdot(ship:facing:forevector, north:vector).
    set Compass to arctan2(EastVel, NorthVel).
    if Compass < 0 {set Compass to Compass + 360.}
    return Compass.
}