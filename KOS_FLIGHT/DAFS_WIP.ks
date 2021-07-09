//DASKRUSTY'S AUTOMATED FLIGHT SYSTEM 
//VERSION 0.03.08

//IDEAS
    //show / hide TKO based on status "landed"
    //slider to control dynamic auto throttle
    //switch between mach / km/h m/s - speed indicator

//[[[M A I N   F U N C T I O N]]]
function Main{
    doGUI().
}

//[[GUI FUNCTION]]
function doGUI{
    clearguis().
    clearscreen. print "GUI starting up".
    //set EXITGUI to false.
    wait 1.
    //core:part:getmodule("kOSProcessor"):doevent("Close Terminal").

    //[GUI STYLING SETTINGS]
    function G_MAIN_TITLE{
        parameter G_MAIN_TITLE.
            set G_MAIN_TITLE:style:textcolor to red.
    }
    function G_MAIN_HEADER{                 //header box styling
        parameter G_MAIN_HEADER.
            set G_MAIN_HEADER:style:width to 500.
    }
    function G_MAIN_HEADER_NAME{            //title heading
        parameter G_MAIN_HEADER_NAME.
            set G_MAIN_HEADER_NAME:style:textcolor to yellow.
    }
    function MIN_BUT{                       //minimise button
        parameter MIN_BUT.
            set MIN_BUT:style:textcolor to yellow.
            set MIN_BUT:style:width to 50.
    }
    function CAN_BUT{                       //close button
        parameter CAN_BUT.
            set CAN_BUT:style:width to 50.
            set CAN_BUT:style:textcolor to yellow.
    }
    function G_MAIN_STATUS{
        parameter G_MAIN_STATUS.
            //set
    }

    //[GUI BODY SETTINGS]
    set WIN_OPEN to 500.
    set WIN_MIN to 77.
    set G_MAIN to gui(WIN_OPEN).
    set G_MAIN:x to 50. //main gui starting position
    set G_MAIN:y to 50.	//main gui starting position
    set G_MAIN:style:padding:h to 5.    //main gui padding
    set G_MAIN:style:padding:v to 5.    //main gui padding
    set G_MAIN:style:height to WIN_OPEN.    //set gui to window open size 

    //[GUI FUNCTION SETUP]
    //[TITLE]
    set G_MAIN_TITLE to G_MAIN:addlabel("<b>" + "DASKRUSTY AUTOMATED FLIGHT SYSTEM" + "</b>" + "<i>" + "                                       V0.03.08" + "</i>").
    //[LEVEL ONE - HEADER BOX]
    set G_MAIN_HEADER to G_MAIN:addhlayout. //first level within gui
        set G_MAIN_HEADER_TITLE to G_MAIN_HEADER:addlabel ("<b>" + "NAME: " + "</b>").  //heading
        set G_MAIN_HEADER_NAME to G_MAIN_HEADER:addlabel ("<b>" + ship:name + "</b>").  //print out of craft name
        set MIN_BUT to G_MAIN_HEADER:addbutton ("_"). //Minimise button
            //set MIN_BUT:style:width to 50. 
            set MIN_BUT:toggle to true.
                set MIN_BUT:ontoggle to { 
                    parameter MINIMISE. 
                    if MINIMISE {
                        set G_MAIN:style:height to WIN_MIN.
                        G_MAIN_STATUS:hide.
                        // MAIN_BOX:hide.
                        // REF_BOX:hide.
                        // SCROLL_BOX:hide.
                    }
                    else {
                        set G_MAIN:style:height to WIN_OPEN.
                        G_MAIN_STATUS:show.
                        // MAIN_BOX:show.
                        // REF_BOX:show.
                        // SCROLL_BOX:show.
                    }
                }.
        set CAN_BUT to G_MAIN_HEADER:addbutton ("X"). //Close
            // set CAN_BUT:style:width to 50.
            // set CAN_BUT:style:textcolor to yellow. 
            set CAN_BUT:onclick to {doCLOSEGUI().}.
    //[LEVEL TWO - STATUS BOX]
    //set G_MAIN_STATUS to G_MAIN:addhlayout.

}

function doCLOSEGUI{
    // G_MAIN_HEADER_STATUS:clear.
    // G_MAIN_HEADER_STATUS:addlabel("Closing GUI").
    // SCROLL_BOX:addlabel("Closing GUI").
    wait 3.
    //set EXITGUI to true.
    print "closing".
    G_MAIN:hide().
}

Main().