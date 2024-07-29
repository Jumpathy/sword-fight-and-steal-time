--Runs the soft shutdown Gui to warn players.

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")



--Set up teleport arrival.
TeleportService.LocalPlayerArrivedFromTeleport:Connect(function(Gui,Data)
	if Data and Data.IsTemporaryServer then
		wait(.25);
		--If it is a temporary server, keep showing the Gui, wait, then teleport back.
		Gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui",10^99)
		StarterGui:SetCore("TopbarEnabled",false)
		StarterGui:SetCoreGuiEnabled("All",false)
		wait(5)
		TeleportService:Teleport(Data.PlaceId,Players.LocalPlayer,nil,Gui)
	else
		--If the player is arriving back from a temporary server, remove the Gui.
		if Gui and Gui.Name == "SoftShutdownGui" then Gui:Destroy() end
	end
end)



--Anything that can cause this to yeild will prevent teleport data being recieved.
local RenderStepped = RunService.RenderStepped
local StartShutdown = game.ReplicatedStorage:WaitForChild("StartShutdown")
local CreateTeleportScreen = require(script:WaitForChild("TeleportScreenCreator"))

--Set up event for when the server is shutting down.
StartShutdown.OnClientEvent:Connect(function()
	--Create the Gui and have it semi-transparent for 1 second.
	local Gui,Background = CreateTeleportScreen()
	Background.BackgroundTransparency = 0.5
	Gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	wait(1)
	
	--Tween the transparency to 0.
	local Start = tick()
	local Time = 0.5
	while tick() - Start < Time do
		local Dif = tick() - Start
		local Ratio = Dif/Time
		Background.BackgroundTransparency = 0.5 * (1 - Ratio)
		RenderStepped:Wait()
	end
	Background.BackgroundTransparency = 0
end)