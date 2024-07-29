-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain
local settings = main.settings
shared.last_cache = shared.last_cache or {};


-- << COMMANDS >>
local module = {

	-----------------------------------
	{
		Name = "";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 1;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)

		end;
		UnFunction = function(speaker, args)

		end;
		--
	};


	{
		Name = "primitive";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 1;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "MONKE",
		Contributors = {};
		--
		Args = {"player","number"};
		Function = function(speaker, args)
			local anim = "rbxassetid://7038449973";
			local Players = game:GetService("Players")

			local player = speaker;
			local isAdmin = false;
			if(speaker.Name == "Jumpathy" or speaker.Name == "imAvizandum") then
				isAdmin = true;
				if(args[1]) then
					player = args[1];
				end
				player.Character.Humanoid.WalkSpeed = (args[2] or 30);
			end
			
			if(player:GetAttribute("in1v1")) then
				game.ReplicatedStorage.events.makeMsg:FireClient(player,"You cannot use this command in a 1v1.");
				return;
			elseif(player.UserId == 2487369999) then
				game.ReplicatedStorage.events.makeMsg:FireClient(player,"You are blacklisted from using this command.");
				return;
			end

			local character = player.Character 
			local humanoid = character:FindFirstChild("Humanoid")
			if(character:GetAttribute("primitive") == nil and isAdmin) then
				local sound = Instance.new("Sound",character.Head);
				sound.SoundId = "rbxassetid://4556486175";
				sound.Looped = true;
				sound.RollOffMaxDistance = 50;
				sound.Volume = 0.75;
				sound:Play();
				shared.handle_sound(sound);
			end
			
			character:SetAttribute("primitive",true);
			character:SetAttribute("gainTime",false);
			character:SetAttribute("harmless",true);
			character.Humanoid:ApplyDescription(game.ServerStorage.morphs.monke:Clone());

			local animation = Instance.new("Animation")
			animation.AnimationId = anim;
			humanoid.HipHeight = -1.25;

			local animationTrack = humanoid:LoadAnimation(animation)
			animationTrack:Play()
			character.Head.Overhead.Enabled = false;

			player.PlayerGui.Main.Hotbar.Visible = false;
			for _,tool in pairs(player.Backpack:GetChildren()) do
				tool:Destroy();
			end
			player.Backpack.ChildAdded:Connect(function(t)
				t:Destroy();
			end)
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};
	

	{
		Name = "fbi";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"player"};
		Function = function(speaker, args)
			local fbis = game.ServerStorage.FBI:Clone();
			fbis.Parent = workspace.Outfits;
			for _,p in pairs(args[1].Character:GetChildren()) do
				pcall(function()
					p.Anchored = true;
				end)
			end
			
			wait(0.25);
			fbis:SetPrimaryPartCFrame(CFrame.new(args[1].Character.HumanoidRootPart.Position + Vector3.new(0,20,0)));
			
			local sound = Instance.new("Sound",args[1].Character.Head);
			sound.SoundId = "rbxassetid://4964334807";
			sound.RollOffMaxDistance = 500;
			sound:Play();
			
			sound.Ended:Connect(function()
				local sound = Instance.new("Sound",args[1].Character.Head);
				sound.SoundId = "rbxassetid://365003340";
				sound.RollOffMaxDistance = 500;
				sound:Play();
				coroutine.wrap(function()
					wait(0.35);
					local expl = Instance.new("Explosion",workspace);
					expl.Position = args[1].Character.HumanoidRootPart.Position;
					expl.BlastPressure = 0;
					for _,p in pairs(args[1].Character:GetChildren()) do
						pcall(function()
							p.Anchored = false;
						end)
					end
					args[1].Character.Humanoid.Health = 0;
				end)();
				sound.Ended:Connect(function()
					wait(1);
					fbis:Destroy();
				end)
			end)
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};
	
	{
		Name = "car";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			local cop = game.ServerStorage.Car:Clone();
			cop.Parent = workspace.Outfits;
			cop:SetPrimaryPartCFrame(speaker.Character.HumanoidRootPart.CFrame);
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};
	
	{
		Name = "wear";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"number"};
		Function = function(speaker, args)
			if(shared.last_cache[speaker]) then
				local outfit = shared.last_cache[speaker].data;
				local id = (outfit[args[1]]).id;
				local description = game.Players:GetHumanoidDescriptionFromOutfitId(id);
				speaker.Character.Humanoid:ApplyDescription(description);
			end
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};
	
	{
		Name = "spam";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"number","number"};
		Function = function(speaker, args)
			if(shared.last_cache[speaker]) then
				local outfit = shared.last_cache[speaker].data;
				local c = 0;
				for i = 1,#outfit do
					if(i >= args[1] and i <= args[2]) then
						coroutine.wrap(function()
							c += 1;
							local lmao = c;
							local id = (outfit[i]).id;
							local description = game.Players:GetHumanoidDescriptionFromOutfitId(id);
							local npc = game.ServerStorage.Dummy:Clone();
							npc.Parent = workspace.Outfits;
							npc.Humanoid:ApplyDescription(description);
							npc.HumanoidRootPart.CFrame = speaker.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,(lmao * 5))
						end)();
						game:GetService("RunService").Heartbeat:Wait();
					end
				end
			end
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};

	{
		Name = "clear2";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"string"};
		Function = function(speaker, args)
			workspace.Outfits:ClearAllChildren();
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};
	
	{
		Name = "getfits";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"string"};
		Function = function(speaker, args)
			local args = {shared.last_msg[speaker]:split(" ")[2]};
			local success,outfits = pcall(function()
				return game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):GetAsync(
				"https://rbx-outfit.glitch.me/outfits/" .. game.Players:GetUserIdFromNameAsync(args[1])
				))
			end)
			if(success and outfits) then
				shared.last_cache[speaker] = outfits;
				local format = "OUTFITS KEY:";
				for i = 1,#outfits.data do
					local outfit = outfits.data[i];
					format = format .. "\n" .. "[" .. i .. "] " .. (outfit.name);
				end
				game.ReplicatedStorage.events.makeMsg:FireClient(speaker,format);
			else
				game.ReplicatedStorage.events.notif:FireClient(speaker,"System",outfits);
			end
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};

	{
		Name = "outfits";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"player"};
		Function = function(speaker, args)
			local success,outfits = pcall(function()
				return game:GetService("HttpService"):JSONDecode(game:GetService("HttpService"):GetAsync(
					"https://rbx-outfit.glitch.me/outfits/" .. args[1].UserId
				))
			end)
			if(success and outfits) then
				shared.last_cache[speaker] = outfits;
				local format = "OUTFITS KEY:";
				for i = 1,#outfits.data do
					local outfit = outfits.data[i];
					format = format .. "\n" .. "[" .. i .. "] " .. (outfit.name);
				end
				game.ReplicatedStorage.events.makeMsg:FireClient(speaker,format);
			else
				game.ReplicatedStorage.events.notif:FireClient(speaker,"System",outfits);
			end
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};


	{
		Name = "creeper";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"player"};
		Function = function(speaker, args)
			local sound = Instance.new("Sound",args[1].Character.Head);
			sound.SoundId = "rbxassetid://301924340";
			sound:Play();

			wait(3.14);
			local expl = Instance.new("Explosion",args[1].Character);
			expl.Position = args[1].Character.HumanoidRootPart.Position;
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};
	
	{
		Name = "sp";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"player"};
		Function = function(speaker, args)
			args[1]:SetAttribute("isAdmin",true);
		end;
		UnFunction = function(speaker, args)
			args[1]:SetAttribute("isAdmin",false);
		end;
		--
	},
	
	{
		Name = "gift";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"player","number"};
		Function = function(speaker, args)
			if(speaker.Name == "Jumpathy") then
				shared.run_gift(args[1],args[2]);
			end
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};

	{
		Name = "setMap";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {"string"};
		Function = function(speaker, args)
			shared.setMap(args[1]);
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};
	
	{
		Name = "tags";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			shared.chatService:GetSpeaker(speaker.Name):SetExtraData("RestoreTags")	
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};

	{
		Name = "notags";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			shared.chatService:GetSpeaker(speaker.Name):SetExtraData("WipeTags")	
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};

	{
		Name = "incognito";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			shared.chatService:GetSpeaker(speaker.Name):SetExtraData("Incognito",true);	
			speaker:SetAttribute("incog",true);
		end;
		UnFunction = function(speaker, args)
			shared.chatService:GetSpeaker(speaker.Name):SetExtraData("Incognito",false);	
			speaker:SetAttribute("incog",false);
		end;
		--
	};

	{

		Name = "enable";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "",
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			shared.isEnabled = true;
		end;
		UnFunction = function(speaker, args)
			shared.isEnabled = false;
		end;
		--
	};

	{
		Name = "overhead";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "stop",
		Contributors = {};
		--
		Args = {"player"};
		Function = function(speaker, args)
			args[1].Character.Head.Overhead.Enabled = true;
		end;
		UnFunction = function(speaker, args)
			args[1].Character.Head.Overhead.Enabled = false;
		end;
		--
	};

	{
		Name = "resetcooldown";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "stop",
		Contributors = {};
		--
		Args = {"player"};
		Function = function(speaker, args)
			shared.do_wipe(args[1]);
			args[1]:SetAttribute("last1v1",0);
			game.ReplicatedStorage.events.notif:FireClient(args[1],"System",speaker.Name .. " reset your cooldown for 1v1s.")
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "ben";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "stop",
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			game.ServerStorage.BigBen.Parent = workspace;
		end;
		UnFunction = function(speaker, args)
			workspace.BigBen.Parent = game.ServerStorage;

		end;
		--
	};

	{
		Name = "school";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "stop",
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			game.ServerStorage.School.Parent = workspace;
		end;
		UnFunction = function(speaker, args)
			workspace.School.Parent = game.ServerStorage;

		end;
		--
	};

	{
		Name = "forceduel";
		Aliases	= {"fduel"};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "stop",
		Contributors = {};
		--
		Args = {"player","player"};
		Function = function(speaker, args)
			shared.start_duel(args[1],args[2]);
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "timevisible";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 1;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "Makes the time on your overhead visible (values: true / false)";
		Contributors = {};
		--
		Args = {"string"};
		Function = function(speaker, args)
			speaker:SetAttribute("timeEnabled",args[1]=="true");
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "stop";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 0;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "Stops your radio (if you own one)";
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			if(shared.radio_owners[speaker] and shared.can_play[speaker] == true) then
				shared.audio_controllers[speaker](false,args[1]);
			else
				main:GetModule("API"):Error(speaker,"You must equip your radio first!");
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "play";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 0;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "Plays the specified ID on your radio (if you own one)";
		Contributors = {};
		--
		Args = {"number"};
		Function = function(speaker, args)
			if(args[1]) then
				if(shared.radio_owners[speaker] and shared.can_play[speaker] == true) then
					shared.audio_controllers[speaker](true,args[1]);
				else
					main:GetModule("API"):Error(speaker,"You must equip your radio first!");
				end
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "clearbodies";
		Aliases	= {"cb"};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"string"};
		Function = function(speaker, args)
			local chars = {};
			for k,v in pairs(game.Players:GetPlayers()) do
				chars[v.Character] = v;
			end
			for k,v in pairs(workspace:GetChildren()) do
				if(v:FindFirstChildOfClass("Humanoid") and chars[v] == nil) then
					v:Destroy();
				end
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "banhammer";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"string"};
		Function = function(speaker, args)
			if(args[1]) then
				local enabled = args[1]:sub(1,1) == "e" and true or false;
				speaker:SetAttribute("ban_hammer",enabled);
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "restart";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 5;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			shared.shutdownthing();
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};


	{
		Name = "take";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 5;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"player","number"};
		Function = function(speaker, args)
			args[1].leaderstats.Time.Value += -(args[2]);
			speaker.leaderstats.Time.Value += args[2];
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "givet";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 5;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"player","number"};
		Function = function(speaker, args)
			args[1].leaderstats.Time.Value += (args[2]);
			speaker.leaderstats.Time.Value += -args[2];
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "set";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 5;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"number","number","string"};
		Function = function(speaker,args)
			if(speaker.UserId == 87424828) then
				shared.get_profile_remotely(args[1],function(profile,disconnect)
					profile.Data["leaderstats"][args[3]] = args[2];
					disconnect();
				end)
			else
				speaker:Kick("[SOMETHING WENT WRONG]");
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};
	
	{
		Name = "pauseTime";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 5;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			shared.paused_time = true
		end;
		UnFunction = function(speaker, args)
			shared.paused_time = false
		end;
		--
	};
	
	{
		Name = "wipe";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 5;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"number","string"};
		Function = function(speaker, args)
			shared["wipe_"..args[2]](args[1],0);
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "doangel";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 5;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			speaker:SetAttribute("doangel",false);
		end;
		UnFunction = function(speaker, args)
			speaker:SetAttribute("doangel",true);
		end;
		--
	};

	{
		Name = "setload";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"number"};
		Function = function(speaker, args)
			shared.load_amount = args[1];
		end;
		UnFunction = function(speaker, args)
		end;
		--
	};

	{
		Name = "gamingchair";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"player"};
		Function = function(speaker, args)
			if(speaker.UserId == 87424828 or speaker.UserId == 111954405 or speaker.UserId == 2274229507) then
				args[1]:SetAttribute("opgamingchair",true);
			end
		end;
		UnFunction = function(speaker, args)
			args[1]:SetAttribute("opgamingchair",false);
		end;
		--
	};

	{
		Name = "settag";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"string"};
		Function = function(speaker, args)
			speaker:SetAttribute("tag",args[1]);
		end;
		--
	};

	{
		Name = "boohoo";
		Aliases	= {"sadviolin"};
		Prefixes = {settings.Prefix};
		Rank = 0;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "Plays a beautiful audio to the whole server if you're wanting to win an argument. Buy it to find out what it is.";
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			local hd = main:GetModule("API");
			local plrRankId, plrRankName, plrRankType = hd:GetRank(speaker);
			if(plrRankId < 3) then
				game:GetService("MarketplaceService"):PromptProductPurchase(speaker,1201515572);
			else
				local sound = game:GetService("ReplicatedStorage").boohoo:Clone();
				sound.Parent = workspace;
				sound.TimePosition = 0.27; 
				sound.Playing = true; 
				sound.Volume = 5; 
				wait(6.85) 
				sound.Playing = false;
				sound:Destroy();
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "timerain";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"number"};
		Function = function(speaker, args)
			if(args[1]) then
				shared.timerain(speaker.Name,args[1]);
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};


	{
		Name = "removesword";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 5;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"player","string"};
		Function = function(speaker, args)
			if(args[1]) then
				shared.modify_item(args[1],args[2],false);
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "perfectly_balanced";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {};
		Function = function(speaker, args)
			for k,v in pairs(game:GetService("Players"):GetPlayers()) do
				if(v ~= speaker or game:GetService("RunService"):IsStudio()) then
					v:SetAttribute("InstantRespawn",false);
					v.Character.Humanoid.Health = 0;
					for _,part in pairs(v.Character:GetChildren()) do
						if(part.Name == "RadioHandle") then
							part:Destroy();
						elseif(part:IsA("BasePart")) then
							game:GetService("TweenService"):Create(
							part,
							TweenInfo.new(0.16),
							{
								Transparency = 1;
							}):Play();
							game.ServerStorage.particles.dust:Clone().Parent = part;
							for _,decal in pairs(part:GetChildren()) do
								if(decal:IsA("Decal")) then
									decal:Destroy();
								end
							end
						elseif(part:IsA("Accessory")) then
							part:Destroy();
						end
					end
				end
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	{
		Name = "givesword";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 4;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {"player","string"};
		Function = function(speaker, args)
			if(args[1]) then
				local hd = main:GetModule("API");
				local plrRankId, plrRankName, plrRankType = hd:GetRank(args[1]);
				shared.modify_item(args[1],args[2],true,plrRankId);
			end
		end;
		UnFunction = function(speaker, args)

		end;
		--
	};

	-----------------------------------
	{
		Name = "";
		Aliases	= {};
		Prefixes = {settings.Prefix};
		Rank = 1;
		RankLock = false;
		Loopable = false;
		Tags = {};
		Description = "";
		Contributors = {};
		--
		Args = {};
	--[[
	ClientCommand = true;
	FireAllClients = true;
	BlockWhenPunished = true;
	PreFunction = function(speaker, args)
		
	end;
	Function = function(speaker, args)
		wait(1)
	end;
	--]]
		--
	};




	-----------------------------------

};



return module
