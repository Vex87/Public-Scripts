local Explode = {}
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Core = require(5584659207)

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
	
	Info.NPC:BreakJoints()	
	wait(Info.Duration + Info.DespawnDelay)	
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

local function CreateExplosionEffect(Info)
	local ModelsHit = {}
	local Effect = Instance.new("Explosion")
	Effect.BlastPressure = Info.BlastPressure
	Effect.DestroyJointRadiusPercent = Info.DestroyJointRadiusPercent
	Effect.BlastRadius = Info.BlastRadius
	Effect.Position = Info.NewExplosion.PrimaryPart.Position	
	Effect.ExplosionType = Info.ExplosionType
 
	Effect.Hit:Connect(function(Part, Dist)
		local Hum = Part.Parent:FindFirstChild("Humanoid")
		if Hum and not ModelsHit[Hum.Parent] then 			
			ModelsHit[Hum.Parent] = true
			local DistFactor = Dist / Effect.BlastRadius
			DistFactor = 1 - DistFactor
			Hum:TakeDamage(Info.MaxDamage * DistFactor)
		end
	end)
 
	Effect.Parent = Info.NewExplosion.PrimaryPart
end

local function CreateExplosion(Info)
	Info.NewExplosion = Info.ExplosionModel:Clone()
	Info.NewExplosion.Parent = Info.Parent
	Info.NewExplosion:MoveTo(Info.Position)	
	CreateExplosionEffect(Info)
end

Explode.Start = function(OldInfo)
	
	local Info = {
		ExplosionModel = game.ServerStorage.Effects.Explosion,				
		Parent = workspace.Debris,
		Position = Vector3.new(0, 0, 0),
		ShakeDist = 20,
		Size = 200,	
		Duration = 1.2,
		DespawnDelay = 0.5,
		
		MaxDamage = 100,	
		BlastRadius = 15,	
		DestroyJointRadiusPercent = 0,
		BlastPressure = 500000,
		ExplosionType = Enum.ExplosionType.NoCraters,
		
		NewExplosion = nil,	
		NPC = nil,			
		
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
	
	if OldInfo then
		for i,v in pairs(OldInfo) do
			Info[i] = v			
		end
	end
	
	CreateExplosion(Info)
	AddShake(Info)
	Info.NewExplosion.PrimaryPart.Sound:Play()
	TweenScale(Info)	
end

return Explode