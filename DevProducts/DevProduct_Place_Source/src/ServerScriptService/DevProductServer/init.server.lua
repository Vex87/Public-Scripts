local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
 
MarketplaceService.ProcessReceipt = function(receiptInfo) 
	
	-- Prompts purchase again if player leaves unexpectedly
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end		
	
	-- Rewards player with purchase
	local handler = require(script[receiptInfo.ProductId])			
	local success, result = pcall(handler, receiptInfo, player)
	if not success then
		warn(player.Name .. " could not process " .. receiptInfo.ProductId)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	return Enum.ProductPurchaseDecision.PurchaseGranted					
end