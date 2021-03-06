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
    private _posVIP = [0,0,0];
    if (worldName isEqualTo "Chernarus" || {worldName isEqualTo "Chernarus_Summer"}) then {
        _posVIP = [MGVAR(centerPos), MGVAR(worldSize),10] call MFUNC(findRuralFlatPos);
        while {(([_posVIP, 3000] call MFUNC(getClosePlayers)) isEqualTo [] && (surfaceIsWater _posVIP)) || !(_posVIP call MFUNC(isOnMap))} do {
            _posVIP = [MGVAR(centerPos), MGVAR(worldSize),10] call MFUNC(findRuralFlatPos);
        };
    } else {
        private _houseArray = [MGVAR(centerPos), MGVAR(worldSize)] call MFUNC(findRuralHousePos);
        _posVIP = (_houseArray select 1);
        while {(([_posVIP, 3000] call MFUNC(getClosePlayers)) isEqualTo [] && (surfaceIsWater _posVIP)) || !(_posVIP call MFUNC(isOnMap))} do {
            _houseArray = [MGVAR(centerPos), MGVAR(worldSize)] call MFUNC(findRuralHousePos);
            _posVIP = (_houseArray select 1);
        };
    };

    private _units = [];

    private _type = GETCLASS(civilian,0);
    private _grp = createGroup civilian;
    private _vip = _grp createUnit [_type, _posVIP, [], 0, "NONE"];
    _vip setPos _posVIP;
    _units pushBack (group _vip);
    [_vip, true] call MFUNC(setUnitHostage);
    // Spawn Vehicle
    if (RND(50)) then {
        private _pos = selectRandom ([_posVIP, 500, 0, 1, true, 10] call MFUNC(findPosArray));
        private _vehicles = [_pos, [1, selectRandom [0, 1]], 1, east] call MFUNC(spawnGroup);
        {
            [_x, 500, false] call MFUNC(setPatrolVeh);
            _units pushBack (group _x);
            nil
        } count _vehicles;
        #ifdef ISDEV
        [_pos, "mil_triangle", "ColorEAST", 0, "Hostage Veh"] call MFUNC(createDebugMarker);
        #endif
    };

    private _pos = [_posVIP, 100, 5] call MFUNC(findRuralFlatPos);
    private _grp = [_pos, 0, floor (random [4, 6, 8]), east] call MFUNC(spawnGroup);
    [[_grp, _posVIP], (random [150, 200, 250])] call MFUNC(taskPatrol);
    _units pushBack _grp;
    private _grp2 = [_pos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [_pos, units _grp2, 200, true] call MFUNC(occupyBuilding);
    _units pushBack _grp2;
    #ifdef ISDEV
    [_pos, "mil_triangle", "ColorEAST", 0, "Hostage Inf"] call MFUNC(createDebugMarker);
    #endif
    [QGVAR(taskManager), [_vip, _units]] call CFUNC(serverEvent);
    RUNTIME("Spawn localte Hostage");
}] call CFUNC(addEventhandler);

[QGVAR(taskManager), {
    (_this select 0) params ["_vip", "_units"];

    private _taskID = "locateHostage" call MFUNC(taskName);

    [
        true,
        [_taskID],
        [
            "We've got intel on a hostage situation. Enemy forces have taken a VIP hostage it is our top priority to rescue him and bring him back to base alive.",
            "Search and Rescue",
            ""
        ],
        getPos _vip, "Created", 5, true, "C", true
    ] call BIS_fnc_taskCreate;
    [{
        params ["_args", "_id"];
        _args params ["_vip", "_units", "_taskID"];
        if !(_vip call MFUNC(isAwake)) exitWith {
            _id call CFUNC(removePerFrameHandler);
            CLEARMISSIONTASK(_taskID, "FAILED");
            GARBAGE(_units);
            NEXTSIDEMISSION;
        };
        if ((getPos _vip) call MFUNC(inBase)) then {
            _id call CFUNC(removePerFrameHandler);
            [{
                params ["_units", "_taskID"];
                CLEARMISSIONTASK(_taskID, "SUCCEEDED");
                GARBAGE(_units);
                NEXTSIDEMISSION;
            }, 20, [_units, _taskID]] call CFUNC(wait);
        };
    }, 10, [_vip, _units, _taskID]] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventhandler);
