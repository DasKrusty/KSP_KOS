LIST ENGINES IN engines.
 
set laststage to 0.
 
SET countdown to 10.
 
lock steering to up + R(0,0,180).
lock throttle to 1.
 
until countdown=0 {
    set countdown to countdown-1.
    clearscreen.
    print countdown+" seconds to launch.".
    
    wait 1.
}
print " ".
print " ".
print " ".
 
//autostaging
set stageneeded to true.
when stageneeded and TIME:SECONDS>laststage+2 then {stage. print "Stage separated.". set stageneeded to false. preserve.}.
when maxthrust = 0 and not stageneeded then { stage. print "Staging...". set stageneeded to true. set laststage to TIME:SECONDS. preserve.}.
//end autostaging
 
set orbitalt to 2868.75*1000.
 
set planningnode to false.
set nodeplanned to false.
 
when altitude > 10000 then {lock steering to up + R(0,0,180) + R(0,-30,0).
    when altitude > 20000 then {lock steering to up + R(0,0,180) + R(0,-60,0).
        when altitude > 71000 then {PANELS ON. print "Extending solar panels...".}.
    }.
}.
 
when apoapsis > orbitalt-orbitalt/5 then {lock throttle to 0.3.
    when apoapsis > orbitalt-orbitalt/10 then {lock throttle to 0.1.
        when apoapsis > orbitalt-orbitalt/20 then {lock throttle to 0.01.
            when apoapsis > orbitalt then {lock throttle to 0. print "ENGINE OFF". set planningnode to true.
                when planningnode then {
                    print "Start orbit adjustament program...".
                    set orbitalvelocity to sqrt((3.5316*10^12)/(orbitalt+600000)).
                    print "Orbital Velocity = " + round(orbitalvelocity,1) + "m/s".
                    SET deltav TO orbitalvelocity-(velocityat(ship, time:seconds+(eta:apoapsis)):orbit:mag).
                    SET node TO NODE(time:seconds+eta:apoapsis, 0, 0, deltav).
                    ADD node.
                    print "Maneuver node planned.".
                    set nodeplanned to true.
                }.
            }.
        }.
    }.
}.
 
 
 
 
 
 
//GRAPHICS
print "APOAPSIS:" at(0,0).
print "0%|------------------------------------------|100%" at(0,1).
print "ALTITUDE:" at(0,2).
print "0%|------------------------------------------|100%" at(0,3).
until nodeplanned {
    print "=" at((apoapsis*41/orbitalt)+3,1).
    print "=" at((altitude*41/orbitalt)+3,3).
    
    //Autostaging for radial engines
    FOR eng IN engines {
    
        if eng:flameout and eng:thrust = 0 {
            stage.
            LIST ENGINES IN engines.
        }.
    }.
    wait .5.
}.
 
//END GRAPHICS
 
lock throttle to 0.
unlock throttle.
unlock steering.
 
run execnode.
 
lock throttle to 0.
unlock throttle.
unlock steering.