local NewThread = function(func,...)
	local Thread = coroutine.wrap(func)
	Thread(...)	
end

return NewThread
