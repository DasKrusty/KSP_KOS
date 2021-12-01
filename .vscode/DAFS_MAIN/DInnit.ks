clearScreen.
wait 1.
if homeConnection:isconnected {
    print "Connection is available".
    wait 3.
    print "Connected".
}
else {
    print "Error".
    wait 3.
    print "Extend antennas else wait until connection is established".
    wait until homeConnection:isconnected.
}

print "Connection delay is " + vessel:connection:delay + " sec".

if vessel:name "Plane". {
    if not exists("1:DAFS_V0.02.73.ks") {
        copyPath("0:DAFS_V0.02.73.ks").
        run DAFS_V0.02.73.
    }
}
if vessel:name "Rocket". {
    if not exists("1:DASLaunch.ks") {
        copyPath("0:DASLaunch.ks").
        run DASLaunch.
    }
}