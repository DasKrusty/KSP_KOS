// ---TEST BENCH--- //


//https://www.youtube.com/watch?v=5ZbCGbdNI_g&list=PLY4XNTtbpFqh2Og-TGzYSfiU5dp0H132L&index=2

set rnwy to latlng(-0.0486,-74.60).		//saved runway location
set ils1 to latlng(-0.0486,-75.5).		//waypoint used to initiate final approach
set ils2 to latlng(-0.0486,-78).		//waypoint used for initial alignment with runway
set bankmax to ship:control:roll.

clearScreen.
sas off.
doAutomaticThrottleControl().
set bankmax to 30.
until ils2:distance<(1000 + ALT:RADAR){
lock steering to ils2:altitudeposition(7500).
print "Step 1 ="+round(ils2:distance)+"m" at (10,5).
WAIT 0.1.
}


clearScreen.
until ils1:distance<(1000 + ALT:RADAR){
lock steering to ils1:altitudeposition(5000).
lock throttle to 0.45.
print "Step 2 ="+round(ils1:distance)+"m" at (10,5).
WAIT 0.1.
}

clearScreen.
until rnwy:distance<(1000 + ALT:RADAR){
lock steering to rnwy:altitudeposition(2500).
lock throttle to 0.25.
print "Step 3 ="+round(rnwy:distance)+"m" at (10,5).
WAIT 0.1.
}

function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
}