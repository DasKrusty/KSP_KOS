/////////////////////////////////////////////////////////////////////////////
// Change apoapsis.
/////////////////////////////////////////////////////////////////////////////
// Establish new apoapsis by performing a burn at periapsis.
// An optional argument allows for scheduling the burn at another time.
/////////////////////////////////////////////////////////////////////////////

parameter nodeAlt.
parameter nodeTime is time:seconds + eta:periapsis.

run node_alt(nodeAlt, nodeTime).