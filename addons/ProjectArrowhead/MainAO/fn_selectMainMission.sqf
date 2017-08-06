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

if ((MGVAR(missionAmount) > 0) && {MGVAR(missionAmount) == MGVAR(missionCounter)}) then {
    "WON" call BIS_fnc_EndMissionServer;
} else {
    private _mission = selectRandom GVAR(mainMissions);
    _mission params ["_name", "_function", "_origin"];

    private _code = missionNamespace getVariable _function;
    if (isNil "_code") then {
        _code = compile _function;
    };

    [_name, _origin] call _code;
};
