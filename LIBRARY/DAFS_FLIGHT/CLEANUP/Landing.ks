// ---TEST BENCH--- //

function main {
    doLOCKSTEERING().
}

//circularization script, starts immediately when called.

function doLOCKSTEERING{
    clearscreen.
    wait 1.
    print "Lock Steering Test 1".
    wait 1.
    //set th to 0.
    //lock throttle to th.
    set dV to ship:facing:vector:normalized.
    //lock steering to lookdirup(dV, ship:facing:topvector).
    lock steering to lookdirup(dV,30).
    print "Heading " + round(ship:facing:vector:normalized).
}.

main().