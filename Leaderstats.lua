-- ServerScriptService
-- 08/13/20

game.Players.PlayerAdded:Connect(function(p)
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = p
	leaderstats.Name = "leaderstats"
	
	local Money = Instance.new("IntValue")
	Money.Parent = leaderstats
	Money.Name = "Money"
	
end)