local Explode = {}
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Core = require(5584659207)

Explode.DefaultInfo = {	
	
	ExplosionModel = game.ServerStorage.Effects.Explosion,		
	
	NewExplosion = nil,
	Parent = workspace.Debris,
	Position = Vector3.new(0, 0, 0),
	ShakeDist = 20,
	Size = 250,	
	Duration = 2,
	DespawnDelay = 2,
	
	ExplodeTweenInfo = {
		EasingStyle = Enum.EasingStyle.Exponential,
		EasingDirection = Enum.EasingDirection.Out,
	},
	
	FadeTweenInfo = {
		EasingStyle = Enum.EasingStyle.Exponential,
		EasingDirection = Enum.EasingDirection.In,
		DurationMultiplier = 0.8,
	}
	
}

local function TweenScale(Info)
	local Model = Info.NewExplosion
	local Primary = Model.PrimaryPart
	local PrimaryCFrame = Primary.CFrame
	
	local ExplodeTweenInfo = TweenInfo.new(Info.Duration, Info.ExplodeTweenInfo.EasingStyle, Info.ExplodeTweenInfo.EasingDirection)
	local FadeTweennInfo = TweenInfo.new(Info.Duration * Info.FadeTweenInfo.DurationMultiplier, Info.FadeTweenInfo.EasingStyle, Info.FadeTweenInfo.EasingDirection)
	
	for _,Part in pairs(Core.Get(Model, "BasePart")) do
		Core.NewThread(function()
			local SizeGoal = Part.Size * Info.Size				
			local Tween1 = TweenService:Create(Part, ExplodeTweenInfo, {Size = SizeGoal})
			Tween1:Play()						
				
			local Tween2 = TweenService:Create(Part, FadeTweennInfo, {Transparency = 1})
			Tween2:Play()					
				
			if Part ~= Primary then					
				local PosGoal = PrimaryCFrame.Position + (Part.Position-PrimaryCFrame.Position) * Info.Size
				local Tween3 = TweenService:Create(Part, ExplodeTweenInfo, {Position = PosGoal})
				Tween3:Play()					
			end							
		end)
	end
	
	wait(Info.DespawnDelay + Info.Duration)
	Model:Destroy()	
	
end

local function AddShake(Info)
	for _,p in pairs(game.Players:GetPlayers()) do
		if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and Core.Mag(p.Character.HumanoidRootPart, Info.NewExplosion.PrimaryPart) < Info.ShakeDist then
			Core.NewThread(function()
				local Shake = script.Shake:Clone()
				Debris:AddItem(Shake, Info.Duration)
				Shake.Parent = p.PlayerGui
			end)
		end
	end
end

local function CreateExplosion(Info)
	Info.NewExplosion = Info.ExplosionModel:Clone()
	Info.NewExplosion.Parent = Info.Parent
	Info.NewExplosion:MoveTo(Info.Position)
end

local function CheckInfoChanges(NewInfo)	
	if NewInfo then
		for i,v in pairs(Explode.DefaultInfo) do
			if not NewInfo[i] then
				NewInfo[i] = v
			end
		end	
	else
		NewInfo = Explode.DefaultInfo
	end
	
	return NewInfo
end

Explode.Start = function(OldInfo)	
	local Info = CheckInfoChanges(OldInfo)	
	CreateExplosion(Info)
	AddShake(Info)
	Info.NewExplosion.PrimaryPart.Sound:Play()
	TweenScale(Info)
end

return Explode