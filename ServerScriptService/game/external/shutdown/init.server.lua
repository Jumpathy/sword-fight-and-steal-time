--Preforms a "soft shutdown". It will teleport players to a reserved server
--and teleport them back, with a new server. ORiginal version by Merely.
--Be aware this will hard shutdown reserved servers.

local PlaceId = game.PlaceId

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local TeleportScreenCreator = script:WaitForChild("TeleportScreenCreator")
local CreateTeleportScreen = require(TeleportScreenCreator)

local SoftShutdownLocalScript = script:WaitForChild("SoftShutdownLocalScript")
TeleportScreenCreator.Parent = SoftShutdownLocalScript
SoftShutdownLocalScript.Parent = game:GetService("ReplicatedFirst")

local StartShutdown = Instance.new("RemoteEvent")
StartShutdown.Name = "StartShutdown"
StartShutdown.Parent = game.ReplicatedStorage

local bro = false; 

game.Players.PlayerAdded:Connect(function(p)
	if(bro) then
		p:Kick("[THIS SERVER IS SHUTTING DOWN]");
	end
end)
function shared.shutdownthing()
		--Return if there is no players.
	if #game.Players:GetPlayers() == 0 then
		if(not game:GetService("RunService"):IsStudio()) then
			bro = true;
				wait(15);
			end
			return
		end

		--Return if the server instance is offline.
		if game.JobId == "" then
			return
		end

		--Send the shutdown message.
		StartShutdown:FireAllClients(true)
		wait(2)
		local ReservedServerCode = TeleportService:ReserveServer(PlaceId)

		--Create the teleport GUI.
		local ScreenGui = CreateTeleportScreen()
		local function TeleportPlayer(Player)
			TeleportService:TeleportToPrivateServer(PlaceId,ReservedServerCode,{Player},nil,{IsTemporaryServer=true,PlaceId = PlaceId},ScreenGui)
		end

		--Teleport players and try to keep the server alive until all players leave.
		for _,Player in pairs(Players:GetPlayers()) do
			TeleportPlayer(Player)
		end
		game.Players.PlayerAdded:connect(TeleportPlayer)
		while #Players:GetPlayers() > 0 do wait() end
end


if not (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
	--If it is not a reserved server, bind the teleporting on close.
	game:BindToClose(shared.shutdownthing)
end