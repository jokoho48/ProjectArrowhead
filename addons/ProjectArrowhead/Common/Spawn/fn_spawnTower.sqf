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
params [["_pos", [0,0,0], [[]]], ["_range", 100, [0]], ["_count", 1, [0]], ["_side", SEN_enemySide]];

private _posArray = [_pos,_range,(_range*0.3),_count] call FUNC(findPosArray);

if !(_posArray isEqualTo []) then {
    private _grp = createGroup _side;
    _grp allowfleeing 0;
    NOCAHE(_grp);
    {
        private _tower = "Land_Cargo_Patrol_V1_F" createVehicle [0,0,0];
        _tower setdir random 360;
        _tower setPosATL _x;
        _tower setvectorup [0,0,1];
        private _unit = _grp createUnit [GETUNIT(_side,0), [0,0,0], [], 0, "NONE"];
        _unit setFormDir (getDir _tower);
        _unit setDir (getDir _tower);
        _unit setpos (_tower buildingpos 1);
        _unit setUnitPos "UP";
        _unit setskill ["spotDistance",0.90];
        _unit disableAI "MOVE";
        nil
    } count _posArray;

    _grp
} else {
    grpNull
};
