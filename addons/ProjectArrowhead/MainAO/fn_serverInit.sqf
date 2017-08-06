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
GVAR(mainMissions) = [];

GVAR(missionAmount) = 10;
GVAR(missionCounter) = 0;
{
    private _configPath = ["Mission", "Server"] select _forEachIndex;
    {
        if (isText _x) then {
            GVAR(mainMissions) pushBack [configName _x, getText _x, _configPath, configNull];
        } else {
            GVAR(mainMissions) pushBack [configName _x, getText (_x >> "function"), _configPath, _x];
        };
        nil
    } count configProperties [_x >> "ProjectArrowhead" >> "mainMissions" , "isClass _x || isText _x", true];
    nil
} forEach [missionConfigFile, configFile];

call FUNC(selectMainMission);
