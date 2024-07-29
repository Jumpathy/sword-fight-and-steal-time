-- << RETRIEVE FRAMEWORK >>
local main = require(game:GetService("ReplicatedStorage"):WaitForChild("HDAdminSetup")):GetMain()


-- << SETUP >>
local character = main.player.Character or main.player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
main.humanoidRigType = humanoid.RigType
wait(1)
for speedCommandName, _ in pairs(main.commandSpeeds) do
	if main.commandsActive[speedCommandName] then
		main.commandsActive[speedCommandName] = nil
		main:GetModule("cf"):ActivateClientCommand(speedCommandName)
	end
end