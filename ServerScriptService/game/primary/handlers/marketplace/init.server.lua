local owned_passes = {};
local passes = {
	
	-- OLD PASSES:
	
	-- general:
	["Instant Respawn"] = 19456594,
	["Colored Username"] = 19456610,
	["Instant Regen"] = 19456620,
	["Elite"] = 20143191,
	-- limiteds:
	["Alienator"] = 20174759,
	["Sus"] = 20753615,
	["Azurath"] = 21150332,
	-- all-time swords:
	["Elite_Sword"] = 20143191,
	-- items:
	["Radio"] = 19456657,
	["Signs"] = 22087849,	
}

local newPasses = {

	["Instant Respawn"] = 22087724,
	["Colored Username"] = 22087737,
	["Instant Regen"] = 22087780,
	["Elite"] = 22087792,
	
	-- limiteds
	["Alienator"] = 22087824,
	["Azurath"] = 22087816,
	["Elite_Sword"] = 22087792,
	
	["Radio"] = 22087796,
	
	["8ball"] = 22116531
}

local gifts = {
	[1201515449] = 22087780,
	[1201515483] = 22087724,
	[1201515383] = 22087737,
	[1201515534] = 22087796,
	[1201515413] = 22087792,
	[1201515335] = 21150332,
	[1201644169] = 22087849,
	[1201658544] = 22116531,
}

local getData = function()
	local shop = game.ReplicatedStorage.shop;
	local objects = {};
	for _,obj in pairs(shop:GetDescendants()) do
		if(obj:IsA("Folder") and not obj:FindFirstChild("numPasses")) then
			table.insert(objects,{
				description = obj.description.Value,
				id = obj.id.Value,
				name = obj.name.Value,
				blurImage = obj.blurImage.Value,
				giftId = obj.giftId.Value,
				old = obj:FindFirstChild("old") and obj.old.Value
			})
		end
	end
	return objects;
end

local getName = function(num)
	for _,o in pairs(getData()) do
		if(o.id == num or o.old == num) then
			local a = o.name:gsub(" ","_");
			return a;
		end
	end
end

local uniqueCallbacks = {
	[20143191] = function(player,gift)
		local hdMain = require(game:GetService("ReplicatedStorage"):WaitForChild("HDAdminSetup")):GetMain()
		local hd = hdMain:GetModule("API")
		local plrRankId, plrRankName, plrRankType = hd:GetRank(player)
		if plrRankId < 1 then
			hd:SetRank(player, 1, "Perm");
		end
	end,
	[22087792] = function(player,gift)
		local hdMain = require(game:GetService("ReplicatedStorage"):WaitForChild("HDAdminSetup")):GetMain()
		local hd = hdMain:GetModule("API")
		local plrRankId, plrRankName, plrRankType = hd:GetRank(player)
		if plrRankId < 1 then
			hd:SetRank(player, 1, "Perm");
		end
	end,
}

local event = game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("getOwnedPasses");
local admins = {};
local targets = {};

local service = require(script:WaitForChild("service"));

local convert = function(owned)
	local tbl = {};
	for passId,hasPass in pairs(owned) do
		for k,v in pairs(passes) do
			if(v == passId) then
				tbl[k] = hasPass;
			end
		end
		for k,v in pairs(newPasses) do
			if(v == passId) then
				tbl[k] = hasPass;
			end
		end
	end
	return tbl;
end

shared.getPasses = function(player)
	local passes,hasAll = player:FindFirstChild("Passes") or Instance.new("StringValue",player),true;
	passes.Name = "Passes";
	
	local strings,hasAll = player:FindFirstChild("OwnedPasses") or Instance.new("StringValue",player),true;
	strings.Name = "OwnedPasses";
	
	for passId,hasPass in pairs(owned_passes[player.UserId]) do
		player.Passes:SetAttribute(passId,hasPass);
		if(not hasPass) then
			strings:SetAttribute(getName(passId),false);
			hasAll = false;
		else
			pcall(function()
				strings:SetAttribute(getName(passId),true);
			end)
		end
	end
	passes:SetAttribute("hasAllPasses",hasAll);
	return convert(owned_passes[player.UserId]);
end

event.OnServerEvent:Connect(function(player)
	event:FireClient(player,convert(owned_passes[player.UserId]))
end)

game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("instantRespawn").OnServerEvent:Connect(function(player,enabled)
	if(convert(owned_passes[player.UserId])["Instant Respawn"] == true) then
		player:SetAttribute("InstantRespawn",enabled);
	end
end)

for _,passId in pairs(newPasses) do
	service.gamepassOwned(passId):Connect(function(player,gift)
		owned_passes[player.UserId][passId] = true;
		pcall(function()
			if(gift) then
				uniqueCallbacks[passId](player);
			end
		end)
		shared.update_user(player,convert(owned_passes[player.UserId]))
		shared.getPasses(player);
		event:FireClient(player,convert(owned_passes[player.UserId]))
	end)
end

for _,passId in pairs(passes) do
	service.gamepassOwned(passId):Connect(function(player,gift)
		owned_passes[player.UserId][passId] = true;
		pcall(function()
			if(gift) then
				uniqueCallbacks[passId](player);
			end
		end)
		shared.update_user(player,convert(owned_passes[player.UserId]))
		shared.getPasses(player);
		event:FireClient(player,convert(owned_passes[player.UserId]))
	end)
end

game:GetService("Players").PlayerAdded:Connect(function(player)
	local p,hasAll = player:FindFirstChild("Passes") or Instance.new("StringValue",player),true;
	p.Name = "Passes";
			
	for _,passId in pairs(passes) do
		p:SetAttribute(tostring(passId),false);
	end
	
	for _,passId in pairs(newPasses) do
		p:SetAttribute(tostring(passId),false);
	end
	
	owned_passes[player.UserId] = owned_passes[player.UserId] or {};
	shared.getPasses(player);
end)

--game:GetService("MarketplaceService").PromptGamePassPurchaseFinished:Connect(function(player,id,wasPurchased)
	--if(wasPurchased) then
		--owned_passes[player.UserId][id] = true;
		--shared.update_user(player,convert(owned_passes[player.UserId]))
		--event:FireClient(player,convert(owned_passes[player.UserId]))
	--end
--end)

local get = function(id)
	for k,v in pairs(passes) do
		if(v == id and (not k:find("Sword"))) then
			return k;
		end
	end
	for k,v in pairs(newPasses) do
		if(v == id and (not k:find("Sword"))) then
			return k;
		end
	end
end

local expected = {};

for productId,passId in pairs(gifts) do
	service.onDeveloperProductPurchase(productId):Connect(function(player)
		local target = targets[player];
		if(target) then
			game.ReplicatedStorage.events.notif:FireClient(target,"System",player.Name .. " gifted you " .. get(passId).. "!");
			shared.run_gift(target,passId);
		end
	end)
end

local giftAdmins = {111954405,87424828,2274229507};
game.ReplicatedStorage.events.prompt.OnServerEvent:Connect(function(player,target,id)
	targets[player] = target;
	if not (table.find(giftAdmins,player.UserId)) then
		game:GetService("MarketplaceService"):PromptProductPurchase(player,id);
	else
		local passId = gifts[id];
		game.ReplicatedStorage.events.notif:FireClient(target,"System",player.Name .. " gifted you " .. get(passId).. "!");
		shared.run_gift(target,passId);
	end
end)

local copy = function(tbl)
	local shallow = {};
	for k,v in pairs(tbl) do
		shallow[k] = v;
	end
	return shallow;
end

local timeRain = function(name,amount,del,attribute)
	local tweenService = game:GetService("TweenService")
	local info = TweenInfo.new(5)

	local function tweenModel(model, CF)
		local CFrameValue = Instance.new("CFrameValue")
		CFrameValue.Value = model:GetPrimaryPartCFrame()

		CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
			model:SetPrimaryPartCFrame(CFrameValue.Value)
		end)

		local tween = tweenService:Create(CFrameValue, info, {Value = CF})
		tween:Play()

		tween.Completed:Connect(function()
			model.Rotate.Disabled = false;
			CFrameValue:Destroy()
		end)
	end
	
	local standard = name.." has spawned in " .. tostring(amount) .. " gems of time for everyone to enjoy!";
	game:GetService("ReplicatedStorage").events.makeMsg:FireAllClients(standard);

	local timePositions = copy(require(game:GetService("ReplicatedStorage"):WaitForChild("timeRainPositions")));
	local randomPositions = {};
	
	for i = 1,amount do
		local key = math.random(1,#timePositions);
		table.insert(randomPositions,timePositions[key]);
		table.remove(timePositions,key);
	end
	
	for _,position in pairs(randomPositions) do
		local gem = game:GetService("ServerStorage").particles.TimeGem:Clone();
		gem:SetPrimaryPartCFrame(CFrame.new(position.X,position.Y,position.Z));
		gem.Parent = workspace;
		if(attribute) then
			gem:SetAttribute(attribute,true);
		end
		tweenModel(gem,CFrame.new(position.X,1.875,position.Z))
		if(del ~= nil and del ~= 0) then
			wait(del or 1);
		end
	end
end

local bomb = function(char)
	local tweenPosition = function(part,len,pos)
		local info = TweenInfo.new(len,Enum.EasingStyle.Linear,Enum.EasingDirection.Out);
		game:GetService("TweenService"):Create(part, info, {
			Position = pos;
		}):Play();
	end

	local tweenSize = function(part,len,size)
		local info = TweenInfo.new(len,Enum.EasingStyle.Linear,Enum.EasingDirection.Out);
		game:GetService("TweenService"):Create(part, info, {
			Size = size;
		}):Play();
	end

	local tweenProperty = function(part,len,property,value)
		local info = TweenInfo.new(len,Enum.EasingStyle.Linear,Enum.EasingDirection.Out);
		game:GetService("TweenService"):Create(part, info, {
			[property] = value
		}):Play();
	end
	
	local ball = Instance.new("Part",char);
	ball.Shape = Enum.PartType.Ball;
	ball.Anchored = true;
	ball.Color = Color3.fromRGB(170, 85, 255);
	ball.Position = char.HumanoidRootPart.Position;
	ball.Anchored = true;
	ball.Size = Vector3.new(1,1,1);
	ball.BottomSurface = Enum.SurfaceType.Smooth; 
	ball.CanCollide = false;
	ball.TopSurface = Enum.SurfaceType.Smooth;
	ball.Material = Enum.Material.Neon;
	tweenSize(ball,1,Vector3.new(150,150,150));
	tweenProperty(ball,0.85,"Transparency",1);
	
	local new = Instance.new("Sound",ball);
	new.SoundId = "rbxassetid://6835752707";
	new:Play();
	new.Ended:Connect(function()
		new:Destroy();
		local new = Instance.new("Sound",workspace);
		new.SoundId = "rbxassetid://2785656389";
		new:Play();
		new.Ended:Connect(function()
			new:Destroy();
		end)
	end)
	
	game:GetService("Debris"):AddItem(ball,20);
end

local function badge(player,badgeId)
	coroutine.wrap(function()
		local success,badgeInfo = pcall(function()
			return game:GetService("BadgeService"):GetBadgeInfoAsync(badgeId);
		end)
		if(success) then
			if(badgeInfo.IsEnabled) then
				local awarded,errorMessage = pcall(function()
					game:GetService("BadgeService"):AwardBadge(player.UserId,badgeId);
				end)
				if(not awarded) then
					warn("Error while awarding badge:",errorMessage);
				end
			end
		else
			warn("Error while fetching badge info!");
		end
	end)();
end

for key,productId in pairs({
	1201514826,
	1201514850,
	1201514869,
	1201514890,
	1201514922,
	1201514937
}) do
	service.onDeveloperProductPurchase(productId):Connect(function(player,receipt)
		local s,e = pcall(function()
			local sound = Instance.new("Sound",player.Character.Head);
			sound.SoundId = "rbxassetid://7112275565";
			sound.RollOffMaxDistance = 200;
			sound:Play();
			local rain = game.ServerStorage.particles.Shower:Clone();
			rain.Parent = player.Character.Head;
			game:GetService("Debris"):AddItem(rain,5);
		end)

		local previous = tonumber(player:GetAttribute("donationAmount") or 0);
		local price = tonumber(({"10","50","100","500","1000","5000"})[key]);
		player:SetAttribute("donationAmount",previous + price);
		shared.profiles[player]["Data"].donationAmount = previous + price;
		shared["wipe_donations"](player.UserId,previous + price);
	end)
end

service.onDeveloperProductPurchase(1201515043):Connect(function(player)
	badge(player,2124790534);
	-- 250 timerain
	timeRain(player.Name,15,0.65,"STANDARD");
end)

service.onDeveloperProductPurchase(1201515110):Connect(function(player)
	badge(player,2124790534);
	-- 500 timerain
	timeRain(player.Name,30,0.65,"RICH");
end)

service.onDeveloperProductPurchase(1201515572):Connect(function(player)
	coroutine.wrap(function()
		local sound = game:GetService("ReplicatedStorage").boohoo:Clone();
		sound.Parent = workspace;
		sound.TimePosition = 0.27; 
		sound.Playing = true; 
		sound.Volume = 5; 
		wait(6.85) 
		sound.Playing = false;
		sound:Destroy();
	end)();
end)

service.onDeveloperProductPurchase(1201515152):Connect(function(player)
	badge(player,2124790534);
	timeRain(player.Name,50,0.65,"RICH");
end)

service.onDeveloperProductPurchase(1201515195):Connect(function(player)
	badge(player,2124790534);
	timeRain(player.Name,100,0.65,"RICH");
end)

service.onDeveloperProductPurchase(1201515272):Connect(function(player)
	badge(player,2124790534);
	coroutine.wrap(function()
		timeRain(player.Name,1500,0.65,"RICH");
	end)();
	bomb(player.Character);
end)

shared.run_gift = function(...)
	return service.giftPass(...);
end
shared.timerain = timeRain;