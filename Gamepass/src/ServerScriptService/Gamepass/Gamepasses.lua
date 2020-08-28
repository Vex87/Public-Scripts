local Gamepasses = {}

Gamepasses[11483606] = function(p)
    wait(1)
    local Sword = game.ServerStorage:WaitForChild("Sword")
    local Backpack = p:WaitForChild("Backpack")
    Sword:Clone().Parent = Backpack
end

Gamepasses[11483609] = function(p)
    local Char = p.Character or p.CharacterAdded:Wait()
    local Hum = Char:WaitForChild("Humanoid")
    Hum.WalkSpeed = 30
end

return Gamepasses