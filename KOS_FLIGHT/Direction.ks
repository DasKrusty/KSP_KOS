//circularization script, starts immediately when called.
set th to 0.
lock throttle to th.
set dV to ship:facing:vector:normalized.
lock steering to lookdirup(dV, ship:facing:topvector).