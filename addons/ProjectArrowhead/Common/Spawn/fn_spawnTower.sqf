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
params [["_pos", [0,0,0], [[]]], ["_range", 100, [0]], ["_count", 1, [0]], ["_side", GVAR(enemySide)], ["_unitCount", 1, [0]]];

private _posArray = [_pos,_range,(_range*0.2),_count] call FUNC(findPosArray);

if !(_posArray isEqualTo []) then {
    private _grp = createGroup _side;
    _grp allowfleeing 0;
    NOCACHE(_grp);
    {
        private _tower = "Land_Cargo_Patrol_V1_F" createVehicle [0,0,0];
        _tower setPosATL _x;
        private _dir = (_tower getRelDir _pos) - 90 + (random 180);
        _tower setDir _dir;
        _tower setPosATL _x;
        _tower setVectorUp [0,0,1];
        private _bPos = (_tower buildingpos -1);
        for "_i" from 1 to (count _bPos) min _unitCount do {
            private _unit = _grp createUnit [GETUNIT(_side,0), [0,0,0], [], 0, "NONE"];
            _unit setFormDir (getDir _tower);
            _unit setDir 180 + (getDir _tower);
            private _uBPos = selectRandom _bPos;
            _bPos deleteAt (_uBPos find _bPos);
            _unit setPos _uBPos;
            _unit setUnitPos "UP";
            _unit setSkill ["spotDistance",1];
            _unit disableAI "MOVE";
        };
        nil
    } count _posArray;

    _grp
} else {
    grpNull
};
