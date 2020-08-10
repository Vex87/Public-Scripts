-- // Settings \\ --

local EFFECT_DURATION = 0.5
local HIT_OFFSET = Vector3.new(0, 0.5, 0)

local START_SIZE = Vector3.new(0.1, 0.05, 0.1)
local END_SIZE = Vector3.new(7, 1, 7)

local BIGGER_DURATION = 0.2
local BIGGER_TWEENINFO = TweenInfo.new(BIGGER_DURATION, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)

local SMALLER_DURATION = 0.2
local SMALLER_TWEENINFO = TweenInfo.new(SMALLER_DURATION, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)

-- // Variables \\ --

local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local DebrisStorage = workspace.Debris
local JumpEffect = game.ServerStorage.Effects.JumpShockwave

local Char = script.Parent
local Hum = Char:WaitForChild("Humanoid") 
local Root = Char:WaitForChild("HumanoidRootPart")	

-- // Functions \\ --

local function FindFloor(Origin)
	local Direction = Vector3.new(0, -100, 0) 
	local Paramas = RaycastParams.new()
	Paramas.FilterDescendantsInstances = {Origin.Parent}
	Paramas.FilterType = Enum.RaycastFilterType.Blacklist
	local Hit = workspace:Raycast(Origin.Position, Direction, Paramas)
 
	if Hit then
		local HitPart = Hit.Instance
		if HitPart:IsDescendantOf(workspace.Map) then
			return Hit.Position
		end
	end
end		

-- // Events \\ --

Hum.StateChanged:Connect(function(OldState, NewState)
	if NewState == Enum.HumanoidStateType.Landed then
		local HitPos = FindFloor(Root)
		if HitPos then	
			
			local NewEffect = JumpEffect:Clone()
			NewEffect.Parent = DebrisStorage
			NewEffect.Size = START_SIZE
			NewEffect.Position = HitPos + HIT_OFFSET
			NewEffect.Landed:Play()
			
			local BiggerTween = TweenService:Create(NewEffect, BIGGER_TWEENINFO, {Size = END_SIZE})
			BiggerTween:Play()			
			BiggerTween.Completed:Wait()			
			wait(EFFECT_DURATION)
			
			local SmallerTween = TweenService:Create(NewEffect, SMALLER_TWEENINFO, {Size = START_SIZE})
			SmallerTween:Play()						
			SmallerTween.Completed:Wait()
			NewEffect:Destroy()	
			
		end
	end
end)