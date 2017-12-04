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
for "_i" from 0 to 3 do {
    [{
        GVAR(sideMissions) call MFUNC(selectMissionData);
    }, ((GVAR(sideMissionDelay)/2) + (random GVAR(sideMissionDelay)))] call CFUNC(wait);
};
