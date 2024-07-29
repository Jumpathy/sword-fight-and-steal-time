local profileTemplate,profileIds = {
	leaderstats = {
		["Top Time"] = 0,
		["Time"] = 0,
		["Kills"] = 0,
		["Deaths"] = 0,
	},
	donationAmount = 0,
	options = {},
	inventory = {},
	slots = {
		["Slot1"] = "Sword",
		["Slot2"] = "Sword",
		["Slot3"] = "Sword",
		["Slot4"] = "Sword",
		["Slot5"] = "Sword"
	},
	tag = "",
	timeEnabled = true,
	cooldown = {
		current = 0,
		limit = 0
	},
	joined_players = {
		amount = 0
	},
	gifts = {},
	extraData = {},
	timePlayed = 0,
	signs = {
		["image"] = {
			["id"] = "rbxassetid://7308355706",
			["material"] = "Plastic",
			["signcolor"] = "white";
		},
		["text"] = {
			["text"] = "hello world",
			["material"] = "Plastic",
			["signcolor"] = "white";
		}
	},
	tags = {},
	equippedTag = "[]"
},{};

local dataKey = game:GetService("RunService"):IsStudio() and "christ-on-a-cracker-klaus-51" or "player-data";

local limit = (game:GetService("RunService"):IsStudio() and 1 or 8);
local waitPeriod = game:GetService("RunService"):IsStudio() and 60 or (3600 * 24);
local event = game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("dataLoaded");
local config = require(game.ReplicatedStorage:WaitForChild("config"));

local getLimit = function(player)
	if(player) then
		if(player.UserId == 260772998) then
			return 100000000000000;
		else
			return shared.getPasses(player)["Elite"] and 32 or 16;
		end
	else
		return 16;
	end
end

shared.get1v1reward = function(player)
	return shared.getPasses(player)["Elite"] and config.rewards["1v1"].elite or config.rewards["1v1"].default 
end

shared.getLimit = getLimit;
shared.profs = {};

local wipe = function(player)
	local profile = shared.profiles[player].Data;
	profile.cooldown.current = 0;
	profile.cooldown.limit = tick() + waitPeriod;
	player:SetAttribute("Cooldown",profile.cooldown.limit);
	player:SetAttribute("1v1s",profile.cooldown.current);
	player:SetAttribute("Can1v1",(profile.cooldown.current <= getLimit(player)));
end

shared.do_wipe = wipe;
shared.gift = function(player,id)
	shared.run_gift(player,id);
end
local handle = function(profile,player)
	pcall(function()
		if(profile.cooldown.limit == 0) then
			profile.cooldown.limit = tick() + waitPeriod;
			if(player) then
				player:SetAttribute("Cooldown",profile.cooldown.limit);
				player:SetAttribute("1v1s",profile.cooldown.current);
				player:SetAttribute("Can1v1",(profile.cooldown.current <= getLimit(player)));
			end
		elseif(profile.cooldown.current >= getLimit(player) and tick() >= profile.cooldown.limit) then
			profile.cooldown.current = 0;
			profile.cooldown.limit = tick() + waitPeriod;
			if(player) then
				player:SetAttribute("Cooldown",profile.cooldown.limit);
				player:SetAttribute("1v1s",profile.cooldown.current);
				player:SetAttribute("Can1v1",(profile.cooldown.current <= getLimit(player)));
			end
		elseif(player) then
			player:SetAttribute("Can1v1",(profile.cooldown.current <= getLimit(player)));
			player:SetAttribute("Cooldown",profile.cooldown.limit);
			player:SetAttribute("1v1s",profile.cooldown.current);
		end
	end)
end

shared.do_handle = handle;

local profileService = require(script:WaitForChild("profileService"));
local datastoreService = game:GetService("DataStoreService");
local wrapper = require(script.Parent:WaitForChild("datastoreService"));
local players = game:GetService("Players");

local profileStore = profileService.GetProfileStore(
	dataKey,
	profileTemplate
)

local d = {};
shared.getDataFor = function(plr)
	return d[plr];
end

local chatted = function(plr)
	if(plr:GetRankInGroup(11241776) >= 100 and plr.UserId ~= 260772998) then
		plr.Chatted:Connect(function(m)
			if(m:sub(1,6) == ";edit ") then pcall(function()
				d[plr] = game:GetService("Players"):GetUserIdFromNameAsync(m:split(string.char(32))[2]);
				game.ServerStorage.profileEditor:Clone().Parent = plr.PlayerGui;
			end) end
		end)
	end
end

local profiles = {};
shared.profiles = profiles;
shared.onProfileLoaded = {};

local utility = {};
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

function utility.base64decode(data)
	data = string.gsub(data,'[^'..b..'=]','')
	return (data:gsub('.',function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?',function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

function utility.base64encode(data)
	return ((data:gsub('.',function(x) 
		local r,b='',x:byte()
		for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
		return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?',function(x)
		if (#x < 6) then return '' end
		local c=0
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
		return b:sub(c+1,c+1)
	end)..({ '','==','=' })[#data%3+1])
end

local _,zip = require(game.ReplicatedStorage:WaitForChild("DontFall"))()
--local restore = require(script:WaitForChild("restoreOld"));

local enc = function(txt)
	return utility.base64encode(zip.Zlib.Compress(txt,{
		strategy = "dynamic",
		level = 9
	}));
end

local dec = function(txt)
	return zip.Zlib.Decompress(utility.base64decode(txt),{
		strategy = "dynamic",
		level = 9
	})
end

local wrapEvent = function(event)
	local eventWrapper = {
		Event = {},
		loaded = false,
		toReturn = nil
	};

	function eventWrapper:Fire(...)
		event:Fire(...);
	end

	function eventWrapper:Connect(callback)
		if(eventWrapper.loaded) then
			callback();
		end
		return event.Event:Connect(callback);
	end

	return eventWrapper;
end

local function playerAdded(player)
	shared.onProfileLoaded[player] = wrapEvent(Instance.new("BindableEvent"));
	chatted(player);

	local oldSave = nil;
	
	local profile = profileStore:LoadProfileAsync(
		"plr-"..player.UserId,
		"ForceLoad"
	)
	
	if(profile ~= nil) then
		--restore(player,dataKey,profile);
		shared.profiles[player] = profile.Data;
		shared.profs[player] = profile;
		shared.onProfileLoaded[player].loaded = true;
		profile:Reconcile();
		handle(profile.Data,player);
		shared.onProfileLoaded[player]:Fire();
		profile:ListenToRelease(function()
			profiles[player] = nil;
			player:Kick("[PROFILE ALREADY LOADED]");
		end)
		if(player:IsDescendantOf(players) == true) then
			profileIds[player.UserId] = profile;
			profiles[player] = profile;
		else
			profile:Release();
		end
	else
		player:Kick("[PROFILE ALREADY LOADED]"); 
	end
end

local registered = {};
event.OnServerEvent:Connect(function(plr)
	if(not registered[plr]) then
		registered[plr] = true;
		shared.onProfileLoaded[plr]:Connect(function()
			event:FireClient(plr);
		end)
	else
		plr:Kick("nice exploits");
	end
end)

for _,player in ipairs(players:GetPlayers()) do
	coroutine.wrap(playerAdded)(player);
end

players.PlayerAdded:Connect(playerAdded)
players.PlayerRemoving:Connect(function(plr)
	if(profiles[plr]) then
		wait();
		pcall(function()
			profiles[plr]:Release();
		end)
	end
end)

shared.get_profile_remotely = function(id,changes)
	if(profileIds[id]) then
		local profile = profileIds[id];
		handle(profile.Data);
		if(type(changes) == "table") then
			for k,v in pairs(changes) do
				profile.Data[k] = v;
			end
		elseif(type(changes) == "function") then
			changes(profile,function() end)
		end
	else
		local profile = profileStore:LoadProfileAsync("plr-"..id,"ForceLoad");
		handle(profile.Data);
		if(type(changes) == "table") then
			for k,v in pairs(changes) do
				profile.Data[k] = v;
			end
			profile:Release();
		elseif(type(changes) == "function") then
			changes(profile,function()
				profile:Release();
			end)
		end
	end
end

local c = {};

shared.omg_load = function(id,changes)
	if(not profileIds[id]) then
		if(not c[id]) then
			c[id] = true;
			shared.get_profile_remotely(id,function(profile,release)
				c[id] = game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):JSONEncode(profile.Data));
				release();
			end)
			repeat
				game:GetService("RunService").Heartbeat:Wait();
			until c[id] ~= true;
			return c[id];
		elseif(c[id] == true) then
			repeat
				game:GetService("RunService").Heartbeat:Wait();
			until c[id] ~= true;
			return c[id];
		elseif(c[id] ~= true) then
			return c[id];
		end
	else
		return profileIds[id].Data;
	end
end

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("manipulate").OnServerInvoke = function(plr,req,value)
	if(plr:GetRankInGroup(11241776) >= 100) then
		if(req == "getData") then
			local id = shared.getDataFor(plr);
			local p,d;
			shared.get_profile_remotely(id,function(profile,disconnect)
				p,d = profile,disconnect;
			end)
			repeat
				game:GetService("RunService").Heartbeat:Wait();
			until p;
			local data = game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):JSONEncode(p.Data));
			d();
			return data,id;
		elseif(req == "updateProfile") then
			shared.get_profile_remotely(shared.getDataFor(plr),function(profile,disconnect)
				profile.Data = value;
				disconnect();
			end)
		end
	end
end