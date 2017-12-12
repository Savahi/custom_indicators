-- For testing

candles = {}

function generateCandles( _numCandles )
	local max
	local min
	local open
	local close
	for i = _numCandles, 1, -1 do		 
		if i < _numCandles then
			open = close
		else
			open = 10000
		end
		max = open + (math.random(20) - 1)
		min = open - (math.random(20) - 1)
		close = min + math.random(max-min+1) - 1
		candles[i] = { max=max, min=min, open=open, close=close }
	end
	return candles
end


function getIndicatorValue( _name, _index )
	if _index >= 0 and _index < table.maxn(candles) then
		return candles[_index+1]
	else 
		return nil
	end
end


candles.generateCandles = generateCandles
candles.getIndicatorValue = getIndicatorValue

return candles