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
GVAR(mainAOTower) = 3;
GVAR(mainAOSniper) = 4;
[QGVAR(spawnClearTownUnits), {
    (_this select 0) params ["_aoPos"];

    for "_i" from 1 to GVAR(mainAOGroupCount) do {
        private _pos = _aoPos vectorAdd [random 200, random 200, 0];
        private _grp = [_pos, 0, floor (random [3, 7, 12]), east] call MFUNC(spawnGroup);
        if (random 1 < 0.7) then {
            [[_grp, _aoPos], (random [GVAR(mainAOSize) * 0.6, GVAR(mainAOSize), GVAR(mainAOSize) * 1.4])] call MFUNC(taskPatrol);
        } else {
            [_aoPos, units _grp, GVAR(mainAOSize)*0.3, true] call MFUNC(occupyBuilding);
        };
    };
    for "_i" from 1 to GVAR(mainAOVehicleCount) do {
        private _pos = _aoPos vectorAdd [random 500, random 500, 0];
        private _vehicles = [_pos, 1, 1, east] call MFUNC(spawnGroup);
        {
            [[_x, _aoPos], (random [GVAR(mainAOSize), GVAR(mainAOSize)*2, GVAR(mainAOSize)*3]), false] call MFUNC(setPatrolVeh);
            nil
        } count _vehicles;
    };
    for "_i" from 1 to GVAR(mainAOAirCount) do {
        private _pos = [_aoPos, worldSize/2, GVAR(mainAOSize)] call MFUNC(findRuralFlatPos);
        private _vehicles = [_pos, 2, 1, east] call MFUNC(spawnGroup);
        {
            [[_x, _aoPos], (random [GVAR(mainAOSize)*2, GVAR(mainAOSize)*3, GVAR(mainAOSize)*4]), true] call MFUNC(setPatrolVeh);
            nil
        } count _vehicles;
    };
    [_aoPos, GVAR(mainAOSize)*1.5, GVAR(mainAOTower), east, 3] call MFUNC(spawnTower);
    //[_this, GVAR(mainAOSniper), GVAR(mainAOTower)/2, GVAR(mainAOTower)*2, east, false, 1] call MFUNC(spawnSniper);
}] call CFUNC(addEventhandler);
