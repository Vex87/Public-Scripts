local Explode = require(game.ServerScriptService.Explode)
local Core = require(5584659207)
local Hum = script.Parent.Humanoid
local Root = script.Parent.HumanoidRootPart
local ExplodeAnm = Hum:LoadAnimation(script.Explode)

---------------------------------------------
---------------------------------------------

local Clone = script.Parent:Clone()

---------------------------------------------
---------------------------------------------

for _,v in pairs(Core.Get(script.Parent, "BasePart")) do
	v:SetNetworkOwner(nil)
end

workspace.Button.ClickDetector.MouseClick:Connect(function()
	ExplodeAnm:Play()
	
	local Con
	Con = ExplodeAnm:GetMarkerReachedSignal("StartExplosion"):Connect(function()
		Explode.Start({
			["Position"] = Root.Position,
			["NPC"] = script.Parent
		})
		Con:Disconnect()
	end)
	
end)

---------------------------------------------
---------------------------------------------

Hum.Died:Connect(function()
	wait(3)
	Clone.Parent = workspace
	script.Parent:Destroy()
end)

---------------------------------------------
---------------------------------------------