local util,added = {
	useCamelcase = true --> This setting is by default enabled to keep the module looking consistent. You can disable this by changing the value!
},Instance.new("BindableEvent");

function util:handleReceipt(receipt)
	return((not util.useCamelcase and receipt) or {
		currencySpent = receipt.CurrencySpent,
		currencyType = receipt.CurrencyType,
		placeIdWherePurchased = receipt.PlaceIdWherePurchased,
		playerId = receipt.PlayerId,
		productId = receipt.ProductId,
		purchaseId = receipt.PurchaseId
	})
end

local custom = {};
function custom:Connect(callback)
	for _,player in pairs(game:GetService("Players"):GetPlayers()) do
		coroutine.wrap(callback)(player);
	end
	game:GetService("Players").PlayerAdded:Connect(callback);
end

util.playerAdded = custom;

return util;