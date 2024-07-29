local o_clock = os.clock;
local c_yield = coroutine.yield;
local c_running = coroutine.running;
local c_resume = coroutine.resume;

local yields = {};
game:GetService("RunService").Stepped:Connect(function()
	local clock = o_clock();
	for index,data in next,yields do
		local spent = clock - data[1];
		if(spent >= data[2]) then
			yields[index] = nil;
			c_resume(data[3],spent,clock);
		end
	end
end)

return function(waitTime)
	waitTime = (type(waitTime) ~= "number" or waitTime < 0) and 0 or waitTime;
	table.insert(yields,{o_clock(),waitTime,c_running()})
	return c_yield()
end