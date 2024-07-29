--[[
	// Author: Jumpathy
	// Description: A "MarketplaceService" wrapper to make coding faster for developers.

	This module is pretty simple but it gets the job done for the time being. I'll update this as-needed.

	------------ premiumPlayerJoined usage:
	This is fired when a player joins with premium, when someone purchases it, & if any player ingame already has it.

	marketplace.premiumPlayerJoined:Connect(function(player) --> player [instance]
		print(player,"has premium!");
	end)

	------------ onDeveloperProductPurchase usage:
	This is fired when a player buys the specified developer product ingame.

	marketplace.onDeveloperProductPurchase(12345678):Connect(function(player,receipt) --> player [instance], receipt [dictionary/table]
		print(player,receipt);
	end)

	------------ gamepassPurchased usage:
	This is fired when a player purchases the specified gamepass ingame.

	marketplace.gamepassPurchased(123456):Connect(function(player)
		print(player,"bought the gamer gamepass")
	end)

	------------ gamepassOwned usage:
	This is fired when a player who has the gamepass is ingame or a player buys it ingame. I'd recommend using this over the previous function.

	marketplace.gamepassOwned(123456):Connect(function(player)
		print(player,"has the epic gamepass")
	end)
]]


local service,datastore,players = game:GetService("MarketplaceService"),game:GetService("DataStoreService"):GetDataStore("PreviousPurchases"),game:GetService("Players");
local module,internal = {},{developerProducts = {},gamepassPurchases = {},onOwned = {},util = require(script:WaitForChild("util"))};
local fired = {};

-- Internal setup:

service.ProcessReceipt = function(receipt)
	local success,result = pcall(function()
		return datastore:GetAsync(receipt.PlayerId.."-"..receipt.PurchaseId)
	end)
	
	if(success and result) then
		return Enum.ProductPurchaseDecision.PurchaseGranted;
	end

	local player = game.Players:GetPlayerByUserId(receipt.PlayerId);
	if(not player) then
		return Enum.ProductPurchaseDecision.NotProcessedYet;
	elseif(player) then
		for _,product in pairs(internal.developerProducts) do
			if(product[1] == receipt.ProductId) then
				coroutine.wrap(product[2])(
					player,internal.util:handleReceipt(receipt)
				);
			end
		end
		pcall(function()
			datastore:SetAsync(receipt.PlayerId.."-"..receipt.PurchaseId,true);
		end)
		return Enum.ProductPurchaseDecision.PurchaseGranted;
	end
end

service.PromptGamePassPurchaseFinished:Connect(function(player,gamepassId,wasPurchased)
	if(wasPurchased) then
		for _,gamepass in pairs(internal.gamepassPurchases) do
			if(gamepass[1] == gamepassId) then
				coroutine.wrap(gamepass[2])(player);
			end
		end
	end
end)

-- Fake bindable to change the connect function (used with premium)

local customEvent = {callbacks = {}};

function customEvent:Connect(callback) --> This is used for running a function each time that this function is connected to.
	table.insert(customEvent.callbacks,callback);
	internal.util.playerAdded:Connect(function(user)
		if(user.MembershipType == Enum.MembershipType.Premium) then
			callback(user);
		end
	end)
end

function customEvent:Fire(...)
	for _,func in pairs(customEvent.callbacks) do
		func(...);
	end
end

players.PlayerMembershipChanged:Connect(function(user)
	if(user.MembershipType == Enum.MembershipType.Premium) then
		customEvent:Fire(user);
	end
end)

-- // Module functions:

module.premiumPlayerJoined = customEvent;

function module.onDeveloperProductPurchase(id)
	local bindable = Instance.new("BindableEvent");
	table.insert(internal.developerProducts,{
		id,function(player,receipt)
			bindable:Fire(player,receipt);
		end,
	});
	return bindable.Event;
end

function module.gamepassPurchased(id)
	local bindable = Instance.new("BindableEvent");
	table.insert(internal.gamepassPurchases,{
		id,function(player)
			fired[player][id] = true;
			bindable:Fire(player);
		end,
	});
	return bindable.Event;
end

function module.gamepassOwned(id)
	local bindable = Instance.new("BindableEvent");
	table.insert(internal.gamepassPurchases,{id,function(player) bindable:Fire(player); end});
	internal.util.playerAdded:Connect(function(plr)
		local success,owns = pcall(function()
			return service:UserOwnsGamePassAsync(plr.UserId,id);
		end)
		fired[plr][id] = {events = {},fired = false};
		table.insert(fired[plr][id]["events"],bindable);
		if(success and owns) then
			fired[plr][id]["fired"] = true;
			bindable:Fire(plr);
		elseif(not owns) then
			shared.onProfileLoaded[plr]:Connect(function()
				local profile = shared.profs[plr].Data;
				if(profile.gifts[id] or profile.gifts[tostring(id)]) then
					fired[plr][id]["fired"] = true;
					bindable:Fire(plr,true);
				end
			end)
		end
	end)
	return bindable.Event;
end

function module.giftPass(player,id)
	shared.onProfileLoaded[player]:Connect(function()
		local profile = shared.profs[player].Data;
		profile.gifts[id] = true;
		if(not fired[player][id]["fired"]) then
			for _,event in pairs(fired[player][id]["events"]) do
				event:Fire(player);
			end
		end
	end)
end

internal.util.playerAdded:Connect(function(plr)
	fired[plr] = {};
end)

-- Return:

return module;