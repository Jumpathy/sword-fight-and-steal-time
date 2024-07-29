local format = require(script:WaitForChild("format"));
local overheads = {};
local overheadData = {};

local wrapEvent = function(event)
	local eventWrapper = {
		Event = {};
	};

	function eventWrapper:Fire(...)
		event:Fire(...);
	end

	function eventWrapper:Connect(callback)
		callback();
		return event.Event:Connect(callback);
	end

	return eventWrapper;
end

local handle = function(tbl)
	return overheads;
end

local link = function(player)
	overheadData[player] = {
		rainbow = false,
		color = Color3.fromRGB(255,255,255),
		changed = wrapEvent(Instance.new("BindableEvent"));
	}

	local data = overheadData[player];

	local character = function(char)
		local humanoid = char:WaitForChild("Humanoid");
		if(data.lastConnection) then
			data.lastConnection:Disconnect();
			data.lastConnection = nil;
		end

		local s,e = pcall(function()
			local overhead = script:WaitForChild("Overhead"):Clone();
			overhead.Username.Rainbow.Disabled = false;
			overhead.Username.Text = (player:GetAttribute("tag") and player:GetAttribute("tag").." " or "")..player.DisplayName;
			overhead.Parent = char:WaitForChild("Head");
			overheads[player] = overhead;

			local timeLink = function(value)
				pcall(function()
					overhead.Time.Text = format.FormatStandard(value);
				end)
			end
			timeLink(player:WaitForChild("leaderstats",50):WaitForChild("Time").Value);
			player.leaderstats.Time.Changed:Connect(function()
				game.ReplicatedStorage.events.onOverhead:FireAllClients(handle());
				timeLink(player.leaderstats.Time.Value);
			end)

			overhead.Time.Visible = player:GetAttribute("timeEnabled");
			player.AttributeChanged:Connect(function(name)
				game:GetService("RunService").Heartbeat:Wait();
				pcall(function()
					overhead.Time.Visible = player:GetAttribute("timeEnabled");
					overhead.Username.Text = (player:GetAttribute("tag") and player:GetAttribute("tag").." " or "")..player.DisplayName;
					overheadData[player].changed:Fire();
				end)
			end)

			humanoid.Changed:Connect(function()
				game.ReplicatedStorage.events.onOverhead:FireAllClients({[1] = overhead});
			end)

			data.lastConnection = data.changed:Connect(function()
				game.ReplicatedStorage.events.onOverhead:FireAllClients(handle());
				overhead.Time.TextColor3 = Color3.fromRGB(255,255,0);
				overhead.Username.RainbowEnabled.Value = data.rainbow;
				if(data.rainbow) then
					overhead.Username.TextColor3 = Color3.fromRGB(255,255,255);
				else
					overhead.Username.TextColor3 = data.color;
				end

				if(player.Name == "imAvizandum") then
					overhead.Username.RainbowEnabled.Value = data.rainbow;
					overhead.Time.TextColor3 = Color3.fromRGB(170, 255, 255);
				elseif(player.Name == "Jumpathy" and not game:GetService("RunService"):IsStudio()) then
					overhead.Time.TextColor3 = Color3.fromRGB(255,255,255);
					if(overhead.Username.Rainbow:FindFirstChild("Darkness")) then
						overhead.Username.Rainbow.Darkness.Parent = overhead.Username;
					end
				end
			end)
		end)
		if(e and not s and game:GetService("RunService"):IsStudio()) then
			warn(e);
		end
	end
	if(player.Character) then
		character(player.Character);
	end	
	player.CharacterAdded:Connect(character);
end

game.ReplicatedStorage.events.onOverhead.OnServerEvent:Connect(function(client)
	game.ReplicatedStorage.events.onOverhead:FireClient(client,handle());
end)

shared.set_overhead_enabled = function(player,bool)
	pcall(function()
		overheads[player].Enabled = bool;
	end)
end

game:GetService("Players").PlayerAdded:Connect(link);
for _,player in pairs(game:GetService("Players"):GetPlayers()) do
	link(player);
end

game:GetService("ReplicatedStorage").events.overheadInteraction.OnServerEvent:Connect(function(player,key,value)
	if(shared.getPasses(player)["Colored Username"]) then
		if(key == "setOverheadColor" and typeof(value) == "Color3") then
			overheadData[player].color = value;
			overheadData[player].changed:Fire();
		elseif(key == "setRainbow" and typeof(value) == "boolean") then
			overheadData[player].rainbow = value;
			overheadData[player].changed:Fire();
		end
	end
end)