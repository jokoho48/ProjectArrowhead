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

GVAR(sideMissions) = ["ProjectArrowhead", "sideMissions"] call MFUNC(readOutMissionData);

GVAR(sideMissionDelay) = [CFGPRAW(sideMissionDelay), 250] call CFUNC(getSetting);

["missionStarted", {
    call FUNC(selectSideMission);
}] call CFUNC(addEventhandler);
