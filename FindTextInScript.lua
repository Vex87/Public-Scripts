local Msg = {"print"}
local Targets = {}

local coreGui = game:GetService("CoreGui")

local descendants = game:GetDescendants()
local isA = game.IsA

local function couldBeMalicious(descendant)
    local success, isScript = pcall(isA, descendant, "LuaSourceContainer")

    if ((success and isScript) and (not descendant:IsDescendantOf(coreGui))) then
        local source = descendant.Source:lower()

        if (source:match("print")) then
            return true
        end
    end
end

for i, descendant in pairs(descendants) do
    if couldBeMalicious(descendant) then
        warn(descendant:GetFullName())
    end
end