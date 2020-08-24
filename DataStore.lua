local DataStore = {}
local Stores = {}

function DataStore.GetStore(Store)
    return game:GetService("DataStoreService"):GetDataStore(Store)
end

function DataStore.LoadData(Store, Key)
    
    if not table.find(Stores, Store) then
        Stores[Store] = DataStore.GetStore(Store)
    end

	local Data
	local Success, ErrorMessage = pcall(function()
		Data = Stores[Store]:GetAsync(Key)
	end)
	
    if Success then
        print(Store .. "-" .. Key .. " was loaded.")
		return Data
    else
        warn(Store .. "-" .. Key .. " was NOT loaded.")
		warn(ErrorMessage)
	end
	
end

function DataStore.SaveData(Store, Key, Data)

    if not table.find(Stores, Store) then
        Stores[Store] = DataStore.GetStore(Store)
    end   

	local Success, ErrorMessage = pcall(function()
		Stores[Store]:SetAsync(Key, Data)
	end)
	
	if Success then
        print(Store .. "-" .. Key .. " was saved.")
    else
        warn(Store .. "-" .. Key .. " was NOT saved.")
		warn(ErrorMessage)
	end
	
end

return DataStore