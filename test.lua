
-- ******************************************************************************************************
-- Testing

ind = require "indicators"
cn = require "candles"

function printCandle( _index )
	candle = cn.getIndicatorValue("", _index)
	print( string.format("o=%.0f h=%.0f l=%.0f c=%.0f shadow=%.0f, body=%.0f", 
		candle.open, candle.max, candle.min, candle.close, candle.max-candle.min, candle.close-candle.open) )
end

for i=1,20 do

	candles = cn.generateCandles(100)

	local w = ind.williams(14,1)
	-- print (w)	

	local a = ind.awesome(5,34,1,0)
	-- print (a)	

	local p = ind.pivotPoints(5,34,1,0)
	print (p.support1)	

end	