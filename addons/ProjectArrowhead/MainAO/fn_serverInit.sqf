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
GVAR(mainMissions) = ["ProjectArrowhead", "mainMissions"] call MFUNC(readOutMissionData);;
GVAR(isFirstCallDone) = false;
GVAR(missionCounter) = 0;
GVAR(missionAmount) = [CFGPRAW(missionAmount), 10] call CFUNC(getSetting);

["missionStarted", {
    [{
        call FUNC(selectMainMission);
    }, 5] call CFUNC(wait);
}] call CFUNC(addEventhandler);
