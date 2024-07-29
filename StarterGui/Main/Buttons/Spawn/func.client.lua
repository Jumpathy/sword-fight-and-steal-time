local clicked = false;
local moving = false;

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

local size = function(a,b,o)
	for k,v in pairs({a,b}) do
		v.Size = UDim2.new(1,0,0,o.AbsoluteSize.Y + (o.AbsoluteSize.Y * 0.18181818181818));
		v.Position = UDim2.new(0.5,0,1,-(o.AbsoluteSize.Y/4));
	end
end

local function updateMoving()
	local o = script.Parent.Parent.Parent.Hotbar:FindFirstChild("Object");
	if(o) then
		size(script.Parent.Parent,script.Parent.Parent.Parent.Hotbar,o);
	end
	pcall(function()
		local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
		moving = humanoid.MoveDirection.Magnitude > 0;
	end)
end

local value;

local cb;
cb = function(name)
	local entered = not game:GetService("Players").LocalPlayer:GetAttribute("inZone");
	local s,e = pcall(function()
		if(not value) then
			value = game:GetService("Players").LocalPlayer.leaderstats.Time;
			value:GetPropertyChangedSignal("Value"):Connect(cb);
		end
		if(entered and game:GetService("Players").LocalPlayer.leaderstats.Time.Value >= 1000 and not shared.gui_open) then
			if(not game.Players.LocalPlayer:GetAttribute("in1v1")) then
				script.Parent.Visible = true;
			else
				script.Parent.Visible = false;
			end
		else
			script.Parent.Visible = false;
		end
	end)
end

game:GetService("Players").LocalPlayer.AttributeChanged:Connect(cb)

script.Parent.MouseButton1Click:Connect(function()
	if(not clicked) then
		local failed = false;
		clicked = true;
		for i = 1,5 do
			if(moving) then
				failed = true;
				coroutine.wrap(function()
					script.Parent.Text = "Stay still!";
					wait(1.5);
					script.Parent.Text = "Teleport to Spawn";
					clicked = false;
				end)();
				break;
			end
			script.Parent.Text = "("..5-i..")";
			if(5-i >= 1) then
				wait(1);
			end
		end
		if(not failed) then
			game.ReplicatedStorage.tp:FireServer();
			script.Parent.Text = "Teleport to Spawn";
			clicked = false;
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace.Map.Spawns:GetChildren()[math.random(1,#workspace.Map.Spawns:GetChildren())].Position + Vector3.new(0,5,0));
		end
	end
end)

game:GetService("RunService").Heartbeat:Connect(updateMoving);