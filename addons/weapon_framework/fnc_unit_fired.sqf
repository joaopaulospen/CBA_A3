/* Order of operations:
1. Is weapon the same as last time?
2. If yes, are we skipping or using the cache?
3. If No, or it's the first time we've fired, cache the weapon. 
*/

#include "script_component.hpp"

params ["_unit","_weapon","_muzzle","_mode"];
private _weapon_check = _unit getVariable [QGVAR(weaponCheck),"false"];
private _onFired_cache = _unit getVariable [QGVAR(onFired_Action_cache),nil];
private _onEmpty_cache = _unit getVariable [QGVAR(onEmpty_cache),nil];

if (_weapon != (_unit getVariable [QGVAR(weapon),_weapon])) then {
	_weapon_check = "false";
};
if (_weapon_check == "true") then
{
	if (_unit ammo _weapon !=0) then 
	{
		if !(isNil "_onFired_cache") then {
			_onFired_cache spawn FUNC(onFiredAction);
		};
	}
	else
	{
		if !(isNil "_onEmpty_cache") then {
			_onEmpty_cache spawn FUNC(playweaponsound);
		};
	};
}
else
{
	if (_weapon_check == "skip") exitwith {};
	[_unit,_weapon,_muzzle,_mode] call FUNC(unit_cache); 
	_this spawn FUNC(unit_fired);
};

