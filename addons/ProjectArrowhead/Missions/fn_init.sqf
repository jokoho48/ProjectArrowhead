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


DFUNC(collectIntelAction) = {
    params ["_object"];
    private _title = "Collect Intel";
    private _iconIdle = "\a3\ui_f\data\gui\rsc\rscdisplayarsenal\map_ca.paa";
    private _iconProgress = "\a3\ui_f\data\gui\rsc\rscdisplayarsenal\map_ca.paa";
    private _showCondition = {
        CLib_Player distance _target <= 5 && simulationEnabled _target
    };

    GVAR(collectStartTime) = -1;
    private _onStart = {
        params ["_target"];

        GVAR(collectStartTime) = time;
    };

    private _onProgress = {
        (time - GVAR(collectStartTime)) / 5;
    };

    private _onComplete = {
        params ["_target"];
        [QGVAR(taskManagerCollectIntel), _target] call CFUNC(serverEvent);

        GVAR(collectStartTime) = -1;
    };

    private _onInterruption = {

        GVAR(collectStartTime) = -1;
    };

    [_object, _title, _iconIdle, _iconProgress, _showCondition, _showCondition, _onStart, _onProgress, _onComplete, _onInterruption, [], 5000, true, true] call CFUNC(addHoldAction);
};

if (isServer) then {
    GVAR(intelObject) = [];
    publicVariable QGVAR(intelObject);
};

if (hasInterface) then {
    if !(GVAR(intelObject) isEqualTo []) then {
        {
            _x call FUNC(collectIntelAction);
            nil
        } count GVAR(intelObject);
    };
    [QGVAR(addIntelAction), {
        params ["_obj"];
        _obj call FUNC(collectIntelAction);
    }] call CFUNC(addEventhandler);
};

[QGVAR(spawnUnitsCollectIntel), {
    params ["_missionData"];
    private _pos = [MGVAR(centerPos), 0, MGVAR(worldSize)*4] call MFUNC(selectRandomPos);
    while {surfaceIsWater _pos || !(_pos call MFUNC(isOnMap))} do {
        _pos = [MGVAR(centerPos), 0, MGVAR(worldSize)*4] call MFUNC(selectRandomPos);
    };
    private _objs = [];
    {
        _x params ["_class", "_offset"];
        private _oPos = (_pos vectorAdd _offset);
        private _obj = createVehicle [_class, [0, 0, 0], [], 0, "CAN_COLLIDE"];
        _obj enableSimulation false;
        _obj allowDamage false;
        _obj setPos _oPos;
        _objs pushBack _obj;
        nil
    } count [
        ["CampEast", [0, 0, 0]],
        ["Land_SatelliteAntenna_01_F", [2.05762,4.5,0.00112915]],
        ["Land_CampingTable_F", [0,3,0.00112915]]
    ];
    private _obj = createVehicle ["Land_SatellitePhone_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
    _obj enableSimulation false;
    _obj allowDamage false;
    _obj setPos (_pos vectorAdd [0.00292969,2.99512,-0.00343895]);
    _objs pushBack _obj;

    if (floor (random 2) == 1) then {
        private _sPos = [_pos, 20, 500] call MFUNC(selectRnadomPos);
        private _grp = [_sPos, 0, floor (random [4, 6, 8]), east] call MFUNC(spawnGroup);
        [[_grp, _pos], (random [150, 200, 250])] call MFUNC(taskPatrol);
        if (floor (random 2) == 1) then {
            [_pos, 1, 1000, 3000, east, false, 2] call MFUNC(spawnSniper);
        };
    };
    GVAR(intelObject) pushBack _obj;

    private _taskID = "collectIntel" call MFUNC(taskName);
    [
        true,
        [_taskID],
        [
            "Collect Intel Mother Fucker",
            "Collect Intel",
            ""
        ],
        _pos vectorAdd [((random 200) - 100), ((random 200) - 100), 0], "Created", 5, true, "search", true
    ] call BIS_fnc_taskCreate;
    NOCACHE(_obj);
    NOCLEAN(_obj);
    _obj setVariable [QGVAR(intelMissionData), [_missionData, _taskID, _objs], true];
    publicVariable QGVAR(intelObject);
    [QGVAR(addIntelAction), _obj] call CFUNC(globalEvent);
}] call CFUNC(addEventhandler);

[QGVAR(taskManagerCollectIntel), {
    params ["_obj"];
    private _data = _obj getVariable QGVAR(intelMissionData);
    _data params ["_missionData", "_taskID", "_objs"];
    GARBAGE(_objs); // Push objs to Garbage Collector
    [_taskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;
    [{
        _this call BIS_fnc_deleteTask;
    }, 10, _taskID] call CFUNC(wait);
    if (isNil "_missionData") exitWith {};
    _missionData call MFUNC(callMissionData);
    deleteVehicle _obj;
    GVAR(intelObject) = GVAR(intelObject) - [objNull];
    publicVariable QGVAR(intelObject);
}] call CFUNC(addEventhandler);
