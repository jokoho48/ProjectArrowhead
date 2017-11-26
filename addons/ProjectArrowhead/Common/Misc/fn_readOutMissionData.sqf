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
private _configPath = _this;
private _return = [];
{
    private _cfg = _x;

    {
        _cfg = _cfg >> _x;
        nil
    } count _configPath;
    private _origin = ["Mission", "Server"] select _forEachIndex;
    {
        if (isText _x) then {
            _return pushBack [configName _x, getText _x, _origin, _x, false];
        } else {
            _return pushBack [configName _x, getText (_x >> "function"), _origin, _x, getNumber (_x >> "requireCollectIntel")];
        };
        nil
    } count configProperties [_cfg , "isClass _x || isText _x", true];
    nil
} forEach [missionConfigFile, configFile];

_return
