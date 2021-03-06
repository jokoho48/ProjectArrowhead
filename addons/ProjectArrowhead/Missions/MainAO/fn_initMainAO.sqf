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
GVAR(lastMissionLocation) = "";
["missionStarted", {
    GVAR(mainAOGroupCount) = [CFGPRAW2(clearTown,mainAOGroupCount), 10] call CFUNC(getSetting);
    GVAR(mainAOVehicleMRAPCount) = [CFGPRAW2(clearTown,mainAOVehicleMRAPCount), 5] call CFUNC(getSetting);
    GVAR(mainAOVehicleLightCount) = [CFGPRAW2(clearTown,mainAOVehicleLightCount), 2] call CFUNC(getSetting);
    GVAR(mainAOVehicleAACount) = [CFGPRAW2(clearTown,mainAOVehicleAACount), 1] call CFUNC(getSetting);
    GVAR(mainAOVehicleHeavyCount) = [CFGPRAW2(clearTown,mainAOVehicleHeavyCount), 1] call CFUNC(getSetting);
    GVAR(mainAOAirCount) = [CFGPRAW2(clearTown,mainAOAirCount), 1] call CFUNC(getSetting);
    GVAR(mainAOTower) = [CFGPRAW2(clearTown,mainAOTowerCount), 3] call CFUNC(getSetting);
    GVAR(mainAOSniper) = [CFGPRAW2(clearTown,mainAOSniperCount), 2] call CFUNC(getSetting);
    GVAR(mainAOStatic) = [CFGPRAW2(clearTown,mainAOStaticCount), 3] call CFUNC(getSetting);
}] call CFUNC(addEventhandler);


[QGVAR(spawnClearTownUnits), {
    RUNTIMESTART;
    private _aoPos = MGVAR(mainAOPos);

    [_aoPos, MGVAR(mainAOSize)*0.5, GVAR(mainAOStatic), -1, east] call MFUNC(spawnStatic); // Spawn Statics expect from Mortar
    [_aoPos, MGVAR(mainAOSize)*0.1, 1, 2, east] call MFUNC(spawnStatic); // Spawn Mortar
    [_aoPos, MGVAR(mainAOSize)*0.9, GVAR(mainAOTower), east, -1] call MFUNC(spawnTower); // Spawn Watch Towers

    // Spawn Inf Groups
    for "_i" from 1 to GVAR(mainAOGroupCount) do {
        private _pos = _aoPos vectorAdd [(random (MGVAR(mainAOSize)/3)) - (MGVAR(mainAOSize)/5), (random (MGVAR(mainAOSize)/3)) - (MGVAR(mainAOSize)/5), 0];
        private _grp = [_pos, 0, ceil (random [2, 4, 6]), east] call MFUNC(spawnGroup);
        if (RND(50)) then {
            [[_grp, _aoPos], (random [MGVAR(mainAOSize), MGVAR(mainAOSize) * 1.2, MGVAR(mainAOSize) * 1.4])] call MFUNC(taskPatrol);
        } else {
            [_pos, units _grp, 50, true] call MFUNC(occupyBuilding);
        };
    };

    // Spawn Vehicles
    {
        private _posArray = [_aoPos, MGVAR(mainAOSize), 0, _x, true, 100] call MFUNC(findPosArray);
        {
            private _vehicles = [_x, [1, _forEachIndex], 1, east] call MFUNC(spawnGroup);
            {
                [[_x, _aoPos], (random [MGVAR(mainAOSize)*1.5, MGVAR(mainAOSize)*3, MGVAR(mainAOSize)*4]), false] call MFUNC(setPatrolVeh);
                nil
            } count _vehicles;
            nil
        } count _posArray;
    } forEach [GVAR(mainAOVehicleMRAPCount), GVAR(mainAOVehicleLightCount), GVAR(mainAOVehicleAACount), GVAR(mainAOVehicleHeavyCount)];


    // Spawn Air Vehciles
    for "_i" from 1 to GVAR(mainAOAirCount) do {
        private _pos = [_aoPos, MGVAR(mainAOSize)*2, MGVAR(mainAOSize)] call MFUNC(findRuralFlatPos);
        private _vehicles = [_pos, [2, 0], 1, east] call MFUNC(spawnGroup);
        {
            [[_x, _aoPos], (random [MGVAR(mainAOSize)*2, MGVAR(mainAOSize)*3, MGVAR(mainAOSize)*4]), true] call MFUNC(setPatrolVeh);
            nil
        } count _vehicles;
    };

    // Spawn Snipers
    [_aoPos, GVAR(mainAOSniper), MGVAR(mainAOSize)*0.2, MGVAR(mainAOSize)*2.5, east, false, 2] call MFUNC(spawnSniper);
    QGVAR(ClearTownTask) call CFUNC(serverEvent);
    RUNTIME("Spawn Main AO");
}] call CFUNC(addEventhandler);

[QGVAR(ClearTownTask), {
    private _taskID = "ClearTown" call MFUNC(taskName);

    [
        true,
        [_taskID],
        [
            format ["Enemy forces in %1 have been spotted. They seem to have the town on a lock down, it's our job to clear the town of enemy forces. ", MGVAR(locationData) select 1],
            format ["Clear out Opfor in %1", MGVAR(locationData) select 1],
            ""
        ],
        MGVAR(mainAOPos), "Created", 5, true, "attack", true
    ] call BIS_fnc_taskCreate;
    private _aiCount = count ((nearestObjects [MGVAR(mainAOPos), ["CAManBase"], MGVAR(mainAOSize)]) select {_x call MFUNC(isAwake)});
    [{
        (_this select 0) params ["_leftToWin", "_taskID"];
        private _currentCount = count ((nearestObjects [MGVAR(mainAOPos), ["CAManBase"], MGVAR(mainAOSize)]) select {_x call MFUNC(isAwake)});
        if (_leftToWin >= _currentCount) then {
            private _units = nearestObjects [MGVAR(mainAOPos), [], MGVAR(mainAOSize)];
            {
                if (RND(50)) then {
                    _x call MFUNC(setUnitSurrender);
                };
            } count _units;
            deleteMarker QGVAR(mainAO);
            GARBAGE(_units);
            CLEARMISSIONTASK(_taskID, "SUCCEEDED");
            NEXTMAINAO;
        };
    }, 20, [round ((_aiCount/100)*10), _taskID]] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventhandler);
