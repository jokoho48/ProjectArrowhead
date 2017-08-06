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
params [["_spawnPos",[0,0,0],[[]]], ["_type",0,[0]], ["_count",1,[0]], ["_side", GVAR(enemySide)], ["_uncache",false]];
_spawnPos set [2, 0];

private _grp = createGroup _side;
_grp allowfleeing 0;
private _driverArray = [];
private _vehArray = [];
for "_j" from 0 to (_count - 1) do {
    private _pos = [_spawnPos, 10] call CFUNC(findSavePosition);
    _pos set [2, 0];
    call {
        if (_type isEqualTo 0) exitWith {
            private _unit = (GETUNIT(_side,_type) createUnit [_pos, _grp]);
            _unit allowDamage false;
        };
        _pos = _spawnPos vectorAdd [random 100, random 100, 0];
        private _veh = if (_type isEqualTo 1) then {
            private _type = GETUNIT(_side,_type);
            _pos = [_pos, 10, 0, _type] call CFUNC(findSavePosition);
            createVehicle [_type,_pos,[],100,"NONE"];
        } else {
            private _type = GETUNIT(_side,_type);
            _pos = [_pos, 10, 0, _type] call CFUNC(findSavePosition);
            if (surfaceIsWater _pos) then {
                createVehicle [_type,_pos,[],100,"FLY"];
            } else {
                createVehicle [_type,_pos,[],100,"NONE"];
            };
        };
        _vehArray pushBack _veh;
        _veh allowDamage false;
        private _unit = _grp createUnit [GETUNIT(_side,0),_pos, [], 100, "NONE"];
        _unit moveInDriver _veh;
        _unit allowDamage false;
        _driverArray pushBack _unit;

        if !((_veh emptyPositions "gunner") isEqualTo 0) then {
            for "_i" from 1 to (_veh emptyPositions "gunner") do {
                _unit = _grp createUnit [GETUNIT(_side,0),_pos, [], 100, "NONE"];
                _unit moveInGunner _veh;
                _unit allowDamage false;
            };
        };
        if !((_veh emptyPositions "commander") isEqualTo 0) then {
            for "_i" from 1 to (_veh emptyPositions "commander") do {
                _unit = _grp createUnit [GETUNIT(_side,0), _pos, [], 100, "NONE"];
                _unit moveInCommander _veh;
                _unit allowDamage false;
            };
        };
    };
};

{
    _x setRank (selectRandom ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"]);
    nil
} count (units _grp);
[{
    params ["_grp","_vehArray"];
    {
        _x allowDamage true;
        nil
    } count (units _grp);
    {
        _x allowDamage true;
        nil
    } count _vehArray;
}, 10, [_grp, _vehArray]] call CFUNC(wait);
if (_uncache) then {NOCACHE(_grp);};
if (_type isEqualTo 0) exitWith {_grp};

_driverArray
