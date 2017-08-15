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

GVAR(sideMissions) = [];

{
    private _origin = ["Mission", "Server"] select _forEachIndex;
    {
        if (isText _x) then {
            GVAR(sideMissions) pushBack [configName _x, getText _x, _origin, configNull];
        } else {
            GVAR(sideMissions) pushBack [configName _x, getText (_x >> "function"), _origin, _x];
        };
        nil
    } count configProperties [_x >> "ProjectArrowhead" >> "sideMissions" , "isClass _x || isText _x", true];
    nil
} forEach [missionConfigFile, configFile];


GVAR(sideMissionDelay) = [CFGPRAW(sideMissionDelay), 240] call CFUNC(getSetting);

call FUNC(selectSideMission);
