#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    create a waypoint Patrol for a Group

    Parameter(s):
    0: Group that should Patrol <Goup, Object> ALT: <Array> 0: group <Goup,Object> 1: target Patrol Group
    1: Distance that waypoints get Set <NUMBER>
    2: Max Waypoint count <Number> (default: 5)

    Returns:
    None
*/
params [["_grpInput", grpNull, [objNull, grpNull, []]], ["_range", 100, [0]], ["_waypointCount", 5, [0]]];

private ["_grp", "_pos"];
if (_grpInput isEqualType []) then {
    _grp = _grpInput select 0;
    _pos = _grpInput select 1;
} else {
    _grp = _grpInput;
    _pos = getPosATL (leader _grpInput);
};

_grp setBehaviour "SAFE";

private _houseArray = _pos nearObjects ["house", _range];

[_grpInput, _range, _houseArray, _waypointCount] call FUNC(setPatrolInf);
