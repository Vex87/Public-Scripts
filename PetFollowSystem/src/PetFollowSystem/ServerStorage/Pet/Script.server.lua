--[[

	Pet Follow System
	> Roblox: VexTrexYT
	> Discord: VexTrex#1429
	
	> Open sourced. Updated 07/30/20.	
	> Uses body positions and body gyros. Compatible with both parts and models. Offsets and powers are customizable.

]]

-- // Variables \\ --

local Pet = script.Parent
local Primary = Pet.Primary
local Settings = require(Pet.Settings)

-- // Defaults \\ --

do
	local Owner = workspace:FindFirstChild(Pet.Name)
	if Owner then
		local Target = Owner:FindFirstChild("HumanoidRootPart")
		if Target then
			Primary.CFrame = Target.CFrame + Vector3.new(Settings.xDist, Settings.yDist, Settings.zDist)
		end
	end
end

Primary.BodyPosition.P = Settings.MovePower
Primary.BodyGyro.P = Settings.RotPower

-- // Main \\ --

while wait(Settings.UpdateDelay) do	
	local Owner = workspace:FindFirstChild(Pet.Name)
	if Owner then
		local Target = Owner:FindFirstChild("HumanoidRootPart")			
		if Target then
			Primary.BodyPosition.Position = Target.Position
			Primary.BodyGyro.CFrame = Target.CFrame * CFrame.new(Settings.xOffset, Settings.yOffset, Settings.zOffset)
		end		
	end
end