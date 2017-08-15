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
[{
    GVAR(sideMissions) call MFUNC(selectMissionData);
}, GVAR(sideMissionDelay)] call CFUNC(wait);
