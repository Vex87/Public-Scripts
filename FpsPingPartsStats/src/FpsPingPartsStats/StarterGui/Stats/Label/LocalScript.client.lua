-- // Settings \\ --

local UPDATE_DELAY = 1
local WHITE_COLOR = Color3.fromRGB(255, 255, 255)
local RED_COLOR = Color3.fromRGB(255, 0, 0)

-- // Variables \\ --

local RemoteEvent = game.ReplicatedStorage.Ping

-- // Main \\ --

while wait(UPDATE_DELAY) do
	
	local PreviousTime = os.clock()
	local Pinged = RemoteEvent:InvokeServer()
	
	if Pinged then		
		
		local CurrentTime = os.clock()		
		local FPS = math.floor(workspace:GetRealPhysicsFPS())
		local Ping = math.floor((CurrentTime - PreviousTime) * 100)
		local Parts = 0
		
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				Parts = Parts + 1
			end
		end
		
		script.Parent.TextColor3 = WHITE_COLOR
		script.Parent.Text = "FPS: " .. FPS .. "     PING: " .. Ping .. " ms     PARTS: " .. Parts	
		
	else		
		script.Parent.TextColor3 = RED_COLOR
		script.Parent.Text = "FPS: N/A     PING: N/A     PARTS: N/A"		
	end	
	
end