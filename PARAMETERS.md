# Bulwark Parameters System

The Bulwark parameters system integrates with the lobby UI to provide an extensible
way to add parameters to the game and allow users to save and load different parameter
configurations. This replaces the "Mission Parameters" which would normally be set in
the multiplayer role-selection screen.

## Overview

Bulwark parameters are stored as an associative array which is saved into the `profileNamespace`
of the user (typically the group leader during the game). This array is indexed by a unique
identifier defined in `bulwark.hpp`.  The exact values of these IDs does not matter, they just
need to be unique.

> WARNING: Do not change existing IDs or you will break people's existing parameter saves. You can
> safely delete IDs though.

Parameters are accessed using the `shared_fnc_getCurrentParamValue` function. For example:
```
#include "shared\bulwark.hpp"
private _currentHostileMultiplier = BULWARK_PARAM_HOSTILE_MULTIPLIER call shared_fnc_getCurrentParamValue;
```

## Parameter Sets

A parameter set is a complete set of parameters either saved to the user's `profileNamespace` or loaded
from the built-in parameters.  These can be loaded and saved by name using `shared_fnc_loadParameterSet`
and `shared_fnc_saveParameterSet`:

> NOTE: There are two types of parameter sets: BUILTIN and CUSTOM.  It's possible to save a custom parameter
> set with the same name as a built-in one.  This is safe to do so as built-in parameters are never actually
> saved, they are "built-in" to the mission.

```
#include "shared\defines.hpp"
private _myParameterSet = ["MyParamSet", PARAMSET_TYPE_CUSTOM] call shared_fnc_loadParameterSet;

... make some changes...

["MyParamSet", _myParameterSet] call shared_fnc_saveParameterSet;
```

Or, to load the "default" parameters by hand:
```
#include "shared\defines.hpp"
private _defaultParameterSet = [PARAMSETS_DEFAULT_SET_NAME, PARAMSET_TYPE_CUSTOM] call shared_fnc_loadParameterSet;
```

## Default and other built-in parameter sets

Built-in parameter sets are defined in `shared_fnc_getDefaultParameterSets`.  Parameter sets added here will always
show up at the top of the lobby dialog for setting parameters. Built-in parameter sets are based on the _default_
parameters, which are defined in `shared_fnc_getDefaultParams`. When a built-in parameter set is loaded (technically
when _any_ parameter set is loaded), the parameters defined in the set overwrite the values of the parameters with
the same ID from the default parameters.  This ensures that if new parameters are added to the game in the defaults, saved parameter sets will use those new defaults.  The format for built-in parameter set values is the same as for *saved* parameter set values, which differs from the default parameter set definition.  See the Parameter Definitions section for more information about the storage format.

## Parameter Definitions

Parameters are defined in `shared_fnc_getDefaultParams`, and are stored as an array with each entry having the following format:

```
// Parameter Definition format
[ 
	<id>,
	<title>, <category>, <type>, <multiselect>, 
	<options>, 
	<value>, 
	<description>
]
```

* `id`: This is a unique identifier for this parameter. It can be any number that doesn't conflict with another parameter and does not change
* `title`: This is the name of the parameter which is displayed in the parameter dialog
* `category`: This is the name of the category the parameter will be displayed under in the dialog
* `type`: This is the parameter type
* `multiselect`: Should be `true` if the parameter supports selecting multiple options at once, `false` otherwise
* `options`: An array of options the user may select from, if any
* `param_value`: The value (or values in the `multiselect = true` case) of the parameter
* `description`: This is the detailed description shown in the parameter dialog when the user elects to change the value

### Options and Values

Parameters can either specify a set of options from which the user may choose, or may allow free-form entry of the
value.  If the `options` part of the parameter is an empty array (`[]`), the parameter dialog will allow the user
to set any value they wish, and the default `param_value` can be anything. If the `options` part of the parameter is a non-empty array, then each entry in the array must be in the following format: 

```
// Option Definition format
[
  <option_id>,
  <option_title>,
  <option_value>
]
```

* `option_id`: The unique identifier of this option - can be any value, just need to be unique among the options in this parameter
* `option_title`: The display name for the option in the parameter dialog
* `option_value`: The actual value for the option as used in the game

> WARNING: Do not change existing `option_id` values.  You can remove them and add new ones, however.

In the case where options are available, the `param_value` of the _parameter_ refers to the _option_id_ of the option in the `options` array (not the `option_value` of the option). This allows the developer to freely change the `option_value` for a given option without changing the parameter value and invalidating saved parameter sets.

## Parameters Dialog

Parameters are presented in the parameters dialog ordered by category.  However, the ordering is defined by the order the
parameters appear in the *default* parameters, as found in `shared_fnc_getDefaultParams`. You may freely re-order parameters
here, but parameters will always appear within their assigned category, and will be ordered within that category in the 
order they appear in that function.

Parameter Sets appear in the following order: built-in parameter sets first, then custom sets in the order they were originally
saved by the user.  The built-in order can be changed by changing the ordering in `shared_fnc_getDefaultParameterSets`. Custom
set ordering cannot be changed.

# Implementation Details

> WARNING: You shouldn't need to do this unless you are editing the parameter system itself or the lobby dialog.  Use `shared_fnc_getCurrentParamValue` instead!

## Getting parameters and options directly

There are a set of macros used to manipulate the parameter and option arrays to ensure they do not become corrupted. These are defined in `shared\defines.hpp`.  Assuming you have already loaded a parameter set using `shared_fnc_loadParameterSet`, you can access it as follows:

```
private _myParameterSet = ["MyParamSet", PARAMSET_TYPE_CUSTOM] call shared_fnc_loadParameterSet;

// Get the parameter in Parameter Definition format
private _myParam = GET_PARAM_BY_ID(_myParameterSet, MY_PARAMETER_ID); 

// Get the `param_value` field of the parameter
private _myParamValue = PARAM_GET_VALUE(_myParam); 

// If the parameter has options, _myParamValue refers to an option and isn't the value itself,
// so we need to look it up. This works in the case where `multiselect` is `false`:
private _myActualValue = if (PARAM_HAS_OPTIONS(_myParam)) then {
  private _option = PARAM_GET_OPTION_BY_ID(_myParam, _myParamValue);

  // Gets the `option_value` field of the option
  PARAM_GET_OPTION_VALUE(_option);
} else {
  _myParamValue;
};
```

For multi-select params, the actual values will be a list of selected options, such as:

```
private _myActualValues = if (PARAM_IS_MULTISELECT(_myParam)) then {
  private _options = PARAM_GET_OPTIONS(_myParam);
  private _returnValues = [];
  {
    private _option = PARAM_GET_OPTION_BY_ID(_myParam, _x);
    _returnValues pushBack PARAM_GET_OPTION_VALUYE(_option);
  } forEach _myParamValue;
  _returnValues;
} else {
  ... non-multiselect handling ...
};
```

## Setting parameter values directly

The macro `PARAM_SET_VALUE` can be used to edit the existing value for a specified param, and is the complement
to `PARAM_GET_VALUE`.

## Parameter Set storage

Parameter sets are stored in the profile only with the information needed to hold their values - they do not contain
the entire definition of each parameter. Their format is as follows:

```
[
  [
    <param_id>, <param_value>
  ],
  ...
]
```

* `param_id`: The ID of the parameter
* `param_value`: The stored value of the parameter

See the implementation of `shared_fnc_saveParameterSet` and `shared_fnc_loadParameterSet`.



