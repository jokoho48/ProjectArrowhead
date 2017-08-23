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
private _mission = selectRandom _this;
_mission params ["_name", "_function", "_origin", "_cfg"];

private _code = missionNamespace getVariable _function;
if (isNil "_code") then {
    _code = compile _function;
};
[_name, _origin, _cfg] call _code;
LOG("load Mission: """ + _name + """ from: " + _origin);
