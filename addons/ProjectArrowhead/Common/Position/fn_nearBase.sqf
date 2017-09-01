#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    checks if Pos is Near base

    Parameter(s):
    Position <Position>

    Returns:
    is Near Base <Boolean>
*/
_this call FUNC(inBase) ||
{(_this distance2D (getMarkerPos GVAR(baseMarker))) < 2000}
