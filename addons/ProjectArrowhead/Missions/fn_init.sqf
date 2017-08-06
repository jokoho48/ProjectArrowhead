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

GVAR(mainAOGroupCount) = 10;
GVAR(mainAOVehicleCount) = 5;
GVAR(mainAOAirCount) = 2;
GVAR(mainAOTower) = 2;
[QGVAR(spawnClearTownUnits), {
    (_this select 0) params ["_aoPos"];
    _aoPos = [_aoPos, 100] call CFUNC(findSavePosition);

    for "_i" from 1 to GVAR(mainAOGroupCount) do {
        private _pos = _aoPos vectorAdd [random 200, random 200, 0];
        _pos = [_pos, 100] call CFUNC(findSavePosition);
        private _grp = [_pos, 0, floor (random [3, 7, 12]), east] call MFUNC(spawnGroup);
        if (random 1 < 0.7) then {
            [_grp, (random [GVAR(mainAOSize) * 0.6, GVAR(mainAOSize), GVAR(mainAOSize) * 1.4])] call MFUNC(taskPatrol);
        } else {
            [_aoPos, units _grp, (random [GVAR(mainAOSize) * 0.6, GVAR(mainAOSize), GVAR(mainAOSize) * 1.4]), true] call MFUNC(occupyBuilding);
        };
    };
    for "_i" from 1 to GVAR(mainAOVehicleCount) do {
        private _pos = _aoPos vectorAdd [random 500, random 500, 0];
        _pos = [_aoPos, 100] call CFUNC(findSavePosition);
        private _vehicles = [_pos, 1, floor (random 3), east] call MFUNC(spawnGroup);
        {
            [_x, (random [GVAR(mainAOSize), GVAR(mainAOSize)*2, GVAR(mainAOSize)*3]), false] call MFUNC(setPatrolVeh);
            nil
        } count _vehicles;
    };
    for "_i" from 1 to GVAR(mainAOAirCount) do {
        private _pos = _aoPos vectorAdd [random 500, random 500, 0];
        _pos = [_aoPos, 100] call CFUNC(findSavePosition);
        private _vehicles = [_pos, 2, floor (random 3), east] call MFUNC(spawnGroup);
        {
            [_x, (random [GVAR(mainAOSize)*2, GVAR(mainAOSize)*3, GVAR(mainAOSize)*4]), true] call MFUNC(setPatrolVeh);
            nil
        } count _vehicles;
    };
}] call CFUNC(addEventhandler);
