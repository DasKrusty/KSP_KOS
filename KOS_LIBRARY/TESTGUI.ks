function Main {
    // doAirSpeed().
    doGUI(). 
}

// function doAirSpeed {
//     when airspeed < 0 then {
//         set ASL to ship:airspeed.
//         preserve.
//         }
// }



function doGui{
//GUI Settings
    //GUI Styling
    clearguis().
    clearscreen. 
    print "GUI running.".
    local gui is gui(500).
        //GUI Content
            gui:addlabel("DASKRUSTY AUTOMATED FLIGHT MODE   V1.01").
        set BoxTit to gui:addhbox().
            local NAME is BoxTit:addlabel("NAME:   " + ship:Name). 
            local HIDE to BoxTit:addbutton ("_").
                set HIDE:style:width to 50.
            local XBUT to BoxTit:addbutton ("X").
                set XBUT:style:width to 50.
        set BoxTop to gui:addhbox().
            BoxTop:addlabel ("CURRENT STATUS:   ").
        set BoxCen to gui:addhbox().
            set BoxLef to BoxCen:addvbox().
            set BoxLef:style:width to 120.
            set BoxLef:style:align to "left".
                    BoxLef:addlabel("RUNMODE: ").
                    local TKO to BoxLef:addbutton ("Take Off").
                    local AUP to BoxLef:addbutton ("Auto Pilot").
                    local FRE to BoxLef:addbutton ("Free Flight").
                    local LAN to BoxLef:addbutton ("Land").
                    local TES to BoxLef:addbutton ("Test").
            set BoxMid to BoxCen:addvbox().
                    BoxMid:addlabel("INFORMATION:").
                    // BoxMid:addlabel("Speed: " + ROUND(ASL) + " m/s" ).
            set BoxRig to BoxCen:addvbox().
                    set BoxRig:style:width to 140.
                    BoxRig:addlabel("SETTINGS:").
                    local AUT is BoxRig:addradiobutton("Auto Throttle",false).
                    local TE2 is BoxRig:addradiobutton("Test 2",false).
                    local TE3 is BoxRig:addradiobutton("Test 3",false).
                    local TE4 is BoxRig:addradiobutton("Test 4",false).
                    local TE5 is BoxRig:addradiobutton("Test 5",false).
        set BoxBot to gui:addhbox().
            BoxBot:addlabel("LAST STATUS: ").
        //GUI Content
    //GUI Styling
gui:show().
//GUI Settings.
//TRIGGERS
LOCAL isDone IS FALSE.
set XBUT:onclick to doGUIHide@. // Hides GUI
set TKO:onclick to doTakeOff@. // Takeoff
set AUP:onclick to doAutoPilot@. // Auto Pilot
set FRE:onclick to doFreeFlight@. // Free Flight
set LAN:onclick to doLand@. // Land
set TES:onclick to doTest@. //Test
//set ATP:ONCHANGE to doAutomaticThrottleControl@.
wait until isDone.
//TRIGGERS

}
//FUNCTIONS


function doGUIHide {    //Hide GUI
    GUI:hide().
}

function doTakeOff {    //Control Take Offs
    sas off.
    Print "NAME:" + ship:name.
    print "READING CRAFT STATS".
    wait 1.
    print "starting precheck".
    lock throttle to 1.
    brakes on.
    stage.
    LIST ENGINES IN myVariable.
    FOR eng IN myVariable {print "Thrust: " + eng:thrust.}
    print "Available Thrust: " + availableThrust.
    set TWR to availableThrust / ship:wetmass.
    print "TWR: " + ROUND(availableThrust / ship:wetmass).
    print "Total Fuel: " + ROUND(ship:liquidfuel).
    print "TKO PITCH: " + ROUND(TWR * 1.5) + " Degrees".
    wait 2.
    lock throttle to 0.
    ag1 on.                             //AG1 is flaps
    lights on.
    lock steering to heading(90,0).    //Initial setting
    wait 3.
    print "precheck done".
    brakes off.
    wait 1.
    doThrott().
    lock steering to heading(90,TWR * 2).
    print "Starting Roll".
    when airspeed > 30 then {
        print "Taking Off".
    }
    wait until altitude > 500. {
        lock steering to heading(90,TWR * 3).
        ag1 off. //FLAPS
        gear off.
        lights off.
    }
    when altitude > 1000 then {
        lock steering to heading(90,2).
        wait 15.
        set thrott to ((thrott - ship:dynamicpressure) - 0.25).
        set ship:control:pilotmainthrottle to thrott.
        sas on. 
        print "TAKEOFF COMPLETE".  
        unlock all.
    }
}

function doAutoPilot {  //Auto Pilot
    //Code here
}

function doFreeFlight { //Free Flight
    //Code here
}

function doLand {       //Land
    //Code here
}

function doTest {       //Test
    //Code here
}

function doThrott {
    set thrott to 1.
    wait 1.
    lock throttle to (thrott - ship:dynamicpressure).
}

function displayWidgetFactory {
  parameter parentWidget, labelName, updateDisplay.

  // set up widgets  
  local hBox to parentWidget:addHBox().
  local labelBox to BoxMid:addLabel("Altitude").
  local valueBox to BoxMid:addLabel(updateDisplay()).
  
  function update {
    set valueBox:text to updateDisplay().
  } 

  return lexicon( "update", update@ ).
}

altitudeDisplay:update().
//FUNCTIONS
Main().