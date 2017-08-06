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


private _location = selectRandom MGVAR(locations);
GVAR(mainAOSize) = ((size _location) select 0) * (getNumber (missionConfigFile >> "ProjectArrowhead" >> "MainAOSize"));
publicVariable QGVAR(mainAOSize);
[QGVAR(spawnClearTownUnits), [getPos _location]] call CFUNC(localEvent);
