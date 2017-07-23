#include "macros.hpp"
/*
    Community Lib - CLib

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
    private _configPath = ["Mission", "Server"] select _forEachIndex;
    {
        if (isText _x) then {
            GVAR(sideMissions) pushBack [configName _x, getText _x, _configPath, configNull];
        } else {
            GVAR(sideMissions) pushBack [configName _x, getText (_x >> "function"), _configPath, _x];
        };
        nil
    } count configProperties [_x >> "BSOPublic" >> "sideMissions" , "isClass _x || isText _x", true];
    nil
} forEach [missionConfigFile, configFile];
