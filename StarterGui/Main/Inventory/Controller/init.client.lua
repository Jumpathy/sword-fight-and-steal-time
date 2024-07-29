local inventory = game:GetService("Players").LocalPlayer:WaitForChild("Inventory");
local currentPage = "All";
local config = require(game:GetService("ReplicatedStorage"):WaitForChild("config"));
local test = {};

local createSwordViewport = function(data)
	local base = data;
	local parent = Instance.new(base.ClassName);

	for k,v in pairs(base) do
		if(k ~= "ClassName" and k ~= "mesh") then
			parent[k] = v;
		end
	end

	if(base.mesh) then
		local mesh = Instance.new(base.mesh.ClassName);
		mesh.Parent = parent

		for k,v in pairs(base.mesh) do
			if(k ~= "ClassName") then
				mesh[k] = v;
			end
		end
	end;

	return parent;
end

local link = function(viewport,handle,name)
	coroutine.wrap(function()
		local cam = Instance.new("Camera");
		cam.Parent = viewport;
		cam.CFrame = CFrame.new(0, 0, 3.5);
		cam.CameraType = Enum.CameraType.Scriptable;
		
		viewport.BackgroundColor3 = Color3.fromRGB(0,0,0);

		local c = config.swordOffsets[name];
		handle.Parent = viewport;
		handle.Position = Vector3.new(0,0,0);
		handle.Orientation =  Vector3.new(-45,90,-90) -- handle.Orientation = Vector3.new(-45,90,-90);
		
		cam.CFrame = CFrame.new(handle.Position + Vector3.new(0,0,3.25), handle.Position + Vector3.new(0,0,0))
		
		if(c ~= nil) then
			for property,value in pairs(c) do
				handle[property] = value;
			end
		end
		
		local combo = function(o,c)
			o.MouseEnter:Connect(function()
				c(true);
			end)
			o.MouseLeave:Connect(function()
				c(false);
			end)
		end
		
		combo(viewport,function(state)
			if(state) then
				game:GetService("TweenService"):Create(cam,TweenInfo.new(0.16,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{CFrame = CFrame.new(0,0,3);}):Play();
			else
				game:GetService("TweenService"):Create(cam,TweenInfo.new(0.16,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{CFrame = CFrame.new(0,0,3.5);}):Play();
			end
		end)

		viewport.CurrentCamera = cam;
	end)();
end

local update = function(category)
	local data = game.ReplicatedStorage.events.swordData:InvokeServer();
	for _,v in pairs(script.Parent:WaitForChild("Grid"):GetChildren()) do
		if(v:IsA("Frame")) then
			v:Destroy();
		end
	end
	for name,value in pairs(inventory:GetAttributes()) do
		if(value) then
			local e = name:gsub("_"," "):gsub("jw","'");
			if(data[e]) then
				if(data[e].category == category or category == "All") then
					local tier = script:WaitForChild(data[e].tier):Clone();
					tier.Frame.Label.Text = e;
					tier.Parent = script.Parent:WaitForChild("Grid");
					
					local entered = false;
					local mouse = game.Players.LocalPlayer:GetMouse();
					
					game:GetService("UserInputService").InputBegan:Connect(function(input)
						if(input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
							if(entered and (not script.Parent.ChooseSlot.Visible) and not shared.menu_open) then
								local sig;
								sig = input.Changed:Connect(function()
									if(input.UserInputState == Enum.UserInputState.End) then
										if(entered) then
											script.Parent.ChooseSlot.Initiate:Fire(data[e]);
										end
										sig:Disconnect()
									end
								end)
							end
						end
					end)
					
					tier.Background.MouseEnter:Connect(function()
						entered = true;
					end)
					
					tier.Background.MouseLeave:Connect(function()
						entered = false;
					end)

					local value = data[e]
					if(value.usesViewport) then
						tier.Background.Image.Image = "";
						local handle = createSwordViewport(value.handleObject);
						link(tier.Background.Viewport,handle,e);
					else
						local texture = value.textureId;
						tier.Background.Image.Image = texture;
					end
				end
			end
		end
	end
end

shared.get_item = function(name)
	local e = name:gsub("_"," "):gsub("jw","'");
	local data = game.ReplicatedStorage.events.swordData:InvokeServer();
	local tier = script:WaitForChild(data[e].tier):Clone();
	tier.Frame.Label.Text = e;
	tier.Parent = script.Parent:WaitForChild("Grid");
	tier.Size = UDim2.new(0,70,0,85);

	local value = data[e]
	if(value.usesViewport) then
		tier.Background.Image.Image = "";
		local handle = createSwordViewport(value.handleObject);
		link(tier.Background.Viewport,handle,e);
	else
		local texture = value.textureId;
		tier.Background.Image.Image = texture;
	end

	return tier;
end

for _,selection in pairs({"All","Limited","Time","Kills","Other"}) do
	script.Parent:WaitForChild("Selection"):WaitForChild(selection).MouseButton1Click:Connect(function()
		update(selection);
		currentPage = selection;
	end)
end

wait(1);

inventory.AttributeChanged:Connect(function()
	update(currentPage)
end);
update(currentPage);