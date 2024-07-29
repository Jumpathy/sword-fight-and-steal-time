-- Referenced by doing ``main.main:GetModule("API")``

local hd = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- << API >>
function hd:GetRankName(rankId)
	return(main:GetModule("cf"):GetRankName(rankId))
end

function hd:GetRankId(rankName)
	return(main:GetModule("cf"):GetRankId(rankName))
end

function hd:Notice(player, message)
	if main.player then
		if message then
			main:GetModule("Notices"):Notice("Notice", "Game Notice", message)
		end
	else
		main:GetModule("cf"):Notice(player, "Game Notice", message)
	end
end

function hd:Error(player, message)
	if main.player then
		if message then
			main:GetModule("Notices"):Notice("Error", "Game Notice", message)
		end
	else
		main.signals.Error:FireClient(player, {"Game Notice", message})
	end
end




return hd