local event = script.Parent:WaitForChild("Initiate");
local slots = script.Parent:WaitForChild("Slots");
local inventory = game:GetService("Players").LocalPlayer:WaitForChild("Inventory");
local selectedItems = inventory:WaitForChild("Selected");
local lastLoaded = true;
local slotItem = {};
local data = game.ReplicatedStorage.events.swordData:InvokeServer();
local config = require(game:GetService("ReplicatedStorage"):WaitForChild("config"));

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

		viewport.CurrentCamera = cam;
		viewport.BackgroundColor3 = Color3.fromRGB(0,0,0);
	end)();
end

event.Event:Connect(function(itemData)
	shared.menu_open = true;
	if(not lastLoaded) then
		repeat
			wait()
		until lastLoaded
	end
	lastLoaded = false;
	
	local items = selectedItems:GetAttributes();
	
	for i = 1,5 do
		pcall(function()
			slotItem[i]:Destroy();
		end)
	end
	
	for name,value in pairs(items) do
		local slotNumber = tonumber(name:sub(5,5));
		local item = value;
		local swordData = data[value:gsub("_"," "):gsub("jw","'")];
		
		if(not swordData) then
			swordData = data["Sword"];
		end
		
		local mouseEnter = false;
		local slot = script:WaitForChild("slot"):Clone();
		slot.SlotNumber.Text = tostring(slotNumber);
		slot.Image.Image = not swordData.usesViewport and swordData.textureId or "";
		slot.LayoutOrder = slotNumber;
		slot.Parent = slots;
		
		game:GetService("UserInputService").InputBegan:Connect(function(input)
			if(input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
				if(mouseEnter and slot:GetFullName() ~= slot.Name and script.Parent.Visible) then
					game:GetService("RunService").Heartbeat:Wait();
					game:GetService("RunService").Heartbeat:Wait();
					game:GetService("RunService").Heartbeat:Wait();

					game.ReplicatedStorage.events.pickSlot:FireServer(slotNumber,itemData.name);
					script.Parent.Visible = false;
					for i = 1,5 do
						pcall(function()
							slotItem[i]:Destroy();
						end)
					end
					shared.menu_open = false;
				end
			end
		end)
		
		slot.MouseEnter:Connect(function()
			mouseEnter = true;
		end)

		slot.MouseLeave:Connect(function()
			mouseEnter = false;
		end)
		
		if(swordData.usesViewport) then
			local handle = createSwordViewport(swordData.handleObject);
			link(slot.Viewport,handle,value:gsub("_"," "):gsub("jw","'"));
		end
		slotItem[slotNumber] = slot;
	end
	
	script.Parent.Visible = true;
	lastLoaded = true;
	shared.menu_open = true;
end)