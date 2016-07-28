#include "script_component.hpp"

params ["_unit","_weapon","_HandAction","_Actiondelay","_Sound","_Sound_Location","","_reloadDelay"];
private _hasOptic = (_this select 6 == 1);
private _acc = _unit weaponAccessories _weapon;

if (_acc select 2 != "") then 
{
    _hasOptic = true;
};


if (!local _unit && _hasOptic) exitwith {};


if (!isDedicated && _hasOptic && player == _unit) then 
{
    if (cameraview == "GUNNER") then
    {
        true call FUNC(block_reloadaction);
    };
    while {cameraview == "GUNNER"} do 
    {
        _unit setWeaponReloadingTime [_unit,_weapon,1];
        sleep 0.001;
    };
    sleep _Actiondelay;
    [_unit,_Sound,_Sound_Location] spawn FUNC(playweaponsound);
    GVAR(playsound) = [_unit,_Sound,_Sound_Location];
    publicVariable QGVAR(playsound);
    _unit playAction _HandAction;
    true call FUNC(block_reloadaction);
    sleep _reloadDelay;
    false call FUNC(block_reloadaction);
    
}
else
{
    sleep _Actiondelay;
    [_unit,_Sound,_Sound_Location] spawn FUNC(playweaponsound);
    if (local _unit) then 
    {
        _unit playAction _HandAction;
        if (_unit == player) then
        {
            true call FUNC(block_reloadaction);
            sleep _reloadDelay;
            false call FUNC(block_reloadaction);
        };
    };
};
