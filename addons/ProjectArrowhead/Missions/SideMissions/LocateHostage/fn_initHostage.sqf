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
    private _posVIP = [0,0,0];
    if (worldName isEqualTo "Chernarus" || {worldName isEqualTo "Chernarus_Summer"}) then {
        _posVIP = [GVAR(centerPos), GVAR(worldSize),10] call MFUNC(findRuralFlatPos);
    } else {
        private _houseArray = [GVAR(centerPos), GVAR(worldSize)] call MFUNC(findRuralHousePos);
        _posVIP = (_houseArray select 0);
        while {(([_posVIP, 3000] call MFUNC(getNearPlayers)) isEqualTo [] && (surfaceIsWater _posVIP))} do {
            _houseArray = [GVAR(centerPos), GVAR(worldSize)] call MFUNC(findRuralHousePos);
            _posVIP = (_houseArray select 0);
        };
    };

    private _units = [];

    private _type = GETCLASS(civilian,0);
    private _grp = createGroup civilian;
    private _vip = _grp createUnit [_type, _posVIP, [], 0, "NONE"];
    _vip setPos _posVIP;
    _units pushBack (group _vip);

    // Spawn Vehicle
    if (random 1 >= 0.4) then {
        private _pos = selectRandom ([_posVIP, 500, 0, 1, true, 10] call MFUNC(findPosArray));
        private _vehicles = [_pos, 1, 1, east] call MFUNC(spawnGroup);
        {
            [_x, 500, false] call MFUNC(setPatrolVeh);
            _units pushBack (group _x);
            nil
        } count _vehicles;
        #ifdef ISDEV
        [_pos, "mil_triangle", "ColorEAST", 0, "Hostage Veh"] call MFUNC(createMarker);
        #endif
    };

    private _pos = [_posVIP, 200, 5] call MFUNC(findRuralFlatPos);
    private _grp = [_pos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [[_grp, _posVIP], (random [100, 150, 200])] call MFUNC(taskPatrol);
    _units pushBack _grp;
    #ifdef ISDEV
    [_pos, "mil_triangle", "ColorEAST", 0, "Hostage Inf"] call MFUNC(createMarker);
    #endif
    [QGVAR(taskManager), [_vip, _units]] call CFUNC(serverEvent);
}] call CFUNC(addEventhandler);

[QGVAR(taskManager), {
    (_this select 0) params ["_vip", "_units"];

    private _taskID = "locateHostage" call MFUNC(taskName);

    [
        true,
        [_taskID],
        [
            "get me out biatsch",
            "Hostage Rescue",
            ""
        ],
        getPos _vip, "Created", 5, true, "C", true
    ] call BIS_fnc_taskCreate;
    _units pushBack _vip;
    [{
        params ["_args", "_id"];
        _args params ["_vip", "_units", "_taskID"];
        if !(alive _vip) exitWith {
            _id call CFUNC(removePerFrameHandler);
            [_taskID, "FAILED",true] call BIS_fnc_taskSetState;
            GARBAGE(_units);
            NEXTSIDEMISSION;
        };
        if ((getPos _vip) call MFUNC(nearBase)) then {
            _id call CFUNC(removePerFrameHandler);
            [{
                params ["_units", "_taskID"];
                [_taskID, "SUCCEEDED",true] call BIS_fnc_taskSetState;
                GARBAGE(_units);
                NEXTSIDEMISSION;
            }, 20, [_units, _taskID]] call CFUNC(wait);
        };
    }, 10, [_vip, _units, _taskID]] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventhandler);
