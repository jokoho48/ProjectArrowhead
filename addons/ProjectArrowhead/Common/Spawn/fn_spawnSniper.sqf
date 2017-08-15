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
private _posiblePos = [_pos, _min, _max] call FUNC(findOverwatchPos);
_posiblePos = _posiblePos call CFUNC(shuffleArray);
private _pCount = count _posiblePos;
private _randomI = floor (random _pCount);
for "_i" from 1 to _count do {
    if (_posiblePos isEqualTo []) then {
        LOG("fn_spawnSniper cannot find suitable overwatch position.");
        if (_force > 0) then {
            [_pos, 1, _min, _max + 300, _side, _nocache, _force - 1] call FUNC(spawnSniper);
        };
    } else {
        private _overwatch = _posiblePos select ((_randomI + _i) mod _pCount);
        _posiblePos deleteAt (_overwatch find _posiblePos);
        private _ppos = _pos vectorDiff _overwatch;

        private _relDir = (_ppos select 0) atan2 (_ppos select 1);

        _overwatch = [_overwatch, 0, random [25, 50, 100], [_relDir - 20, _relDir + 20]] call MFUNC(selectRandomPos);

        private _objs = nearestTerrainObjects [_overwatch, ["BUSH", "ROCK", "ROCKS"], 100];
        private _posASL = AGLToASL(_pos) vectorAdd [0,0, getTerrainHeightASL _pos + 1];
        if !(_objs isEqualTo []) then {
            {
                private _lis = lineIntersectsSurfaces [_posASL, getPosASL _x, objNull, objNull, true, -1, "NONE", "NONE"];
                if (_lis isEqualTo []) exitWith {
                    _overwatch = getPos _x;
                };
                nil
            } count (_objs call CFUNC(shuffleArray));
        };
        private _grp = createGroup _side;
        _overwatch set [2,0];
        private _unit = _grp createUnit [GETCLASS(_side,3), _overwatch, [], 0, "NONE"];
        _unit setPos _overwatch;
        _unit setUnitPos "DOWN";
        _unit setSkill ["spotDistance", 1];
        _unit setUnitRank "COLONEL";
        (units _grp) doWatch _pos;
        _return pushBack _grp;
        _grp setBehaviour "COMBAT";
        #ifdef ISDEV
        [getPos _unit, "mil_triangle", "ColorEAST", (getDir _unit), "Sniper"] call FUNC(createMarker);
        #endif
        if (_nocache) then {NOCACHE(_grp);};
    };
};

_return
