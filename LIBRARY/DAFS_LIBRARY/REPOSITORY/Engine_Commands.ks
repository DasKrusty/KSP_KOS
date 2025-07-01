//ENGINE COMMANDS
LIST ENGINES IN myVariable.
    FOR eng IN myVariable {
    eng:TOGGLEMODE.
    Print "Engine ISP" + Eng:isp.
    }