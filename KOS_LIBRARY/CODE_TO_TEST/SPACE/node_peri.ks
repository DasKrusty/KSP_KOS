/////////////////////////////////////////////////////////////////////////////
// Change periapsis.
/////////////////////////////////////////////////////////////////////////////
// Establish new periapsis by performing a burn at apoapsis.
// An optional argument allows for scheduling the burn at another time.
/////////////////////////////////////////////////////////////////////////////

parameter nodeAlt.
parameter nodeTime is time:seconds + eta:apoapsis.

run node_alt(nodeAlt, nodeTime).