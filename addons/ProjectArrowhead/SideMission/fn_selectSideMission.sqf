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

#ifdef ISDEV
    private _time = 10;
#else
    private _time = ((GVAR(sideMissionDelay)/2) + random GVAR(sideMissionDelay));
#endif
[{
    GVAR(sideMissions) call MFUNC(selectMissionData);
}, _time] call CFUNC(wait);
