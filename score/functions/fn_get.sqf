#include "..\..\shared\bulwark.hpp"

private _killPoints = 0;
if (!isnil "KILLPOINTS_MODE") then {
    switch (KILLPOINTS_MODE) do {
        case KILLPOINTS_MODE_PRIVATE: {
            _killPoints = player getVariable "killPoints";
            if(isNil "_killPoints") then {
                _killPoints = 0;
            };
        };
        case KILLPOINTS_MODE_SHARED: {
        };
        case KILLPOINTS_MODE_SHAREABLE: {
        };
    };
};
_killPoints;