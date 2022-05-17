// Testing JSON to write, save setting for aircraft script

function SAVESET {
    local LEXI to lexicon(
        "OPTSPEED", OPTSPEED,
        "OPTALT", OPTALT
    ).
    local filepath is path("0:/json/" + ship:name + "/autopilot.json").
	writejson(LEXI, filepath).
}

function LOADSET {
    local filepath is path("0:/json/" + ship:name + "/autopilot.json").
    if exists(filepath) {
        local LEXI is readjson(filepath).
        if LEXI:haskey("OPTSPEED") set OPTSPEED to LEXI["OPTSPEED"].
        if LEXI:haskey("OPTALT") set OPTALT to LEXI["OPTALT"].
        hudtext("Loaded vessel settings from " + filePath,15,2,25,cyan,false).
        return true.
    }
    else return false.
}
LOADSET().