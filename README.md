A lua library to calculate technical indicators 
===================================================================================
version 0.0.1
    
> **Important notice**:
> Nothing important yet... :)

## CONTENTS / СОДЕРЖАНИЕ ##
[williams](#williams) - Williams %R Indicator.  
[awesome](#awesome) - Awesome Indicator.  
[pivotPoints](#pivotpoints) - Pivot Points.  

-----

### Williams ###
Returns the value of the "Williams %R" indicator.

```lua
function williams( _period, _timeFrame, _index )
```
    _period (integer) - The period of the indicator.
    _timeFrame (integer) - Time frame for candles.
    _index (integer, default:0, optional) - The index of candle to calculate the indicator at. 


### Awesome ###
Returns the value of the "Awesome" indicator
```lua
function awesome( _periods1, _periods2, _timeFrame, _index )
```
    _period1 (integer) - Period 1 of the indicator.
    _period2 (integer) - Period 2 of the indicator.
    _timeFrame (integer) - Time frame for candles
    _index (integer, default:0, optional) - The index of candle to calculate the indicator at. 


### Pivot Points ###
Returns a set of support/resistance levels.

```lua
pivotPoints( _timeFrame, _index )
```
    _timeFrame (integer) - Time frame for candles.
    _index (integer, default:0, optional) - The index of candle to calculate the indicator at. 


