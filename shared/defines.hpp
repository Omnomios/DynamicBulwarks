#define LOG_INFO "INFO"
#define LOG_ERR  "ERR"
#define LOG_WARN "WARN"

#define TYPENAME_ARRAY        "ARRAY"
#define TYPENAME_BOOL         "BOOL"
#define TYPENAME_CODE         "CODE"
#define TYPENAME_CONFIG       "CONFIG"
#define TYPENAME_CONTROL      "CONTROL"
#define TYPENAME_DISPLAY      "DISPLAY"
#define TYPENAME_GROUP        "GROUP"
#define TYPENAME_LOCATION     "LOCATION"
#define TYPENAME_OBJECT       "OBJECT"
#define TYPENAME_SCALAR       "SCALAR"
#define TYPENAME_SCRIPT       "SCRIPT"
#define TYPENAME_SIDE         "SIDE"
#define TYPENAME_STRING       "STRING"
#define TYPENAME_TEXT         "TEXT"
#define TYPENAME_TEAM_MEMBER  "TEAM_MEMBER"
#define TYPENAME_NAMESPACE    "NAMESPACE"
#define TYPENAME_DIARY_RECORD "DIARY_RECORD"
#define TYPENAME_TASK         "TASK"

//
// Parameters
//
#define GET_PARAM_BY_INDEX(params, index) (params select index)
#define GET_PARAM_BY_ID(params, id) call { private _id = id; private _paramIndex = (params findIf { _id == PARAM_GET_ID(_x) }); if (_paramIndex == -1) then { nil; } else { GET_PARAM_BY_INDEX(params, _paramIndex); };}
#define GET_CURRENT_PARAM_BY_INDEX(index) (CurrentBulwarkParams select index)
#define GET_CURRENT_PARAM_BY_ID(id) GET_PARAM_BY_ID(CurrentBulwarkParams, id)

#define PARAM_CATEGORY_FILTERS "Filters"
#define PARAM_CATEGORY_LOOT "Loot"
#define PARAM_CATEGORY_WEIGHTEDLOOT "Weighted Randomized loot settings"
#define PARAM_CATEGORY_WAVE "Waves"
#define PARAM_CATEGORY_START "Start Conditions"
#define PARAM_CATEGORY_BULWARK "Bulwark Configuration"
#define PARAM_CATEGORY_GAME "Game Configuration"
#define PARAM_CATEGORY_TIME "Time and Date"
#define PARAM_CATEGORY_GEOGRAPHY "Geography"
#define PARAM_CATEGORY_UPGRADES "Upgrades"
#define PARAM_CATEGORY_PLAYER "Player Configuration"
#define PARAM_CATEGORY_AMOUNTAMMO "Ammo loot settings"

// A boolean value (true/false)
#define PARAM_TYPE_BOOL 0
#define PARAM_TYPE_NUMBER 1
#define PARAM_TYPE_STRING 2

#define PARAM_INDEX_ID          0
#define PARAM_INDEX_TITLE       1
#define PARAM_INDEX_CATEGORY    2
#define PARAM_INDEX_TYPE        3
#define PARAM_INDEX_MULTISELECT 4
#define PARAM_INDEX_OPTIONS     5
#define PARAM_INDEX_VALUE       6
#define PARAM_INDEX_DESC        7

#define PARAM_INDEX_OPTION_ID 0
#define PARAM_INDEX_OPTION_NAME 1
#define PARAM_INDEX_OPTION_VALUE 2

// Param Getters
#define PARAM_GET_ID(param) (param select PARAM_INDEX_ID)
#define PARAM_GET_TITLE(param) (param select PARAM_INDEX_TITLE)
#define PARAM_GET_CATEGORY(param) (param select PARAM_INDEX_CATEGORY)
#define PARAM_GET_TYPE(param) (param select PARAM_INDEX_TYPE)
#define PARAM_IS_MULTISELECT(param) (param select PARAM_INDEX_MULTISELECT)
#define PARAM_HAS_OPTIONS(param) (count (param select PARAM_INDEX_OPTIONS) > 0)
#define PARAM_GET_OPTIONS(param) (param select PARAM_INDEX_OPTIONS)
#define PARAM_GET_OPTION_BY_INDEX(param, index) (PARAM_GET_OPTIONS(param) select index)
#define PARAM_GET_OPTION_INDEX_FOR_ID(param, id) call { private _id = id; (PARAM_GET_OPTIONS(param) findIf { typename _id == typename PARAM_GET_OPTION_ID(_x) && { _id == PARAM_GET_OPTION_ID(_x) } }) }
#define PARAM_GET_OPTION_BY_ID(param, id) call { private _optionIndex = PARAM_GET_OPTION_INDEX_FOR_ID(param, id); if (_optionIndex == -1) then { nil;} else { PARAM_GET_OPTION_BY_INDEX(param, _optionIndex); }; }
#define PARAM_GET_VALUE(param) (param select PARAM_INDEX_VALUE)
#define PARAM_GET_DESC(param) (param select PARAM_INDEX_DESC)

#define PARAM_GET_OPTION_ID(option) (option select PARAM_INDEX_OPTION_ID)
#define PARAM_GET_OPTION_NAME(option) (option select PARAM_INDEX_OPTION_NAME)
#define PARAM_GET_OPTION_VALUE(option) (option select PARAM_INDEX_OPTION_VALUE)

// Param Setters
#define PARAM_SET_VALUE(param, value) param set [PARAM_INDEX_VALUE, value]

// Saved params
#define SAVED_PARAM_INDEX_ID    0
#define SAVED_PARAM_INDEX_VALUE 1

#define SAVED_PARAM_GET_ID(param) (param select SAVED_PARAM_INDEX_ID)
#define SAVED_PARAM_GET_VALUE(param) (param select SAVED_PARAM_INDEX_VALUE)

// Parameter Sets
#define PARAMSETS_DEFAULT_SET_NAME "Default"
#define PARAMSETS_SAVE_NAME "_ParameterSets"
#define PARAMSETS_SELECTED_SAVE_NAME "_SelectedParameterSet"

#define PARAMSET_TYPE_BUILTIN 0
#define PARAMSET_TYPE_CUSTOM 1

#define PARAMSET_INDEX_TITLE 0
#define PARAMSET_INDEX_TYPE 1

#define PARAMSET_GET_TITLE(set) (set select PARAMSET_INDEX_TITLE)
#define PARAMSET_GET_TYPE(set) (set select PARAMSET_INDEX_TYPE)
