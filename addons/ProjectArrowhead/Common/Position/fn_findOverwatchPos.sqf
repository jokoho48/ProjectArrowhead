#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Find a Overwatch Position to a Target Position

    Parameter(s):
    0: Center Position <Position>
    1: Minimum Distance <Number>
    2: Maximum Distance <Number>

    Returns:
    Posible Overwatch Positions <Array<Position>>
*/
params ["_pos", "_min", "_max"];

private _varName = format ["%1_%2_%3_%4", _pos, _min, _max];
private _posiblePos = GVAR(OverwatchCache) getVariable [_varName, []];
if !(_posiblePos isEqualTo []) exitWith { _posiblePos; };
private _posASL = (AGLToASL(_pos) vectorAdd [0,0, getTerrainHeightASL _pos + 1]);

{
    private _checkPos = locationPosition _x;
    #ifdef ISDEV
    private _mrk = [_checkPos, "hd_dot"] call FUNC(createDebugMarker);
    #endif
    private _height = (getTerrainHeightASL _checkPos) - (getTerrainHeightASL _pos);
    private _distance = _checkPos distance2D _pos;
    private _incidenceAngle = _height atan2 _distance;
    if ((_distance > _min) && {_distance < _max} && {_height > 20 || (_incidenceAngle < 60 && _incidenceAngle > 15)}) then {
        private _lis = lineIntersectsSurfaces [_posASL, AGLToASL(_checkPos), objNull, objNull, true, -1, "NONE", "NONE"];
        #ifdef ISDEV
        _mrk setMarkerColor "ColorBlue";
        {
            _x params ["_aslPos"];
            [_aslPos, "hd_dot", "ColorRed"] call FUNC(createDebugMarker);
            nil
        } count _lis;
        #endif
        if (_lis isEqualTo []) then {
            _posiblePos pushback _checkPos;
            #ifdef ISDEV
            _mrk setMarkerColor "ColorGreen";
            #endif
        };
    };
    nil
} count (nearestLocations [_pos, ["Hill", "Mount"], _max]);

GVAR(OverwatchCache) setVariable [_varName, _posiblePos, true];
_posiblePos
