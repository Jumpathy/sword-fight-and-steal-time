local module = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- << FUNCTIONS >>
function module:Setup()
	local commandsToAdd = require(main.server.Modules.Commands)
	for i, command in pairs(commandsToAdd) do
		if type(command) == "table" then
			--ChangeRankRequiredToUseCommand
			local commandName = string.lower(command.Name)
			local changeRankByNameSetting = main.settings.ChangeRankRequiredToUseCommand or main.settings.SetCommandRankByName
			local changeRank = changeRankByNameSetting[command.Name] or changeRankByNameSetting[commandName]
			if changeRank then
				if tonumber(changeRank) == nil then
					changeRank = main:GetModule("cf"):GetRankId(changeRank)
				end
				command.Rank = changeRank
			elseif commandName == "cmdbar" or commandName == "cmdbar2"  then
				local settingName = commandName:gsub("^%a", function(c) return(string.upper(c)) end)
				local setting = main.settings[settingName]
				if setting then
					if tonumber(setting) == nil then
						setting = main:GetModule("cf"):GetRankId(setting)
					end
					command.Rank = setting
					main.settings[settingName] = setting
				end
			end
			--
			if commandName ~= "" then
				local function getCommandTables()
					local template, modified = {},{}
					for dataName, data in pairs(command) do
						if main:GetModule("cf"):FindValue(main.commandInfoToShowOnClient, dataName) then
							template[dataName] = data
						elseif dataName == "UnFunction" and type(data) == "function" then
							template["UnFunction"] = "un".. string.gsub(command.Name, "%a", function(c) return string.upper(c) end, 1)
						end
						modified[dataName] = data 
					end
					--
					local lowerCaseArgs = {}
					if command.Args then
						for i,v in pairs(command.Args) do
							table.insert(lowerCaseArgs, string.lower(v))
						end
					end
					template.RankName = main:GetModule("cf"):GetRankName(command.Rank)
					template.Args = lowerCaseArgs
					modified.Args = lowerCaseArgs
					--
					return template, modified	
				end
				local infoTemplate, modifiedCommand = getCommandTables()
				table.insert(main.commandInfo, infoTemplate)
				main.commands[commandName] = modifiedCommand
				--Special Colors
				if command.SpecialColors then
					for i,v in pairs(main.settings.Colors) do
						local shortName = v[1]
						if shortName ~= "w" then
							local newTemplate, newModifiedCommand = getCommandTables()
							local commandColorName = command.Name..shortName
							local color = v[3]
							newTemplate.SpecialColor = color
							newTemplate.SpecialColorName = shortName
							newTemplate.OriginalName = command.Name
							newTemplate.Name = commandColorName
							newModifiedCommand.SpecialColor = color
							newModifiedCommand.Name = commandColorName
							newModifiedCommand.OriginalName = command.Name
							table.insert(main.commandInfo, newTemplate)
							main.commands[commandColorName] = newModifiedCommand
						end
					end
				end
				--
				for infoName, infoTable in pairs(main.infoOnAllCommands) do
					local commandStat = command[infoName]
					if type(commandStat) == "table" then
						for i,v in pairs(commandStat) do
							if infoName ~= "Contributors" then
								v = string.lower(v)
							end
							if infoName == "Contributors" or infoName == "Tags" then
								if infoName == "Contributors" and tonumber(v) then
									v = main.main:GetModule("cf"):GetName(v)
								end
								local statCount = main.infoOnAllCommands[infoName][v]
								if statCount == nil then
									--if infoName ~= "Contributors" or not isCustomCommands then
										main.infoOnAllCommands[infoName][v] = 1
									--end
								else
									main.infoOnAllCommands[infoName][v] = statCount + 1
								end
							elseif infoName == "Aliases" then
								main.infoOnAllCommands[infoName][v] = commandName
							else
								main.infoOnAllCommands[infoName][v] = true
							end
						end
					end
				end
				main.commandRanks[commandName] = command.Rank
			end
		end
	end
end




return module