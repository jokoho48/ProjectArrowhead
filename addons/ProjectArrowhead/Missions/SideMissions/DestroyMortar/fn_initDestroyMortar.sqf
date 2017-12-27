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

    private _pos = [MGVAR(centerPos), 250, MGVAR(worldSize)*4] call MFUNC(selectRandomPos);
    while {surfaceIsWater _pos || !(_pos call MFUNC(isOnMap))} do {
        _pos = [MGVAR(centerPos), 250, MGVAR(worldSize)*4] call MFUNC(selectRandomPos);
    };
    private _objs = ["mortarBase", _pos, [(random 2) - 1, (random 2) - 1, 0]] call MFUNC(createObjectComp);
    private _mortars = ["Sign_Arrow_Yellow_F",  [east, ["static", "mortar"]] call MFUNC(getClassName), _objs, false] call MFUNC(replaceObjects);
    _objs pushBack _mortars;

    private _type = [east, "inf"] call MFUNC(getClassName);
    private _mortarGroup = createGroup east;
    {
        _x enableSimulationGlobal true;
        private _gunner = _mortarGroup createUnit [_type, getPos _x, [], 0, "NONE"];
        _gunner assignAsGunner _x;
        _gunner moveInGunner _x;
        _gunner setFormDir (getDir _x);
        _gunner setDir (getDir _x);
        _gunner doWatch (_gunner modelToWorld [0,100,30]);
        _gunner disableAI "MOVE";
        _gunner disableAI "ANIM";
        _gunner disableAI "FSM";
        _gunner disableAI "TARGET";
        _gunner disableAI "AUTOTARGET";
        _gunner disableAI "AIMINGERROR";
        _gunner disableAI "SUPPRESSION";
        NOCACHE(_x);
        NOCACHE(_gunner);
        _objs pushBack _gunner;
        nil
    } count _mortars;
    _objs pushBack _mortarGroup;
    private _grp = [_pos, 0, floor (random [4, 6, 8]), east] call MFUNC(spawnGroup);
    [[_grp, _pos], (random [150, 200, 250])] call MFUNC(taskPatrol);
    #ifdef ISDEV
    [_pos, "mil_triangle", "ColorEAST", 0, "Mortar Inf"] call MFUNC(createDebugMarker);
    #endif
    _objs pushBack _grp;
    for "_i" from 1 to 3 do {
        if (RND(50)) then {
            private _grp = [_pos, 0, floor (random [4, 6, 8]), east] call MFUNC(spawnGroup);
            [[_grp, _pos], (random [150, 200, 250])] call MFUNC(taskPatrol);
            #ifdef ISDEV
            [_pos, "mil_triangle", "ColorEAST", 0, "Mortar Inf"] call MFUNC(createDebugMarker);
            #endif
            _objs pushBack _grp;
        };
    };

    NOCACHE(_mortarGroup);
    [QGVAR(taskManager), [_mortars, _objs, _pos]] call CFUNC(serverEvent);
}] call CFUNC(addEventhandler);

[QGVAR(taskManager), {
    (_this select 0) params ["_mortars", "_objs", "_pos"];

    private _taskID = "destroyMortar" call MFUNC(taskName);

    [
        true,
        [_taskID],
        [
            "A hostile artillery position has been attacking our forces in the area. Annihilate it!",
            "S&D OPFOR artillery position",
            ""
        ],
        _pos, "Created", 5, true, "destroy", true
    ] call BIS_fnc_taskCreate;

    [{
        params ["_data", "_pfhID"];
        _data params [["_mortars", []], ["_objs", []], "_taskID"];

        if (({alive _x} count _mortars) != 0) exitWith {};
        GARBAGE(_objs);
        [_taskID, "SUCCEEDED",true] call BIS_fnc_taskSetState;
        [{
            _this call BIS_fnc_deleteTask;
        }, 10, _taskID] call CFUNC(wait);
        _pfhID call CFUNC(removePerFrameHandler);
    }, 5, [_mortars, _objs, _taskID]] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventhandler);
