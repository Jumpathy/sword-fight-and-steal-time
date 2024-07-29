-- << DEFINE MAIN AND SERVICES >>
-- To index a service, do main.serviceName (e.g. main.players, main.teleportService, main.tweenService, etc)
local main = setmetatable({}, {
    __index = function(self, name)
        local pass, service = pcall(game.GetService, game, name:sub(1, 1):upper()..name:sub(2))
        if pass then
            self[name] = service
            return service
        end
    end
})



function main:Initialize(location, loader)
	
	-- << SHORTHAND SERVICES >>
	main.rs = game:GetService("ReplicatedStorage")
	main.ss = game:GetService("ServerStorage")
	main.sss = game:GetService("ServerScriptService")
	
	
	
	-- << SETUP >>
	local function ConvertToCamelCase(pascalCase)
		local camelCase = string.lower(string.sub(pascalCase,1,1))..string.sub(pascalCase,2)
		return camelCase
	end
	
	if location == "Server" then
		-- Define storage folders
		main.mainModule = script:FindFirstAncestor("MainModule")
		main.server = main.mainModule.Server
		main.client = main.mainModule.Client
		
		main.workspaceFolder = Instance.new("Folder")
		main.workspaceFolder.Name = "HDAdminWorkspaceFolder"
		main.workspaceFolder.Parent = workspace
		
		-- Retrieve default settings
		local settingsModuleCopy = main.server.Assets:FindFirstChild("SettingsCopy")
		if settingsModuleCopy then
			main.settings = require(settingsModuleCopy)
		end
		
		-- Update settings
		local settingsModule = require(loader:FindFirstChild("Settings", true))
		if settingsModule then
			for settingName, value in pairs(settingsModule) do
				main.settings[settingName] = value
			end
		end
		
		-- Merge CustomFeatures into MainModule
		local customFeatures = loader:FindFirstChild("CustomFeatures", true)
		local function UpdateStorageWithContents(folder, coreFolderName)
			local newCoreFolderName = string.lower((coreFolderName == "Client" and coreFolderName) or "Server")
			local storageName = folder.Name
			local storage = main[newCoreFolderName]:FindFirstChild(storageName)
			if storage and storageName ~= "client" and storageName ~= "server" then
				for _, newItem in pairs(folder:GetChildren()) do
					local existingItem = storage:FindFirstChild(newItem.Name)
					if existingItem and not existingItem:IsA("ModuleScript") then
						existingItem:Destroy()
					end
					newItem.Parent = storage
				end
			end
		end
		if customFeatures then
			for a,b in pairs(customFeatures:GetChildren()) do
				UpdateStorageWithContents(b)
				local coreFolderName = b.Name
				for c,d in pairs(b:GetChildren()) do
					UpdateStorageWithContents(d, coreFolderName)
				end
			end
		end
		
		-- Place items into correct locations
		local itemsToMove = {
			["Client"] = main.rs;
			["Server"] = main.ss;
			}
		local itemsToCloneAndMove = {
			["HDAdminLocalFirst"] = main.replicatedFirst;
			["HDAdminStarterCharacter"] = main.starterPlayer.StarterCharacterScripts;
			["HDAdminStarterPlayer"] = main.starterPlayer.StarterPlayerScripts;
			["HDAdminGUIs"] = main.starterGui;
			["Preload"] = main.replicatedFirst;
			}
		local function CheckToMove(item)
			local itemName = item.Name
			local itemLocation = (itemsToMove[itemName] or itemsToCloneAndMove[itemName])
			if itemLocation and not itemLocation:FindFirstChild(itemName) then
				if itemsToMove[itemName] then
					item.Name = "HDAdmin"..itemName
					item.Parent = itemLocation
				elseif itemsToCloneAndMove[itemName] then
					local itemClone = item:Clone()
					itemClone.Parent = itemLocation
					if itemClone:IsA("LocalScript") then
						itemClone.Disabled = false
					end
				end
			end
		end
		for a,b in pairs(main.mainModule:GetChildren()) do
			CheckToMove(b)
			for c,d in pairs(b:GetChildren()) do
				CheckToMove(d)
				for e,f in pairs(d:GetChildren()) do
					CheckToMove(f)
				end
			end
		end
		
		-- Manually add items for players who joined early
		local setupQuickJoiners = main.server.Assets.SetupQuickJoiners
		for i, player in pairs(main.players:GetChildren()) do
			setupQuickJoiners:Clone().Parent = player.PlayerGui
		end
		
		--Setup SaveMap Default
		coroutine.wrap(function()
			local mapBackup = Instance.new("Folder")
			mapBackup.Name = "HDAdminMapBackup"
			mapBackup.Parent = main.ss
			main.client.Signals.Initialized.Event:Wait()
			main:GetModule("cf"):SaveMap()
		end)()
	
	
	
	
	elseif location == "Client" then
		
		-- Define storage folders
		main.client = main.rs:WaitForChild("HDAdminClient")
		for a,b in pairs(main.client:GetChildren()) do
			--main[ConvertToCamelCase(b.Name)] = b
		end
		main.workspaceFolder = workspace:WaitForChild("HDAdminWorkspaceFolder")
		
		-- Core client variables
		main.player = game.Players.LocalPlayer
		main.playerGui = main.player:WaitForChild("PlayerGui")
		main.gui = main.playerGui:WaitForChild("HDAdminGUIs")
		main.templates = main.gui.Templates
		main.warnings = main.gui.MainFrame:WaitForChild("Warnings")
		main.camera = workspace.CurrentCamera
		
		-- Get device type
		main.tablet = false
		if main.guiService:IsTenFootInterface() then
			main.device = "Console"
		elseif (main.userInputService.TouchEnabled and not main.userInputService.MouseEnabled) then
			main.device = "Mobile"
		else
			main.device = "Computer"
		end
		if main.gui.AbsoluteSize.Y < 1 then repeat wait() until main.gui.AbsoluteSize.Y > 0 end
		if main.device == "Mobile" then
			if main.gui.AbsoluteSize.Y >= 650 then
				main.tablet = true
			end
		end
		
		-- Retrieve PlayerData
		local success, dataToRetrieve
		for i = 1, 50 do
			success, dataToRetrieve = pcall(function() return main.client.Signals.RetrieveData:InvokeServer() end)
			--print("HD Admin DataToRetrieveType = ",type(dataToRetrieve),dataToRetrieve)
			if success and dataToRetrieve then
				break
			else
				wait(1)
			end
		end
		for statName, statData in pairs(dataToRetrieve) do
			main[statName] = statData
		end
		
		
	end
	
	
	
	-- << SHARED CORE VARIABLES >>
	local dateDetails = os.date("*t", os.time())
	main.hdAdminCoreName = (dateDetails.day == 1 and dateDetails.month == 4 and "144p Admin") or "HD Admin"
	main.modules = {}
	main.coreFolder = main[string.lower(location)]
	main.moduleGroup = main.coreFolder.Modules
	main.sharedModules =  main.client.SharedModules
	main.signals = main.client.Signals
	main.audio = main.client.Audio
	
	local waitingForModule = {}
	function main:GetModule(name)
		if not main.modules[name] then
			local request = {name = name, addedSignal = Instance.new("BindableEvent")}
			waitingForModule[#waitingForModule+1] = request
			request.addedSignal.Event:Wait()
		end
		return main.modules[name]
	end
	function main.loadModule(name)
		if not main.modules[name] then
			local request = {name = name, addedSignal = Instance.new("BindableEvent")}
			waitingForModule[#waitingForModule+1] = request
			request.addedSignal.Event:Wait()
		end
		return main.modules[name]
	end
	
	-- << SETUP MODULES >>
	local moduleNamesToAdapt = {
		["cf"] = {"ClientCoreFunctions", "SharedCoreFunctions", "ServerCoreFunctions"};
		["API"] = {"ClientAPI", "ServerAPI", "SharedAPI"};
	}
	local moduleNamesToAdaptDictionary = {}
	for newName, originalNames in pairs(moduleNamesToAdapt) do
		for _, originalName in pairs(originalNames) do
			moduleNamesToAdaptDictionary[originalName] = newName
		end
	end
	local function SetupModules(folder, moduleStorage)
		for a,b in pairs(folder:GetDescendants()) do
			if b:IsA("ModuleScript") and b.Name ~= script.Name then
				coroutine.wrap(function()
					--Adapt module name if specified
					local moduleName = b.Name
					local newModuleName = moduleNamesToAdaptDictionary[moduleName]
					if newModuleName then
						moduleName = newModuleName
					end
					
					--Retrieve module data
					local success, data = pcall(function() return require(b) end)
					
					--Warn of module error
					if not success then
						warn("HD Admin Module Error | "..b.Name.." | ".. tostring(data))
					
					--If module already exists, merge conetents
					elseif moduleStorage[moduleName] then
						for funcName, func in pairs(data) do
							if tonumber(funcName) then
								table.insert(moduleStorage[moduleName], func)
							else
								moduleStorage[moduleName][funcName] = func
							end
						end
						
					--Else setup new module
					else
						moduleStorage[moduleName] = data
						for i = #waitingForModule, 1, -1 do
							local request = waitingForModule[i]
							if request.name == moduleName then
								table.remove(waitingForModule, i)
								request.addedSignal:Fire()
							end
						end
					end
					
					--Hide module on client
					if location == "Client" and b.Name ~= script.Name then
						b:Destroy()
					end
				end)()
			end
		end
	end
	require(script.MainVariables):SetupMainVariables(location)
	SetupModules(main.moduleGroup, main.modules)
	SetupModules(main.sharedModules, main.modules)
	
	
	
	-- << STARTER FUNCTIONS >>
	if location == "Server" then
		main.server.Assets:WaitForChild("HDAdminSetup").Parent = main.rs
		if not main.ownerName then
			main.ownerName = main:GetModule("cf"):GetName(main.ownerId)
		end
		main:GetModule("CommandHandler"):Setup()
		main:GetModule("LoaderHandler"):Setup()
		main.chatService = require(main.sss:WaitForChild("ChatServiceRunner", 1):WaitForChild("ChatService", 1))
	end
	
	
	
	-- << END >>
	main.initialized = true
	main.client.Signals.Initialized:Fire()
end




-- << CHECK INITIALIZED >>
function main:CheckInitialized()
	if not main.initialized then
		script.Parent.Parent:WaitForChild("Signals"):WaitForChild("Initialized").Event:Wait()
	end
	return main
end



---------------------
_G.HDAdminMain = main
---------------------



return main