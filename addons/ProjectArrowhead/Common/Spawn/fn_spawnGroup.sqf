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
params [["_spawnPos",[0,0,0],[[]]], ["_type",0,[0]], ["_count",1,[0]], ["_side", SEN_enemySide], ["_uncache",false]];
private ["_unitPool", "_vehPool", "_airPool"];
switch _side do {
    case WEST: {_unitPool = GVAR(unitPoolFriendly); _vehPool = GVAR(vehiclePoolFriendly); _airPool = GVAR(airPoolFriendly);};
    case RESISTANCE: {_unitPool = GVAR(unitPoolRebels); _vehPool = GVAR(vehiclePoolRebels); _airPool = [];};
    default {_unitPool = GVAR(unitPoolEnemy); _vehPool = GVAR(vehiclePoolEnemy); _airPool = GVAR(airPoolEnemy);};
};

private _grp = createGroup _side;
_grp allowfleeing 0;
private _driverArray = [];

for "_j" from 0 to (_count - 1) do {
    private _pos = [_spawnPos, 10] call FUNC(findSavePosition);

    call {
        if (_type isEqualTo 0) exitWith {
            (selectRandom _unitPool) createUnit [_pos, _grp];
        };
        private _veh = if (_type isEqualTo 1) then {
            (selectRandom _vehPool) createVehicle _pos;
        } else {
            createVehicle [(selectRandom _airPool),_pos,[],0,"FLY"];
        };

        private _unit = _grp createUnit [(selectRandom _unitPool),_pos, [], 0, "NONE"];
        _unit moveInDriver _veh;
        _driverArray pushBack _unit;

        if !((_veh emptyPositions "gunner") isEqualTo 0) then {
            for "_i" from 0 to (_veh emptyPositions "gunner") do {
                _unit = _grp createUnit [(selectRandom _unitPool),_pos, [], 0, "NONE"];
                _unit moveInGunner _veh;
            };
        };
        if !((_veh emptyPositions "commander") isEqualTo 0) then {
            for "_i" from 0 to (_veh emptyPositions "commander") do {
                _unit = _grp createUnit [(selectRandom _unitPool), _pos, [], 0, "NONE"];
                _unit moveInCommander _veh;
            };
        };
    };
};
if (_uncache) then {NOCHACE(_grp);};
if (_type isEqualTo 0) exitWith {_grp};

_driverArray
