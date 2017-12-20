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

    private _pos = [MGVAR(centerPos), 120, MGVAR(worldSize)*4] call MFUNC(selectRandomPos);
    while {surfaceIsWater _pos || !(_pos call MFUNC(isOnMap))} do {
        _pos = [MGVAR(centerPos), 120, MGVAR(worldSize)*4] call MFUNC(selectRandomPos);
    };
    private _objs = ["mortarBase", _pos, [(random 2) - 1, (random 2) - 1, 0]] call MFUNC(createObjectComp);
    private _mortars = ["Sign_Arrow_Yellow_F",  [east, ["static", "mortar"]] call MFUNC(getClassName), _objs] call MFUNC(replaceObjects);
    _objs pushBack _mortars;

    private _type = [east, "inf"] call MFUNC(getClassName);
    private _mortarGroup = createGroup east;
    {
        private _unit = _type createUnit [getPos _x, _mortarGroup];
        _objs pushBack _unit;
        _unit moveInGunner _x;
        _unit assignAsGunner _x;
        nil
    } count _mortars;
    _objs pushBack _mortarGroup;
    private _grp = [_pos, 0, floor (random [4, 6, 8]), east] call MFUNC(spawnGroup);
    [[_grp, _pos], (random [150, 200, 250])] call MFUNC(taskPatrol);
    #ifdef ISDEV
    [_sPos, "mil_triangle", "ColorEAST", 0, "Mortar Inf"] call MFUNC(createDebugMarker);
    #endif
    _objs pushBack _grp;
    for "_i" from 1 to 3 do {
        if (RND(50)) then {
            private _grp = [_pos, 0, floor (random [4, 6, 8]), east] call MFUNC(spawnGroup);
            [[_grp, _pos], (random [150, 200, 250])] call MFUNC(taskPatrol);
            #ifdef ISDEV
            [_sPos, "mil_triangle", "ColorEAST", 0, "Mortar Inf"] call MFUNC(createDebugMarker);
            #endif
            _objs pushBack _grp;
        };
    };

    private _taskID = "destryMortar" call MFUNC(taskName);
    [
        true,
        [_taskID],
        [
            "Destroy Mortar Position",
            "Make it BOOOOOM",
            ""
        ],
        _pos vectorAdd [((random 200) - 100), ((random 200) - 100), 0], "Created", 5, true, "destroy", true
    ] call BIS_fnc_taskCreate;
    NOCACHE(_obj);
    NOCACHE(_mortarGroup);
    [QGVAR(taskManager), [_mortars, _taskID, _objs]] call CFUNC(serverEvent);
}] call CFUNC(addEventhandler);

[QGVAR(taskManager), {
    (_this select 0) params ["_mortars", "_taskID", "_objs"];

    private _taskID = "destroyMortar" call MFUNC(taskName);

    [
        true,
        [_taskID],
        [
            "Mortar Boom",
            "Mortar Bad Boy make Boom",
            ""
        ],
        getPos _tower, "Created", 5, true, "C", true
    ] call BIS_fnc_taskCreate;

    [{
        params ["_data", "_pfhID"];
        _data params [["_mortars", []], ["_objs", []], "_taskID"];

        GARBAGE(_objs);
        if (({alive _x} count _mortars) != 0) exitWith {};
        [_taskID, "SUCCEEDED",true] call BIS_fnc_taskSetState;
        [{
            _this call BIS_fnc_deleteTask;
        }, 10, _taskID] call CFUNC(wait);
        _pfhID call CFUNC(removePerFrameHandler);
    }, 5, [_mortars, _taskID, _objs]] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventhandler);
