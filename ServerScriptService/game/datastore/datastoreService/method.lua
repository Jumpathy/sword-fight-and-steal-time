--[[
CREDITS: bereza, kampfkarren (learned from their source code and created my own implementations of certain functions.
--]]

-- i do not feel like explaining this code LOL

local module = {};
local datastoreService = game:GetService("DataStoreService");

local behavior = {};
behavior.__index = behavior;

local getLastKey = function(ds)
	local success,result = pcall(function()
		return ds:GetSortedAsync(false, 1):GetCurrentPage()[1];
	end)
	
	if(not success) then
		return false,result;
	else
		if(result) then
			return true,result.value;
		else
			return false,nil;
		end
	end
end

function behavior:get()
	self.fetchedYet = true;
	
	local success,result = pcall(function()
		return self.ordered:GetSortedAsync(false, 1):GetCurrentPage()[1];
	end)
	
	if not success then
		warn(result);
		return false,result;
	end
	
	local page = result;
	if(page ~= nil) then
		local key = page.value;
		self.lastKey = key;
				
		local success,result = pcall(function()
			return self.main:GetAsync(key);
		end)
				
		if success then
			return true,result;
		else
			warn(result);
			return false,nil;
		end
	else
		return true,nil;
	end
end

function behavior:save(value)
	local key = (self.lastKey or 0) + 1;
	
	if(not self.fetchedYet) then
		local success,response = getLastKey(self.ordered);
		if(success) then
			if(response ~= nil and type(response) == "number") then
				key = response + 1;
				self.lastKey = key;
			end
		end
	end
	
	local success,err = pcall(function()
		self.main:SetAsync(key,value);
	end)
	
	if not success then
		warn(err);
		return false,err;
	end
	
	local success,err = pcall(function()
		self.ordered:SetAsync(key,key)
	end)
	
	if not success then
		warn(err);
		return false,err;
	end
	
	self.lastKey = key;
	return true,nil;
end

function behavior:getKeys()
	local success,result = pcall(function()
		return self.ordered:GetSortedAsync(true,100);
	end)
		
	if(success and result) then
		local response = {};
		local pages = result;
		
		while true do
			local data = pages:GetCurrentPage();
			for _,entry in pairs(data) do
				table.insert(response,entry.value)
			end
			
			if pages.isFinished then
				break;
			else
				pages:AdvanceToNextPageAsync();
			end
		end
				
		return true,response;
	else
		if(not success) then
			warn(result);
			return false,result;
		else
			return true,nil;
		end
	end
end

function behavior:getSave(key)
	local success,result = pcall(function()
		return self.main:GetAsync(key);
	end)
	if(not success) then
		warn(result);
	end
	return success,result;
end

function module.new(datastoreName,key,scope)	
	if(scope == 0) then
		scope = nil;
	end
	
	local key = datastoreName.."-"..tostring(key);
	
	local data = {
		main = datastoreService:GetDataStore(key,scope);
		ordered = datastoreService:GetOrderedDataStore(key,scope);
		mainKey = key;
		fetchedYet = false;
	};
	
	return setmetatable(data,behavior)
end

return module;