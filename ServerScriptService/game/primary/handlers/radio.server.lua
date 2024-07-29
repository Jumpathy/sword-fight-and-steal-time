local bonded = {};
local radioHandle = script:WaitForChild("Handle");
local last = {};
local sounds = {};
local canPlayLast = {};

shared.radio_owners = {};
shared.audio_controllers = {};
shared.can_play = {};

local backWeld = function(player,radio)
	local function weldBetween(a, b)
		local weld = Instance.new("ManualWeld")
		weld.Part0 = a
		weld.Part1 = b
		weld.C0 = CFrame.new()
		weld.C1 = b.CFrame:inverse() * a.CFrame
		weld.Parent = a
		return weld;
	end
	local char = player; 
	local hand = radio:Clone()
	hand.Parent=char
	hand.Name = "RadioHandle";
	hand.CFrame=char:WaitForChild("Torso").CFrame*CFrame.new(Vector3.new(0,0,1))*CFrame.Angles(0,math.rad(180),math.rad(45))
	weldBetween(char:WaitForChild("Torso"), hand)
	hand.CanCollide = false
	hand.Anchored = false
end

local func = function(plr)
	bonded[plr] = {
		event =  Instance.new("BindableEvent"),
		state = false
	}

	local char = function(character)
		if(bonded[plr].connection) then
			bonded[plr].connection:Disconnect();
			bonded[plr].connection = nil;
		end

		local sound = Instance.new("Sound");
		sound.Parent = character:WaitForChild("Torso");
		sound.RollOffMaxDistance = 500;
		sounds[plr] = sound;
		sound.Name = "Radio";
		--script:WaitForChild("compressor"):Clone().Parent = sound;

		local func = function(enabled)
			shared.audio_controllers[plr] = function(playing,id)
				if(playing) then
					last[plr] = {id = id};
					sound.TimePosition = 0;
					sound.SoundId = "rbxassetid://"..tostring(id);
					sound:Play();
				else
					last[plr] = nil;
					sound:Stop();
				end
			end

			if(enabled) then
				backWeld(character,radioHandle);
				if(last[plr]) then
					if(not (sound.TimePosition >= 0 and sound.SoundId == "rbxassetid://"..tostring(last[plr] and last[plr].id or 0))) then
						sounds[plr].TimePosition = last[plr].timePosition or 0;
						sounds[plr].SoundId = "rbxassetid://"..tostring(last[plr].id);
						sounds[plr]:Play();
					end
				end
			else
				pcall(function()
					character.RadioHandle:Destroy();
				end)
			end
		end
		bonded[plr].connection = bonded[plr].event.Event:Connect(func);
		func(bonded[plr].state);
	end
	if(plr.Character) then
		char(plr.Character);
	end
	plr.CharacterAdded:Connect(char);
	plr.CharacterRemoving:Connect(function()
		pcall(function()
			last[plr] = {
				id = last[plr].id,
				timePosition = sounds[plr].TimePosition;
			}
		end)
	end)
	local cached = {};
	local backpack = function(backpack)
		local item = function(i)
			if(i.Name == "Radio") then
				if(not cached[i]) then
					cached[i] = true;
					i.Unequipped:Connect(function()
						game:GetService("RunService").Heartbeat:Wait();
						if(bonded[plr].state == false) then
							shared.can_play[plr] = false;
							shared.audio_controllers[plr](false);
						end
					end)
				end
			end
		end
		backpack.ChildAdded:Connect(item);
		for _,i in pairs(backpack:GetChildren()) do
			item(i);
		end
	end

	backpack(plr.Backpack);
	plr.ChildAdded:Connect(function(obj)
		if(obj:IsA("Backpack")) then
			backpack(obj);
		end
	end)
end

shared.is_binded = function(plr)
	return bonded[plr].state;
end

game:GetService("ReplicatedStorage"):WaitForChild("bindRadio").Event:Connect(function(plr,enabled)
	bonded[plr].state = enabled;
	bonded[plr].event:Fire(enabled);
end)

game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("getRadioSounds").OnServerInvoke = function(plr)
	local s = {};
	for _,v in pairs(sounds) do
		table.insert(s,v);
	end
	return s;
end

game:GetService("Players").PlayerRemoving:Connect(function(p)
	sounds[p] = nil;
end)

game:GetService("Players").PlayerAdded:Connect(func);
for _,player in pairs(game:GetService("Players"):GetPlayers()) do
	func(player);
end