// This function automatically adjusts the crafts speed based on how much dynamic atmospheric pressure the craft is facing.

// Version 0.08 - Not tested
function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
    }