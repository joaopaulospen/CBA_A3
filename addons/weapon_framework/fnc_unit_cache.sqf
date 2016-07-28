#include "script_component.hpp"
params ["_unit","_weapon","_muzzle","_mode"];

private _param = (configFile >> "CfgWeapons" >> _weapon >> "bg_weaponparameters");

_unit setvariable [QGVAR(weapon),_weapon];

if (isClass _param) then
{
    _unit setVariable [QGVAR(weaponCheck), "true"];
    if (isClass (_param >> "onFired_Action")) then
    {
        private ["_HandAction","_Actiondelay","_Sound","_Sound_Location","_hasOptic","_reloadDelay","_weaponConfig","_speed"];
        _HandAction = (_param >> "onFired_Action" >> "HandAction") call BIS_fnc_getCfgData;
        _Actiondelay = (_param >> "onFired_Action" >> "Actiondelay") call BIS_fnc_getCfgData;
        _Sound = (_param >> "onFired_Action" >> "Sound") call BIS_fnc_getCfgData;
        _Sound_Location = (_param >> "onFired_Action" >> "Sound_Location") call BIS_fnc_getCfgData;
        _hasOptic = (_param >> "onFired_Action" >> "hasOptic") call BIS_fnc_getCfgData;
        if (_mode == _weapon) then 
        {
            _weaponConfig = (configFile >> "CfgWeapons" >> _weapon);
            _speed = getnumber (_weaponConfig >> "reloadTime");
            _reloadDelay = _speed + 0.15;
        }
        else
        {
            _weaponConfig = (configFile >> "CfgWeapons" >> _weapon >> _mode);
            _speed = getnumber (_weaponConfig >> "reloadTime");
            _reloadDelay = _speed + 0.15;
        };
        
        _unit setVariable [QGVAR(onFired_Action_cache), [_unit,_weapon,_HandAction,_Actiondelay,_Sound,_Sound_Location,_hasOptic,_reloadDelay]];
    }
    else
    {
        _unit setVariable [QGVAR(onFired_Action_cache), nil];
    };
    if (isClass (_param >> "onEmpty")) then
    {
        _Sound = (_param >> "onEmpty" >> "Sound") call BIS_fnc_getCfgData;
        _Sound_Location = (_param >> "onEmpty" >> "Sound_Location") call BIS_fnc_getCfgData;
        _unit setVariable [QGVAR(onEmpty_cache), [_unit,_Sound,_Sound_Location]];
    }
    else
    {
        _unit setVariable [QGVAR(onEmpty_cache), nil];
    };
}
else
{
    _unit setVariable [QGVAR(weaponCheck), "skip"];
    false
};