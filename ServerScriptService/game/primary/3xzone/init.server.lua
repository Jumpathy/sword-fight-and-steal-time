local existing = {};
local setId = 0;
local n = game:GetService("RunService"):IsStudio() and 10 or 300;

local zone = require(7260112804);

local wait = require(script:WaitForChild("betterWait"));
shared.in_3x = {};

local playerInteracted = function(zone,callback)
	zone.playerEntered:Connect(function(plr)
		callback(plr,true);
	end)	
	zone.playerExited:Connect(function(plr)
		callback(plr,false);
	end)	
end

local floor = math.floor;
local mod = math.fmod;
local function format(total_seconds)
	local time_days = floor(total_seconds / 86400)
	local time_hours = floor(mod(total_seconds, 86400) / 3600)
	local time_minutes = floor(mod(total_seconds, 3600) / 60)
	local time_seconds = floor(mod(total_seconds, 60))
	if (time_hours < 10) then
		time_hours = "0" .. time_hours
	end
	if (time_minutes < 10) then
		time_minutes = "0" .. time_minutes
	end
	if (time_seconds < 10) then
		time_seconds = "0" .. time_seconds
	end
	return time_minutes .. ":" .. time_seconds
end

local createZone = function(pad)
	local zone = zone.new(pad.Zone);

	local disconnect = playerInteracted(zone,function(player,inside)
		shared.in_3x[player] = inside;
	end)

	coroutine.wrap(function()
		local i = 0;
		while wait(1) do
			i += 1;
			if(i >= n) then
				pad.g.Tags.Container.pName.Text = format(n-i);
				break;
			else
				pad.g.Tags.Container.pName.Text = format(n-i);
			end
		end
	end)();

	return zone;
end

local sets = require(game.ReplicatedStorage.sets);
local last = 0;

local spawnSet = function()
	shared.in_3x = {};
	for _,set in pairs(existing) do
		set[1]:Destroy();
		set[2]:destroy();
	end
	existing = {};
	
	local sets = sets[workspace.Map:GetAttribute("Selected")];

	local key = math.random(1,#sets);
	local newSet = sets[key];

	for _,position in pairs(newSet) do
		coroutine.wrap(function()
			local pad = game.ServerStorage.timePad:Clone();
			pad.Parent = workspace:WaitForChild("Map"):WaitForChild("TimeZones");
			pad:SetPrimaryPartCFrame(CFrame.new(position));
			local zone,c = createZone(pad);
			table.insert(existing,{pad,zone});
		end)();
	end
end

while true do
	local last = workspace.Map:GetAttribute("Selected");
	local changed,lastConnection = false,nil;
	spawnSet();
	shared.done = false;
	coroutine.wrap(function()
		shared.done = false;
		wait(n+1);
		shared.done = true;
	end)();
	pcall(function()
		lastConnection:Disconnect();
	end)
	lastConnection = workspace.Map.AttributeChanged:Connect(function()
		if(workspace.Map:GetAttribute("Selected") ~= last) then
			changed = true;
		end
	end)
	repeat
		game:GetService("RunService").Heartbeat:Wait();
	until(shared.done or changed);
end