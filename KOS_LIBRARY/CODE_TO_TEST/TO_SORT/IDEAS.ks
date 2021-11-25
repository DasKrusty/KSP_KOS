ALTITUDE[1] 	ALT:RADAR[1]

ETA:APOAPSIS[1] 	ETA:PERIAPSIS[1]

Explanations:
Commands:
Self explaining commands:

Click to expand/shrink
•   BREAK

Click to expand/shrink
•   CLEARSCREEN

Click to expand/shrink
•   REBOOT

Click to expand/shrink
•   SHUTDOWN

Click to expand/shrink
•   STAGE
Math Functions:

Click to expand/shrink
•   SIN(<float>),COS(<float>),TAN(<float>)

Click to expand/shrink
•   ARCSIN(<float>),ARCCOS(<float>),ARCTAN(<float>)

Click to expand/shrink
•   ARCTAN2(<float>)

Click to expand/shrink
•   ABS(<float>)
Execution Flow Control:

Click to expand/shrink
•   {<set_of_commands>}

Click to expand/shrink
•   IF <compare_expression>[<COMMANDS>]

Click to expand/shrink
•   RUN <file>[(parameter_list)]

Click to expand/shrink
•   UNTIL <compare_expression_or_boolean>{ <commands> }

Click to expand/shrink
•   WAIT <float:_time_in_seconds>

Click to expand/shrink
•   WAIT UNTIL <compare_expression_or_boolean>

Click to expand/shrink
•   WHEN <compare_expression> THEN <statement_or_block>

Click to expand/shrink
•   ON <AGX|SAS|RCS|bool_var*|float_var*> [<DO SOMETHING.>]
Manipulating booleans:

(Also works for any numerical variable. Turning a number "on" makes it a 1. Turning it "off" makes it a 0.)

Click to expand/shrink
•   <bool_var*|float_var*> ON|OFF

Click to expand/shrink
•   TOGGLE <any_boolean_variable>

(Also see the ON command above, which operates on booleans but is a flow control command).
other:
Click to expand/shrink
•   COPYPATH ("<volumefrom>:/<file>","<volumeto>:/<file>"
Click to expand/shrink
•   DECLARE <new_variable>
Click to expand/shrink
•   DECLARE PARAMETER <variable>[,<variable>[,...]]
Click to expand/shrink
•   DELETE <file>[FROM <volume>]
Click to expand/shrink
•   EDIT <file>
Click to expand/shrink
•   LIST VOLUMES|FILES|PARTS|RESOURCES|ENGINES|TARGETS|BODIES
Click to expand/shrink
•   LOCK <variable> TO <expression>
Click to expand/shrink
•   UNLOCK <variable>
Click to expand/shrink
•   LOG <string_to_be_appended_to_the_file> TO <file>
Click to expand/shrink
•   PRINT <string> [AT(<integer_x*>,<integer_y*>)]
Click to expand/shrink
•   RENAME VOLUME|FILE <volume_or_file_name> TO <new_name>
Click to expand/shrink
•   SET <variable>TO <value>
Click to expand/shrink
•   SWITCH TO <volume_number_or_volume_name>
System Variables:
Lockable variables:

    Only to be used with LOCK and UNLOCK. (Not with SET. They don't have the desired effect when used with SET.)

    STEERING[1]

    THROTTLE[1]

    WHEELSTEERING[1]
    WHEELTHROTTLE[1]

Bindings:

    ABORT[1] 	AG<1-10>[1] 	BRAKES[1] 	GEAR[1] 	LIGHTS[1] 	RCS[1] 	SAS[1] 	TARGET[1]

System variables:

    ALTITUDE:

    ALTITUDE[1] 	ALT:RADAR[1] 	ALT:APOAPSIS[1] 	ALT:PERIAPSIS[1] 	APOAPSIS[1] 	PERIAPSIS[1] 

    TIME:

    ETA:APOAPSIS[1] 	ETA:PERIAPSIS[1] 	ETA:NODE[1] 	MISSIONTIME[1] 	SESSIONTIME[1] 	WARP[1] 

    Speed:

    ANGULARMOMENTUM[1] 	ANGULARVEL[1] 	SURFACESPEED[1] 	VERTICALSPEED[1] 	VELOCITY[:SURFACE|ORBIT|SURFACEHEADING][1]

    Steering:

    <Direction>:PITCH|YAW|ROLL[1] 	FACING[1] 	GEOPOSITION[1] 	HEADING[1] 	LATITUDE[1] 	LONGITUDE[1]
    MAG:NODE[1] 	NORTH[1] 	PROGRADE[1] 	RETROGRADE[1] 	UP[1] 	NODE[1]

    other:

    AV[1] 	BODY[1] 	MASS[1] 	MAXTHRUST[1] 	STATUS[1] 	STAGE[:<ressource>][1]
    TARGET[:DISTANCE|DIRECTION|BEARING|HEADING][1] 	VESSELNAME[1]
    <<name_of_any_resource>> 	

Note: This last one collides with my explanation style.

Other Informations:
To be Placed on this site:

    Time[:clock|:calendar|:day|:year|:hour|:minute|:second]
    add Node(,<delta_v_x>,<delta_v_y>,<delta_v_z>)

        set to Node(). add .
        [:deltav|:deltav:mag]

    nextnode[:eta]
    encounter[:peripapsis]
    remove node|nextnode

Upcomming features:

    FLOOR(),CEILING(),ROUND(), SQRT()
    T() Value = new TimeSpan(parameters[0]);
    CALL <???>[1]

Not working, without function or only partly implemented:
Notes:

    Info about command extracted from the source codes (18.09.2013)

    *= Additional mentioned in the source code, but functionality hasn't been tested yet.

Wikiupdate:

In here is the data for the next Update of this wiki page:
Categories:

    Article stubs
    KerboScript

Community content is available under CC-BY-SA unless otherwise noted.
Add a comment about List of all Commands

8 comments
A Fandom user
·2014/07/07

kOS development is now being handled by a tight-knit group of dedicated code junkies, and they're posting the updated commands here:

http://ksp-kos.github.io/KOS_DOC/

I hope this makes it to the front of the line.
Write a reply
A Fandom user
·2013/12/03

TARGET also has the following members... Don't know how it would look on the tables avobe.

ALTITUDE
ANGULARMOMENTUM
ANGULARVEL
APOAPSIS
BEARING
BODY
DIRECTION
DISTANCE
FACING
GEOPOSITION
HEADING
LATITUDE
LONGITUDE
MASS
MAXTHRUST
NORTH
PERIAPSIS
PROGRADE
RETROGRADE
SENSOR
SURFACESPEED
TERMVELOCITY
UP
VELOCITY
VERTICALSPEED
VESSELNAME
A Fandom user
·2013/12/03

Hmm... My kOS 0.9.1 (last one) doesn't recongize TARGET as a variable. If you asing it of course you'll have a VesselTarget variable with all those members.
User avatar
BiZZ Keryear
·2013/12/04

Registering would make it kinda easier to to track who you are ... as a "A Wikia contributor" you are only one of 7 billion potential ...

Anyway. Target is a variable. And the last kOS is 0.9.2 .. which claims to be 0.9.1 ...

And because a lot of changes ... btw. this list is still based on version 0.7 ... that happend after 0.9.2 my update of the docu is kinda stuck. And right now I haven't time to test out what is in and whats not, and that also would be for naught in the moment Kevin comes back and makes an update...

Just expand the point Wikiaupdate and see what else might be in ...
Rosco P. Coltrane
·2013/12/04

I'm basing all this in the soruce that I got from Github, which, now that I think about it, is not the version I have installed at all. :s

BTW,  yep, I reckon that keeping this updated could be a big task. I'm writing an IDE for kOS so I'm working on a code that extracts some of this info on it's own... more or less. (see the discussion I started as anonymous).  
Write a reply
A Fandom user
·2013/12/03

Added "ORBIT" and "SURFACEHEADING" to "VELOCITY" in the System Variables section.



My first time ever editing a wiki, so please rollback any changes if innapropiate and let me know please so I learn. :)
Write a reply
Steven Mading
·2013/11/05

I added expansion explanations to STEERING and THROTTLE but didn't know how to do it with your templates so I did it manually with DIVs feel free to re-work it to use the template.

I refrained from explaining WHEELSTEERING and WHEELTHROTTLE because I haven't used them enough yet to feel autoritative about how they work.
Write a reply
Steven Mading
·2013/11/04

There was some inconsistency with the list of commands and whether special variables were treated as part of the command or as arguments.  For example, the commands:

blah ON,  blah OFF, and   TOGGLE blah.

treated RCS and SAS and such as if they were special case keywords when they're not.  They're just variables - but they're predefined variables rather than ones the user made.

It makes more sense to just document the TOGGLE command as "it flips a boolean variable", and then elsewhere further down in the section on special built-in variables explain that SAS and RCS and so on are special case boolean variables that have magic effects when they're flipped.

Similarly the fact that the event trigger "ON AG5 do blah" works with action groups isn't really *part* of the ON command itself.  The command just operates on any boolean, and AG5 is a boolean.

Similarly when explaining the LOCK and UNLOCK commands:  The fact that you can steer by using LOCK STEERING isn't due to the LOCK command.  It's due to the special handling of the STEERING variable and how the KOS computer reacts to it being manipulated.  Therefore the explanation that you can steer by using LOCK STEERING TO xxxxx doesn't belong in the LOCK command.  It belongs in the explanation of the special variable called STEERING.

I say all this as a defense of my edits and an explanation of why some things you had in there are missing now.  It's not that they should be removed, but that they belong further down the page out of the part that's meant to be a terse list of the commnds.

If you disagree feel free to revert my edits, but I thin think this is a lot cleaner.
User avatar
BiZZ Keryear
·2013/11/05

That's why a different point of view often make the difference.

Thats was something I didn't thought of... Maybe because I have read it that way in source files. Well can't remember that well. There also where some issues at that time of grouping things which used the same keyword but where at different places in the sources...

But I still think there might be unexperienced user can stumble on it so the most common keywords should me mentioned separately to get the intended usage on the 1st grasp.

Not everyone might get it at 1st sight that SAS and so on are Booleans.

Albert Einstein:

    "Two things are infinite: The universe and human stupidity, and I'm not sure about the universe."


All in all I like very much (most of) your changes. I think its a step in right way. This page still needs lot of work, though.
Write a reply
Steven Mading
·2013/09/26

I approve of the template style if for no other reason than when it's in raw HTML Wikia keeps (incorrectly) thinking it knows how to "cook" what you edited correctly and change it.
User avatar
BiZZ Keryear
·2013/09/27

The template is not as simple as I liked to, since I have no access to php or lua here, but the plain html would be a far bigger mess ... there are actually more styles infos than visible. it is utill Norcalairman adds the css i have given him, or antill he gives me the rights to do so myself.
(Edited by BiZZ Keryear)
Write a reply
Steven Mading
·2013/09/26

What's up with all the footnotes.  They don't seem to be doing anything as they all point to the same place at the bottom of the page: 1.00, 1.01, 1.02... etc are all the same footnote as far as I can tell.
User avatar
BiZZ Keryear
·2013/09/27

They mark those 95% of commands/variables I directly read from the source code.

78 in total to be precise. Some of those had nowhere a documentation, some only a very incompete.

But for some reasons my my templete dislikes the = except in the last slot... so I added it to the description where I had one. The rest is still there and counted but invisible...

dunno why.
Write a reply
User avatar
BiZZ Keryear
·2013/09/26

Please visit the documentation of this site before editing.
Write a reply
Recent Wiki Activity

    Example - Simple Autolaunch
    A Fandom user
    Mission toolkit v3
    A Fandom user
    Example - To the Mun and back
    A Fandom user
    List of all Commands
    A Fandom user
    Tutorials and Example Scripts

Popular Pages

    Example - To the Mun and back

    XYZ system of KSP

    Example - Skycrane demo

    Installation and Usage

    Example - Descend Lander/Skycrane

FandomShop
Newsletter
Paramount+
Bingebot: Find a new show to watch in 30 seconds
Explore properties

    Fandom
    Gamepedia
    D&D Beyond
    Cortex RPG
    Muthead
    Futhead
    Fanatical

Follow Us

Overview

    About
    Careers
    Press
    Contact
    Terms of Use
    Privacy Policy
    Global Sitemap
    Local Sitemap

Community

    Community Central
    Support
    Help

Advertise

    Media Kit
    Contact

Fandom Apps
Take your favorite fandoms with you and never miss a beat.

D&D Beyond

KOS Wiki is a FANDOM Games Community.
View Mobile Site


Skip to content
Pull requests
Issues
Marketplace
Explore
@DasKrusty
Nivekk /
KOS

19
78

    30

Code
Issues 94
Pull requests 28
Actions
Projects
Wiki
Security

    Insights

1 branch
0 tags
Latest commit
@Nivekk
Nivekk KSP 1.0 Support
669a964
on 29 Apr 2015
Git stats

    285 commits

Files
Type
Name
Latest commit message
Commit time
Bindings
A few new features
6 years ago
Commands
KSP 1.0 Support
6 years ago
Preprocessor
A few new features
6 years ago
Properties
Initial commit
8 years ago
Structures
KSP 1.0 Support
6 years ago
.gitignore
Support update for latest KSP
6 years ago
CHANGELOG.md
Update CHANGELOG.md
8 years ago
CPU.cs
A few new features
6 years ago
ContextRunProgram.cs
Just moving some things around
6 years ago
Core.cs
KSP 1.0 Support
6 years ago
DebugTools.cs
Converted to be compilable using .net 3.5
8 years ago
File.cs
Converted to be compilable using .net 3.5
8 years ago
Harddisk.cs
Fix for issue #104
8 years ago
InputManager.cs
Just moving some things around
6 years ago
InternalDisplay.cs
A few new features
6 years ago
InterpreterBootup.cs
Converted to be compilable using .net 3.5
8 years ago
InterpreterEdit.cs
Fix for issue #160
8 years ago
InterpreterImmediate.cs
A few new features
6 years ago
LICENSE.md
Adding license file
8 years ago
README.md
Merge pull request #179 from a1270/solarpanelstats
8 years ago
SteeringHelper.cs
Bug fixes, new expressions
8 years ago
TermWindow.cs
A few new features
6 years ago
VesselUtils.cs
KSP 1.0 Support
6 years ago
Volume.cs
changed syntax, switched code to use existing abstractions
8 years ago
kOS.csproj
A few new features
6 years ago
kOSException.cs
Added the ability for errors to identify the sub-program they're foun…
8 years ago
kOSExternalCommand.cs
Fix for SET after the recent changes
8 years ago
kOSIDModule.cs
Converted to be compilable using .net 3.5
8 years ago
kOSProcessor.cs
A few new features
6 years ago
README.md
kOS Mod Overview

kOS is a scriptable autopilot Mod for Kerbal Space Program. It allows you write small programs that automate specific tasks.
Installation

Like other mods, simply merge the contents of the zip file into your Kerbal Space Program folder.
Usage

Add the Compotronix SCS part to your vessel; it’s under the “Control” category in the Vehicle Assembly Building or Space Plane Hanger. After hitting launch, you can right-click on the part and select the “Open Terminal” option. This will give you access to the KerboScript interface where you can begin issuing commands and writing programs.
KerboScript

KerboScript is a programming language that is derived from the language of planet Kerbin, which sounds like gibberish to non-native speakers but for some reason is written exactly like English. As a result, KerboScript is very English-like in its syntax. For example, it uses periods as statement terminators.

The language is designed to be easily accessible to novice programmers, therefore it is case-insensitive, and types are cast automatically whenever possible.

A typical command in KerboScript might look like this:

PRINT “Hello World”.

Expressions

KerboScript uses an expression evaluation system that allows you to perform math operations on variables. Some variables are defined by you. Others are defined by the system.

There are three basic types:
Numbers

You can use mathematical operations on numbers, like this:

SET X TO 4 + 2.5. 
PRINT X.             // Outputs 6.5

The system follows the order of operations, but currently the implementation is imperfect. For example, multiplication will always be performed before division, regardless of the order they come in. This will be fixed in a future release.
Mathematical Functions
Basic Functions

ABS(1).             // Returns absolute value of input. e.g. 1
MOD(21,6).          // Returns remainder of an integer division. e.g. 3
FLOOR(1.887).       // Rounds down to the nearest whole number. e.g. 1
CEILING(1.887).     // Rounds up to the nearest whole number. e.g. 2
ROUND(1.887).       // Rounds to the nearest whole number. e.g. 2
ROUND(1.887, 2).    // Rounds to the nearest place value. e.g. 1.89
SQRT(7.89).         // Returns square root. e.g. 2.80891438103763

Trigonometric Functions

SIN(6).                 // Returns sine of input. e.g. 0.10452846326
COS(6).                 // Returns cosine. e.g. 0.99452189536
TAN(6).                 // Returns tangent. e.g. 0.10510423526
ARCSIN(0.67).           // Returns angle whose sine is input in degrees. e.g. 42.0670648
ARCCOS(0.67).           // Returns angle whose cosine is input in degrees. e.g. 47.9329352
ARCTAN(0.67).           // Returns angle whose tangent is input in degrees. e.g. 33.8220852
ARCTAN2(0.67, 0.89).    // Returns the angle whose tangent is the quotient of two specified numbers in degrees. e.g. 36.9727625

Strings

Strings are pieces of text that are generally meant to be printed to the screen. For example:

PRINT “Hello World!”.

To concatenate strings, you can use the + operator. This works with mixtures of numbers and strings as well.

PRINT “4 plus 3 is: “ + (4+3).

Directions

Directions exist primarily to enable automated steering. You can initialize a direction using a vector or a rotation.

SET Direction TO V(0,1,0).         // Set a direction by vector
SET Direction TO R(0,90,0).        // Set by a rotation in degrees

You can use math operations on Directions as well. The next example uses a rotation of “UP” which is a system variable describing a vector directly away from the celestial body you are under the influence of.

SET Direction TO UP + R(0,-45,0).  // Set direction 45 degress west of “UP”.

Command Reference
ADD

Adds a maneuver node to the flight plan.

Example: This statement adds a node that occurs 30 seconds from now, and has a delta-V of 100 m/s radial out, 0 m/s normal, and 200 m/s prograde.

ADD NODE(TIME + 30, 100, 0, 200).

REMOVE

Removes maneuver node from flight plan. Cannot remove bare nodes e.g. ADD NODE().

SET X TO NODE(0,0,0,0).
ADD X.
REMOVE X.

ADD NODE(0,0,0,0).
REMOVE.             // Does not remove node.

BREAK

Breaks out of a loop. Example:

SET X TO 1.
UNTIL 0 {
    SET X TO X + 1.
    IF X > 10 { BREAK. }.       // Exits the loop when X is greater than 10
}.

CLEARSCREEN

Clears the screen and places the cursor at the top left. Example:

CLEARSCREEN.

COPY

Copies a file to or from another volume. Volumes can be referenced by their ID numbers or their names if they’ve been given one. See LIST, SWITCH and RENAME. Example:

SWITCH TO 1.       // Makes volume 1 the active volume
COPY file1 FROM 0. // Copies a file called file1 from volume 0 to volume 1
COPY file2 TO 0.   // Copies a file called file1 from volume 1 to volume 0

DELETE

Deletes a file. You can delete a file from the current volume, or from a named volume. Example:

DELETE file1.         // Deletes file1 from the active volume.
DELETE file1 FROM 1.  // Deletes file1 from volume 1

DECLARE

Declares a variable at the current context level. Alternatively, a variable can be implicitly declared by a SET or LOCK statement. Example:

DECLARE X.

DECLARE PARAMETER

Declares variables to be used as a parameter. Example:

DECLARE PARAMETER X.
DECLARE PARAMETER X,y.
RUN MYPROG(X).

EDIT

Edits a program on the currently selected volume. Example:

EDIT filename.

IF

Checks if the expression supplied returns true. If it does, IF executes the following command block. Example:

SET X TO 1.
IF X = 1 { PRINT "X equals one.". }.            // Prints "X equals one."
IF X > 10 { PRINT "X is greater than ten.". }.  // Does nothing

If statements can make use of boolean operators. Example:

IF X = 1 AND Y > 4 { PRINT "Both conditions are true". }.
IF X = 1 OR Y > 4 { PRINT "At least one condition is true". }.

LIST

Lists the files on the current volume, or lists the currently available volumes. Lists files by default. Example:

LIST.           // Lists files on the active volume
LIST FILES.     // Lists files on the active volume
LIST VOLUMES.   // Lists all volumes, with their numbers and names
LIST BODIES.    // Lists celestial bodies and their distance
LIST TARGETS.   // Lists target-able vessels in range
LIST RESOURCES. // List of resources by stage
LIST PARTS.     // Lists parts in vessel
LIST ENGINES.   // List of engines

LOCK

Locks a variable to an expression. On each cycle, the target variable will be freshly updated with the latest value from expression. Example:

SET X TO 1.
LOCK Y TO X + 2.
PRINT Y.       // Outputs 3
SET X TO 4.
PRINT Y.      // Outputs 6

ON

Awaits a change in a boolean variable, then runs the selected command. This command is best used to listen for action group activations. Example:

ON AG3 PRINT “Action Group 3 Activated!”.
ON SAS PRINT “SAS system has been toggled”.

PRINT

Prints the selected text to the screen. Can print strings, or the result of an expression. Example:

PRINT “Hello”.
PRINT 4+1.
PRINT “4 times 8 is: “ + (4*8).

PRINT.. AT (COLUMN,LINE)

Prints the selected text to the screen at specified location. Can print strings, or the result of an expression. Example:

PRINT “Hello” at (0,10).
PRINT 4+1 at (0,10).
PRINT “4 times 8 is: “ + (4*8) at (0,10).

LOG.. TO

Logs the selected text to a file on the local volume. Can print strings, or the result of an expression. Example:

LOG “Hello” to mylog.
LOG 4+1 to mylog .
LOG “4 times 8 is: “ + (4*8) to mylog.

RENAME

Renames a file or volume. Example:

RENAME VOLUME 1 TO AwesomeDisk
RENAME FILE MyFile TO AutoLaunch.

REMOVE

Removes a maneuver node. Example:

REMOVE NEXTNODE.        // Removes the first maneuver node in the flight plan.

RUN

Runs the specified file as a program. Example:

RUN AutoLaunch.

SET.. TO

Sets the value of a variable. Declares the variable if it doesn’t already exist. Example:

SET X TO 1.

STAGE

Executes the stage action on the current vessel. Example:

STAGE.

SWITCH TO

Switches to the specified volume. Volumes can be specified by number, or it’s name (if it has one). See LIST and RENAME. Example:

SWITCH TO 0.                        // Switch to volume 0.
RENAME VOLUME 1 TO AwesomeDisk.     // Name volume 1 as AwesomeDisk.
SWITCH TO AwesomeDisk.              // Switch to volume 1.

TOGGLE

Toggles a variable between true or false. If the variable in question starts out as a number, it will be converted to a boolean and then toggled. This is useful for setting action groups, which are activated whenever their values are inverted. Example:

TOGGLE AG1.			// Fires action group 1.
TOGGLE SAS.			// Toggles SAS on or off.

UNLOCK

Releases a lock on a variable. See LOCK. Examples:

UNLOCK X.                // Releases a lock on variable X.
UNLOCK ALL.              // Releases ALL locks.

UNTIL

Performs a loop until a certain condition is met. Example:

SET X to 1.
UNTIL X > 10 {          // Prints the numbers 1-10.
    PRINT X.
    SET X to X + 1.
}.

WAIT

Halts execution for a specified amount of time, or until a specific set of criteria are met. Note that running a WAIT UNTIL statement can hang the machine forever if the criteria are never met. Examples:

WAIT 6.2.                     // Wait 6.2 seconds.
WAIT UNTIL X > 40.            // Wait until X becomes greater than 40.
WAIT UNTIL APOAPSIS > 150000. // You can see where this is going.

WHEN.. THEN

Executes a command when a certain criteria are met. Unlike WAIT, WHEN does not halt execution. Example:

WHEN BCount < 99 THEN PRINT BCount + “ bottles of beer on the wall”.

..ON

Sets a variable to true. This is useful for the RCS and SAS bindings. Example:

RCS ON 			// Turns on the RCS

..OFF

Sets a variable to false. This is useful for the RCS and SAS bindings. Example

RCS OFF			// Turns off the RCS

WARP

Sets game warp to provided value(0-7).

SET WARP TO 5.      // Sets warp to 1000x.
SET WARP TO 0.      // Sets warp to 0x aka real time.

REBOOT

Reboots the kOS module.
SHUTDOWN

Causes kOS module to shutdown.
Flight Statistics

You can get several useful vessel stats for your ships

VESSELNAME
ALTITUDE
ALT:RADAR           // Your radar altitude
BODY                // The current celestial body whose influence you are under
MISSIONTIME         // The current mission time
VELOCITY            // The current orbital velocity
VERTICALSPEED
SURFACESPEED
LATITUDE
LONGITUDE
STATUS              // Current situation: LANDED, SPLASHED, PRELAUNCH, FLYING, SUB_ORBITAL, ORBITING, ESCAPING, or DOCKED
INLIGHT          // Returns true if not blocked by celestial body, always false without solar panel.
INCOMMRANGE         // returns true if in range
COMMRANGE           // returns commrange
MASS
MAXTHRUST           // Combined thrust of active engines at full throttle (kN)

TIME

Returns time in various formats.

TIME                // Gets the current universal time
TIME:CLOCK          // Universal time in H:M:S format(1:50:26)
TIME:CALENDAR       // Year 1, day 134
TIME:YEAR           // 1
TIME:DAY            // 134
TIME:HOUR           // 1
TIME:MINUTE         // 50
TIME:SECOND         // 26

Vectors

These return a vector object, which can be used in conjuction with the LOCK command to set your vessel's steering.

PROGRADE
RETROGRADE
UP				// Directly away from current body

Orbit geometry values

These values can be polled either for their altitude, or the vessel's ETA in reaching them. By default, altitude is returned.

APOAPSIS			// Altitude of apoapsis
ALT:APOAPSIS		// Altitude of apoapsis
PERIAPSIS			// Altitude of periapsis
ALT:PERIAPSIS		// Altitude of periapsis
ETA:APOAPSIS		// ETA to apoapsis
ETA:PERIAPSIS		// ETA to periapsis

Maneuver nodes

NODE                // Direction of next maneuver node, can be used with LOCK STEERING
MAG:NODE            // Delta-v magnitude of maneuver node
ETA:NODE            // ETA to active maneuver node
ENCOUNTER           // Returns celestial body of encounter
NEXTNODE            // Next node in flight plan.

Resources
Resource Types

LIQUIDFUEL
OXIDIZER
ELECTRICCHARGE
MONOPROPELLANT
INTAKEAIR
SOLIDFUEL

Stage specific values

STAGE:LIQUIDFUEL            // Prints per stage liquid fuel.
STAGE:OXIDIZER

Global values

PRINT <LiquidFuel>.                         // Print the total liquid fuel in all tanks. DEPRECATED
PRINT SHIP:LIQUIDFUEL.                      // Print the total liquid fuel in all tanks.
PRINT VESSEL("kerbRoller2"):LIQUIDFUEL.     // Print the total liquid fuel on kerbRoller2.
PRINT TARGET:LIQUIDFUEL.                    // Print the total liquid fuel on target.

Flight Control

These values can be SET, TOGGLED, or LOCKED. Some values such as THROTTLE and STEERING explicity require the use of lock.
Controls which use ON and OFF

SAS				// For these five, use ON and OFF, example: SAS ON. RCS OFF.
GEAR
RCS
LIGHTS
BRAKES
LEGS
CHUTES	// Cannot be un-deployed.
PANELS

Controls that can be used with TOGGLE

ABORT
AGX             // Where x = 1 through 10. Use toggle, example: TOGGLE AG1.             	

Controls that must be used with LOCK

THROTTLE			// Lock to a decimal value between 0 and 1.
STEERING			// Lock to a direction.
WHEELTHROTTLE       // Seperate throttle for wheels
WHEELSTEERING       // Seperate steering system for wheels

Structures

Structures are variables that can contain more than one piece of information. Structures can be used with SET.. TO just like any other variable. Changing valves works only with V() and NODE() at this time, cannot be used with lock.

Their subelements can be accessed by using : along with the name of the subelement.
LATLNG (latitude, longitude)

Represents a set of geo-coordinates.

SET X TO LATLNG(10, 20).            // Initialize point at lattitude 10, longitude 20
PRINT X:LAT.                        // Print 10.
PRINT X:LNG.                        // Print 20.
PRINT X:DISTANCE.                   // Print distance from vessel to x (same altitude is presumed)
PRINT LATLNG(10,20):HEADING.        // Print the heading to the point.
PRINT X:BEARING.                    // Print the heading to the point relative to vessel heading.

NODE (universalTime, radialOut, normal, prograde)

Represents a maneuver node.

SET X TO NODE(TIME+60, 0, 0, 100).  // Creates a node 60 seconds from now with
                                    // prograde=100 m/s
ADD X.                              // Adds the node to the flight plan.
PRINT X:PROGRADE.                   // Returns 100.
PRINT X:ETA.                        // Returns the ETA to the node.
PRINT X:DELTAV                      // Returns delta-v vector.
REMOVE X.                           // Remove node  from the flight plan.

SET X TO NODE(0, 0, 0, 0).          // Create a blank node.
ADD X.                              // Add Node to flight plan.
SET X:PROGRADE to 500.              // Set nodes prograde to 500m/s deltav.
PRINT X:APOAPSIS.                   // Returns nodes apoapsis.
PRINT X:PERIAPSIS.                  // Returns nodes periapsis.

HEADING (degreesFromNorth, pitchAboveHorizon)

Represents a heading that's relative to the body of influence.

SET X TO HEADING(45, 10).           // Create a rotation facing northeast, 10 degrees above horizon

R (pitch, yaw, roll)

Represents a rotation.

SET X TO PROGRADE + R(90,0,0).      // Initializes a direction to prograde plus a relative pitch of 90
LOCK STEERING TO X.                 // Steer the vessel in the direction suggested by direction X.

V (x, y, z)

Represents a vector.

SET varname TO V(100,5,0).          // initializes a vector with x=100, y=5, z=0
varname:X.                          // Returns 100.
V(100,5,0):Y.                       // Returns 5.
V(100,5,0):Z.                       // Returns 0.
varname:MAG.                        // Returns the magnitude of the vector, in this case
SET varname:X TO 111.               // Changes vector x value to 111.
SET varname:MAG to 10.              // Changes magnitude of vector. e.g. V(9.98987,0.44999,0)

VESSEL (vesselname)

Represents a targetable vessel

SET X TO VESSEL("kerbRoller2").     // Initialize a reference to a vessel.
PRINT X:DISTANCE.                   // Print distance from current vessel to target.
PRINT X:HEADING.                    // Print the heading to the vessel.
PRINT X:BEARING.                    // Print the heading to the target vessel relative to vessel heading.

SHIP

Represents currently selected ship

PRINT SHIP.                            // returns VESSEL("kerbRoller2")
PRINT SHIP:DISTANCE.                   // Print distance from current vessel to target.
PRINT SHIP:HEADING.                    // Print the heading to the vessel.
PRINT SHIP:BEARING.                    // Print the heading to the target vessel relative to vessel heading.

TARGET

Represents targeted vessel or celestial body

SET TARGET TO "kerbRoller2".        // target kerbRoller2
PRINT TARGET:DISTANCE.              // Print distance from current vessel to target.
PRINT TARGET:HEADING.               // Print the heading to the target vessel.
PRINT TARGET:BEARING.               // Print the bearing to the target vessel relative to vessel heading.

System Variables

Returns values about kOS and hardware

PRINT VERSION.            // Returns operating system version number. 0.8.6
PRINT VERSION:MAJOR.      // Returns major version number. e.g. 0
PRINT VERSION:MINOR.      // Returns minor version number. e.g. 8
PRINT SESSIONTIME.        // Returns amount of time, in seconds, from vessel load.

About

Fully programmable autopilot mod for KSP.
Resources
Readme
License
GPL-3.0 License
Releases
No releases published
Packages
No packages published
Contributors 14

    @Nivekk
    @a1270
    @palaslet
    @ehrenmurdick
    @xZise
    @dail8859
    @civilwargeeky
    @Dunbaratu
    @childonline
    @BGog
    @thanpolas

+ 3 contributors
Languages

    C# 100.0% 

    © 2021 GitHub, Inc.
    Terms
    Privacy
    Security
    Status
    Docs

    Contact GitHub
    Pricing
    API
    Training
    Blog
    About

// kOStok Abort v1.0.0
// Kevin Gisi
// http://youtube.com/gisikw

NOTIFY("Abort program initiated").

IF PERIAPSIS > 60000 {
  NOTIFY("Orbit detected. Deorbiting").

  LOCK STEERING TO RETROGRADE.
  WAIT 20.
  LOCK THROTTLE TO 1.

  WAIT UNTIL PERIAPSIS < 35000 OR SHIP:LIQUIDFUEL < 0.1 OR SHIP:ELECTRICCHARGE < 5.
}

NOTIFY("Orbital decay achieved").
LOCK THROTTLE TO 0.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

WAIT 5. NOTIFY("Detaching").
UNTIL FALSE {
  STAGE.
}

// Circularization Script v1.0.0
// Kevin Gisi
// http://youtube.com/gisikw

PARAMETER targetAltitude.
PARAMETER referenceVessel.
PARAMETER longitudeDifference.

// Wait for correct phase angle
IF referenceVessel <> FALSE {
  SET lngDiff TO 0.

  UNTIL lngDiff > longitudeDifference - 0.5 AND lngDiff < longitudeDifference + 0.5 {
    SET lngDiff TO SHIP:LONGITUDE - VESSEL(referenceVessel):LONGITUDE.
    WAIT 0.01.
  }
}

// Transfer burn
SET transfer TO PROGRADE.
LOCK STEERING TO transfer. WAIT 5.
LOCK THROTTLE TO 1.
WAIT UNTIL APOAPSIS > targetAltitude * 0.9.
LOCK THROTTLE TO 0.1.
WAIT UNTIL APOAPSIS > targetAltitude.
LOCK THROTTLE TO 0.

// Coast to apoapsis
WAIT UNTIL ETA:APOAPSIS < 20.

// Circularization burn
SET circularization TO PROGRADE.
LOCK STEERING TO circularization. WAIT 5.
LOCK THROTTLE TO 1.
WAIT UNTIL PERIAPSIS > targetAltitude * 0.9.
LOCK THROTTLE TO 0.1.
WAIT UNTIL PERIAPSIS > targetAltitude.
LOCK THROTTLE TO 0.

// Test Script

// Ship's delta v
FUNCTION TLM_DELTAV {
  LIST ENGINES IN shipEngines.
  SET dryMass TO SHIP:MASS - ((SHIP:LIQUIDFUEL + SHIP:OXIDIZER) * 0.005).
  RETURN shipEngines[0]:ISP * 9.80665 * LN(SHIP:MASS / dryMass).
}

// Time to complete a maneuver
FUNCTION MNV_TIME {
  PARAMETER deltaV.

  SET maxAccel TO SHIP:MAXTHRUST / SHIP:MASS.
  RETURN deltaV / maxAccel.
}

// Time to complete a maneuver
// FUNCTION MNV_TIME {
//   PARAMETER dV.
//
//   LIST ENGINES IN en.
//
//   LOCAL f IS en[0]:MAXTHRUST * 1000.  // Engine Thrust (kg * m/s²)
//   LOCAL m IS SHIP:MASS * 1000.        // Starting mass (kg)
//   LOCAL e IS CONSTANT():E.            // Base of natural log
//   LOCAL p IS en[0]:ISP.               // Engine ISP (s)
//   LOCAL g IS 9.80665.                 // Gravitational acceleration constant (m/s²)
//
//   RETURN g * m * p * (1 - e^(-dV/(g*p))) / f.
// }

// Delta v requirements for Hohmann Transfer
FUNCTION MNV_HOHMANN_DV {
  PARAMETER desiredAltitude.

  SET u  TO SHIP:OBT:BODY:MU.
  SET r1 TO SHIP:OBT:SEMIMAJORAXIS.
  SET r2 TO desiredAltitude + SHIP:OBT:BODY:RADIUS.

  // v1
  SET v1 TO SQRT(u / r1) * (SQRT((2 * r2) / (r1 + r2)) - 1).

  // v2
  SET v2 TO SQRT(u / r2) * (1 - SQRT((2 * r1) / (r1 + r2))).

  RETURN LIST(v1, v2).
}

PRINT "Testing Functions".
PRINT "Ship's DeltaV: " + TLM_DELTAV().
PRINT "Time for 100m/s maneuver: " + MNV_TIME(100).
PRINT "Transfer DeltaV to 60km: " + MNV_HOHMANN_DV(60000).

WAIT 500.


NOTIFY("Deorbiting launch vessel").
LOCK STEERING TO RETROGRADE.
WAIT 10.
LOCK THROTTLE TO 1.
WAIT UNTIL PERIAPSIS < 10000.
LOCK THROTTLE TO 0.



// Automatic Lander

local SUICIDE_DISTANCE_MARGIN is 50.
local ACCEPTABLE_LANDING_SLOPE is 5.
local ACCEPTABLE_DRIFT is 0.5.
local CONTACT_SPEED is 2.
local CONTACT_CUTOFF is 15.
local DESCENT_SPEED is 5.

function main {
  set ship:control:pilotmainthrottle to 1.
  sas on.
  wait until abort.
  core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
  clearscreen.
  set terminal:charheight to 14.
  set terminal:charwidth to 14.
  set terminal:brightness to 1.
  set ship:control:pilotmainthrottle to 0.
  sas off.
  display(lex("step", "Suicide burn")).
  perform_suicide_burn().
  display(lex("step", "Slope seek")).
  seek_landing_area().
  display(lex("step", "Landing")).
  land().
}

function perform_suicide_burn {
  local t is 0.
  lock steering to descent_vector().
  lock throttle to t.
  until alt:radar < SUICIDE_DISTANCE_MARGIN {
    if has_impact_time(SUICIDE_DISTANCE_MARGIN) set t to 1.
    else set t to 0.
    wait 0.
  }
}

function has_impact_time {
  parameter margin.
  local a is g() * (1 - availtwr()).
  local v is -verticalspeed.
  local d is alt:radar - margin.
  local tti is v^2 + 2*a*d.
  display(lex("TTI", tti)).
  return tti > 0.
}

function seek_landing_area {
  local target_vector is unrotate(up).
  local t is 1.
  lock throttle to t.
  lock steering to target_vector.
  local slope is vang(ground_slope(), up:vector).
  until slope < ACCEPTABLE_LANDING_SLOPE and
        velocity:surface:mag < ACCEPTABLE_DRIFT {
    set slope to vang(ground_slope(), up:vector).
    local desired_velocity is vxcl(up:vector, ground_slope()).
    set desired_velocity:mag to 2.
    if slope < ACCEPTABLE_LANDING_SLOPE set desired_velocity to v(0, 0, 0).
    local delta_velocity is desired_velocity - velocity:surface.
    set target_vector to unrotate(up:vector * g() + delta_velocity).
    set t to hover(0).
    display(lex("Slope", vang(ground_slope(), up:vector))).
    wait 0.
  }
}

function ground_slope {
  local east is vcrs(north:vector, up:vector).
  local a is body:geopositionof(ship:position + 5 * north:vector).
  local b is body:geopositionof(ship:position - 5 * north:vector + 5 * east).
  local c is body:geopositionof(ship:position - 5 * north:vector - 5 * east).

  local a_vec is a:altitudeposition(a:terrainheight).
  local b_vec is b:altitudeposition(b:terrainheight).
  local c_vec is c:altitudeposition(c:terrainheight).

  return vcrs(c_vec - a_vec, b_vec - a_vec).
}

local hover_pid is pidloop(2.7, 4.4, 0.12, 0, 1).
function hover {
  parameter setpoint.
  set hover_pid:setpoint to setpoint.
  set hover_pid:maxoutput to availtwr().
  return min(
    hover_pid:update(time:seconds, ship:verticalspeed) /
    max(cos(vang(up:vector, ship:facing:vector)), 0.0001) /
    max(availtwr(), 0.0001),
    1
  ).
}

function land {
  local t is 0.
  lock steering to descent_vector().
  lock throttle to t.
  until alt:radar < CONTACT_CUTOFF { set t to hover(-DESCENT_SPEED). wait 0. }
  until velocity:surface:mag < ACCEPTABLE_DRIFT { set t to hover(0). wait 0. }
  until ship:status = "Landed" { set t to hover(-CONTACT_SPEED). wait 0. }
  lock throttle to 0.
}

// Helper functions

function descent_vector {
  if vang(srfretrograde:vector, up:vector) > 90 return unrotate(up).
  return unrotate(up:vector * g() - velocity:surface).
}

local display_data is lex(
  "step", "waiting"
).
function display {
  parameter update is lex().
  for key in update:keys set display_data[key] to update[key].
  local i is 0.
  for key in display_data:keys {
    print (key + ": " +display_data[key]):padright(terminal:width) at (0, i).
    set i to i + 1.
  }
}

function unrotate {
  parameter v. if v:typename <> "Vector" set v to v:vector.
  return lookdirup(v, ship:facing:topvector).
}

function g {
  return body:mu / ((ship:altitude + body:radius)^2).
}

function availtwr {
  return ship:availablethrust / (ship:mass * g()).
}

main().