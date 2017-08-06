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
params [["_grp", grpNull, [objNull, grpNull]], ["_range", 100, [0]], ["_waypointCount", 5, [0]]];

if (_grp isEqualType objNull) then {
    _grp = group _grp
};
_grp setBehaviour "SAFE";
private _lead = leader _grp;
private _houseArray = (getposATL _lead) nearObjects ["house", _range];

[_grp, _range, _houseArray, _waypointCount] call FUNC(setPatrolInf);
