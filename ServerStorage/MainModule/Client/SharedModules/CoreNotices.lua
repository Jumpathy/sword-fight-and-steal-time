local module = {}
local main = _G.HDAdminMain


function module:GetNotice(noticeName)
	local coreNotices = {
	
	WelcomeRank = {
		main.hdAdminCoreName,
		"Your rank is '%s'! Click to view the commands.", -- (rankName)
		{"ShowSpecificPage", "Commands", "Commands"}
		};
	
	WelcomeDonor = {
		main.hdAdminCoreName,
		"Your're a Donor! Click to view Donor Commands.",
		{"ShowSpecificPage", "Special", "Donor"}
		};
	
	SetRank = {
		main.hdAdminCoreName,
		"You've been %sed to '%s'!" -- (rankType, rankName)
		};
	
	UnlockRank = {
		main.hdAdminCoreName,
		"You've unlocked the rank '%s'!" -- (rankName)
		};
	
	UnRank = {
		main.hdAdminCoreName,
		"You've been unranked!"
		};
	
	ParserInvalidCommandRank = {
		main.hdAdminCoreName,
		"'%s' is not a valid command! Try '%srank plr %s' instead." -- (commandName, prefix, rankName)
		};
	
	ParserInvalidCommandNormal = {
		main.hdAdminCoreName,
		"'%s' is not a valid command!", -- (commandName)
		""
		};
	
	ParserInvalidPrefix = {
		main.hdAdminCoreName,
		"Invalid prefix! Try '%s%s' instead.", -- (correctedPrefix, commandName)
		};
	
	ParserInvalidVipServer = {
		main.hdAdminCoreName,
		"You cannot use '%s' in VIP Servers.", -- (commandName)
		};
	
	ParserInvalidDonor = {
		main.hdAdminCoreName,
		"You must be a Donor to use that command!",
		};
	
	ParserInvalidLoop = {
		main.hdAdminCoreName,
		"You do not have permission to use Loop commands!",
		};
	
	ParserInvalidRank = {
		main.hdAdminCoreName,
		"You do not have permission to use '%s'", -- (commandName)
		};
	
	ParserCommandBlock = {
		main.hdAdminCoreName,
		"Commands are temporarily disabled.'",
		};
	
	ParserInvalidRigType = {
		main.hdAdminCoreName,
		"%s must be %s to use that command.",  -- (playerName, rigType)
		};
	
	ParserPlayerRankBlocked = {
		main.hdAdminCoreName,
		"You do not have the permissions to use '%s' on %s!",  -- (commandName, playerName)
		};
	
	ParserSpeakerRank = {
		main.hdAdminCoreName,
		"You %sed %s to '%s'", -- (commandName, playersRanked, rankName)
		};
	
	ParserSpeakerUnrank = {
		main.hdAdminCoreName,
		"You unranked %s", -- (amount of players unranked)
		};
	
	ParserPlrPunished = {
		main.hdAdminCoreName,
		"%s must be unpunished to use that command.",  -- (playerName)
		};
	
	ReceivedPM = {
		main.hdAdminCoreName,
		"You have a message from %s! Click to open.", -- (playerName)
		};
	
	RemovePermRank = {
		main.hdAdminCoreName,
		"Successfully unranked %s!", -- (playerName)
		};
	
	BroadcastSuccessful = {
		main.hdAdminCoreName,
		"Broadcast successful! Your announcement will appear shortly.",
		};
	
	BroadcastFailed = {
		main.hdAdminCoreName,
		"Broadcast failed to send.",
		};
	
	InformPrefix = {
		main.hdAdminCoreName,
		"The server prefix is '%s'", -- (prefix)
		};
	
	GetSoundSuccess = {
		main.hdAdminCoreName,
		"The ID of the sound playing is: %s", -- (soundId)
		};
	
	GetSoundFail = {
		main.hdAdminCoreName,
		"No sound is playing!",
		};
	
	UnderControl = {
		main.hdAdminCoreName,
		"You're being controlled by %s!", -- (playerName)
		};
	
	ClickToTeleport = {
		"Teleport",
		"Click to teleport to '%s' [%s]", -- (placeName, placeId)
		};
	
	BanSuccess = {
		main.hdAdminCoreName,
		"Successfully banned %s! Click to view the Banland.", -- (playerName)
		{"ShowSpecificPage", "Admin", "Banland"}
		};
	
	UnBanSuccess = {
		main.hdAdminCoreName,
		"Successfully unbanned %s!", -- (playerName)
		};
	
	QualifierLimitToSelf = {
		main,
		"'%ss' hdAdminCoreNamecan only use commands on theirself!" -- (rankName)
		};
	
	QualifierLimitToOnePerson = {
		main.hdAdminCoreName,
		"'%ss' can only use commands on one person at a time!" -- (rankName)
		};
	
	ScaleLimit = {
		main.hdAdminCoreName,
		"The ScaleLimit is %s for ranks below '%s'" -- (scaleLimit, rankName)
		};
	
	RequestsLimit = {
		main.hdAdminCoreName,
		"You're sending requests too fast!"
		};
	
	AlertFail = {
		main.hdAdminCoreName,
		"Alert failed to send."
		};
	
	PollFail = {
		main.hdAdminCoreName,
		"Poll failed to send."
		};
	
	GearBlacklist = {
		main.hdAdminCoreName,
		"Cannot insert gear: %s. This item has been blacklisted.", -- (gearId)
		};
	
	BanFailLength = {
		main.hdAdminCoreName,
		"%sBan Length must be greater than 0!" -- (Predefined message)
		};
	
	BanFailVIPServer = {
		main.hdAdminCoreName,
		"%s'permBan' is prohibited on VIP Servers!" -- (Predefined message)
		};
	
	BanFailAllServers = {
		main.hdAdminCoreName,
		"You do not have permission to ban players from 'all servers'."
		};
	
	BanFailAlreadyBanned = {
		main.hdAdminCoreName,
		"%splayer has already been banned!" -- (Predefined message)
		};
	
	BanFailPermission = {
		main.hdAdminCoreName,
		"You do not have permission to ban %s"
		};
	
	BanFailDataNotFound = {
		main.hdAdminCoreName,
		"%sData not found."
		};
	
	RestoreDefaultSettings = {
		"Settings",
		"Successfully restored all settings to default!"
		};
	
	CommandBarLocked = {
		main.hdAdminCoreName,
		"You do not have permission to use the commandBar%s! Rank required: '%s'" -- (barId, rankName)
		};
	
	FollowFail = {
		main.hdAdminCoreName,
		"Failed to teleport. %s is not in-game."
		};
	
	SaveMap1 = {
		main.hdAdminCoreName,
		"Saving a copy of the map..."
		};
	
	SaveMap2 = {
		main.hdAdminCoreName,
		"Map successfully saved!"
		};
	
	CommandLimit = {
		main.hdAdminCoreName,
		"The %s limit is %s for ranks below '%s'" -- (type, limit, rankName)
		};
	
	CommandLimitPerMinute = {
		main.hdAdminCoreName,
		"Sending commands too fast! CommandLimitPerMinute exceeded."
		};
	
	template = {
		main.hdAdminCoreName,
		""
		};
	
	}

	return coreNotices[noticeName]
	
end


return module