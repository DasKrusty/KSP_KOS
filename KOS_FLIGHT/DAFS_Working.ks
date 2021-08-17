function MAIN{
    funcGUI().
    until false.
}

function funcGUI{
    clearguis().
    clearscreen. print "GUI starting up".
    wait 1.
    core:part:getmodule("kOSProcessor"):doevent("Close Terminal").
    // local EXITGUI is false.
    // set EXITGUI to false.
    
    //[GUI BODY SETTINGS]
    set WIN_OPEN to 500.
    set WIN_MIN to 77.
    set G_MAIN to gui(WIN_OPEN).
    set G_MAIN:x to 50. //main gui starting position
    set G_MAIN:y to 50.	//main gui starting position
    set G_MAIN:style:padding:h to 5.    //main gui padding
    set G_MAIN:style:padding:v to 5.    //main gui padding
    set G_MAIN:style:height to WIN_OPEN.    //set gui to window open size 
}

MAIN().