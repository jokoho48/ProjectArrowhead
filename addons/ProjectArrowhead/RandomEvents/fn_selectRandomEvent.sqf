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
    GVAR(randomEvents) call MFUNC(selectMissionData);
    call FUNC(selectRandomEvent);
}, random GVAR(EventTimings)] call CFUNC(wait);
