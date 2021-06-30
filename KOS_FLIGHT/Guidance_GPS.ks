// ---TEST BENCH--- //

function main {
    //doGPS().
    doLAND().
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
                    until STATUS = "LANDED"{
                        brakes:on.
                        sas:on.
                    }
                }
            }
        }
}

main().