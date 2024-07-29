local module = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- << VARIABLES >>
local settingUpPlayer = {}



-- << LOCAL FUNCTIONS >>
local function playerAdded(player)
	
	-- Character Added
	player.CharacterAdded:Connect(function(character)
		
		--Check if any commands need re-activating
		local humanoid = character:WaitForChild("Humanoid")
		local pdata = main.pd[player]
		if pdata then
			for commandName,_ in pairs(pdata.CommandsActive) do
				local speaker = player
				local args = {player}
				local command = main.commands[string.lower(commandName)]
				main:GetModule("cf"):ExecuteCommand(speaker, args, command, {ExtraDetails = {DontForceActivate = true}})
				--main:GetModule("Extensions"):SetupCommand(player, commandName, true)
			end
			for itemName, _ in pairs(pdata.Items) do
				main:GetModule("Extensions"):SetupItem(player, itemName, true)
			end
		end
		
		--Other
		wait(1)
		if settingUpPlayer[player] then
			repeat wait(0.1) until not settingUpPlayer[player]
		end
		
	end)
	
	--Check if loader banned
	local userId = player.UserId
	if main.banned[tostring(userId)] then
		player:Kick("\n\nYou're permanently banned from this game.\n\n")
	end
	
	-- Setup PlayerData
	settingUpPlayer[player] = true
	local pdata = main:GetModule("PlayerData"):SetupPlayerData(player)
	settingUpPlayer[player] = nil
	
	--Player Chatted
	if not main.players:GetPlayerByUserId(userId) then return end
	player.Chatted:Connect(function(message)
		main.signals.PlayerChatted:Fire(player, message)
		main:GetModule("Parser"):ParseMessage(player, message, true)
	end)
	
	--Setup Friends
	local friends = main:GetModule("cf"):GetFriends(userId)
	if not main.pd[player] then return end
	main.pd[player].Friends = friends
	
	-- Check if default settings have changed
	if not main.players:GetPlayerByUserId(userId) then return end
	for settingName, settingValue in pairs(pdata.DefaultSettings) do
		local defaultSettingValue = main.settings[settingName]
		--print(settingName.." : "..tostring(defaultSettingValue).." : ".. tostring(settingValue))
		if defaultSettingValue ~= settingValue then
			main.pd[player].DefaultSettings[settingName] = defaultSettingValue
			main:GetModule("PlayerData"):ChangeStat(player, settingName, defaultSettingValue)
		end
	end
	
	--
	main:GetModule("PlayerData"):ChangeStat(player, "SetupData", true)
	--
	
	
	
	-- << SETUP RANKS >>
	--Owner
	if userId == main.ownerId or main:GetModule("cf"):FindValue(main.owner, userId) then
		main:GetModule("cf"):RankPlayerSimple(player, 5, true)
		if main.oldLoader then
			main.signals.ShowWarning:FireClient(player, "OldLoader")
		end
	end
	
	--Check if player has admin in this server
	local serverRank = main.serverAdmins[player.Name]
	if serverRank then
		main:GetModule("cf"):RankPlayerSimple(player, serverRank)
	end
	
	--Specific User
	local specificUserRank = main.permissions.specificUsers[player.Name]
	if specificUserRank then
		main:GetModule("cf"):RankPlayerSimple(player, specificUserRank, true)
	end
	
	--Gamepasses
	for gamepassId, gamepassInfo in pairs(main.permissions.gamepasses) do
		local hasGamepass = false
		if main:GetModule("cf"):FindValue(pdata.Gamepasses, gamepassId) then
			hasGamepass = true
			
		elseif main.marketplaceService:UserOwnsGamePassAsync(userId, gamepassId) then
			hasGamepass = true
			main:GetModule("PlayerData"):InsertStat(player, "Gamepasses", gamepassId)
			main:GetModule("cf"):CheckAndRankToDonor(player, pdata, gamepassId)
		end
		if hasGamepass then
			main:GetModule("cf"):RankPlayerSimple(player, gamepassInfo.Rank, true)
		end
	end
		
	--Assets
	if not main.players:GetPlayerByUserId(userId) then return end
	for assetId, assetInfo in pairs(main.permissions.assets) do
		local hasAsset = false
		if main:GetModule("cf"):FindValue(pdata.Assets, assetId) then
			hasAsset = true
		elseif main.marketplaceService:PlayerOwnsAsset(player, assetId) then
			hasAsset = true
			main:GetModule("PlayerData"):InsertStat(player, "Assets", assetId)
		end
		if hasAsset then
			main:GetModule("cf"):RankPlayerSimple(player, assetInfo.Rank, true)
		end
	end
		
	--Groups
	if not main.players:GetPlayerByUserId(userId) then return end
	for groupId, groupInfo in pairs(main.permissions.groups) do
		local roleName = player:GetRoleInGroup(groupId)
		if groupInfo.Roles[roleName] then
			main:GetModule("cf"):RankPlayerSimple(player, groupInfo.Roles[roleName].Rank, true)
		end
	end
	
	--Friends
	if not main.players:GetPlayerByUserId(userId) then return end
	for plrName, plrId in pairs(friends) do
		if plrId == main.ownerId then
			main:GetModule("cf"):RankPlayerSimple(player, main.permissions.friends, true)
		end
	end
	
	--VIPServers
	local vipServerOwnerId = game.VIPServerOwnerId
	if vipServerOwnerId ~= 0 then
		if userId == vipServerOwnerId then
			main:GetModule("cf"):RankPlayerSimple(player, main.permissions.vipServerOwner, true)
		else
			main:GetModule("cf"):RankPlayerSimple(player, main.permissions.vipServerPlayer, true)
		end
	end
	
	--Free admin
	local freeAdminRank = main.permissions.freeAdmin
	if tonumber(freeAdminRank) and freeAdminRank > 0 then
		main:GetModule("cf"):RankPlayerSimple(player, freeAdminRank, true)
	end
	
	
	
	-- << CHECK FOR SERVER LOCK >>
	if pdata.Rank < main.ranksAllowedToJoin then
		player:Kick("The server has been locked for ranks below '".. main:GetModule("cf"):GetRankName(main.ranksAllowedToJoin).."'")
		for i, plr in pairs(main.players:GetChildren()) do
			main.signals.Hint:FireClient(plr, {"Standard", "Server Lock: "..player.Name.." attempted to join! Rank = '"..main:GetModule("cf"):GetRankName(pdata.Rank).."'", Color3.fromRGB(255,255,255)})
		end
	end
	
	
	
	-- << CHECK IF BANNED >>
	--local success, record = false, main.serverBans[main:GetModule("cf"):FindUserIdInRecord(main.serverBans, userId)]
	local success, record = pcall(function() return main.serverBans[main:GetModule("cf"):FindUserIdInRecord(main.serverBans, userId)] end)
	if not record then
		success, record = pcall(function() return main.sd.Banland.Records[main:GetModule("cf"):FindUserIdInRecord(main.sd.Banland.Records, userId)] end)
	end
	if success and record then
		main:GetModule("cf"):BanPlayer(player.UserId, record)
	end
	
	
	
	-- << CHECK PERM RANK AND RANK EXISTS >>
	if pdata.SaveRank and main:GetModule("cf"):GetRankName(pdata.Rank) == "" then
		main:GetModule("cf"):Unrank(player)
	end
	
	
	
	-- << START COLOUR >>
	wait(2)
	if not main.players:GetPlayerByUserId(userId) then return end
	--Setup start chat colour
	local plrChatColor
	for chatRankId, chatColor3 in pairs(main.settings.ChatColors) do
		if pdata.Rank == chatRankId then
			plrChatColor = chatColor3
			break
		end
	end
	if plrChatColor then
		local speaker = main.chatService:GetSpeaker(player.Name)
		if not speaker then
			local maxRetries = 10
			for i = 1,maxRetries do
				wait(0.5)
				if not main.players:GetPlayerByUserId(userId) then return end
				speaker = main.chatService:GetSpeaker(player.Name)
				if speaker then
					break
				end
			end
		end
		if speaker then
			speaker:SetExtraData("ChatColor", plrChatColor)
		end
	end
	
	
	
	-- << NOTICES >>
	wait(1)
	if not main.players:GetPlayerByUserId(userId) then return end
	if pdata.Rank > 0 and main.settings.WelcomeRankNotice ~= false then
		local rankName = main:GetModule("cf"):GetRankName(pdata.Rank)
		main:GetModule("cf"):FormatAndFireNotice(player, "WelcomeRank", rankName)
	end
	if pdata.Donor and main.settings.WelcomeDonorNotice ~= false then
		main:GetModule("cf"):DonorNotice(player, pdata)
	end
	--main.signals.FadeInIcon:FireClient(player)
	
		
end





-- << SETUP >>
--Player added, setup playerMain
game.Players.PlayerAdded:Connect(function(player)
	playerAdded(player)
end)

--Player removing
main.players.PlayerRemoving:Connect(function(player)
	--
	main.permissionToReplyToPrivateMessage[player] = nil
	main.commandBlocks[player] = nil
	--
	local pdata = main.pd[player]
	if pdata then
		for itemName, item in pairs(pdata.Items) do
			item:Destroy()
		end
		local underControl = pdata.Items["UnderControl"]
		if underControl then
			local controller = underControl.Value
			if controller then
				main:GetModule("cf"):RemoveControlPlr(controller)
			end
		end
	end
	for i, plr in pairs(main.players:GetChildren()) do
		local plrData = main.pd[plr]
		if plrData then
			local tag = plrData.Items["UnderControl"]
			if tag and tag.Value == player then
				main:GetModule("cf"):RemoveUnderControl(plr)
			end
		end
	end
	--
	main:GetModule("PlayerData"):RemovePlayerData(player)
	--
end)


--Setup fast joiners
spawn(function()
	wait(1)
	for _,player in pairs(main.players:GetChildren()) do
		if not main.pd[player] and not settingUpPlayer[player] then
			playerAdded(player)
		end
	end
end)




return module