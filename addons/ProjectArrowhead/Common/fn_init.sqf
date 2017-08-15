#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Init for Common Module

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(centerPos) = [worldSize/2, worldSize/2];
GVAR(worldSize) = (worldSize/2);

call FUNC(Settings);

["entityCreated", {
    (_this select 0) params ["_obj"];
    if (_obj isKindOf "ModuleCurator_F") then {
        _obj addEventHandler ["CuratorPinged", { _this call FUNC(onPinged); }];
    };
}] call CFUNC(addEventhandler);

call FUNC(fillLocations);
GVAR(locations) call CFUNC(shuffleArray);

["ACE_handcuffUnit", {
    (_this select 0) params ["_unit", "_state"];
    if !(local _unit) exitWith {};
    [_unit, _state] call ace_captives_fnc_setHandcuffed;
}] call CFUNC(addEventhandler);

["excuteFunction", {
    (_this select 0) params [["_function", ""], "_args"];
    _args call (missionNamespace getVariable [_function, {LOG("Error Function not found")}]);
}] call CFUNC(addEventhandler);

["excuteCode", {
    (_this select 0) params [["_code", {}], "_args"];
    _args call _code;
}] call CFUNC(addEventhandler);



DFUNC(createMarker) = {
#ifdef ISDEV
    params ["_pos", "_icon", "_color", "_dir", "_text"];
    private _mrk = createMarker [format[QGVAR(%1_%2_%3_%4), _pos, _icon, _color, _dir, _text], _pos];
    _mrk setMarkerType _icon;
    if !(isNil "_color") then {
        _mrk setMarkerColor _color;
    };
    if !(isNil "_dir") then {
        _mrk setMarkerDir (180 - _dir);
    };
    if !(isNil "_text")  then {
        _mrk setMarkerText _text;
    };
    _mrk
#endif
};

PRAW_fnc_canGarbageCollect = {
    params ["_obj"];
    if (_obj isEqualType objNull) then {
        _obj call CLib_GarbageCollector_fnc_pushbackInQueue;
    } else {
        {
            if (vehicle _x != _x) then {
                _x call CLib_GarbageCollector_fnc_pushbackInQueue;
            };
            _x call CLib_GarbageCollector_fnc_pushbackInQueue;
            nil
        } count (units (group _obj))
    };
};
