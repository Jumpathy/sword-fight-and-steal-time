local format = require(game.ServerScriptService.game.leaderboard.board.format);

local data = game:GetService("DataStoreService"):GetOrderedDataStore("release_time-1.0.0.1"):GetSortedAsync(false,100,1,math.huge);
local function iterPageItems(pages)
	return coroutine.wrap(function()
		local pagenum = 1
		while true do
			for _, item in ipairs(pages:GetCurrentPage()) do
				coroutine.yield(item, pagenum)
			end
			if pages.IsFinished then
				break
			end
			pages:AdvanceToNextPageAsync()
			pagenum = pagenum + 1
		end
	end)
end

local totalTime = 0;
for opt,_ in iterPageItems(data) do
	totalTime += opt.value;
end

print(format.FormatStandard(totalTime),"loaded")