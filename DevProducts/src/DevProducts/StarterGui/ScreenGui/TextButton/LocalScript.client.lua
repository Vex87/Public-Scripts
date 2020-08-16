local PRODUCT_ID = 1070882683

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local p = Players.LocalPlayer

script.Parent.MouseButton1Click:Connect(function()
	MarketplaceService:PromptProductPurchase(p, PRODUCT_ID)	
end)