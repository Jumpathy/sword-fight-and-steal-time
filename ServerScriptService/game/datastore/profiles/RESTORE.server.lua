coroutine.wrap(function()
	local success,result = pcall(function()
		return datastoreService:GetDataStore("data_transferred_2"):GetAsync(player.UserId);
	end)
	if(success and not result) then
		local success,dataResult = wrapper:GetAsync(player.UserId,"user-data-reset-release-1.0.0");
		if(success and dataResult) then
			local s,e = pcall(function()
				return datastoreService:GetDataStore("data_transferred_2"):SetAsync(player.UserId,true);
			end)
			if(e and not s) then
				player:Kick("[FAILED TO LOAD DATA]");
				return;
			elseif(s and not e) then
				oldSave = dataResult;
			end
		elseif(not success) then
			player:Kick("[FAILED TO LOAD DATA]");
			return;
		end
	elseif(not success) then
		player:Kick("[FAILED TO LOAD DATA]");
		return;
	end
	if(oldSave) then
		for k,v in pairs(oldSave) do
			profile["Data"][k] = v;
		end
	end
end)