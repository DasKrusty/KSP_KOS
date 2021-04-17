//Script to test planes
//PROCESS: Start / Climb at 10 and print every 1000m / When reach max alt go down to 1000m / find max climb rate

//TARGET FLIGHT
// set TDi to 90.       //Target Direction - 90 = East / 180 = South...
// set THR to 1.0.      //Throttle Control for Thrust
//TARGET FLIGHT

//MAIN FUNCTON
function Main {
    clearScreen.
    LIST ENGINES IN myVariable.
    FOR eng IN myVariable {print "Thrust: " + eng:thrust.}
    print "Available Thrust: " + availableThrust.
    doPreCheck().
    doTakeOff().
    //when altitude > 1000 then {doMaxClimb().}
    //doClimbControl().
    // doMaxCeiling().
    // doDrop().

}
//MAIN FUNCTION

function doPreCheck {
    //clearScreen.
    Print "NAME:" + ship:name.
    print "Total Fuel: " + ROUND(ship:liquidfuel).
    print "starting precheck".
    wait 1.
    ag1 on.
    wait 1.                             //AG1 is flaps
    lights on.
    wait 1.
    lock steering to heading(90,0).    //Initial setting
    wait 1.
    print "precheck done".
}

function doTakeOff {
    print "takeoff prepped".
    wait 3.
    stage.
    wait 1.
    print "engine activated".
    wait 1.
    lock throttle to 1.
    wait 3.
    //doThrotCont().
    wait 1.
    //Toggle mode of Engine
    LIST ENGINES IN myVariable.
    FOR eng IN myVariable {
    eng:TOGGLEMODE.
    }.
    //Toggle mode of Engine
    lock steering to heading(90,5).
    print "Starting Roll".
    wait 5.
    print "Taking Off".
    lock steering to heading(90,30).
    wait until altitude > 500. {
        ag1 off. //FLAPS
        gear off.
        lights off.
        //Toggle mode of Engine
        LIST ENGINES IN myVariable.
        FOR eng IN myVariable {
        eng:TOGGLEMODE.
        }.
        //Toggle mode of Engine
    }
    wait until altitude < 1500. {
        lock steering to heading(90,5).
    }
}

// function doThrotCont {
//     local dynThrot is max(0, min(1, 1 - ((Ship:Q * k) / (Ship:Mass * (Ship:Body:MU / (Ship:Body:Radius + Altitude) ^ 2))).
// }

// function doThrotCont{
// 	return max(0, min(1,1 - (ship:verticalspeed / ship:termvelocity))).
// }

// function doThrotCont {
//   parameter desired_accel.
//   lock throttle to max(0, min(1, desired_accel / (ship:maxthrust / ship:mass))).
// }

// function doThrotCont {
//     print "throttle control activated".
//     SET srfGrav TO BODY:mu / BODY:RADIUS^2.
//     SET desiredSrfTWR TO THR.
//     LOCK THROTTLE TO SHIP:AVAILABLETHRUST/(SHIP:MASS*srfGrav*desiredSrfTWR).
// }

// function doMaxClimb {
//     print "@ 1000m".
//     lock steering to heading(90,10).
//     set NAS to airspeed.
//     wait 1.
//     if NAS < airspeed {
//         lock throttle to 0.
//         wait 1.

//     }
//     else if NAS > airspeed {
//         lock throttle to 1.
//     }
// }

// function doClimbControl{
//     wait 1.
//     if SPD < airspeed {
//         lock steering to heading(90,PIT + 1).
//         wait 1.
//         set SPD to airspeed.
//     }
//     else if SPD > airspeed {
//         lock steering to heading(90,PIT - 1).
//         wait 1.
//         set SPD to airspeed.
//     }
    
// }

// set newalt to 1000.
// set totfuel to ship:liquidfuel.

// when altitude > newalt then {
//     print "ALT: " + altitude + "m".
//     print "SPE: " + airspeed + "m/s".
//     print "Km/h: " + (airspeed * 3.6 / 60) + "km/h".
//     print "MAT: " + maxThrust + "Kw".
//     print "FUE: " + totfuel + "L".
//     print "" + ship:liquidfuel + "".
//     PRINT "There is " + SHIP:LIQUIDFUEL + " liquid fuel on the ship.".
//     PRINT "There is " + STAGE:LIQUIDFUEL + " liquid fuel in this stage.".
//     wait 3.
//     set newalt to (newalt + 1000).
//     preserve.
//STAGE:"LIQUIDFUEL".
// print "Consumption:" + engine:fuelflow.
// print "ISP: " + engine:isp.
// print "max thrust: " + engine:maxthrust.
// print "thrust: " + engine:thrust.
// }

main().
wait until false.

