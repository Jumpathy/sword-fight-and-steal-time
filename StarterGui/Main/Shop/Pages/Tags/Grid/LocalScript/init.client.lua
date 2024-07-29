local config = require(game:GetService("ReplicatedStorage"):WaitForChild("config"))
local user = script:WaitForChild("User")
local timeValue = game:GetService("Players").LocalPlayer:WaitForChild("leaderstats",100):WaitForChild("Time")
local format = require(script:WaitForChild("format"));
local tag = game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("tag")
local localPlayer = game:GetService("Players").LocalPlayer
local options = {}

local onBought = function(name,clone)
	options[clone] = true
	local handle = function()
		local et = localPlayer:GetAttribute("EquippedTag")
		for clone,_ in pairs(options) do
			clone.Buy.Text = (et == clone.Name and "Unequip" or "Equip")
		end
	end
	clone.Buy.MouseButton1Click:Connect(function()
		if(localPlayer:GetAttribute("EquippedTag") == name) then
			tag:InvokeServer("unequip",name)
			handle()
		else
			tag:InvokeServer("equip",name)
			handle()
		end
	end)
	handle()
end

local owns = function(name)
	return localPlayer:WaitForChild("Tags"):GetAttribute(name)==true
end

for tagName,data in pairs(config.chatTags) do
	local clone = user:Clone()
	clone.TextLabel.Text = tagName
	clone.TextLabel.TextColor3 = data[2]
	clone.LayoutOrder = data[1]
	clone.Parent = script.Parent
	clone.Name = tagName
	local canPurchase = false

	local update = function()
		if(timeValue.Value < data[1]) then
			canPurchase = false
			clone:WaitForChild("Buy").BackgroundColor3 = Color3.fromRGB(255,50,0)
			clone:WaitForChild("Buy").Text = format.FormatCompact(data[1])		
		else
			canPurchase = true
			clone:WaitForChild("Buy").BackgroundColor3 = Color3.fromRGB(0, 171, 74)
			clone:WaitForChild("Buy").Text = "Purchase"
		end
	end

	if(not owns(tagName)) then
		local conn = timeValue.Changed:Connect(update)
		update()

		local sig;
		sig = clone:WaitForChild("Buy").MouseButton1Click:Connect(function()
			if(canPurchase) then
				local bought = tag:InvokeServer("buy",tagName)
				if(bought) then
					sig:Disconnect()
					conn:Disconnect()
					onBought(tagName,clone)
				end
			end
		end)
	else
		onBought(tagName,clone)
	end
end