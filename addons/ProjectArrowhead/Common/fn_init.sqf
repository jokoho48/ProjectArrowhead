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

["missionStarted", {
    call FUNC(Settings);
    call FUNC(fillLocations);
    GVAR(locations) call CFUNC(shuffleArray);
    west setFriend [east , 0];
    west setFriend [independent , 0];
    west setFriend [civilian, 1];

    east setFriend [west, 0];
    east setFriend [independent, 1];
    east setFriend [civilian, 1];

    independent setFriend [west , 0];
    independent setFriend [civilian , 1];
    independent setFriend [east , 1];

}] call CFUNC(addEventhandler);
["entityCreated", {
    (_this select 0) params ["_obj"];
    if (_obj isKindOf "ModuleCurator_F") then {
        _obj addEventHandler ["CuratorPinged", { _this call MFUNC(onPinged); }];
    };
}] call CFUNC(addEventhandler);

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


DFUNC(createDebugMarker) = {
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
player createDiarySubject ["PAW", "ProjectArrowHead"];
player createDiaryRecord ["PAW", ["Changelog",
"
v0.2<br/>
 - fix general Lint issues<br/>
 - add Collect Intel Pretask Posiblilty<br/>
 - fix that HC can be a Target for attack Missions<br/>
 - improve Performance of some functions<br/>
 - remove Task that are Completed to reduce task spamm in the beginning of the mission
<br/>
v0.1<br/>
 - initial Release<br/>
"]];
