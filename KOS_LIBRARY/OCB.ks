//COPIED BITS OFFICIAL WORKING CODE

//ENGINE COMMANDS
LIST ENGINES IN myVariable.
    FOR eng IN myVariable {
    eng:TOGGLEMODE.
    Print "Engine ISP" + Eng:isp.
    }
//ENGINE COMMANDS

//THROTTLE COMMANDS
//Test 1 - Unsuccessful
function doThrotCont{
	return max(0, min(1,1 - (ship:verticalspeed / ship:termvelocity))).
}
//Test 2 - Unsuccessful - parameter desired_accel. is issue
function doThrotCont {
parameter desired_accel.
  lock throttle to max(0, min(1, desired_accel / (ship:maxthrust / ship:mass))).
}

local dynThrot is max(0, min(1, 1 - ((Ship:Q * k) / (Ship:Mass * (Ship:Body:MU / (Ship:Body:Radius + Altitude) ^ 2))).

set drag to ((ship:maxthrust / ship:mass) * throttle * ship_forward_vector + gravity_vector):length - ((speed_last - speed_now) / delta_t).

//PRINTS
//SHIP INFO
Print "NAME: " + ship:name.
print "Total Fuel: " + ROUND(ship:liquidfuel).
