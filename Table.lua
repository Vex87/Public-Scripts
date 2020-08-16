-- ServerScriptService
-- 08/16/20
-- VexTrexYT

local Table = {	}

function Table.Remove(Table, Value, RemoveCount)	
	
	if not Table then
		error("Missing Argument 1: Table")
	end	
	
	if not Value then
		error("Missing Argument 2: Value (Variant)")
	end		
	
	if RemoveCount == true then	
		local Counter = 0
		repeat
			table.remove(Table, table.find(Table, Value))	
			Counter = Counter + 1	
		until not table.find(Table, Value)
		return Counter
	elseif not RemoveCount then
		table.remove(Table, table.find(Table, Value))
	elseif typeof(RemoveCount) == "number" then
		for x = RemoveCount, 1, -1 do
			if table.find(Table, Value) then
				table.remove(Table, table.find(Table, Value))	
			end
		end
	end
	
end

function Table.Find(Table, Classifier, Value)
	
	if not Table then
		error("Missing Argument 1: Table")
	end
	
	if not Classifier then
		error("Missing Argument 2: Classifier (String)")
	end	
	
	for _,v in pairs(Table) do
		if Classifier == "Class" then
				
			if not Value then
				error("Missing Argument 3: Class Name (String)")
			end			
			
			local p
			local Success = pcall(function()	
				p = v:IsA(Value)
			end)	
					
			if Success and p then
				return v
			end						
				
		elseif Classifier == "Property" then
			
			if not Value then
				error("Missing Argument 3: Properties (Table: KEY=PROPERTYNAME, VALUE=PROPERTYVALUE)")
			end			
				
			local Pass = true
			for PropertyName,PropertyValue in pairs(Value) do	
				local Success = pcall(function()	
					local p = v[PropertyName]
				end)	
				
				if not Success then
					Pass = false
				elseif v[PropertyName] ~= PropertyValue then
					Pass = false
				end						
			end	
				
			if Pass then
				return v
			end					
			
		elseif Classifier == "Type" then
			
			if typeof(v) == Value then
				return v
			end				
			
		elseif Classifier == "PrefixIndex" then
				
			if not Value then
				error("Missing Argument 3: Prefix (String)")
			end					
			
			pcall(function()
				if string.sub(v, 1, #Value) == Value then
					return v
				end
			end)
			
		elseif Classifier == "PrefixName" then
				
			if not Value then
				error("Missing Argument 3: Prefix (String)")
			end					
			
			local p
			local Success = pcall(function()	
				p = string.sub(v.Name, 1, #Value) == Value
			end)	
					
			if Success and p then
				return v
			end						
			
		elseif Classifier == "SuffixIndex" then
				
			if not Value then
				error("Missing Argument 3: Suffix (String)")
			end					
			
			pcall(function()
				if string.sub(v, #v - #Value + 1, #v) == Value then
					return v
				end	
			end)
			
		elseif Classifier == "SuffixName" then
				
			if not Value then
				error("Missing Argument 3: Suffix (String)")
			end					
			
			local p
			local Success = pcall(function()	
				p = string.sub(v.Name, #v.Name - #Value + 1, #v.Name) == Value
			end)	
					
			if Success and p then
				return v
			end				
			
		else
			if v == Classifier then
				return v
			end					
		end	
	end	
	
end

function Table.Get(Table, Classifier, Value, Amount)
	
	if not Table then
		error("Missing Argument 1: Table")
	end
	
	local FinalTable = {}
	for _,v in pairs(Table) do
		if Classifier == "Class" then
				
			if not Value then
				error("Missing Argument 3: Class Name (String)")
			end			
			
			local p
			local Success = pcall(function()	
				p = v:IsA(Value)
			end)	
					
			if Success and p then
				table.insert(FinalTable, v)
			end						
				
		elseif Classifier == "Property" then
			
			if not Value then
				error("Missing Argument 3: Properties (Table: KEY=PROPERTYNAME, VALUE=PROPERTYVALUE)")
			end			
				
			local Pass = true
			for PropertyName,PropertyValue in pairs(Value) do	
				local Success = pcall(function()	
					local p = v[PropertyName]
				end)	
				
				if not Success then
					Pass = false
				elseif v[PropertyName] ~= PropertyValue then
					Pass = false
				end						
			end	
				
			if Pass then
				table.insert(FinalTable, v)
			end					
				
		elseif Classifier == "PrefixIndex" then
				
			if not Value then
				error("Missing Argument 3: Prefix (String)")
			end					
			
			pcall(function()
				if string.sub(v, 1, #Value) == Value then
					table.insert(FinalTable, v)
				end
			end)
			
		elseif Classifier == "PrefixName" then
				
			if not Value then
				error("Missing Argument 3: Prefix (String)")
			end					
			
			local p
			local Success = pcall(function()	
				p = string.sub(v.Name, 1, #Value) == Value
			end)	
					
			if Success and p then
				table.insert(FinalTable, v)
			end						
			
		elseif Classifier == "SuffixIndex" then
				
			if not Value then
				error("Missing Argument 3: Suffix (String)")
			end					
			
			pcall(function()
				if string.sub(v, #v - #Value + 1, #v) == Value then
					table.insert(FinalTable, v)
				end	
			end)
			
		elseif Classifier == "SuffixName" then
				
			if not Value then
				error("Missing Argument 3: Suffix (String)")
			end					
			
			local p
			local Success = pcall(function()	
				p = string.sub(v.Name, #v.Name - #Value + 1, #v.Name) == Value
			end)	
					
			if Success and p then
				table.insert(FinalTable, v)
			end				
			
		elseif Classifier == "Type" then
			
			if typeof(v) == Value then
				table.insert(FinalTable, v)
			end	
			
		else
			Amount = Value
			if v == Classifier then
				table.insert(FinalTable, v)
			end				
		end	
		
	end
	
	if typeof(Amount) == "number" and #FinalTable > Amount then
		for x = #FinalTable-1, Amount, -1 do
			table.remove(FinalTable, x)
		end
	elseif not Amount then
		for x = #FinalTable-1, 1, -1 do
			table.remove(FinalTable, x)
		end		
	end	
	
	return FinalTable
end

function Table.Wait(MyTable, Classifier, Value, MaxWait)
	
	if not MyTable then
		error("Missing Argument 1: Table")
	end
	
	local Found
	if not MaxWait then		
		repeat	
			Found = Table.Find(MyTable, Classifier, Value)	
			wait(1)
		until Found	
	else			
		for x = MaxWait, 0, -1 do	
			Found = Table.Find(MyTable, Classifier, Value)	
			if Found then break end				
			wait(1)
		end		
	end
	
	return Found	
	
end

return Table