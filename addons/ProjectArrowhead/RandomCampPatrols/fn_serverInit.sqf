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

GVAR(ObjCompArray) = [];
{
    GVAR(ObjCompArray) pushBack [
        [configName _x, getText (_x >> "className")] select isText (_x >> "className"),
        getNumber(_x >> "size"),
        getNumber(_x >> "useSOF") isEqualTo 1
    ];
    nil
} count configProperties [MISSIONCLASS >> "RandomCampCompositions", "isClass _x", true];
GVAR(randomCampCount) = [CFGPRAW2(RandomCampPatrols,randomCampCount), 10] call CFUNC(getSetting);
GVAR(randomPatrolCount) = [CFGPRAW2(RandomCampPatrols,randomPatrolCount), 10] call CFUNC(getSetting);
GVAR(randomPatrolVehCount) = [CFGPRAW2(RandomCampPatrols,randomPatrolVehCount), 4] call CFUNC(getSetting);

[QMGVAR(mainAOGenerated), {
    call FUNC(spawn);
}] call CFUNC(addEventhandler);
