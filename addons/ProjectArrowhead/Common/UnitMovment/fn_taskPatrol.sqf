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
params [["_grp", grpNull, [objNull, grpNull]], ["_range", 100, [0]]];

if (_grp isEqualType objNull) then {
    _grp = group _grp
};
_grp setBehaviour "SAFE";
private _lead = leader _grp;
private _houseArray = (getposATL _lead) nearObjects ["house", _range];

[_grp, _range, _houseArray] call FUNC(setPatrolInf);
