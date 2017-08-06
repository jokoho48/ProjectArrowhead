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
params [["_grpInput", grpNull, [objNull, grpNull, []]], ["_range", 100, [0]], ["_waypointCount", 5, [0]]];

private "_grp";
if (_grpInput isEqualType []) then {
    _grp = _grpInput select 0;
} else {
    _grp = grpInput;
};
if (_grp isEqualType objNull) then {
    _grp = group _grp
};
_grp setBehaviour "SAFE";
private _lead = leader _grp;
private _houseArray = (getposATL _lead) nearObjects ["house", _range];

[_grpInput, _range, _houseArray, _waypointCount] call FUNC(setPatrolInf);
