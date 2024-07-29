local starterGui = game:GetService("StarterGui");
starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false);

local config = require(game.ReplicatedStorage:WaitForChild("config"));

local localPlayer = game:GetService("Players").LocalPlayer;
local equipped;
local lastObject;
local templates = {};
local order = {};
local viewports = {};
local connection;

local equip;
local link;
local add;

local setup = function()
	if(connection) then
		connection:Disconnect();
		connection = nil;
	end
	templates = {};
	equipped = nil;
	lastObject = nil;
	order = {};
	viewports = {};
	local equippedItem = nil;

	for _,obj in pairs(script.Parent:GetChildren()) do
		if(obj.ClassName ~= "UIListLayout" and obj.ClassName ~= "LocalScript") then
			obj:Destroy();
		end
	end

	equip = function(object)
		if(script.Parent.Visible and object ~= nil) then
			localPlayer.Character.Humanoid:UnequipTools();
			if(equipped == nil or equipped ~= object) then
				if(object:GetAttribute("UseViewport")) then
					equippedItem = object;
					viewports[object](true);
				end
				equipped = object;
				localPlayer.Character.Humanoid:EquipTool(object);
				lastObject = object;
			else
				if(equipped:GetAttribute("UseViewport")) then
					equippedItem = nil;
					viewports[equipped](false);
				end
				equipped = nil;
				lastObject = nil;
			end
			for k,v in pairs(templates) do
				v.Border.BackgroundColor3 = Color3.fromRGB(40,40,40);
			end
			templates[object].Border.BackgroundColor3 = (equipped == object and Color3.fromRGB(255,255,255) or Color3.fromRGB(40,40,40))
		end	
	end

	link = function(viewport,handle,name)
		local main = handle;
		handle = handle:WaitForChild("Handle");
		coroutine.wrap(function()
			local cam = Instance.new("Camera");
			cam.Parent = viewport;
			cam.CFrame = CFrame.new(0, 0, 3.5);
			cam.CameraType = Enum.CameraType.Scriptable;

			viewport.BackgroundColor3 = Color3.fromRGB(0,0,0);

			local c = config.swordOffsets[name];
			handle = handle:Clone();
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
			
			local forced = false;
			
			viewports[main] = function(bool)
				forced = bool;
				local state = bool;
				if(state) then
					game:GetService("TweenService"):Create(cam,TweenInfo.new(0.16,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{CFrame = CFrame.new(0,0,3);}):Play();
				else
					game:GetService("TweenService"):Create(cam,TweenInfo.new(0.16,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{CFrame = CFrame.new(0,0,3.5);}):Play();
				end
			end

			combo(viewport,function(state)
				if(not forced) then
				if(state) then
					game:GetService("TweenService"):Create(cam,TweenInfo.new(0.16,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{CFrame = CFrame.new(0,0,3);}):Play();
				else
					game:GetService("TweenService"):Create(cam,TweenInfo.new(0.16,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{CFrame = CFrame.new(0,0,3.5);}):Play();
					end
				end
			end)

			viewport.CurrentCamera = cam;
		end)();
	end

	add = function(object)
		if(object:IsA("Tool")) then
			local template = templates[object] or script:WaitForChild("Object"):Clone();
			template.Parent = script.Parent;
			if(not templates[object]) then
				if(object:GetAttribute("UseViewport")) then
					template.Image.Image = "";
					link(template.Viewport,object,object.Name);
				else
					template.Image.Image = object.TextureId;
				end
			end
			templates[object] = template;

			if(not table.find(order,object)) then
				coroutine.wrap(function()
					local sin = false;
					template.MouseEnter:Connect(function()
						sin = true;
					end)
					template.MouseLeave:Connect(function()
						sin = false;
					end)
					game:GetService("UserInputService").InputBegan:Connect(function(input)
						if(input.UserInputType  == Enum.UserInputType.MouseButton1) then
							if(sin) then
								equip(object);
							end
						elseif(input.UserInputType == Enum.UserInputType.Touch) then
							game:GetService("RunService").Heartbeat:Wait();
							if(sin) then
								equip(object);
							end
						end
					end)
				end)();
				order[object:GetAttribute("Order") or game:GetService("HttpService"):GenerateGUID()] = object;
				template.LayoutOrder = object:GetAttribute("Order") or #order;
				local signal;
				signal = game:GetService("RunService").Heartbeat:Connect(function()
					if(object:GetFullName() == object.Name) then
						pcall(function()
							templates[object]:Destroy();
							templates[object] = nil;
							object:Destroy();
							signal:Disconnect();
						end)
					end
				end)
			end
		end
	end

	connection = localPlayer.Backpack.ChildAdded:Connect(add);
	for k,v in pairs(localPlayer.Backpack:GetChildren()) do
		add(v);
	end
end

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(setup);
if(game:GetService("Players").LocalPlayer.Character) then
	setup();
end

game:GetService("Players").LocalPlayer:GetMouse().KeyDown:Connect(function(key)
	if(tonumber(key)) then
		pcall(function()
			if(not shared.gui_open) then
				equip(order[tonumber(key)]);
			end
		end)
	end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input,gp)
	if(input.KeyCode == Enum.KeyCode.Backspace and not gp) then
		if(lastObject) then
			if(not shared.gui_open) then
				equip(lastObject);
			end
		end
	end
end)

function shared.unequip_all()
	if(lastObject) then
		equip(lastObject);
	end
end