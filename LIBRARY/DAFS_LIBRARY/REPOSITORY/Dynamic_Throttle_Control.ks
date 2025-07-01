set DAT to SETTINGS_BOX:addcheckbox ("Dynamic Auto Throttle"). //Used in a GUI
    set DAT:toggle to true.
        set DAT:ontoggle to {
            parameter C.
            if C {
                doAutomaticThrottleControl().
            }
            else {
                unlock throttle.
            }
        }.

function doAutomaticThrottleControl {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
}