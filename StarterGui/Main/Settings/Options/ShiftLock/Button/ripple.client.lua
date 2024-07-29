local ms = game.Players.LocalPlayer:GetMouse()
local btn = script.Parent
local Sample = Instance.new("ImageLabel")
Sample.Name = "Sample"
Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Sample.BackgroundTransparency = 1.000
Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
Sample.ImageColor3 = Color3.fromRGB(0, 0, 0)
Sample.ImageTransparency = 0.600
Sample.ZIndex = btn.ZIndex + 1;

btn.MouseButton1Click:Connect(function()
	local c = Sample:Clone()
	c.Parent = btn
	local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
	c.Position = UDim2.new(0, x, 0, y)
	local len, size = 0.35, nil
	if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
		size = (btn.AbsoluteSize.X * 1.5)
	else
		size = (btn.AbsoluteSize.Y * 1.5)
	end
	c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
	for i = 1, 10 do
		c.ImageTransparency = c.ImageTransparency + 0.05
		wait(len / 12)
	end
	c:Destroy()
end)

local platform = function()
	--------------- Variables: ---------------

	local pf = "Desktop";
	local uis = game:GetService("UserInputService");
	local guis = game:GetService("GuiService");

	--------------- Detection: ---------------

	if(uis.TouchEnabled) then 
		if(uis.GyroscopeEnabled or uis.AccelerometerEnabled) then  
			pf = "Mobile";
		end
	else
		if(guis:IsTenFootInterface()) then 
			pf = "Console";
		end
	end

	--------------- Return: ---------------

	return pf;
end

if(platform() == "Mobile" or game:GetService("RunService"):IsStudio()) then
	script.Parent.Parent.Visible = true;
end

script.Parent.MouseButton1Click:Connect(function()
	game.Players.LocalPlayer.isShiftlock.Value = not game.Players.LocalPlayer.isShiftlock.Value;
end)