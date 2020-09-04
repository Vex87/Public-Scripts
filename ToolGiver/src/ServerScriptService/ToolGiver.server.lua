-- // Settings \\ --

local GIVE_COMMAND = "give" -- The prefix to give a tool
local WHITELIST = {
    "VexTrexYT",
    197935298, 
    {GroupId = 6458408, MinRankId = 255}
}

--[[

    String = Username
    Number = Player ID
    Dictionary (GroupId, MinRankId) = Group Rank
     * If no MinRankId is provided, than it will check if the player is in the group instead

    local WHITELIST = {
        "VexTrexYT", 
        197935298, 
        {GroupId = 6458408, MinRankId = 255}
    }

]]

-- // Functions \\ --

function FindPlayer(pName, CurrentP)
    for _,p in pairs(game.Players:GetPlayers()) do
        if p ~= CurrentP and p.Name:lower():sub(1, #pName) == pName:lower() then
            return p
        end
    end
end

function CheckIfWhitelisted(p)
    for _,v in pairs(WHITELIST) do
        if typeof(v) == "string" and p.Name == v then
            return true
        elseif typeof(v) == "number" and p.UserId == v then
            return true
        elseif typeof(v) == "table" and p:GetRankInGroup(v.GroupId) >= (v.MinRankId or 1) then
            return true
        end
    end
end

-- // Events \\ --

game.Players.PlayerAdded:Connect(function(p)
    if CheckIfWhitelisted(p) then
        p.Chatted:Connect(function(Msg, Recipient)
            local Args = Msg:split(" ")
            if #Args == 2 and Args[1]:lower() == GIVE_COMMAND:lower() then
                local Target = FindPlayer(Args[2], p)
                if Target then
                    local Char = p.Character
                    if Char then
                        local Tool = p.Character:FindFirstChildWhichIsA("Tool") or p:WaitForChild("Backpack"):FindFirstChildWhichIsA("Tool")
                        if Tool then
                            Tool.Parent = Target:WaitForChild("Backpack")
                        end
                    end
                end
            end
        end)
    end
end)