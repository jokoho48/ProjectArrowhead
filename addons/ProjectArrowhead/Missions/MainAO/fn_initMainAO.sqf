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

GVAR(mainAOGroupCount) = 10;    // TODO: make settings
GVAR(mainAOVehicleCount) = 5;    // TODO: make settings
GVAR(mainAOAirCount) = 2;    // TODO: make settings
GVAR(mainAOTower) = 3;    // TODO: make settings
GVAR(mainAOSniper) = 2;    // TODO: make settings
GVAR(mainAOStatic) = 3;    // TODO: make settings

[QGVAR(spawnClearTownUnits), {
    private _aoPos = MGVAR(mainAOPos);

    [_aoPos, MGVAR(mainAOSize)*0.5, GVAR(mainAOStatic), -1, east] call MFUNC(spawnStatic); // Spawn Statics expect from Mortar
    [_aoPos, MGVAR(mainAOSize)*0.1, 1, 2, east] call MFUNC(spawnStatic); // Spawn Mortar
    [_aoPos, MGVAR(mainAOSize)*0.9, GVAR(mainAOTower), east, 4] call MFUNC(spawnTower); // Spawn Watch Towers

    // Spawn Inf Groups
    for "_i" from 1 to GVAR(mainAOGroupCount) do {
        private _pos = _aoPos vectorAdd [(random 200) - 100, (random 200) - 100, 0];
        private _grp = [_pos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
        if (random 1 < 0.7) then {
            [[_grp, _aoPos], (random [MGVAR(mainAOSize) * 0.6, MGVAR(mainAOSize), MGVAR(mainAOSize) * 1.4])] call MFUNC(taskPatrol);
        } else {
            [_aoPos, units _grp, MGVAR(mainAOSize)*0.3, true] call MFUNC(occupyBuilding);
        };
    };

    // Spawn Vehicles
    private _posArray = [_aoPos, MGVAR(mainAOSize), 0, GVAR(mainAOVehicleCount), true, 10] call MFUNC(findPosArray);
    {
        private _vehicles = [_x, 1, 1, east] call MFUNC(spawnGroup);
        {
            [[_x, _aoPos], (random [MGVAR(mainAOSize)*1.5, MGVAR(mainAOSize)*3, MGVAR(mainAOSize)*4]), false] call MFUNC(setPatrolVeh);
            nil
        } count _vehicles;
        nil
    } count _posArray;

    // Spawn Air Vehciles
    for "_i" from 1 to GVAR(mainAOAirCount) do {
        private _pos = [_aoPos, MGVAR(mainAOSize)*2, MGVAR(mainAOSize)] call MFUNC(findRuralFlatPos);
        private _vehicles = [_pos, 2, 1, east] call MFUNC(spawnGroup);
        {
            [[_x, _aoPos], (random [MGVAR(mainAOSize)*2, MGVAR(mainAOSize)*3, MGVAR(mainAOSize)*4]), true] call MFUNC(setPatrolVeh);
            nil
        } count _vehicles;
    };

    // Spawn Snipers
    [_aoPos, GVAR(mainAOSniper), MGVAR(mainAOSize)*0.2, MGVAR(mainAOSize)*1.3, east, false, 2] call MFUNC(spawnSniper);
    QGVAR(ClearTownTask) call CFUNC(serverEvent);
}] call CFUNC(addEventhandler);

[QGVAR(ClearTownTask), {
    private _taskID = "ClearTown" call MFUNC(taskName);

    [
        true,
        [_taskID],
        [
            format ["Clear %1 from enemy forces", MGVAR(locationData) select 1],
            "Clear Town",
            "attack"
        ],
        MGVAR(mainAOPos), 1, 1, false, "attack", true
    ] call BIS_fnc_taskCreate;
    private _aiCount = count nearestObjects [MGVAR(mainAOPos), ["CAManBase"], MGVAR(mainAOSize)];
    [{
        (_this select 0) params ["_leftToWin", "_taskID"];
        private _currentCount = count nearestObjects [MGVAR(mainAOPos), ["CAManBase"], MGVAR(mainAOSize)];
        if (_leftToWin >= _currentCount) then {
            private _units = nearestObjects [MGVAR(mainAOPos), ["CAManBase", "AllVehicles"], MGVAR(mainAOSize)];
            {
                if ((random 1) <= 0.5) then {
                    _x call MFUNC(setUnitSurrender);
                };
            } count _units;
            [{
                deleteMarker QGVAR(mainAO);
                {
                    deleteVehicle _x;
                    nil
                } count _this;
            }, 500, _units] call CFUNC(wait);
            [_taskID, "SUCCEEDED",true] call BIS_fnc_taskSetState;
            (_this select 1) call CFUNC(removePerFrameHandler);
            // call EFUNC(MainAO,selectMainMission);
        };
    }, 20, [ceil ((_aiCount/100)*10), _taskID]] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventhandler);
