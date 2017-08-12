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
(_this distance (getMarkerPos GVAR(baseMarker))) < 2500 ||
[_this, GVAR(baseMarker)] call FUNC(inArea)
