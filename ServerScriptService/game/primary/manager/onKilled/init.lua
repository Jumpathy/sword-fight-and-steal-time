local format = require(script:WaitForChild("format"));

return function(killer,target,stealTime)
	if(target and not shared.paused_time) then
		local amnt = (target.leaderstats.Time.Value);
		if(stealTime) then
			killer.leaderstats.Time.Value += amnt;
			killer.leaderstats.Kills.Value += 1;
			killer.leaderstats.Streak.Value += 1;
			target.leaderstats.Streak.Value = 0;
			target.leaderstats.Deaths.Value += 1;
			target.leaderstats.Time.Value = 0;
			shared.profiles[target].Data.leaderstats.Time = 0;
		end
		if(stealTime) then
			local distance = (killer.Character.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).magnitude;
			local s,e = pcall(function()
				shared.logs_hd_admin("System",killer.Name .. " killed "..target.Name.." from "..math.floor(distance).." studs and took " .. format.FormatStandard(amnt) .. " time.")
			end)
			if(e and not s) then
				warn("[ERROR LOGGING KILL]",e);
			end
			game.ReplicatedStorage.events.killfeed:FireAllClients(killer.DisplayName,target.DisplayName,math.floor(distance)); 
		end
		if(killer:GetAttribute("InstantRegen")) then
			killer.Character.Humanoid.Health = killer.Character.Humanoid.MaxHealth;
		end
	end
end