local module = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- << VARIABLES >>
local topBarFrame = main.gui.CustomTopBar



-- << SETUP >>
for _,revent in pairs(main.signals:GetChildren()) do
	if revent:IsA("RemoteEvent") then
		revent.OnClientEvent:Connect(function(args)
			if not main.initialized then main.client.Signals.Initialized.Event:Wait() end
			
			---------------------------------------------
			if revent.Name == "ChangeStat" then
				local statName, newValue = args[1], args[2]
				main.pdata[statName] = newValue
				if statName == "Donor" then
					main:GetModule("PageSpecial"):UpdateDonorFrame()
				end
			
			elseif revent.Name == "InsertStat" then
				local locationName, newValue = args[1], args[2]
				table.insert(main.pdata[locationName], newValue)
				
			elseif revent.Name == "RemoveStat" then
				local locationName, newValue = args[1], args[2]
				for i,v in pairs(main.pdata[locationName]) do
					if tostring(v) == tostring(newValue) then
						table.remove(main.pdata[locationName], i)
						break
					end
				end
			
			elseif revent.Name == "Notice" or revent.Name == "Error" then
				main:GetModule("Notices"):Notice(revent.Name, args[1], args[2], args[3])
					
			elseif revent.Name == "ShowPage" then
				main:GetModule("GUIs"):ShowSpecificPage(args[1], args[2])
				
			elseif revent.Name == "ShowBannedUser" then
				main:GetModule("GUIs"):ShowSpecificPage("Admin", "Banland")
				if type(args) == "table" then
					main:GetModule("cf"):ShowBannedUser(args)
				end
			
			elseif revent.Name == "SetCameraSubject" then
				main:GetModule("cf"):SetCameraSubject(args)
				
			elseif revent.Name == "Clear" then
				main:GetModule("Messages"):ClearMessageContainer()
				
			elseif revent.Name == "ShowWarning" then
				main:GetModule("cf"):ShowWarning(args)
			
			elseif revent.Name == "Message" then
				main:GetModule("Messages"):Message(args)
			
			elseif revent.Name == "Hint" then
				main:GetModule("Messages"):Hint(args)
				
			elseif revent.Name == "GlobalAnnouncement" then
				main:GetModule("Messages"):GlobalAnnouncement(args)
			
			elseif revent.Name == "SetCoreGuiEnabled" then
				main.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType[args[1]], args[2])
			
			elseif revent.Name == "CreateLog" then
				main:GetModule("cf"):CreateNewCommandMenu(args[1], args[2], 5)
			
			elseif revent.Name == "CreateAlert" then
				main:GetModule("cf"):CreateNewCommandMenu("alert", {args[1], args[2]}, 8, true)
			
			elseif revent.Name == "CreateBanMenu" then
				main:GetModule("cf"):CreateNewCommandMenu("banMenu", args, 6)
			
			elseif revent.Name == "CreatePollMenu" then
				main:GetModule("cf"):CreateNewCommandMenu("pollMenu", args, 9)
			
			elseif revent.Name == "CreateMenu" then
				main:GetModule("cf"):CreateNewCommandMenu(args.MenuName, args.Data, args.TemplateId)
			
			elseif revent.Name == "CreateCommandMenu" then
				local title = args[1]
				local details = args[2]
				local menuType = args[3]
				main:GetModule("cf"):CreateNewCommandMenu(title, details, menuType)
			
			elseif revent.Name == "RankChanged" then
				main:GetModule("cf"):UpdateIconVisiblity()
				main:GetModule("PageAbout"):UpdateRankName()
				main:GetModule("GUIs"):DisplayPagesAccordingToRank(true)
				if main.initialized then
					main:GetModule("PageCommands"):CreateCommands()
				end
				
			elseif revent.Name == "ExecuteClientCommand" then
				local speaker, args, commandName, other = args[1], args[2], args[3], args[4]
				local unFunction = other.UnFunction
				local functionType = "Function"
				if unFunction then
					functionType = "UnFunction"
				end
				local clientCommand = main:GetModule("ClientCommands")[commandName]
				if clientCommand then
					local Function = clientCommand[functionType]
					if Function then
						Function(speaker, args, clientCommand)
					end
				end
			
			elseif revent.Name == "ReplicationEffectClientCommand" then
				local commandName = args[1]
				local speaker = args[2]
				local rArgs = args[3]
				local clientCommand = main:GetModule("ClientCommands")[commandName]
				if clientCommand then
					local replicationEffect = clientCommand.ReplicationEffect
					if replicationEffect then
						replicationEffect(speaker, rArgs, clientCommand)
					end
				end
				
			elseif revent.Name == "ActivateClientCommand" then
				local commandName = args[1]
				local extraDetails = args[2]
				--Custom speed
				local speed = extraDetails and ((extraDetails.Speed ~= 0 and extraDetails.Speed) or nil)
				if speed then
					main.commandSpeeds[commandName] = speed
					local oldMenu = main.gui:FindFirstChild("CommandMenufly")
					main:GetModule("cf"):DestroyCommandMenuFrame(oldMenu)
				end
				--Deactivate other flight commands 
				if main.commandSpeeds[commandName] then
					for otherCommandName, _ in pairs(main.commandSpeeds) do
						if otherCommandName ~= commandName then
							main:GetModule("cf"):DeactivateCommand(otherCommandName)
						end
					end
				end
				--Activate command
				main.commandsAllowedToUse[commandName] = true
				main:GetModule("cf"):ActivateClientCommand(commandName, extraDetails)
				--Setup command menu
				local menuDetails, menuType
				for menuTypeName, menuCommands in pairs(main.commandsWithMenus) do
					menuDetails = menuCommands[commandName]
					if menuDetails then
						menuType = tonumber(menuTypeName:match("%d+"))
						break
					end
				end
				if menuDetails then
					main:GetModule("cf"):CreateNewCommandMenu(commandName, menuDetails, menuType)
				end
			
			elseif revent.Name == "DeactivateClientCommand" then
				main:GetModule("cf"):DeactivateCommand(args[1])
			
			elseif revent.Name == "FadeInIcon" then
				--[[
				local topBarFrame = main.gui.CustomTopBar
				local imageButton = topBarFrame.ImageButton
				imageButton.ImageTransparency = 1
				main.tweenService:Create(imageButton, TweenInfo.new(1), {ImageTransparency = 0}):Play()
				--]]
				
			elseif revent.Name == "ChangeMainVariable" then
				main[args[1]] = args
				
				
					
			end
			---------------------------------------------
			
		end)
	
	
	
	
	
	
	
	
	elseif revent:IsA("RemoteFunction") then
		function revent.OnClientInvoke(args)
			if not main.initialized then main.client.Signals.Initialized.Event:Wait() end
			
			---------------------------------------------
			if revent.Name == "GetLocalDate" then
				return os.date("*t", args)
				
				
			end
		end
	
	
	
	
	
	
	end
end
			



return module