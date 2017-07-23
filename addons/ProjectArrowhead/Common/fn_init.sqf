#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:
    Init for Common Module

    Parameter(s):
    None

    Returns:
    None
*/


GVAR(baseMarker) = "Base";
["DisplayHint", {
    (_this select 0) params ["_headerText", "_mainText"];
    [format ["<t size='0.6' color='#ff0000'>%1</t> %1 <br/>", _headerText, _mainText]] spawn bis_fnc_dynamicText;
}] call CFUNC(addEventhandler);


DFUNC(onPinged) = {
    params ["_curator", "_unit"];

    private _pingCount = _unit getVariable "derp_curatorPingCount";
    private _lastPingTime = _unit getVariable "derp_lastPingTime";

    if (isnil "_pingCount") then {
        _unit setVariable ["derp_curatorPingCount", 1, false];
        _unit setVariable ["derp_lastPingTime", time, false];
    } else {
        _pingCount = _pingCount + 1;

        if (_lastPingTime <= time - 20) then {
            _unit setVariable ["derp_lastPingTime", time, false];
            _unit setVariable ["derp_curatorPingCount", 1, false];
        } else {
            if (_pingCount == 4) then {
                ["DisplayHint", _unit, ["YOU HAVE ANGERD ZEUS", "wait 20s before pressing the zeus ping button again, or die."]] call CFUNC(targetEvent);
            };
            if (_pingCount >= 5) then {
                _unit setDamage 1;
                _unit setVariable ["derp_curatorPingCount", nil, false];
                _unit setVariable ["derp_lastPingTime", nil, false];
            } else {
                _unit setVariable ["derp_lastPingTime", time, false];
                _unit setVariable ["derp_curatorPingCount", _pingCount, false];
            };
        };
    };
};

["entityCreated", {
    (_this select 0) params ["_obj"];
    if (_obj isKindOf "ModuleCurator_F") then {
        _obj addEventHandler ["CuratorPinged", { _this call FUNC(onPinged); }];
    };
}] call CFUNC(addEventhandler);


GVAR(unitPoolFriendly) = [];
GVAR(unitPoolEnemy) = [];
GVAR(unitPoolRebels) = [];
GVAR(unitPoolCiv) = [];
GVAR(vehiclePool) = [];
GVAR(vehiclePoolEnemy) = [];
GVAR(vehiclePoolCiv) = [];
GVAR(sniperPool) = [];

GVAR(enemySide) = East;

GVAR(locations) = [];
{ // if location is in _SEN_blacklistLocation, does not have a name or is near the MOB safezone, it is not added to DCG
    private _locName = text _x;
    private _locPos = getpos _x;
    _locPos set [2,0];
    if (_locPos distance (getmarkerpos GVAR(baseMarker)) > 1000 + 900) then {
        GVAR(locations) pushBack _x
    };
    nil
} count (nearestLocations [GVAR(centerPos), ["NameCityCapital","NameCity","NameVillage"], worldSize/2]);
