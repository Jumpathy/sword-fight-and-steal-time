local key = "joined_players";
local profiles = {};

local rewards = {
	[15] = {"Starlight","Starlight"},
	[35] = {"Uni_Sword","Unicorn Sword"}
}

local handleReferences = function(player,amount,profile,justJoined)
	local sort,inventory = {},player:WaitForChild("Inventory",200);
	for amnt,data in pairs(rewards) do
		if(amount >= amnt) then
			if(inventory:GetAttribute(data[1]) == nil) then
				inventory:SetAttribute(data[1],true);
				game.ReplicatedStorage.events.notif:FireClient(player,"System","You have unlocked the '"..data[2].."' sword from having " .. amnt .. " people join you!")
				game.ReplicatedStorage.events.makeMsg:FireClient(player,"You have unlocked the '"..data[2].."' sword from having " .. amnt .. " people join you!")
			end
		else
			table.insert(sort,amnt);
		end
	end
	table.sort(sort,function(a,b)
		return(b > a) 
	end)
	if(#sort >= 1) then
		game.ReplicatedStorage.events.makeMsg:FireClient(player,"Get ".. (sort[1] - amount) .. " more players to join your profile to unlock a special sword!");
		game.ReplicatedStorage.events.notif:FireClient(player,"System","Get ".. (sort[1] - amount) .. " more players to join your profile to unlock a special sword!");
	end
end

local player = function(plr)
	repeat
		game:GetService("RunService").Heartbeat:Wait();
	until shared.onProfileLoaded[plr] ~= nil;
	
	shared.onProfileLoaded[plr]:Connect(function()
		local data = shared.profiles[plr];
		profiles[plr] = data;
		handleReferences(plr,data[key].amount,data);
	end)
	
	if(plr.FollowUserId ~= 0) then
		local followed = game:GetService("Players"):GetPlayerByUserId(plr.FollowUserId);
		if(followed) then
			repeat
				game:GetService("RunService").Heartbeat:Wait();
			until profiles[followed];
			local data = profiles[followed];
			if(data[key].amount < 300 and (not data[key][plr.UserId])) then
				data[key].amount += 1;
				data[key][plr.UserId] = true;
				handleReferences(followed,data[key].amount,data,true);
			end
		end
	end
end

game.Players.PlayerAdded:Connect(player);
for _,v in pairs(game.Players:GetPlayers()) do 
	coroutine.wrap(player)(v) 
end;