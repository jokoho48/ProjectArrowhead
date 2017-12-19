#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Spawns a AI Group at Spawn Pos

    Parameter(s):
    0: Target Position <Position>
    1: Unit Type ref: MFUNC(getClassName)
    2: Reinforcments Vehicle Type ref: MFUNC(getClassName)
    3: Amount of Units in a Group <Number> (default: 5)
    4: Side <Side> (default: EnemySide)
    5: Dont Cache the Units <Boolean> (default: false)

    Returns:
    spawned Groups <Array<Group>>
*/
params [
    ["_targetPos", [0,0,0], [[]]],
    ["_typeUnit", 0, [0, [], ""]],
    ["_type", 0, [0]],
    ["_countUnit", 1, [0]],
    ["_side", GVAR(enemySide)],
    ["_uncache",false]
];

private _pos = [_targetPos, MGVAR(worldSize)*4, 20, MGVAR(mainAOSize)] call MFUNC(findRuralFlatPos);
while {surfaceIsWater _pos && !(([_pos, 2000] call FUNC(getClosePlayers)) isEqualTo []) || !(_pos call MFUNC(isOnMap))} do {
    _pos = [_targetPos, MGVAR(worldSize)*4, 20, MGVAR(mainAOSize)] call MFUNC(findRuralFlatPos);
};

private _objs = [];
private _grp = [_pos, _typeUnit, _countUnit, _side, _uncache] call FUNC(spawnGroup);
_objs pushback _grp;
private _driver = [_pos, _type, 1, _side, _uncache] call FUNC(spawnGroup);
_objs pushback _driver;
private _vehicle = (vehicle (_driver select 0));
_vehicle setVariable [QGVAR(ejectUnits), units _grp, true];
_objs pushback _vehicle;

{
    _x assignAsCargo _vehicle;
    _x moveInCargo _vehicle;
    nil
} count (units _grp);

private _wp1Code = {
    private _units = (vehicle _this) getVariable [QGVAR(ejectUnits), []];
    {
        _x action ["Eject", vehicle _x];
        private _chute = "O_Parachute_02_F" createVehicle [getPos _x];
        _x assignAsDriver _chute;
        _x moveInDriver _chute;
        nil
    } count _units;
    [group (_units select 0), getpos ((_units select 0) findNearestEnemy (_units select 0)), 500, true] call CBA_fnc_taskAttack;
    (group _this) setCurrentWaypoint [group _this, 1];
};

_wp1Code = _wp1Code call CFUNC(codeToString);
private _wp2Code = {
    GARBAGE(vehicle _this);
    GARBAGE(group _this);
};

_wp2Code = _wp2Code call CFUNC(codeToString);

private _wp1 = (group (_driver select 0)) addWayPoint [_targetPos, 0];
private _wp2 = (group (_driver select 0)) addWayPoint [_targetPos, 1];
_wp1 setWaypointStatements ["true", _wp1Code];
_wp2 setWaypointStatements ["true", _wp2Code];

_objs
