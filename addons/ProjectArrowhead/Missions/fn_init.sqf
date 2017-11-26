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
    private _obj = ("Land_SatellitePhone_F" createVehicle _pos);
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
        _obj, "Created", 5, true, "search", true
    ] call BIS_fnc_taskCreate;
    NOCACHE(_obj);
    NOCLEAN(_obj);
    _obj setVariable [QGVAR(intelMissionData), [_missionData, _taskID], true];
    publicVariable QGVAR(intelObject);
    [QGVAR(addIntelAction), _obj] call CFUNC(globalEvent);
}] call CFUNC(addEventhandler);

[QGVAR(taskManagerCollectIntel), {
    params ["_obj"];
    private _data = _obj getVariable QGVAR(intelMissionData);
    _data params ["_missionData", "_taskID"];
    [_taskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;
    if (isNil "_missionData") exitWith {};
    _missionData call MFUNC(callMissionData);
    deleteVehicle _obj;
    GVAR(intelObject) = GVAR(intelObject) - [objNull];
    publicVariable QGVAR(intelObject);
}] call CFUNC(addEventhandler);
