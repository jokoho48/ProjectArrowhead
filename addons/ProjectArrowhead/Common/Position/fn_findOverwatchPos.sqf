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
params ["_pos", "_min", "_max"];

private _varName = format [QGVAR(%1_%2_%3), _pos, _min, _max];
private _posiblePos = GVAR(OverwatchCache) getVariable [_varName, []];
if !(_posiblePos isEqualTo []) exitWith { _posiblePos; };
private _posASL = AGLToASL(_pos) vectorAdd [0,0, getTerrainHeightASL _pos + 1];

{
    private _checkPos = locationPosition _x;
    #ifdef ISDEV
    private _mrk = [_checkPos, "hd_dot"] call FUNC(createMarker);
    #endif
    private _height = abs (getTerrainHeightASL _pos - getTerrainHeightASL _checkPos);
    private _distance = _checkPos distance2D _pos;
    if ((_distance > _min) && {(_distance < _max)} && {_height > 50}) then {
        private _lis = lineIntersectsSurfaces [_posASL, AGLToASL(_checkPos), objNull, objNull, true, -1, "NONE", "NONE"];
        #ifdef ISDEV
        _mrk setMarkerColor "ColorBlue";
        private _in = str _forEachIndex;
        {
            _x params ["_aslPos"];
            private _mrk = [_aslPos, "hd_dot", "ColorRed"] call FUNC(createMarker);
            nil
        } forEach _lis;
        #endif
        if (_lis isEqualTo []) then {
            _posiblePos pushback _checkPos;
            #ifdef ISDEV
            _mrk setMarkerColor "ColorGreen";
            #endif
        };
    };
    nil
} forEach nearestLocations [_pos, ["Hill", "Mount"], _max];

GVAR(OverwatchCache) setVariable [_varName, _posiblePos, true];
_posiblePos
