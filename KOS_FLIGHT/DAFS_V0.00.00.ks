function Main{  
    doGUI(). 
}

function doGui{
    clearguis().
    clearscreen. print "GUI starting up".
    wait 1.
    //core:part:getmodule("kOSProcessor"):doevent("Close Terminal").

    //WINDOW SIZING
    local WIN_OPEN is (500).

    local g is gui(WIN_OPEN).

    //GUI LAYOUT
    //TITLE
    local TITLE to g:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.00.18" + "</i>").

    g:show().
//GUI END DESIGN
}



main().