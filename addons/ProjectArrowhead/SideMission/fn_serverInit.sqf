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

["missionStarted", {
    GVAR(sideMissionDelay) = [CFGPRAW(sideMissionDelay), 250] call CFUNC(getSetting);
    GVAR(sideMissionCount) = [CFGPRAW(sideMissionCount), 3] call CFUNC(getSetting);
    call FUNC(selectSideMission);
}] call CFUNC(addEventhandler);
