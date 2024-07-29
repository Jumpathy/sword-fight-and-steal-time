-- This is for commands which continue on respawn
local module = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain
local settings = main.settings



-- << SETUP ITEMS (items which continue on respawn) >>
function module:SetupItem(player, itemName, playerRespawned)
	if playerRespawned then
		wait(0.1)
	end
	local pdata = main.pd[player]
	local item = pdata.Items[itemName]
	local head = main:GetModule("cf"):GetHead(player)
	if head and pdata then
		
		if itemName == "FreezeBlock" then
			main:GetModule("cf"):Movement(false, player)
			main:GetModule("cf"):SetTransparency(player.Character, 1)
			if item:FindFirstChild("FreezeClone") then
				main.signals.SetCameraSubject:FireClient(player, (item.FreezeClone.Humanoid))
			end
			
		elseif itemName == "JailCell" then
			head.CFrame = item.Union.CFrame
		
		elseif itemName == "ControlPlr" then
			local plr = item.Value
			local controllerHumanoid = main:GetModule("cf"):GetHumanoid(player)
			if plr and controllerHumanoid then
				main:GetModule("MorphHandler"):BecomeTargetPlayer(player, plr.UserId)
				main.signals.SetCameraSubject:FireClient(player, (controllerHumanoid))
				main:GetModule("cf"):CreateFakeName(player, plr.Name)
			else
				main:GetModule("cf"):RemoveControlPlr(player)
			end
			
		elseif itemName == "UnderControl" then
			local controller = item.Value
			local controllerHumanoid = main:GetModule("cf"):GetHumanoid(controller)
			if controller and controllerHumanoid then
				main.signals.SetCameraSubject:FireClient(player, (controllerHumanoid))
				--main:GetModule("cf"):SetTransparency(player.Character, 1, true)
				--main:GetModule("cf"):Movement(false, player)
				player.Character.Parent = nil
			else
				main:GetModule("cf"):RemoveUnderControl(player)
			end
			
			-- Controler
			-- Plr
			
		end
	end
end



return module