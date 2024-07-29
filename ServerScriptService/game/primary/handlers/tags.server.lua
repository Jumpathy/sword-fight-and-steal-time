local profiles = {};

local decode = function(tbl)
	if(tbl == false) then
		return {}
	end
	local raw = game:GetService("HttpService"):JSONDecode(tbl)
	raw.Color = raw.Color and Color3.fromRGB(unpack(raw.Color)) or nil
	return raw
end

shared.decode_tag = decode

local handle = function(player)
	local parsed = decode(profiles[player]["equippedTag"])
	local text = parsed and parsed["Text"]
	if(not text) then
		player:SetAttribute("EquippedTag",false)
		shared.fix(player)
		return
	end
	player:SetAttribute("EquippedTag",text ~= "" and text or false)
	shared.fix(player)
end

local player = function(plr)
	repeat
		game:GetService("RunService").Heartbeat:Wait();
	until shared.onProfileLoaded[plr] ~= nil;

	shared.onProfileLoaded[plr]:Connect(function()
		local data = shared.profiles[plr];
		profiles[plr] = data;		
		local tags = Instance.new("Folder",plr)
		tags.Name = "Tags"
		for k,v in pairs(data.tags) do
			tags:SetAttribute(k,v)
		end
		tags.AttributeChanged:Connect(function(name)
			data.tags[name] = tags:GetAttribute(name)
		end)
		handle(plr)
	end)
end

game.Players.PlayerAdded:Connect(player);
for _,v in pairs(game.Players:GetPlayers()) do 
	coroutine.wrap(player)(v) 
end;

local config = require(game:GetService("ReplicatedStorage"):WaitForChild("config"))
local encode = function(tbl)
	if(tbl.Color) then
		tbl.Color = {
			math.floor(tbl.Color.R * 255),
			math.floor(tbl.Color.G * 255),
			math.floor(tbl.Color.B * 255),
		}
	end
	return game:GetService("HttpService"):JSONEncode(tbl)
end

game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("tag").OnServerInvoke = function(player,request,value)
	if(request == "buy") then
		local data = config.chatTags[value]
		if(data) then
			local cost = data[1]
			if(player.leaderstats.Time.Value >= cost) then
				player.Tags:SetAttribute(value,true)
				return true
			end
		end
	elseif(request == "equip") then
		local data = config.chatTags[value]
		if(data and (profiles[player]["tags"][value])) then
			profiles[player]["equippedTag"] = encode ({
				Text = value,
				Color = data[2]
			})
			handle(player)
		end
	elseif(request == "unequip") then
		local data = config.chatTags[value]
		if(data and (profiles[player]["tags"][value])) then
			profiles[player]["equippedTag"] = encode({
				Text = ""
			})
			handle(player)
		end
	end
end