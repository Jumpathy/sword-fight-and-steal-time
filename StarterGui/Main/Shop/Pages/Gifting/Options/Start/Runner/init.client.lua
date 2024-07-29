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

local last = 0;

local getData = function()
	local shop = game.ReplicatedStorage.shop;
	local objects = {};
	for _,obj in pairs(shop:GetDescendants()) do
		if(obj:IsA("Folder") and not obj:FindFirstChild("numPasses")) then
			table.insert(objects,{
				description = obj.description.Value,
				id = obj.id.Value,
				name = obj.name.Value,
				blurImage = obj.blurImage.Value,
				giftId = obj.giftId.Value,
				old = obj:FindFirstChild("old") and obj.old.Value,
				escaped = obj.name.Value:gsub(" ","_");
			})
		end
	end
	return objects;
end

local setup = function(passes,key,handle)
	local owned = passes.Parent.OwnedPasses;
	local data = getData();
	local template = script:WaitForChild("Template");
	for _,obj in pairs(script.Parent.Parent.Options:GetChildren()) do
		if(obj:IsA("TextButton")) then
			obj:Destroy();
		end
	end
	script.Parent.Parent.Options.CanvasSize = UDim2.new(0,0,0,20);
	coroutine.wrap(function()
		local c = 0;
		for i = 1,#data do
			if(last ~= key) then return end
			print(owned:GetAttribute(data[i].escaped));
			if(not owned:GetAttribute(data[i].escaped)) then
				local temp = template:Clone();
				temp.Text = data[i].name;
				temp.Size = UDim2.new(1,0,0,0);
				temp.Parent = script.Parent.Parent.Options;
				temp.Visible = true;
				temp:TweenSize(
					UDim2.new(1,0,0,25),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Bounce,
					1/4,
					true);
				temp.MouseButton1Click:Connect(function()
					handle(data[i]);
				end)
				local connection;
				connection = owned.AttributeChanged:Connect(function(id)
					if(owned:GetAttribute(data[i].escaped) == true) then
						connection:Disconnect();
						temp:Destroy();
					end
				end)
				wait(1/4);
				script.Parent.Parent.Options.CanvasSize = UDim2.new(0,0,0,script.Parent.Parent.Options.Layout.AbsoluteContentSize.Y);
			else
				c += 1;
			end
		end
		if(c - #data == 0) then
			shared.doNotify(
				"System",
				"This user owns every gamepass already."
			)
		end
	end)();
end

btn.MouseButton1Click:Connect(function()
	if(shared.lastSelectedName and shared.lastSelectedName>=1) then
		if(shared.lastSelectedName == game.Players.LocalPlayer.UserId and not game:GetService("RunService"):IsStudio()) then
			shared.doNotify(
				"System",
				"You cannot gift yourself."
			)
		else
			local player = game.Players:GetPlayerByUserId(shared.lastSelectedName);
			last = tick();
			local current = last;
			if(player) then
				setup(player.Passes,current,function(data)
					game.ReplicatedStorage.events.prompt:FireServer(player,data.giftId);
				end)
			end
			game.Players.PlayerRemoving:Connect(function(p)
				if(p == player and (current == last)) then
					for _,obj in pairs(script.Parent.Parent.Options:GetChildren()) do
						if(obj:IsA("TextButton")) then
							obj:Destroy();
						end
					end
					shared.doNotify("System","The player you were attempting to gift left.");
				end
			end)
		end
	end
end)