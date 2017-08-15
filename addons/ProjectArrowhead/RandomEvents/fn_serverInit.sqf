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
GVAR(randomEvents) = ["ProjectArrowhead", "randomEvents"] call MFUNC(readOutMissionData);
GVAR(EventTimings) = [600,1000,1200]; // TODO: Setting

call FUNC(selectRandomEvent);
