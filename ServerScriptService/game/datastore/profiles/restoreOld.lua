local http = game:GetService("HttpService");

return function(player,key,profile)
	if(not profile.Data.restoredData) then
		local success,response = pcall(function()
			return http:JSONDecode(http:GetAsync(
				"https://rbxdta.glitch.me/get/" .. key .. "/plr-" .. player.UserId
			));
		end)
		if(response and success) then
			if(not response.failed) then
				profile.Data = response.Data;
				profile.Data.restoredData = true;
			end
		elseif(not success) then
			warn(response);
		end
	end
end