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
[QGVAR(spawnUnits), {
    RUNTIMESTART;

    private _posTower = [MGVAR(centerPos), MGVAR(worldSize), 150] call MFUNC(findRuralFlatPos);
    while {(([_posTower, 3000] call MFUNC(getClosePlayers)) isEqualTo [] && (surfaceIsWater _posTower)) || !(_posTower call MFUNC(isOnMap))} do {
        _posTower = [MGVAR(centerPos), MGVAR(worldSize), 150] call MFUNC(findRuralFlatPos);
    };
    private _objs = [];
    _objs = ["destroyComTower", _posTower, [(random 2) - 1, (random 2) - 1, 0]] call MFUNC(createObjectComp);
    private _tower = _objs select {
        (typeOf _x) == "Land_TTowerBig_2_F"
    };
    _tower = _tower select 0;
    private _units = [];

    // Spawn Vehicle
    if (RND(50)) then {
        private _pos = selectRandom ([_posTower, 100, 0, 1, true, 10] call MFUNC(findPosArray));
        private _vehicles = [_pos, [1, selectRandom [0, 1]], 1, east] call MFUNC(spawnGroup);
        {
            [_x, 500, false] call MFUNC(setPatrolVeh);
            _units pushBack (group _x);
            nil
        } count _vehicles;
        #ifdef ISDEV
        [_pos, "mil_triangle", "ColorEAST", 0, "Tower Veh"] call MFUNC(createDebugMarker);
        #endif
    };

    private _grp = [_posTower, 0, floor (random [4, 6, 8]), east] call MFUNC(spawnGroup);
    [[_grp, _posTower], (random [150, 200, 250])] call MFUNC(taskPatrol);
    _units pushBack _grp;
    private _grp2 = [_posTower, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [_posTower, units _grp2, 200, true] call MFUNC(occupyBuilding);
    _units pushBack _grp2;
    #ifdef ISDEV
    [_posTower, "mil_triangle", "ColorEAST", 0, "Tower Inf"] call MFUNC(createDebugMarker);
    #endif
    [QGVAR(taskManager), [_tower, _units, _objs]] call CFUNC(serverEvent);
    RUNTIME("Spawn DestryTower");
}] call CFUNC(addEventhandler);

[QGVAR(taskManager), {
    (_this select 0) params ["_tower", "_units", "_objs"];

    private _taskID = "destroyComTower" call MFUNC(taskName);

    [
        true,
        [_taskID],
        [
            "Make Tower BOOOOOM",
            "BOOM BOOM Tower",
            ""
        ],
        getPos _tower, "Created", 5, true, "C", true
    ] call BIS_fnc_taskCreate;
    _tower setVariable [QGVAR(towerData), [_units, _objs, _taskID]];
    _tower addEventHandler ["Killed", {
        params ["_obj"];
        private _data = _obj getVariable [QGVAR(towerData), []];
        _data params [["_units", []], ["_objs", []], "_taskID"];
        GARBAGE(_units);
        GARBAGE(_objs);
        GARBAGE(_obj);
        [_taskID, "SUCCEEDED",true] call BIS_fnc_taskSetState;
        [{
            _this call BIS_fnc_deleteTask;
        }, 10, _taskID] call CFUNC(wait);
    }];
}] call CFUNC(addEventhandler);
