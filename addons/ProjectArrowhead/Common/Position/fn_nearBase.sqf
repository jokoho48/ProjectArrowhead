#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Description

    Parameter(s):
    0: Argument <Type>

    Returns:
    0: Return <Type>
*/
params ["_pos"];
(_pos distance (getMarkerPos GVAR(baseMarker))) < 1000 &&
[_pos, GVAR(baseMarker)] call FUNC(inArea)
