#include "script_component.hpp"

LOG(MSG_INIT);

PREP(playweaponsound);
PREP(onFiredAction);
PREP(block_reloadaction);
PREP(unit_fired);


QGVAR(playsound) addPublicVariableEventHandler {(_this select 1) spawn FUNC(playweaponsound)};
