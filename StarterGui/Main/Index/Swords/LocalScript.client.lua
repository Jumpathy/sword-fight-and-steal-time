local swords = game.ReplicatedStorage.events.swordData:InvokeServer();
local config = require(game:GetService("ReplicatedStorage"):WaitForChild("config"));

local create = function(data)
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

local tierPriority = {
	["Rainbow"] = {1,"Unobtainables"},
	["White"] = {1,"Unobtainables"},
	["Black"] = {3,"Exotic"},
	["Golden"] = {2,"Godly"},
	["Cyan"] = {1,"Unobtainables"},
	["Mythical"] = {4,"Mythical"},
	["Legendary"] = {5,"Legendary"},
	["Rare"] = {6,"Rare"};
	["Uncommon"] = {7,"Uncommon"},
	["Common"] = {8,"Common"},
}

for k,sword in pairs(swords) do
	if(sword.unlisted == false) then
		local template = script.Frame:Clone();

		if(sword.usesViewport) then
			local handle = create(sword.handleObject);
			handle.Parent = template.Image.Viewport;
			link(template.Image.Viewport,handle,k);
		else
			template.Image.Image.Image = sword.textureId;
		end
				
		template.LayoutOrder = tierPriority[sword.tier][1];
		template.Desc.Text = sword.description;
		template:FindFirstChild("Name").Text = k;
		template.Tier.Text = tierPriority[sword.tier][2];

		template.Parent = script.Parent;
		script.Parent.CanvasSize = UDim2.new(1,0,0,script.Parent:FindFirstChildOfClass("UIListLayout").AbsoluteContentSize.Y);
	end	
end