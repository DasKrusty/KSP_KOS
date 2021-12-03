clearScreen.
wait 1.
print "DasKrusty's Automated Flight System".
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
wait 1.
switch to 0.
        list files.
        // wait 1.
        // switch to 1.
        // // copy Aircraft.ks from 0.
        // copyPath("0:Aircraft.ks","1:Aircraft.ks").
        // run Aircraft.
// C:\Program Files (x86)\Steam\steamapps\common\Kerbal Space Program\Ships\Script\KSP_KOS\.vscode\DAFS_MAIN\Aircraft.ks
// print "Connection delay is " + vessel:connectiondelay + " sec".

// if ship:heading = north {
//     if not exists("1:Rocket.ks") {
//         copyPath("0:Rocket.ks").
//         run Rocket.
//     }}
// else {
//     if not exists("1:/Aircraft.ks") {
//         switch to 0.
//         list files.
//         wait 1.
//         switch to 1.
//         copy Aircraft. from 0.
//         run Aircraft.
//     }
// }