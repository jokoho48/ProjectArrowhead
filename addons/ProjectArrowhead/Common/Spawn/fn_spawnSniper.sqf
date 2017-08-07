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

params [["_pos", [0, 0, 0], [[]]], ["_count", 1, [0]], ["_min", 100, [0]],["_max", 1100, [0]], ["_side", GVAR(enemySide)], ["_nocache", false], ["_force", 2]];
private _return = [];
private _posASL = AGLToASL _pos;
private _loc = nearestLocations [_pos, ["Hill", "Mount"], _max];
private _posiblePos = [];
{
    private _checkPos = AGLToASL getPos _x;
    private _name = createMarker [QGVAR(debugMarkerSniper) + (str _forEachIndex), _checkPos];
    _name setMarkerShape "ICON";
    _name setMarkerType "hd_dot";
    if !(terrainIntersectASL [_posASL, _checkPos]) then {
        _name setMarkerColor "ColorBlue";
        private _ref1 = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];
        private _ref2 = createVehicle ["Land_HelipadEmpty_F", _checkPos, [], 0, "CAN_COLLIDE"];
        private _height = ((getposASL _ref2) vectorDiff (getPosASL _ref1)) select 2;
        private _distance = _checkPos distance _pos;
        if ((_distance > _min) && {(_distance < _max)} && {_height > 80}) then {
            _posiblePos pushback _checkPos;
            _name setMarkerColor "ColorRed";
        };
        deleteVehicle _ref1;
        deleteVehicle _ref2;
    };
    nil
} forEach _loc;
_posiblePos = _posiblePos call CFUNC(shuffleArray);
for "_i" from 1 to _count do {
    if (_posiblePos isEqualTo []) then {
        LOG("fn_spawnSniper cannot find suitable overwatch position.");
        if (_force > 0) then {
            [_pos, 1, _min, _max + 100, _side, _nocache, _force - 1] call FUNC(spawnSniper);
        };
    } else {
        private _overwatch = selectRandom _posiblePos;
        _posiblePos deleteAt (_overwatch find _posiblePos);
        private _ppos = _pos vectorDiff _overwatch;

        private _relDir = (_ppos select 0) atan2 (_ppos select 1);

        _overwatch = [_overwatch, 0, random [25, 50, 100], [_relDir - 60, _relDir + 60]] call MFUNC(selectRandomPos);

        private _objs = nearestTerrainObjects [_overwatch, ["BUSH", "ROCK", "ROCKS"], 100];
        if !(_objs isEqualTo []) then {
            {
                if !(terrainIntersectASL [_posASL, (getPosASL _x)]) exitWith {
                    _overwatch = getPos _x;
                };
            } forEach _objs
        };
        private _grp = createGroup _side;
        private _unit = _grp createUnit [GETUNIT(_side,3), _overwatch, [], 0, "NONE"];
        _unit setUnitPos "DOWN";
        _unit setSkill ["spotDistance", 1];
        _unit setUnitRank "COLONEL";
        (units _grp) doWatch _pos;
        _return pushBack _grp;
        _grp setBehaviour "COMBAT";

        if (_nocache) then {NOCACHE(_grp);};
    };
};

_return
