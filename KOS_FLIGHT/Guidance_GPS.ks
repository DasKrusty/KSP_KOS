// ---TEST BENCH--- //

function main {
    doGPS().
}

//circularization script, starts immediately when called.

function doGPS{
    //setup
    clearscreen.
    print "Welcome to plen".

    print "Loading waypoints.". 			//Waypoints that are used for automatic navigation.
    set tgt to latlng(20.5829,-146.5116).	//enter custom waypoint here
    set rnwy to latlng(-0.0486,-74.60).		//saved runway location
    set ils1 to latlng(-0.0486,-75.5).		//waypoint used to initiate final approach
    set ils2 to latlng(-0.0486,-78).		//waypoint used for initial alignment with runway
}.

set TAR to latlng(-1.532,-71.880).
until TAR:distance<7000{
    lock steering to TAR:altitudeposition(5000).
    print "Distance from Target = " + round(TAR:distance) + "m".
    wait 0.1.
}

//https://www.youtube.com/watch?v=5ZbCGbdNI_g&list=PLY4XNTtbpFqh2Og-TGzYSfiU5dp0H132L&index=2

main().