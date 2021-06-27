//Purpose of this code is to figure out what direction the craft is facing and then locking the heading to that current direction.
//Used for my auto take off and locking heading.

set NDIR to (ship:bearing - 180).   //Set new direction for steering
    sas off.
    lock steering to heading(NDIR,TWR * 1.5).