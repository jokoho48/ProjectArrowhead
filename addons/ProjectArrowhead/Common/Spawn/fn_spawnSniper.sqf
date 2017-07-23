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

params [["_pos", [0, 0, 0], [[]]], ["_count", 1, [0]], ["_min", 100, [0]],["_max", 1100, [0]], ["_side", GVAR(enemySide)], ["_nocache", false], ["_force", 2]];
private _return = [];

for "_i" from 1 to _count do {
    private _overwatch = [_pos,_max,_min,-1000] call BIS_fnc_findoverwatch;
    private _ref1 = createVehicle ["Land_HelipadEmpty_F", _pos, [], 0, "CAN_COLLIDE"];
    private _ref2 = createVehicle ["Land_HelipadEmpty_F", _overwatch, [], 0, "CAN_COLLIDE"];
    private _overwatchHeight = (_ref1 worldtomodel _overwatch) select 2;
    private _overwatchASL = (getposASL _ref2) select 2;

    if (_overwatch isEqualTo [0,0,0] || {_overwatch isEqualTo []} || {_overwatch distance _pos > _max} || {_overwatchASL < 80}) then {
        LOG("fn_spawnSniper cannot find suitable overwatch position.");
        if (_force != 0) then {
            [_pos, 1, _min, _max, _side, _nocache, _force - 1] call FUNC(spawnSniper);
        };
    } else {
        private _type = selectRandom GVAR(sniperPool);
        private _grp = createGroup _side;
        private _unit = _grp createUnit [_type, _overwatch, [], 0, "NONE"];
        _unit setUnitPos "DOWN";
        _unit setskill ["spotDistance",0.97];
        (units _grp) doWatch _pos;
        _return pushBack _grp;
        _grp setBehaviour "COMBAT";

        if (_nocache) then {NOCAHE(_grp);};

    };
    deleteVehicle _ref1;
    deleteVehicle _ref2;
};

_return
