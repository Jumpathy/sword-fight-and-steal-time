local userDataKey = "user-data-reset-release-1.0.0"; -- DO NOT MODIFY (WILL WIPE ALL DATA)
local inSpectators = {};

local players = game:GetService("Players");
local physics = game:GetService("PhysicsService");
physics:CreateCollisionGroup("players");
physics:CreateCollisionGroup("sword_effects");
shared.paused_time = false;

local swordAdmins = {373187429,2557383750,87424828,111954405};
local uniqueItemPasses = {
	"Alienator","Elite_Sword","Radio","Sus","Azurath","8ball"
}

local wait = require(script:WaitForChild("betterWait"));
local zoneModule = require(6190726965);
local safeZone = require(game:GetService("ReplicatedStorage"):WaitForChild("Services"):WaitForChild("Zone"):WaitForChild("ZoneService")):createZone("sf_region",workspace:WaitForChild("Map"):WaitForChild("Safezone"));
local config = require(game:GetService("ReplicatedStorage"):WaitForChild("config"));

local pi = Instance.new("BindableEvent");
local playerInteracted = pi.Event;

game.ReplicatedStorage.events:WaitForChild("ping").OnServerInvoke = function() return true; end

local last = {};
local has = {};
game:GetService("RunService").Heartbeat:Connect(function()
	local players = safeZone:getPlayers();
	for _,player in pairs(game:GetService("Players"):GetPlayers()) do
		if(table.find(players,player) and not has[player]) then
			has[player] = true;
			pi:Fire(player,true);
		elseif(not table.find(players,player) and has[player]) then
			has[player] = false;
			pi:Fire(player,false);
		end
	end
end)

local wrap = {};

function wrap.new(...)
	local class = ({...})[1];
	local p = Instance.new(...);
	if(class == "Sound") then
		shared.handle_sound(p);
	end
	return p;
end

shared.custom_instance = wrap;

workspace:WaitForChild("Map"):WaitForChild("Safezone"):WaitForChild("Zone").Touched:Connect(function(hit)
	local player = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent);
	if(player) then
		if(not has[player]) then
			has[player] = true;
			pi:Fire(player,true);
		end
	end
end)

local updateTime = {};
local inZone = {};
local saveFuncs = {};
local swords = {};

local floor = math.floor;
local mod = math.fmod;
local function disp(total_seconds)
	local time_days = floor(total_seconds / 86400)
	local time_hours = floor(mod(total_seconds,86400) / 3600)
	local time_minutes = floor(mod(total_seconds,3600) / 60)
	local time_seconds = floor(mod(total_seconds,60))
	if (time_hours < 10) then
		time_hours = "0" .. time_hours
	end
	if (time_minutes < 10) then
		time_minutes = "0" .. time_minutes
	end
	if (time_seconds < 10) then
		time_seconds = "0" .. time_seconds
	end
	return time_days .. ":" .. time_hours .. ":" .. time_minutes .. ":" .. time_seconds
end

local bindSword = function(player,character,sword)
	table.insert(swords,sword);
	sword:GetPropertyChangedSignal("Parent"):Connect(function()
		if(sword.Parent ~= player:FindFirstChild("Backpack") and sword.Parent ~= character) then
			sword:Destroy();
		end
	end)
	pcall(function()
		character:WaitForChild("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
		character:WaitForChild("Humanoid").Died:Connect(function()
			sword:Destroy();
		end)
	end)
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

local linked = {};
local check = function(player)
	coroutine.wrap(function()
		local inv = player:WaitForChild("Inventory");
		if(not linked[player]) then
			linked[player] = true;
			local c = function()
				if(inv:GetAttribute("Requiem")) then
					badge(player,2124813897);
				end
			end
			inv.AttributeChanged:Connect(c);
			c();
		end
	end)();
end

local swordData = function()
	local swords = game:GetService("ServerStorage"):WaitForChild("swords");
	local data = {};
	for _,sword in pairs(swords:GetChildren()) do
		data[sword.Name] = {
			name = sword.Name:gsub(" ","_"):gsub("'","jw"),
			tier = sword:GetAttribute("Tier") or "Common",
			category = sword:GetAttribute("Category") or "Other",
			usesViewport = sword:GetAttribute("UseViewport") == true,
			textureId = sword.TextureId,
			rankRequired = sword:GetAttribute("RankRequired") or nil,
			handleObject = sword:GetAttribute("UseViewport") == true and sword.Handle:IsA("MeshPart") and {
				ClassName = "Part";
				Position = sword.Handle.Position,
				Size = sword.Handle.Size,
				Orientation = sword.Handle.Orientation,
				Color = sword.Handle.Color,
				
				mesh = {
					ClassName = "SpecialMesh",
					Scale = Vector3.new(1,1,1),
					TextureId = sword.Handle.TextureID,
					MeshId = sword.Handle.MeshId,
				} or nil;
			} or {
				ClassName = "Part",
				Position = sword.Handle.Position,
				Size = sword.Handle.Size,
				Orientation = sword.Handle.Orientation,
				Color = sword.Handle.Color,

				mesh = sword.Handle:FindFirstChildOfClass("SpecialMesh") and {
					ClassName = "SpecialMesh",
					Scale = sword.Handle:FindFirstChildOfClass("SpecialMesh").Scale,
					TextureId = sword.Handle:FindFirstChildOfClass("SpecialMesh").TextureId,
					MeshId = sword.Handle:FindFirstChildOfClass("SpecialMesh").MeshId,
					VertexColor = sword.Handle:FindFirstChildOfClass("SpecialMesh").VertexColor
				} or nil;
			},
			shopData = sword:GetAttribute("ShopCategory") and {	
				category = sword:GetAttribute("ShopCategory"),
				price = tonumber(sword:GetAttribute("Price")); --> SKY WHY DID YOU MAKE THEM STRINGS JIH3RKJ32HTKJ
			},
			description = sword:GetAttribute("Description") or "",
			unlisted = sword:GetAttribute("Unlisted")
		}

	end
	return data;
end

game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("swordData").OnServerInvoke = function()
	return swordData();
end

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("unlock").OnServerEvent:Connect(function(player,item)
	for name,data in pairs(swordData()) do
		if(name == item) then
			if(player.leaderstats[data.shopData.category == "Time" and "Top Time" or "Kills"].Value >= data.shopData.price) then
				shared.modify_item(player,data.name,true);
				check(player);
			end
		end
	end
end)

local dataTable = {};

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("getOptions").OnServerEvent:Connect(function(plr)
	if(dataTable[plr]) then
		game.ReplicatedStorage:WaitForChild("events"):WaitForChild("getOptions"):FireClient(plr,dataTable[plr].options);
	end
end)

local setMap = function(name)
	workspace.Map:SetAttribute("Selected",name);
	workspace.Map.Addons:ClearAllChildren();
	local constants = config.mapConstants[name];
	if(constants.Baseplate) then
		for property,value in pairs(constants.Baseplate) do
			workspace.Map.Baseplate[property] = value;
		end
	end
	if(constants.Extra) then
		local map = constants.Extra.Map;
		if(map) then
			map:Clone().Parent = workspace.Map.Addons;
		end
	end
	if(constants.Sky) then
		pcall(function()
			game.Lighting.sky:Destroy();
		end)
		constants.Sky:Clone().Parent = game.Lighting;
	else
		pcall(function()
			game.Lighting.sky:Destroy();
		end)
		game.ServerStorage.maps.default.sky:Clone().Parent = game.Lighting;
	end
	if(constants.Atmosphere) then
		game.ReplicatedStorage.atmosphere:Clone().Parent = game.Lighting;
	else
		pcall(function()
			game.Lighting:FindFirstChildOfClass("Atmosphere"):Destroy();
		end)
	end
end

shared.setMap = setMap;

if(config.mapsEnabled) then
	local maps = {"Default","Desert","Space","Winter"};
	local current,statusDelay = maps[1],15;
	
	local newMap = function()
		local new = "";
		repeat
			new = (maps[math.random(1,#maps)]);
		until(new ~= current);
		current = new;
		return new;
	end

	coroutine.wrap(function()
		while true do
			coroutine.wrap(function()
				wait(config.mapChangeDelay - statusDelay);
				for i = 1,statusDelay do
					wait(1);
					game.ReplicatedStorage.events.status:FireAllClients({
						visible = true,
						text = "Map changing in " .. (statusDelay - i);
					})
				end
				game.ReplicatedStorage.events.status:FireAllClients({
					visible = false,
				})
				setMap(newMap());
			end)();
			wait(config.mapChangeDelay);
		end
	end)();
end

local leaderstats = function(player)
	if(not shared.onProfileLoaded[player]) then
		repeat
			game:GetService("RunService").Heartbeat:Wait();
		until shared.onProfileLoaded[player] ~= nil;
	end
	shared.onProfileLoaded[player]:Connect(function()
		local data = shared.profiles[player];
		dataTable[player] = data;
		game.ReplicatedStorage:WaitForChild("events"):WaitForChild("getOptions"):FireClient(player,data.options);

		player:SetAttribute("donationAmount",data["donationAmount"] or 0);
		player:SetAttribute("tag",data["tag"] or "");
		player:SetAttribute("timeEnabled",data["timeEnabled"] ~= nil and data["timeEnabled"] or true);

		local inventoryChange = function()
			for itemName,value in pairs(player.Inventory:GetAttributes()) do
				data.inventory[itemName] = value;
			end
		end

		local slotChange = function()
			for slotNumber,itemName in pairs(player.Inventory.Selected:GetAttributes()) do
				data.slots[slotNumber] = itemName;
			end
		end

		local statistics = Instance.new("Folder");
		statistics.Name = "leaderstats";
		statistics.Parent = player;
		coroutine.wrap(function()
			local names = {"Time","Top Time","Kills","Deaths","Streak","K/D"};
			local tbl = {};
			for _,name in pairs(names) do
				local class = name == "K/D" and "NumberValue" or "IntValue";
				local stat = Instance.new(class);
				tbl[name] = stat;
				stat.Name = name;
				stat.Parent = statistics;
				stat.Value = data.leaderstats[name];
				if(name ~= "Streak" and name ~= "K/D") then
					stat:GetPropertyChangedSignal("Value"):Connect(function()
						data.leaderstats[name] = stat.Value;
					end)
				end
			end
			tbl["Time"]:GetPropertyChangedSignal("Value"):Connect(function()
				if(tbl["Time"].Value >= tbl["Top Time"].Value) then
					tbl["Top Time"].Value = tbl["Time"].Value;
				end
			end)

			player:SetAttribute("InstantRespawn",data.options.instantRespawn == true);

			for s,v in pairs(data.slots) do
				player:WaitForChild("Inventory"):WaitForChild("Selected"):SetAttribute(s,v);
			end
			
			data.inventory["Leaderboard"] = false
			
			if(player.UserId == 2674225207) then
				data.inventory["Requiem"] = true;
			elseif(player.UserId == 184957594) then
				data.inventory["Twinqle_Sword"] = true;
			end
			
			pcall(function()
				if(player:IsInGroup(11241776)) then
					data.inventory["Upside"] = true;
				else
					data.inventory["Upside"] = false;
				end

				if(player:GetRankInGroup(11241776) >= 253) then
					data.inventory["Gun_Sword"] = true;
					data.inventory["Ban_Hammer"] = true;
				else
					data.inventory["Gun_Sword"] = false;
				end
			end)

			for s,v in pairs(data.inventory) do
				player:WaitForChild("Inventory"):SetAttribute(s,v);
			end

			updateBackpack(player);

			player:WaitForChild("Inventory").AttributeChanged:Connect(inventoryChange);
			player:WaitForChild("Inventory"):WaitForChild("Selected").AttributeChanged:Connect(slotChange);
			player.AttributeChanged:Connect(function(name)
				if(name == "tag") then
					data["tag"] = player:GetAttribute(name);
				elseif(name == "timeEnabled") then
					data["timeEnabled"] = player:GetAttribute(name);
				end
			end)

			if(player:GetAttribute("donationAmount") >= 1) then
				shared["wipe_donations"](player.UserId,player:GetAttribute("donationAmount"));
			end
			
			local nextTime = tick() + 1;
			while wait() do
				if(game:GetService("Players"):FindFirstChild(player.Name)) then
					if(tick() >= nextTime) then
						nextTime = tick() + 1;
						data.timePlayed += 1;
					end
					tbl["K/D"].Value = (math.clamp(tbl["Kills"].Value,1,math.huge) / math.clamp(tbl["Deaths"].Value,1,math.huge))
				else
					break;
				end
			end
		end)();
	end)
end

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("setSetting").OnServerEvent:Connect(function(plr,option,value)
	local data = dataTable[plr];
	if(not data) then
		repeat
			game:GetService("RunService").Heartbeat:Wait();
		until dataTable[plr];
		data = dataTable[plr];
	end

	if(option == "muteRadios" and type(value) == "boolean") then
		data.options.muteRadios = value;
	elseif(option == "muteSwords" and type(value) == "boolean") then
		data.options.muteSwords = value;
	elseif(option == "night" and type(value) == "boolean") then
		data.options.night = value;
	elseif(option == "instantRespawn" and type(value) == "boolean") then
		if(not plr:GetAttribute("in1v1")) then
			data.options.instantRespawn = value;
		end
	elseif(option == "colorPicker" and type(value) == "table") then
		local newValue = {};
		for k,v in pairs(value) do
			if(k == "color" and typeof(v) == "Color3") then
				newValue[k] = {v.R * 255,v.G * 255,v.B * 255};
			elseif(k == "rainbow" and type(v) == "boolean") then
				newValue[k] = v;
			end
		end
		data.options.colorPicker = newValue;
	elseif(option == "muteMusic" and type(value) == "boolean") then
		data.options.muteMusic = value;
	elseif(option == "lowDetail" and type(value) == "boolean") then
		data.options.lowDetail = value;
	end
end)

local tagged = {};

local added = function(plr)
	plr.CharacterAdded:Connect(function(char)
		for k,v in pairs(workspace:GetChildren()) do
			if(v.Name == char.Name and v:FindFirstChildOfClass("Humanoid") ~= nil) then
				if(v ~= char) then
					v:Destroy();
				end
			end
		end
		tagged[plr] = false;
	end)
	plr.CharacterRemoving:Connect(function(char)
		pcall(function()
			if(char.Humanoid:FindFirstChild("creator")) then
				tagged[plr] = true;
			end
		end)
	end)
end

game.Players.PlayerAdded:Connect(added);
for _,player in pairs(game:GetService("Players"):GetPlayers()) do
	added(player);
end

game.Players.PlayerRemoving:Connect(function(plr)
	if(tagged[plr]) then
		plr.leaderstats.Time.Value = 0;
		coroutine.wrap(function()
			wait(1);
			if(workspace:FindFirstChild(plr.Name)) then
				local model = workspace[plr.Name];
				if(model:FindFirstChildOfClass("Humanoid")) then
					model:Destroy();
				end
			end
		end)();
	end
end)

local getSwords = function(player)
	local swords = {};
	for name,value in pairs(player:WaitForChild("Inventory"):GetAttributes()) do
		if(value) then
			table.insert(swords,name);
		end
	end
	return swords;
end

coroutine.wrap(function()
	local swords = game:GetService("ServerStorage"):WaitForChild("swords");
	repeat
		wait();
	until #swords:GetChildren() >= swords:GetAttribute("NumSwords");
	wait(.2);
	swords:SetAttribute("Loaded",true);
end)();

local inventory = function(player)
	coroutine.wrap(function()
		local inventory = Instance.new("Folder");
		inventory.Parent = player;
		inventory.Name = "Inventory";
		inventory:SetAttribute("Sword",true);

		local selected = Instance.new("StringValue");
		selected.Parent = inventory;
		selected.Name = "Selected";
	end)();
end

function shared.modify_item(player,item,bool,rank)
	local inventory = player.Inventory;
	if(item == "all") then
		if(not rank) then
			for _,sword in pairs(swordData()) do
				inventory:SetAttribute(sword.name,(bool ~= nil and bool or true));
			end
		else
			for _,sword in pairs(swordData()) do
				if(sword.rankRequired ~= nil) then
					if(rank >= sword.rankRequired) then
						inventory:SetAttribute(sword.name,(bool ~= nil and bool or true));
					end
				else
					inventory:SetAttribute(sword.name,(bool ~= nil and bool or true));
				end
			end
		end
	else
		inventory:SetAttribute(item,(bool ~= nil and bool or true));
	end
end

updateBackpack = function(plr)
	for _,item in pairs(plr.Backpack:GetChildren()) do
		item:Destroy();
	end
	local chosen = {};
	for i = 1,5 do
		local slot = plr.Inventory.Selected:GetAttribute("Slot"..tostring(i));
		if(not chosen[slot] and slot) then
			pcall(function()
				if(plr.Inventory:GetAttribute(slot)) then
					chosen[slot] = true;
					local sword = game:GetService("ServerStorage").swords[slot:gsub("_"," "):gsub("jw","'")]:Clone();
					sword.Parent = plr.Backpack;
					sword:SetAttribute("Order",i);
					bindSword(plr,plr.Character,sword);
				end
			end)
		end
	end
end

local wrap = function()
	local new = {};
	local calls = {};

	function new:Fire(data)
		new.has = true;
		for k,v in pairs(calls) do
			v(data);
		end
	end

	new.Event = {};
	function new.Event:Connect(callback)
		if(new.has) then
			callback(new.has);
		else
			table.insert(calls,callback);
		end
	end
	return new;
end

local on = function(parent,name)
	local signal = wrap();
	if(parent:FindFirstChild(name)) then
		signal.has = (parent:FindFirstChild(name));
	else
		coroutine.wrap(function()
			signal:Fire(parent:WaitForChild(name));
		end)();
	end
	return signal.Event;
end

local onJoined = function(player)
	leaderstats(player);
	inventory(player);
	local character = function(char)
		coroutine.wrap(function()
			updateBackpack(player);
			on(char,"HumanoidRootPart"):Connect(function()
				game:GetService("RunService").Heartbeat:Wait();
				if(not player:GetAttribute("in1v1")) then
					player.Character.HumanoidRootPart.CFrame = workspace.Map.Spawns:GetChildren()[math.random(1,16)].CFrame;
				end
			end)
			player.CharacterAppearanceLoaded:Wait();
			physics:CollisionGroupSetCollidable("sword_effects","players",false);
			physics:CollisionGroupSetCollidable("players","players",false);

			for _,object in pairs(char:GetChildren()) do
				if(object:IsA("BasePart")) then
					physics:SetPartCollisionGroup(object,"players");
				end
			end

			local conn;
			conn = char.Humanoid.Died:Connect(function()
				conn:Disconnect();
				updateTime[player] = false;
				if(player:GetAttribute("InstantRespawn")) then
					player:LoadCharacter();
				end
			end)
		end)();
	end
	player.CharacterAdded:Connect(character);
	if(player.Character) then
		character(player.Character);
	end
	while wait(1) do
		if(game:GetService("Players"):FindFirstChild(player.Name)) then
			if(updateTime[player]) then
				if(not inSpectators[player]) then
					local s,r = pcall(function()
						return not(player.Character:GetAttribute("gainTime") == false)
					end)
					if(r and not shared.paused_time) then
						player.leaderstats.Time.Value += shared.in_3x[player] and 3 or 1;
					end
				end
			end
		else
			break;
		end
	end
end

local leaving = function(player)
	player:SetAttribute("inZone",false);
	inZone[player] = tick();
	local current = inZone[player];
	wait(1);
	if(inZone[player] == current) then
		updateTime[player] = true;
	end
end

local entered = function(player)
	player:SetAttribute("inZone",true);
	inZone[player] = tick();
	updateTime[player] = false;
end

playerInteracted:Connect(function(player,inZone)
	local func = inZone and entered or leaving;
	func(player);
end)

local data = {};
local current = {};
Instance.new("BindableEvent").Event:Connect(function()
	current = {};
	for k,v in pairs(safeZone:getPlayers()) do
		game.ReplicatedStorage.events.zone:FireClient(v,false);
		current[v] = true;
		if(not data[v]) then
			data[v] = true;
			coroutine.wrap(function()
				entered(v);
			end)();
		end
	end
	for _,player in pairs(game:GetService("Players"):GetPlayers()) do
		if(not current[player]) then
			game.ReplicatedStorage.events.zone:FireClient(player,(true and inSpectators[player]));
		end
		if(not current[player]) then
			if(data[player]) then
				data[player] = false;
				coroutine.wrap(function()
					leaving(player);
				end)();
			end
		end
	end
end)

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("1v1").OnServerEvent:Connect(function(plr,option)
	if(option == "teleportTo1v1" and shared.lastGame ~= nil) then
		inSpectators[plr] = true;
		plr.Character.Humanoid.MaxHealth = math.huge;
		plr.Character.Humanoid.Health = math.huge;
		plr.Character.HumanoidRootPart.CFrame = workspace.Arena.SS.CFrame;
		plr:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("Hotbar").Visible = false;
		for k,v in pairs(plr.Character:GetChildren()) do
			if(v:IsA("Tool")) then
				v.Parent = plr.Backpack;
			end
		end
		plr.Character.ChildAdded:Connect(function(i)
			if(i:IsA("Tool")) then
				i:Destroy();
			end
		end)
	end
end)

game.ReplicatedStorage.tp.OnServerEvent:Connect(function(plr)
	if(inSpectators[plr]) then
		inSpectators[plr] = nil;
		plr:LoadCharacter();
	end
end)

game.ReplicatedStorage:WaitForChild("request1v1").OnServerEvent:Connect(function(speaker,userId)
	if(type(userId) == "number") then
		local player = game.Players:GetPlayerByUserId(userId);
		if(player) then
			local s,e = pcall(function()
				if(player ~= speaker and player ~= nil or (game:GetService("RunService"):IsStudio())) then
					shared.do_handle(shared.profiles[speaker].Data,speaker);
					shared.do_handle(shared.profiles[player].Data,player);
					if(not workspace.Arena:GetAttribute("1v1Currently")) then
						if(speaker.Name == "Jumpathy") then
							speaker:SetAttribute("last1v1",0);
						end
						local timeSince = tick() - (speaker:GetAttribute("last1v1") or 0);
						local response = false;
						if(player:GetAttribute("Can1v1") and speaker:GetAttribute("Can1v1")) then
							if(player.AccountAge >= 20 and speaker.AccountAge >= 20) then
								if(timeSince >= 100000000 or timeSince > 100) then
									workspace.Arena:SetAttribute("1v1Currently",true);
									game.ReplicatedStorage.events.makeMsg:FireClient(speaker,"You have challenged "..player.Name.." to a duel.");
									if(not game:GetService("RunService"):IsStudio()) then
										speaker:SetAttribute("last1v1",tick());
									end
									local k = game:GetService("HttpService"):GenerateGUID();
									game.ReplicatedStorage.events["1v1"]:FireClient(player,"'ALLO REMOTE SPY",speaker.Name,k);
									local conn;
									conn = game.ReplicatedStorage.events["1v1"].OnServerEvent:Connect(function(p,v,kk)
										if(p == player) then
											response = true;
											if(kk == k and v == "Accept") then
												if(p == player) then
													for k,v in pairs({player,speaker}) do
														local s,e = pcall(function()
															shared.profiles[v].Data.cooldown.current += 1;
															shared.do_handle(shared.profiles[v].Data,v);
															game.ReplicatedStorage.events.notif:FireClient(v,"System","You have " .. (shared.getLimit(v) - (shared.profiles[v].Data.cooldown.current)) .. " 1v1s remaining today.");
														end)
														if(e and not s) then
															warn(e);
														end
													end
													conn:Disconnect();
													shared.start_duel(speaker,player);
												end
											elseif(kk == k and v == "Decline") then
												workspace.Arena:SetAttribute("1v1Currently",false);
												game.ReplicatedStorage.events.notif:FireClient(speaker,"System",player.Name.." declined the 1v1.");
											end
										end
									end)
									coroutine.wrap(function()
										local n = player.Name;
										wait(16);
										if(not response) then
											game.ReplicatedStorage.events.notif:FireClient(speaker,"System",player.Name.." declined the 1v1.");
											workspace.Arena:SetAttribute("1v1Currently",false);
										end
									end)();
								else
									game.ReplicatedStorage.events.notif:FireClient(speaker,"System","You are on a cooldown for 1v1s for " .. (100 - math.floor(timeSince)) .. " more seconds.");
								end
							else
								game.ReplicatedStorage.events.notif:FireClient(speaker,"System","You both need to have been on Roblox for more than 20 days to begin a duel.");
							end
						else
							local a = speaker:GetAttribute("Can1v1");
							local b = player:GetAttribute("Can1v1");
							local t = {{speaker,a},{player,b}};
							local cannot1v1 = {};
							for k,v in pairs(t) do
								local userCooldown = v[2];
								if(not userCooldown) then
									local tim = v[1]:GetAttribute("Cooldown") - tick();
									tim = (disp(tim));
									game.ReplicatedStorage.events.notif:FireClient(v[1],"System","You have reached your daily 1v1 limit (resets in " .. tim .. ")");
									cannot1v1[v[1]] = tim;
								end
							end
							for k,v in pairs(cannot1v1) do
								game.ReplicatedStorage.events.notif:FireClient(speaker,"System",k.Name .. " can 1v1 again in " .. v);
							end
						end
					else
						game.ReplicatedStorage.events.notif:FireClient(speaker,"System","There is currently a 1v1 going on.");
					end
				else
					if(speaker == player) then
						game.ReplicatedStorage.events.notif:FireClient(speaker,"System","You cannot 1v1 yourself.");
					else
						game.ReplicatedStorage.events.notif:FireClient(speaker,"System","Something went wrong.");
					end
				end
			end)
			if(e and not s) then
				warn(e);
			end
		else
			game.ReplicatedStorage.events.notif:FireClient(speaker,"System","Invalid player.");
		end
	end
end)

shared.start_duel = function(p1,p2)
	game.ReplicatedStorage.events.makeMsg:FireAllClients(p1.Name .. " is 1v1'ing " .. p2.Name);
	local interact = workspace.Arena.Interact;

	local arena = workspace:WaitForChild("Arena");
	local currentGame = tick();
	inSpectators = {};
	shared.lastGame = currentGame;

	for k,v in pairs(game.Players:GetPlayers()) do
		if(v ~= p1 and v ~= p2) then
			game.ReplicatedStorage.events["1v1"]:FireClient(v,"offerTp","System");
		end
	end

	local vsText = p1.DisplayName .. " VS " .. p2.DisplayName;
	interact:Fire("setPlayers",vsText);

	local chars = {};
	interact:Fire("countdown",5,function()
		local count = 0;
		for _,char in pairs(chars) do
			char:WaitForChild("Humanoid").WalkSpeed = 16;
			count += 1;
		end
		if(count >= 2) then
			interact:Fire("musicManage","play");
		end
	end)

	interact:Fire("victoryScreech","stop");

	for key,p in pairs({p1,p2}) do
		local previous = p:GetAttribute("InstantRespawn");
		local opposite = (key == 1 and 2 or 1);
		local plr = opposite == 1 and p1 or p2;
		p:SetAttribute("in1v1",true);
		p:SetAttribute("InstantRespawn",false);
		coroutine.wrap(function()
			local lose = function(giveReward)
				giveReward = (giveReward == nil and true or giveReward);
				if(giveReward) then
					interact:Fire("musicManage","stop");
					interact:Fire("victoryScreech","play");
				end
				
				arena:SetAttribute("1v1Currently",false);
				local opposite = (key == 1 and 2 or 1);
				local plr = opposite == 1 and p1 or p2;
				local loser = opposite == 1 and p2 or p1;
				
				if(giveReward) then
					coroutine.wrap(function()
						game:GetService("RunService").Heartbeat:Wait();
						plr.leaderstats.Time.Value += (shared.get1v1reward(plr));
					end)();
				end
				
				if(giveReward) then
					game.ReplicatedStorage.events.makeMsg:FireAllClients(plr.Name .. " wins the 1v1 with " .. loser.Name);
				else
					game.ReplicatedStorage.events.makeMsg:FireAllClients(loser.Name .. " left the 1v1 in the middle of the battle.");
				end
				wait(5);
				coroutine.wrap(function()
					for k,v in pairs({p1,p2}) do
						pcall(function()
							v:LoadCharacter();
							v:SetAttribute("in1v1",false);
							p:SetAttribute("InstantRespawn",previous);
						end)
					end
					for s,v in pairs(inSpectators) do
						pcall(function()
							s:LoadCharacter();
						end)
					end
					inSpectators = {};
				end)();
				shared.lastGame = nil;
			end
			local c;
			c = p.CharacterAdded:Connect(function(char)
				chars[p] = char;
				char:SetAttribute("immune",plr.Name);
				c:Disconnect();
				char:WaitForChild("Humanoid").WalkSpeed = 0;
				local hrp = char:WaitForChild("HumanoidRootPart");
				wait();
				hrp.CFrame = arena["Spawn"..key].CFrame;
				char.Humanoid.Died:Connect(lose);
			end)
			p:LoadCharacter();
			game:GetService("Players").PlayerRemoving:Connect(function(pl)
				if(pl == p) then
					if(shared.lastGame == currentGame) then
						lose(false);
					end
				end
			end)
		end)();
	end
end

local customSounds = {};
shared.handle_sound = function(sound)
	table.insert(customSounds,sound);
	sound.RollOffMaxDistance = 350;
	coroutine.wrap(function()
		while wait() do
			if(sound:GetFullName() == sound.Name) then
				table.remove(customSounds,table.find(customSounds,sound));
				break;
			end
		end
	end)();
	game:GetService("ReplicatedStorage"):WaitForChild("updateSounds"):FireAllClients();
end

game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("getSounds").OnServerInvoke = function(player)
	--[[local sounds = {};
	for k,v in pairs(swords) do
		for _,descendant in pairs(v:GetDescendants()) do
			if(descendant:IsA("Sound")) then
				table.insert(sounds,descendant);
			end
		end
	end
	for k,v in pairs(customSounds) do
		table.insert(sounds,v);
	end--]]
	return customSounds;
end

game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("pickSlot").OnServerEvent:Connect(function(player,slotNumber,item)
	if(slotNumber > 0 and slotNumber < 6) then
		for itemName,value in pairs(player:WaitForChild("Inventory"):GetAttributes()) do
			if(itemName == item and value) then
				for name,i in pairs(player.Inventory.Selected:GetAttributes()) do
					if(i == item) then
						player.Inventory.Selected:SetAttribute(name,"Sword");
					end
				end
				player.Inventory.Selected:SetAttribute("Slot"..tostring(math.floor(slotNumber)),item);
				updateBackpack(player);
				break;
			end
		end
	end
end)

players.PlayerAdded:Connect(onJoined);
for _,player in pairs(players:GetPlayers()) do
	coroutine.wrap(function()
		onJoined(player);
	end)();
end

shared.update_user = function(player,passes)
	for k,v in pairs(passes) do
		player:SetAttribute(k:gsub(string.char(32),""),v);
		if(table.find(uniqueItemPasses,k) and v) then
			shared.modify_item(player,k,true);
		elseif(k == "Signs" and v) then
			shared.modify_item(player,"Image_Sign",true);
			shared.modify_item(player,"Text_Sign",true);
		end
	end
	check(player);
	shared.setup_tags(player,passes);
end

local e = 0;
local tips = config.tips;

coroutine.wrap(function()
	while true do
		wait(200,500);
		e += 1;
		if(e > #tips) then
			e = 1;
		end
		game.ReplicatedStorage.events.makeMsg:FireAllClients(tips[e]);
	end
end)();

coroutine.wrap(function()
	while true do
		wait(math.random(500,2000));
		shared.timerain("Game",math.random(1,5),1.25);
	end
end)();