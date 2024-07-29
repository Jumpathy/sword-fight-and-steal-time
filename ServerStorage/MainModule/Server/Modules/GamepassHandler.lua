local module = {}


local main = _G.HDAdminMain


--Purchase and receive gamepasses
main.marketplaceService.PromptGamePassPurchaseFinished:Connect(function(player,assetId,isPurchased)
	local pdata = main.pd[player]
	if isPurchased and pdata then
		local validGamepass = main.permissions.gamepasses[tostring(assetId)]
		if validGamepass and not main:GetModule("cf"):FindValue(pdata.Gamepasses, assetId) then
			main:GetModule("PlayerData"):InsertStat(player, "Gamepasses", assetId)
			main:GetModule("cf"):RankPlayerSimple(player, validGamepass.Rank)
			if not main:GetModule("cf"):FindValue(main.products, assetId) then
				main:GetModule("cf"):FormatAndFireNotice(player, "UnlockRank", main:GetModule("cf"):GetRankName(validGamepass.Rank))
			end
			main:GetModule("cf"):CheckAndRankToDonor(player, pdata, assetId)
		end
	end
end)




return module