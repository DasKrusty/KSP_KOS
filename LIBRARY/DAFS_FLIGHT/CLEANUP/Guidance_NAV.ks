// ---TEST BENCH--- //

function main {
    doLOCKSTEERING().
}

//circularization script, starts immediately when called.

function doLOCKSTEERING{
    clearscreen.
    wait 1.
    print "Lock Steering Test 1".
    wait 1.
    //set th to 0.
    //lock throttle to th.
    set dV to ship:facing:vector:normalized.
    //lock steering to lookdirup(dV, ship:facing:topvector).
    lock steering to lookdirup(dV,30).
    print "Heading " + round(ship:facing:vector:normalized).
}.

main().

That Gui looks great!
So if you want to update the text of a label, you need to assign a variable to that particular label and update it in a loop.

First create a variable called 'airspeedLabel'.

local airspeedLabel is BoxC:addlabel("Speed: " + "nan").

Now to actually have it display your airspeed, you need to continuously update the label in a loop:

set airspeedLabel:text to ("Speed: " + ROUND(airspeed) + " m/s").

I see your code runs mostly on triggers and 'wait' statements. This is not the best combination with continuously updating labels. It might be best to invest a bit of time to convert the overall structure to a main loop that controls all individual functions. For example:

// Main Loop
until false {
updateGUI().
flightManager().
}

In this situation you would have the updateGUI() function update all labels in the GUI, and the flightManager() function control the vessel.

Be careful not to use Triggers like 'when', and 'wait' statements' in a loop.

function displayWidgetFactory {
  parameter parentWidget, labelName, updateDisplay.

  // set up widgets  
  local hBox to parentWidget:addHBox().
  local labelBox to hBox:addLabel("Altitude").
  local valueBox to hBox:addLabel(updateDisplay()).
  
  function update {
    set valueBox:text to updateDisplay().
  } 

  return lexicon( "update", update@ ).
}

// used like this:
local mygui to GUI(500).
local altitudeDisplay to displayWidgetFactory(mygui, "altitude", {return ship:altitude.}).
mygui:show().

// then later to refresh the display:
altitudeDisplay:update().

Engine:MODES
Access:	Get only
Type:	List of strings
Lists names of modes of this engine if multimode, returns a list of 1 string “Single mode” otherwise.