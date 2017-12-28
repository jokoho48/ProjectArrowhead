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

    private _spawnBase = ((floor (random 2)) == 1);
    private _posOff = [MGVAR(centerPos), MGVAR(worldSize), [10, 300] select _spawnBase] call MFUNC(findRuralFlatPos);
    while {(([_posOff, 3000] call MFUNC(getClosePlayers)) isEqualTo [] && (surfaceIsWater _posOff)) || !(_posOff call MFUNC(isOnMap))} do {
        _posOff = [MGVAR(centerPos), MGVAR(worldSize), [10, 300] select _spawnBase] call MFUNC(findRuralFlatPos);
    };
    private _objs = [];
    if (_spawnBase) then {
        private _offPos = +_posOff;
        _objs = ["smallBase", _offPos, [(random 2) - 1, (random 2) - 1, 0]] call MFUNC(createObjectComp);
    };
    private _units = [];

    private _type = GETCLASS2(east,0,0);
    private _grp = createGroup east;
    private _officer = _grp createUnit [_type, _posOff, [], 0, "NONE"];
    _officer setPos _posOff;
    _units pushBack (group _officer);
    // Spawn Vehicle
    if (RND(50)) then {
        private _pos = selectRandom ([_posOff, 100, 0, 1, true, 10] call MFUNC(findPosArray));
        private _vehicles = [_pos, [1, selectRandom [0, 1]], 1, east] call MFUNC(spawnGroup);
        {
            [_x, 500, false] call MFUNC(setPatrolVeh);
            _units pushBack (group _x);
            nil
        } count _vehicles;
        #ifdef ISDEV
        [_pos, "mil_triangle", "ColorEAST", 0, "Eliminate Veh"] call MFUNC(createDebugMarker);
        #endif
    };

    if (_spawnBase) then {
        private _grp2 = [_posOff, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
        [_posOff, units _grp2, 200, true] call MFUNC(occupyBuilding);
    };

    private _grp = [_posOff, 0, floor (random [4, 6, 8]), east] call MFUNC(spawnGroup);
    [[_grp, _posOff], (random [150, 200, 250])] call MFUNC(taskPatrol);
    _units pushBack _grp;
    private _grp2 = [_posOff, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [_posOff, units _grp2, 200, true] call MFUNC(occupyBuilding);
    _units pushBack _grp2;
    #ifdef ISDEV
    [_posOff, "mil_triangle", "ColorEAST", 0, "Eliminate Inf"] call MFUNC(createDebugMarker);
    #endif
    [QGVAR(taskManager), [_officer, _units, _objs]] call CFUNC(serverEvent);
    RUNTIME("Spawn eliminate Officer");
}] call CFUNC(addEventhandler);

[QGVAR(taskManager), {
    (_this select 0) params ["_officer", "_units", "_objs"];

    private _taskID = "eliminateOfficer" call MFUNC(taskName);

    [
        true,
        [_taskID],
        [
            "Locate and assassinate enemy officer",
            "Eliminate Officer",
            ""
        ],
        getPos _officer, "Created", 5, true, "C", true
    ] call BIS_fnc_taskCreate;
    _officer setVariable [QGVAR(officerData), [_units, _objs, _taskID]];
    _officer addEventHandler ["Killed", {
        params ["_unit"];
        private _data = _unit getVariable [QGVAR(officerData), []];
        _data params [["_units", []], ["_objs", []], "_taskID"];
        GARBAGE(_units);
        GARBAGE(_objs);
        GARBAGE(_unit);
        [_taskID, "SUCCEEDED",true] call BIS_fnc_taskSetState;
        [{
            _this call BIS_fnc_deleteTask;
        }, 10, _taskID] call CFUNC(wait);
        NEXTSIDEMISSION;
    }];
}] call CFUNC(addEventhandler);
