clearScreen.
wait 2.
print "DasKrusty's Automated Flight System".
wait 2.
print "Attempting to establish a connection".
wait 2.
if ControlConnection:isconnected {
    print "Connection is available, establishing a connection".
    wait 3.
    print "Connected".
}
else {
    print "Error, could not establish a connection".
    wait 3.
    print "Extend antennas else wait until connection is established".
    wait until homeConnection:isconnected.
}

set VAB to latlng(-0.097207,-74.557674).
set SPH to latlng(-0.048617,-74.724722).

// print VAB:distance + "m".
// print SPH:distance + "m".

wait 3.
print "Attempting to verify type of craft".
wait 2.
print "Running scan...".
wait 2.

if core:tag = "Aircraft" {
        print "Craft recognised previously as an aircraft...".
        wait 2.
        print "Script found on local drive and booting".
        wait 2.
        print "Booting... Please wait.".
        wait 3.
        run Aircraft.
}

if core:tag = "Rocket" {
        print "Craft recognised previously as a rocket type...".
        wait 2.
        print "Script found on local drive and booting".
        wait 2.
        print "Booting... Please wait.".
        wait 3.
        run Rocket.
}

if VAB:distance < SPH:distance {
    if not exists("1:Rocket.ks") {
        print "ERROR... Script not found".
        wait 1.
        print "Searching Archive".
        wait 1.
        print "Archive scripts to follow".
        switch to 0.
        wait 1.
        list files.
        wait 1.
        switch to 1.
        copyPath("0:/KSP_KOS/Rocket.ks","1:Rocket.ks").
        print "Copying script to local server...".
        set core:tag to "Rocket".
        print "Script found on local drive and booting".
        wait 1.
        print "Booting... Please wait.".
        wait 3.
        run Rocket.
}
}

if VAB:distance > SPH:distance {
    if not exists("1:Aircraft.ks") {
        print "ERROR... Script not found".
        wait 1.
        print "Searching Archive".
        wait 1.
        print "Archive scripts to follow".
        switch to 0.
        wait 1.
        list files.
        wait 1.
        switch to 1.
        copyPath("0:/KSP_KOS/Aircraft.ks","1:Aircraft.ks").
        print "Copying script to local server...".
        set core:tag to "Aircraft".
        print "Script found on local drive and booting".
        wait 1.
        print "Booting... Please wait.".
        wait 3.
        run Aircraft.
}
}