local createTag = function(text,color)
	return {TagText = text, TagColor = color};
end

local joined = {111954405,87424828,2274229507}

shared.setup_tags = function(player,passes)
	if(shared.get_speaker == nil) then
		repeat game:GetService("RunService").Heartbeat:Wait(); until shared.get_speaker ~= nil;
	end
	local speaker = shared.get_speaker(player.Name);
	if(not speaker) then
		repeat game:GetService("RunService").Heartbeat:Wait() until  shared.get_speaker(player.Name) ~= nil;
		speaker =  shared.get_speaker(player.Name);
	end
	if(passes["Elite"] and not joined[player]) then
		joined[player] = true;
		shared.add_to_elite(player);
	end

	local tags = {};
	local nameColor;
	local chatColor;

	local priority = {
		function()
			return passes["Elite"] and player.UserId ~= 111954405 and createTag("Elite",Color3.fromRGB(255,0,0))
		end,
		function()
			return player.Name == "Jumpathy" and createTag("Developer",Color3.fromRGB(170, 0, 255))
		end,
		function()
			return player.Name == "imAvizandum" and createTag("Developer",Color3.fromRGB(170, 255, 255))
		end,
		function()
			return player.UserId == 2557383750 and createTag("Owner",Color3.fromRGB(0,0,0))
		end,
	}

	local priority2 = {
		function()
			return passes["Elite"] and Color3.fromRGB(255,0,0);
		end,
		function()
			return player.Name == "Jumpathy" and Color3.fromRGB(170, 0, 255)
		end,
		function()
			return player.UserId == 111954405 and Color3.fromRGB(0,0,0)
		end,
		function()
			return player.Name == "imAvizandum" and Color3.fromRGB(255,255,255)
		end,
		function()
			return player.UserId == 2557383750 and Color3.fromRGB(0,0,0)
		end,
	}

	local priority3 = {
		function()
			return passes["Elite"] and Color3.fromRGB(255,255,0)
		end,
		function()
			return player.UserId == 111954405 and Color3.fromRGB(255,255,0)
		end,
		function()
			return player.Name == "imAvizandum" and Color3.fromRGB(255,255,255)
		end
	}

	for _,tag in pairs(priority) do
		local r = tag();
		if(r) then
			tags = {r};
		end
	end

	for _,nc in pairs(priority2) do
		local nc = nc();
		if(nc) then
			nameColor = nc;
		end
	end

	for _,cc in pairs(priority3) do
		local c = cc();
		if(c) then
			chatColor = c;
		end
	end

	if(tags[1] ~= nil) then
		speaker:SetExtraData("Tags",tags);
	end
	if(nameColor) then
		speaker:SetExtraData("NameColor",nameColor);
	end
	if(chatColor) then
		speaker:SetExtraData("ChatColor",chatColor);
	end
end

local tags = require(game:GetService("ReplicatedStorage"):WaitForChild("config"))["chatTags"]

shared.fix = function(player)
	if(shared.get_speaker == nil) then
		repeat game:GetService("RunService").Heartbeat:Wait(); until shared.get_speaker ~= nil;
	end
	local speaker = shared.get_speaker(player.Name);
	if(not speaker) then
		repeat game:GetService("RunService").Heartbeat:Wait() until  shared.get_speaker(player.Name) ~= nil;
		speaker =  shared.get_speaker(player.Name);
	end
	
	local existing = speaker:GetExtraData("Tags") or {}
	local equipped = player:GetAttribute("EquippedTag")
	local data = tags[equipped]
	local toAdd = {}
	if(equipped) then
		local tag = createTag(equipped,data[2])
		table.insert(toAdd,tag)
	end
	
	for name,data in pairs(tags) do
		for key,tag in pairs(existing) do
			if(tag.TagText == name) then
				table.remove(existing,key)
				break
			end
		end
	end
	
	for _,add in pairs(toAdd) do
		table.insert(existing,add)
	end
	speaker:SetExtraData("Tags",existing)
end