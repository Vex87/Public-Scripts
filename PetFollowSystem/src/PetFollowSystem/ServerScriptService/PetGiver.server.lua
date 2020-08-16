-- // Functions \\ --

local function GivePet(p, Char)
	local NewPet = game.ServerStorage.Pet:Clone()
	NewPet.Parent = workspace.Pets
	NewPet.Name = p.Name	
end

local function DeletePet(pName)
	local Pet = workspace.Pets:FindFirstChild(pName)
	if Pet then
		Pet:Destroy()
	end	
end

-- // Events \\ --

game.Players.PlayerAdded:Connect(function(p)		
	p.CharacterAdded:Connect(function(Char)
		
		Char:WaitForChild("Humanoid").Died:Connect(function()
			DeletePet(p.Name)
		end)

		if not workspace.Pets:FindFirstChild(p.Name) then
			GivePet(p, Char)
		end
		
	end)
end)

game.Players.PlayerRemoving:Connect(function(p)	
	DeletePet(p.Name)
end)