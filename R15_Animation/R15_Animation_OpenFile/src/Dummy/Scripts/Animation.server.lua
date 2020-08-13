local Char = script.Parent.Parent
local Hum = Char.Humanoid
local AnimsStorage = Char.Animations
local Anims = {}

for _,Anim in pairs(AnimsStorage:GetChildren()) do
	Anims[Anim.Name] = Hum:LoadAnimation(Anim[math.random(1, #Anim:GetChildren())])
end

Hum.Running:Connect(function(Speed)
	if Speed ~= 0 then
		Anims.Idle:Stop()
		Anims.Run:Play()
	else
		Anims.Run:Stop()
		Anims.Idle:Play()
	end
end)

Hum.Jumping:Connect(function(Entering)
	if Entering then
		Anims.Jump:Play()
	else
		Anims.Jump:Stop()
	end
end)

Hum.FreeFalling:Connect(function(Entering)
	if Entering then
		Anims.FreeFall:Play()
	else
		Anims.FreeFall:Stop()
	end
end)