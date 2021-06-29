// ---TEST BENCH--- //

function main {
    doGPS().
    doLAND().
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

set TAR to latlng(-0.0486,-74.60).
sas off.
until TAR:distance<7000{
    lock steering to TAR:altitudeposition(2500).
    print "Distance from Target = " + round(TAR:distance) + "m" at (0,5).
    wait 0.1.
}

//https://www.youtube.com/watch?v=5ZbCGbdNI_g&list=PLY4XNTtbpFqh2Og-TGzYSfiU5dp0H132L&index=2

function doLAND {
    set RUNWAY to latlng(-0.0486,-74.60).
    set INILI1 to latlng(-0.0486,-75.5).
    set INILI2 to latlng(-0.0486,-78).

    sas:off.
    lock steering to INILI2:altitudeposition(2500).
    print "Distance to Target ="+round(INILI2:distance)+"m".
        until INILI2:distance<1000{
            lock steering to INILI1:altitudeposition(500).
            print "Distance to Target ="+round(INILI1:distance)+"m".
            lock throttle to 0.5.
            until INILI2:distance<500{
                lock steering to RUNWAY:altitudeposition(100).
                print "Distance to Target ="+round(RUNWAY:distance)+"m".
                lock throttle to 0.25.
                until RUNWAY:distance<100{
                    lock steering to heading(180,5).
                    gear:on.
                    lock throttle to 0.
                    until ship:status:"landed"{
                        brakes:on.
                        sas:on.
                    }
                }
            }
        }
}

main().