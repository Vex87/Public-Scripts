-- ServerScriptService
-- 08/16/20
-- VexTrexYT

local NewThread = function(func,...)
	local Thread = coroutine.wrap(func)
	Thread(...)	
end

return NewThread