local datastoreModule = {};
local cache = {};
local save = require(script:WaitForChild("method"));

function datastoreModule:SetAsync(ds,key,value,player)
	if(not shared.profiles[player] and game.PlaceId == 1) then
		local scope = 0;
		local masterKey = string.format("%s-%s(%s)",ds,key,scope)
		local datastore;
		
		if(cache[masterKey] ~= nil) then
			datastore = cache[masterKey];
		else
			datastore = save.new(ds,key,scope);
			cache[masterKey] = datastore;
		end
		
		if(datastore ~= nil) then
			return datastore:save(value);
		else
			return nil;
		end
	end
end

function datastoreModule:GetAsync(ds,key,scope,player)
	if(scope == nil) then
		scope = 0;
	end
	local masterKey = string.format("%s-%s(%s)",ds,key,scope)
	local datastore;
	
	if(cache[masterKey] ~= nil) then
		datastore = cache[masterKey];
	else
		datastore = save.new(ds,key,scope);
		cache[masterKey] = datastore;
	end
	
	if(datastore ~= nil) then
		return datastore:get();
	else
		return nil;
	end
end

return datastoreModule;