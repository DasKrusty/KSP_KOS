// Broken Launch Script

lock throttle to 1.
stage.
wait 1.
stage.

// until ship:maxthrust > 0 { stage. }

lock targetPitch to 88.963 - 1.03287 * alt:radar^0.409511.
set targetDirection to 90.
lock steering to heading(targetDirection, targetPitch).

set oldThrust to ship:avaiLablethrUST.
until apoapsis > 100000 {
  // print apoapsis.
  print "Available: " + ship:availablethrust.
  print "Old: " + oldThrust.
  if ship:availablethrust < (oldThrust - 10) {
    stage. wait 1.
    set oldThrust to ship:availablethrust.
  }
}

lock throttle to 0.
lock steering to prograde.

wait until false.