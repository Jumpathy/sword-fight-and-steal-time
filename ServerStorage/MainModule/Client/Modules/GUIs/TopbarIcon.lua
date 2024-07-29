-- LOCAL
local main = _G.HDAdminMain
local playerGui = main.playerGui
local replicatedStorage = game:GetService("ReplicatedStorage")
local hdDirectory = replicatedStorage:FindFirstChild("HDAdmin")
local topbarPlus = hdDirectory and hdDirectory:FindFirstChild("Topbar+")

-- This allows for backwards compatibility with v1 until Nanoblox is released
if topbarPlus then
	local iconController = require(topbarPlus.IconController)
	local hdIcon = iconController:createIcon("HDAdmin", 4882428756, 0)
	hdIcon:setToggleMenu(main.gui.MainFrame)
	return hdIcon
end

-- Check the game for another v2; if present use this instead
local blueGradient
local topbarPlusReference = replicatedStorage:FindFirstChild("TopbarPlusReference")
if topbarPlusReference then
	topbarPlus = topbarPlusReference.Value
else
	topbarPlus = main.client.Assets.Icon
	blueGradient = require(topbarPlus.Themes.BlueGradient)
end

-- Now use TopbarPlus as normal
local Icon = require(topbarPlus)
local hdIcon = Icon.new()
	:setImage(4882428756, "deselected")
	:setImage(6326373239, "selected")
	:setImageYScale(0.5, "selected")
	:bindToggleItem(main.gui.MainFrame)
	:setOrder(0)
	if blueGradient then
		hdIcon:setTheme(blueGradient)
	end

return hdIcon