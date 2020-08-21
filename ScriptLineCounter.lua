local Count = 0
local Services = {
	workspace.Map,
	game.ReplicatedStorage,
	game.ServerScriptService,
	game.ServerScriptService,
	game.StarterGui,
	game.StarterPack,
	game.StarterPlayer
}

for _,Service in pairs(Services) do
	for __,Script in pairs(Service:GetDescendants()) do
		if Script:IsA("LuaSourceContainer") then
			local Lines = string.split(Script.Source, "\n")
			warn(Script:GetFullName() .. ": " .. #Lines)
			Count = Count + #Lines
		end
	end
end

warn("TOTAL LINES ARE: " .. Count)