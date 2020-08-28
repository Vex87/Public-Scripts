-- // Settings \\ --

local GAMEPASS_BUTTON_TAG = "Gamepass"

-- // Variables \\ --

local CollectionService = game:GetService("CollectionService")
local MarketplaceService = game:GetService("MarketplaceService")
local Gamepasses = require(script.Gamepasses)

-- // Functions \\ --

local function RunPurchase(p, ID)
    Gamepasses[ID](p)
end

local function CheckOwnership(p, ID)
    local HasPass
    local Success, ErrorMessage = pcall(function()
        HasPass = MarketplaceService:UserOwnsGamePassAsync(p.UserId, ID)
    end)

    if not Success then
		warn("Error while checking if player has pass: " .. tostring(ErrorMessage))
        return
    elseif HasPass then
        return true
    end
end

local function Purchased(p, ID, PurchaseSuccess)
    if PurchaseSuccess then
		RunPurchase(p, ID)
	end
end

local function PromptPurchase(...)
    MarketplaceService:PromptGamePassPurchase(...)
end

local function PlayerAdded(p)
    for ID, Function in pairs(Gamepasses) do
        if CheckOwnership(p, ID) then
            RunPurchase(p, ID)
        end
    end
end

-- // Events \\ --

game.Players.PlayerAdded:Connect(PlayerAdded)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(Purchased)

-- // Main \\ --

for _,Button in pairs(CollectionService:GetTagged(GAMEPASS_BUTTON_TAG)) do
    Button.ClickDetector.MouseClick:Connect(function(p)
        PromptPurchase(p, Button.ID.Value)
    end)
end

CollectionService:GetInstanceAddedSignal(GAMEPASS_BUTTON_TAG):Connect(function(Button)
    Button.ClickDetector.MouseClick:Connect(function(p)
        PromptPurchase(p, Button.ID.Value)
    end)
end)