#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Spawns Towers Random around a Center Position

    Parameter(s):
    0: Center Position <Position>
    1: Range for Waypoints <Number> (default: 100)
    2: Amount <Number> (default: 1)
    3: Side <Side> (default: EnemySide)
    4: Amount of Units Spawned on a Tower <Number> (default: 1)
    5: Dont Cache the Units <Boolean> (default: false)

    Returns:
    Group of Spawned Units <Group>
*/
params [["_pos", [0,0,0], [[]]], ["_range", 100, [0]], ["_count", 1, [0]], ["_side", GVAR(enemySide)], ["_unitCount", 1, [0]], ["_nocache", false]];

private _posArray = [_pos,_range,(_range*0.2),_count] call FUNC(findPosArray);

if !(_posArray isEqualTo []) then {
    private _grp = createGroup _side;
    _grp allowfleeing 0;
    if (_nocache) then {
        NOCACHE(_grp);
    };
    {
        private _tower = "Land_Cargo_Patrol_V3_F" createVehicle [0,0,0];
        private _dir = (_tower getRelDir _pos) - 55 + (random 110);
        _tower setDir _dir;
        _tower setPosATL _x;
        _tower setVectorUp [0,0,1];
        private _bPos = (_tower buildingpos -1);
        {
            ["addCuratorEditableObjects", [_x, [[_tower], true]]] call CFUNC(serverEvent);
            nil
        } count allCurators;
        private "_count";
        if (_unitCount == -1) then {
            _count = ceil random 4;
        } else {
            _count = _unitCount;
        };
        private _bPosCount = count _bPos;
        for "_i" from 1 to (_bPosCount min _count) do {
            private _uBPos = _bPos select ((_i + 2) mod _bPosCount);
            private _unit = _grp createUnit [GETCLASS(_side,0), _uBPos, [], 0, "NONE"];
            _unit setFormDir (getDir _tower);
            _unit setDir (180 + (getDir _tower));
            _unit setPos _uBPos;
            _unit setUnitPos "UP";
            _unit setSkill ["spotDistance",1];
            _unit disableAI "MOVE";
        };
        #ifdef ISDEV
        [_x, "mil_triangle", "ColorEAST", _dir, "TOWER"] call FUNC(createMarker);
        #endif
        nil
    } count _posArray;

    _grp
} else {
    grpNull
};
