FOR P IN SHIP:PARTS {
  LOG ("MODULES FOR PART NAMED " + P:NAME) TO MODLIST.
  LOG P:MODULES TO MODLIST.
}.

SET MOD TO P:GETMODULE("some name here").
LOG ("These are all the things that I can currently USE GETFIELD AND SETFIELD ON IN " + MOD:NAME + ":") TO NAMELIST.
LOG MOD:ALLFIELDS TO NAMELIST.




set mySlider:ONCHANGE to whenMySliderChanges@.

function whenMySliderChanges {
  parameter newValue.

  print "Value is " +
         round(100*(newValue-mySlider:min)/(mySlider:max-mySlider:min)) +
         "percent of the way between min and max.".
}