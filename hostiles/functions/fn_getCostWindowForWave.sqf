params ["_minCost", "_maxCost", "_capWave", "_windowSize", "_wave"];


private _actualCostSpan = (_maxCost - _minCost) * _windowSize;

private _wave1CostCenter = _minCost + (1 / _capWave) * (_maxCost - _minCost);
private _wave1MaxCost = (_wave1CostCenter + _actualCostSpan) min _maxCost;

private _actualCostCenter = _minCost + (_wave / _capWave) * (_maxCost - _minCost) - (_wave1MaxCost - 1);

private _actualMinCost = ((_actualCostCenter - _actualCostSpan) max _minCost) min (_maxCost - _actualCostSpan);
private _actualMaxCost = (_actualCostCenter + _actualCostSpan) min _maxCost;

[_actualMinCost, _actualMaxCost];