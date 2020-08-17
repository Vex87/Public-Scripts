-- // Settings \\ --

local SIZE = 250
local DURATION = 2
local DESPAWN_DEPLAY = 2
local SHAKE_DIST = 20
local TWEEN_INFO = TweenInfo.new(DURATION, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local FADE_TWEEN_INFO = TweenInfo.new(DURATION * 0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)

-- // Variables \\ --

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Explosion = script.Explosion

-- // Functions \\ --

local function NewThread(func,...)	
	local a = coroutine.wrap(func)
	a(...)	
end

local function TweenScale(Model)
	
	local Primary = Model.PrimaryPart
	local PrimaryCFrame = Primary.CFrame
	
	for i, Part in pairs(Model:GetChildren()) do		
		if Part:IsA("BasePart") then
			NewThread(function()	
				
				local SizeGoal = Part.Size * SIZE				
				local Tween1 = TweenService:Create(Part, TWEEN_INFO, {Size = SizeGoal})
				Tween1:Play()						
				
				local Tween2 = TweenService:Create(Part, FADE_TWEEN_INFO, {Transparency = 1})
				Tween2:Play()					
				
				if Part ~= Primary then					
					local PosGoal = PrimaryCFrame.Position + (Part.Position-PrimaryCFrame.Position)* SIZE
					local Tween3 = TweenService:Create(Part, TWEEN_INFO, {Position = PosGoal})
					Tween3:Play()					
				end				
				
			end)
		end
	end
	
	wait(DESPAWN_DEPLAY + DURATION)
	Model:Destroy()
end

local function AddShake(Model)	
	for _,p in pairs(game.Players:GetPlayers()) do
		if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and (p.Character.HumanoidRootPart.Position - Model.PrimaryPart.Position).Magnitude < SHAKE_DIST then
			NewThread(function()
				local Shake = script.Shake:Clone()
				Debris:AddItem(Shake, DURATION)
				Shake.Parent = p.PlayerGui					
			end)
		end
	end
end

local function Explode()
	
	local NewExplosion = Explosion:Clone()
	NewExplosion.Parent = workspace.Debris	
	NewExplosion:MoveTo(Vector3.new(0, 5, 0))
	
	AddShake(NewExplosion)
	NewExplosion.InnerPrimary.Sound:Play()
	TweenScale(NewExplosion)
end

workspace.Button.ClickDetector.MouseClick:Connect(Explode)