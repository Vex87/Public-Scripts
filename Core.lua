-- ServerScriptService
-- 08/16/20
-- VexTrexYT

local Core = {}

-- // Instances \\ --

function Core.NewInstance(Class, Properties)
	
	if not Class then
		error("Missing Argument 1: Class Name")
	end
	
	local Temp = Instance.new(Class)
	
	if Properties then
		for PropertyName, Property in pairs(Properties) do
			Temp[PropertyName] = Property
		end
	end
	
	return Temp	
	
end

function Core.CloneInstance(instance, Properties)
	
	if not instance then
		error("Missing Argument 1: instance (Instance)")
	end
	
	local Temp = instance:Clone()
	
	if Properties then
		for PropertyName, Property in pairs(Properties) do
			Temp[PropertyName] = Property
		end
	end
	
	return Temp	
	
end

function Core.ChangeProperty(Instances, Properties)
	
	if not Instances then
		error("Missing Argument 1: Array of Instances")
	end
	
	if not Properties then
		error("Missing Argument 2: Properties (Table)")
	end	
	
	for _,v in pairs(Instances) do		
		for PropertyName, PropertyValue in pairs(Properties) do
			v[PropertyName] = PropertyValue	
		end			
	end
	
	return Instances
end

-- // Paths \\ --

function Core.Find(Obj, Target, Classifier, Val)
	
	if not Obj then
		error("Missing Argument 1: Object (Instance)")
	end
	
	if not Target then
		error("Missing Argument 2: Target (String)")
	end	
	
	if not Classifier then
		error("Missing Argument 3: Classifier (String)")
	end
	
	local TempTbl = {}	
	do
		if Target == "Children" then
			TempTbl = Obj:GetChildren()					
		elseif Target == "Siblings" then		
			TempTbl = Obj.Parent:GetChildren()
			table.remove(TempTbl, table.find(TempTbl, Obj))		
		elseif Target == "Descendants" then		
			TempTbl = Obj:GetDescendants()		
		elseif Target == "Ancestors" then	
			repeat
				Obj = Obj.Parent
				if Obj then
					table.insert(TempTbl, Obj)
				end
			until not Obj.Parent
		end
	end
	
	for _,v in pairs(TempTbl) do
		if Classifier == "Class" then
				
			if not Val then
				error("Missing Argument 4: Class Name (String)")
			end			
				
			if v:IsA(Val) then
				return v
			end
				
		elseif Classifier == "Property" then
			
			if not Val then
				error("Missing Argument 4: Properties (Table: KEY=PROPERTYNAME, VALUE=PROPERTYVALUE)")
			end			
			
			local Pass = true
			for PropertyName,PropertyValue in pairs(Val) do	
				local Success = pcall(function()	
					local p = v[PropertyName]
				end)	
					
				if Success and v[PropertyName] ~= PropertyValue then
					Pass = false
				elseif not Success then
					Pass = false
				end						
			end	
				
			if Pass then
				return v
			end					
								
		elseif Classifier == "Prefix" then
				
			if not Val then
				error("Missing Argument 4: Prefix (String)")
			end					
				
			if string.sub(v.Name, 1, #Val) == Val then
				return v
			end	
				
		elseif Classifier == "Suffix" then
				
			if not Val then
				error("Missing Argument 4: Suffix (String)")
			end						
				
			if string.sub(v.Name, #v.Name - #Val + 1, #v.Name) == Val then
				return v
			end		
		end	
	end
	
end

function Core.Get(Obj, Target, Classifier, Val)
	
	if not Obj then
		error("Missing Argument 1: Object (Instance)")
	end
	
	if not Target then
		error("Missing Argument 2: Target (String)")
	end	
	
	if not Classifier then
		error("Missing Argument 3: Classifier (String)")
	end
	
	local TempTbl = {}	
	local FinalTbl = {}
	do
		if Target == "Children" then
			TempTbl = Obj:GetChildren()					
		elseif Target == "Siblings" then		
			TempTbl = Obj.Parent:GetChildren()
			table.remove(TempTbl, table.find(TempTbl, Obj))		
		elseif Target == "Descendants" then		
			TempTbl = Obj:GetDescendants()		
		elseif Target == "Ancestors" then	
			repeat
				Obj = Obj.Parent
				if Obj then
					table.insert(TempTbl, Obj)
				end
			until not Obj.Parent
		end
	end
	
	for _,v in pairs(TempTbl) do
		if Classifier == "Class" then
				
			if not Val then
				error("Missing Argument 4: Class Name (String)")
			end			
				
			if v:IsA(Val) then
				table.insert(FinalTbl, v)
			end
				
		elseif Classifier == "Property" then
			
			if not Val then
				error("Missing Argument 4: Properties (Table: KEY=PROPERTYNAME, VALUE=PROPERTYVALUE)")
			end			
			
			if Val then
				local Pass
				
				for PropertyName,PropertyValue in pairs(Val) do					
					local Success = pcall(function()	
						local p = v[PropertyName]
					end)	
					
					if Success and v[PropertyName] == PropertyValue then
						Pass = true
					else
						Pass = false
					end						
				end	
				
				if Pass then
					table.insert(FinalTbl, v)
				end					
				
			end	
				
		elseif Classifier == "Prefix" then
				
			if not Val then
				error("Missing Argument 4: Prefix (String)")
			end					
				
			if string.sub(v.Name, 1, #Val) == Val then
				table.insert(FinalTbl, v)
			end	
				
		elseif Classifier == "Suffix" then
				
			if not Val then
				error("Missing Argument 4: Suffix (String)")
			end						
				
			if string.sub(v.Name, #v.Name - #Val + 1, #v.Name) == Val then
				table.insert(FinalTbl, v)
			end		
		end	
	end
	
	return FinalTbl
end

function Core.Wait(Obj, Classifier, Val, MaxWait)
	
	if not Obj then
		error("Missing Argument 1: Object (Instance)")
	end
	
	if not Classifier then
		error("Missing Argument 2: Classifier (String)")
	end	
	
	local Found
	if not MaxWait then		
		repeat	
			Found = Core.Find(Obj, "Children", Classifier, Val)	
			wait(1)
		until Found	
	else			
		for x = MaxWait, 0, -1 do	
			Found = Core.Find(Obj, "Children", Classifier, Val)	
			if Found then break end				
			wait(1)
		end		
	end
	
	return Found
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

return Core