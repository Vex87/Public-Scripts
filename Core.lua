local Core = {}

function Core.Round(n, Places)
	if not Places then
		return math.floor(n + 0.5)
	end
	return math.floor((n * 10 ^ Places) + 0.5) / 10 ^ Places
end

function Core.Get(Parent, Class)
	local Tbl = {}
	
	for _,v in pairs(Parent:GetChildren()) do
		if v:IsA(Class) then
			table.insert(Tbl, v)
		end
	end
	
	return Tbl
end

function Core.WaitForPath(target, path, maxWait)
	
	local BAD_ARG_ERROR="%s is not a valid %s"
	
	do --error checking
		local tt=typeof(target)
		local tp=typeof(path)
		local tm=typeof(maxWait)
		if tt~="Instance" then error(BAD_ARG_ERROR:format("Argument 1","Instance")) end
		if tp~="string" then error(BAD_ARG_ERROR:format("Argument 2","string")) end
		if tm~="nil" and tm~="number" then error(BAD_ARG_ERROR:format("Argument 3","number")) end
	end
	local segments=string.split(path,".")
	local latest
	local start=tick()
	for index,segment in pairs(segments) do
		if maxWait then
			latest=target:WaitForChild(segment,(start+maxWait)-tick())
		else
			latest=target:WaitForChild(segment)
		end
		if latest then
			target=latest
		else
			return nil
		end
	end
	return latest
	
end

function Core.Mag(Start, End)
	
	if typeof(Start) ~= "Vector3" then
		Start = Start.Position
	end
	
	if typeof(End) ~= "Vector3" then
		End = End.Position
	end	
	
	return (Start-End).Magnitude
end

function Core.NewThread(func,...)
	local a = coroutine.wrap(func)
	a(...)
end

function Core.CloneTable(OriginalTable)
	local copy = {}
	for k, v in pairs(OriginalTable) do
		if type(v) == "table" then
			v = Core.CloneTable(v)
		end
		copy[k] = v
	end
	return copy
end

function Core.TableRemove(Table, Value, RemoveCount)		
	local Count = 0
	
	if typeof(RemoveCount) == "number" then
		for x = RemoveCount, 1, -1 do
			if table.find(Table, Value) then
				Count = Count + 1
				table.remove(Table, table.find(Table, Value))	
			end
		end
	elseif RemoveCount then
		repeat
			if table.find(Table, Value) then
				Count = Count + 1	
				table.remove(Table, table.find(Table, Value))	
			end
		until not table.find(Table, Value)
	elseif not RemoveCount then
		if table.find(Table, Value) then
			Count = Count + 1
			table.remove(Table, table.find(Table, Value))
		end
	end
	
	return Count
end

return Core