-- Referenced by doing ``main.main:GetModule("API")``

local hd = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain




-- << VARIABLES >>
local errors = {
	Player = "Player does not exist!";
}



-- << API >>
function hd:DisableCommands(player, boolean)
	if boolean then
		main.commandBlocks[player] = true
		local pdata = main.pd[player]
		if pdata and pdata.Donor then
			main:GetModule("Parser"):ParseMessage(player, "!unlasereyes", false)
		end
	else
		main.commandBlocks[player] = nil
	end
end


function hd:SetRank(player, rank, rankType)
	if tonumber(rank) == nil then
		rank = main:GetModule("cf"):GetRankId(rank)
	end
	if not player then
		return(errors.Player)
	elseif rank > 5 or (rank == 5 and player.UserId ~= main.ownerId) then
		return("Cannot set a player's rank above or equal to 5 (Owner)!")
	else
		main:GetModule("cf"):SetRank(player, main.ownerId, rank, rankType)
	end
end


function hd:UnRank(player)
	main:GetModule("cf"):Unrank(player)
end


function hd:GetRank(player)
	local pdata = main.pd[player]
	if not pdata then
		return 0, errors.Player
	else
		local rankId = pdata.Rank
		local rankName = main:GetModule("cf"):GetRankName(rankId)
		local rankType = main:GetModule("cf"):GetRankType(player)
		return rankId, rankName, rankType
	end
end



return hd