local PRODUCT_ID = 0

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local p = Players.LocalPlayer

MarketplaceService:PromptProductPurchase(p, PRODUCT_ID)