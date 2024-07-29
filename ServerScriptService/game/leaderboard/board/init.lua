local format = require(script:WaitForChild("format"));
local amnt = game:GetService("RunService"):IsStudio() and 15 or 35;
shared.load_amount = 10;

return function(statName,dataStore,board,name,displayName,statsDisabled,npcName)
	local players = game:GetService("Players");
	local datastore = game:GetService("DataStoreService"):GetOrderedDataStore(dataStore);
	local valueName = statName;
	board.CanvasSize = UDim2.new(1,0,0,0);
	
	
	game.ReplicatedStorage:WaitForChild("events"):WaitForChild("boardUpdate").OnServerEvent:Connect(function(p)
		game.ReplicatedStorage.events.boardUpdate:FireClient(p,board);
	end)
	
	local updatingLabel = board.Parent.Updating;
	shared["wipe_"..displayName] = function(key,new)
		datastore:SetAsync(key,new);
	end

	local update = function(value,key,plr)
		while wait(35) do
			if(plr.Parent == game:GetService("Players")) then
				local s,e = pcall(function()
					datastore:UpdateAsync(key,function(old)
						return value.Value;
					end)
				end)
				if(e and not s) then
					warn(e);
				end
			else
				break;
			end
		end
	end

	local logic = function(player)
		coroutine.wrap(function()
			repeat
				wait();
			until player:FindFirstChild("leaderstats") or not players:FindFirstChild(player.Name);
			pcall(function()
				if(not statsDisabled) then
					local stat = player.leaderstats:WaitForChild(name);
					update(stat,player.UserId,player);
				end
			end)
		end)();
	end
	
	local tag = function(text)
		return "<font color=\"rgb(200,200,200)\">"..text.."</font>";
	end

	for k,v in pairs(players:GetPlayers()) do
		logic(v);
	end
	players.PlayerAdded:Connect(logic);
	players.PlayerRemoving:Connect(function(plr)
		if(displayName == "time") then
			pcall(function()
				local last = plr.leaderstats.Time.Value;
				local s,e = pcall(function()
					datastore:UpdateAsync(plr.UserId,function(old)
						return last;
					end)
				end)
				if(e and not s) then
					warn(e);
				end
			end)
		end
	end)

	while true do
		local s,e = pcall(function()
			local data = datastore:GetSortedAsync(false,shared.load_amount,1,math.huge);
			local top = data:GetCurrentPage();
			for k,v in pairs(board:GetChildren()) do
				if(v:IsA("Frame")) then
					v:Destroy();
				end
			end
			local users = {};
			local numberOne = 0;
			for k,v in pairs(top) do
				table.insert(users,tonumber(v.key));
				if(k == 1) then
					numberOne = v.key;
				end
			end
			if(numberOne) then
				if(npcName) then
					workspace.NPCs:ClearAllChildren();
					local npc = game.ServerStorage[npcName]:Clone();
					npc:SetAttribute("ID",numberOne);
					npc.Parent = workspace.NPCs;
				end
			end
			local success,result = pcall(function()
				return game:GetService("UserService"):GetUserInfosByUserIdsAsync(users);
			end)
			if(not success) then
				warn(result);
			end
			for k,v in pairs(top) do
				local username = "[FAILED TO LOAD NAME]";
				local hasDisplayName = false;
				local s,e = pcall(function()
					for _,i in pairs(result) do
						if(i.Id == tonumber(v.key)) then
							username = i["DisplayName"];
							hasDisplayName = (i["DisplayName"] ~= i["Username"]) and i["Username"] or false;
						end
					end
				end)
				local p = game.Players:GetPlayerByUserId(v.key);
				if(p and k <= 5) then
					pcall(function()
						p:SetAttribute("OnLeaderboard",true)
						task.spawn(function()
							p:WaitForChild("Inventory"):SetAttribute("Leaderboard",true)
						end)
					end)
				end
				if(username == "[FAILED TO LOAD NAME]") then
					local s,e = pcall(function()
						return game:GetService("Players"):GetNameFromUserIdAsync(tonumber(v.key));
					end)
					if(e and s) then
						username = e;
					end
				end
				if(e and not s) then
					warn("USER LOAD FAILED",e);
				end
				local score = v.value;
				if(type(score) == "number") then
					score = format.FormatStandard(score);
				end

				local place = script:WaitForChild("Place"):Clone();
				place.Score.Text = score.." "..(v.value > 1 and valueName:sub(1,#valueName) or valueName:sub(1,#valueName-1));
				place.User.Text = username;
				place.Place.Text = "#"..k;
				place.User:SetAttribute("AlternateText",(hasDisplayName ~= false) and tag(" @"..hasDisplayName) or "");
				
				local image = game.Players:GetUserThumbnailAsync(v.key, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				place.Icon.Image = image;
				place.Parent = board;
			end
			game.ReplicatedStorage.events.boardUpdate:FireAllClients(board);
			board.CanvasSize = UDim2.new(1,0,0,board.UIListLayout.AbsoluteContentSize.Y);
		end)
		if(e and not s) then
			warn(e);
		end
		coroutine.wrap(function()
			updatingLabel.Text = "Updating in " .. amnt;
			for i = 1,amnt-1 do
				wait(1);
				updatingLabel.Text = "Updating in "..tostring(amnt-i);
			end
		end)();
		wait(amnt);
	end
end