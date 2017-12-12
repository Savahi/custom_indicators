-- Williams %R, Awesome Oscillator и Pivot Points	

-- require "candles"

-- The lines below should be commented in production version 
require "candles"
getIndicatorValue = candles.getIndicatorValue
-- *************************************************************

local indicators = {}


function williams( _period, _timeFrame, ... )

	local candleIndex = readOptionalArgumentsOfIndicators(...)

	local candle = readCandle( candleIndex, _timeFrame )
	if candle == nil then
		return nil
	end
	local close0 = candle.close

	local maxHigh = candle.max
	local minLow = candle.min
	for i = 1, _period - 1 do
		candle = readCandle( candleIndex + i, _timeFrame )
		if candle == nil then
			return nil
		end
		if candle.max > maxHigh then
			maxHigh = candle.max
		end
		if candle.min < minLow then
			minLow = candle.min
		end
	end

	local diff = maxHigh - minLow
	if not( diff > 0 ) then
		return nil
	end

	return (maxHigh - close0) / diff * (-100.0)
end


-- AO = SMA(High+Low)/2, 5 Periods) - SMA(High+Low/2, 34 Periods)
function awesome( _periods1, _periods2, _timeFrame, ... )

	local candleIndex = readOptionalArgumentsOfIndicators(...)

	if _periods1 == 0 or _periods2 == 0 then
		return nil
	end

	local periods = math.max( _periods1, _periods2 )
	local sum1 = 0.0
	local sum2 = 0.0
	for i = 1, periods do
		local candle = readCandle( candleIndex+i-1, _timeFrame )
		if candle == nil then
			return nil
		end
		if i <= _periods1 then
			sum1 = sum1 + (candle.max + candle.min)/2.0
		end
		if i <= _periods2 then
			sum2 = sum2 + (candle.max + candle.min)/2.0
		end
	end

	return (sum1/_periods1 - sum2/_periods2)
end


function pivotPoints( _timeFrame, ... )

	local candleIndex = readOptionalArgumentsOfIndicators(...)

	local candle = readCandle( candleIndex, _timeFrame )
	if candle == nil then
		return nil
	end

	local pivotP = (candle.max + candle.min + candle.close) / 3
	local support1 = pivotP * 2 - candle.max
	local support2 = pivotP * 2 - (candle.max - candle.min)
	local resistance1 = pivotP * 2 + candle.min
	local resistance2 = pivotP * 2 + (candle.max - candle.min)

	return { pivotPoint=pivotP, support1=support1, support2=support2, resistance1=resistance1, resistance2=resistance2 }
end


function proofCandle( _candleOpen, _candleMax, _candleMin, _candleClose )

	if _candleOpen == nil or _candleMax == nil or _candleMin == nil or _candleClose == nil then
		return nil
	end

	local candleOpen = tonumber( _candleOpen )
	if candleOpen == nil then
		return nil
	end
	local candleMax = tonumber( _candleMax )
	if candleMax == nil then
		return nil
	end
	local candleMin = tonumber( _candleMin )
	if candleMin == nil then
		return nil
	end
	local candleClose = tonumber( _candleClose )
	if candleClose == nil then
		return nil
	end

	return { open=candleOpen, min=candleMin, max=candleMax, close=candleClose }
end


function readCandle( _candleIndex, _timeFrame )

	local candle = getIndicatorValue( "NewCandle_".._timeFrame, _candleIndex )
	if candle == nil then
		return nil
	end

	local proofed = proofCandle( candle.open, candle.max, candle.min, candle.close )
	-- print( proofed.open ..",".. proofed.max ..",".. proofed.min ..",".. proofed.close )
	return proofed
end


function readOptionalArgumentsOfIndicators( ... )
	local candleIndex = 0

	for k,v in ipairs{...} do
		if k == 1 then
			candleIndex = v 
		end
	end

	return candleIndex
end


indicators.williams = williams
indicators.awesome = awesome
indicators.pivotPoints = pivotPoints
return indicators
