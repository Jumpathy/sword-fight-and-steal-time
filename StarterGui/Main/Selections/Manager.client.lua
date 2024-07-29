local functions = {};
local flags = {};
local hotbar = script.Parent.Parent:WaitForChild("Hotbar");
local buttons = hotbar.Parent:WaitForChild("Buttons");
local mouse = game:GetService("Players").LocalPlayer:GetMouse();
flags.settings = false;

functions.Settings = function()
	for flag,value in pairs(flags) do
		if(value and flag ~= "settings") then
			functions[flag:sub(1,1):upper()..flag:sub(2,#flag)]();
		end
	end
	flags.settings = not flags.settings;
	hotbar.Visible = not flags.settings;
	buttons.Visible = not flags.settings;
	shared.gui_open = flags.settings;
	script.Parent.Parent.Settings:TweenPosition(
		flags.settings and UDim2.new(0.5,0,0.5,0) or UDim2.new(0.5,0,-1,0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.25,
		true
	)
end

functions.Stats = function()
	for flag,value in pairs(flags) do
		if(value and flag ~= "stats") then
			functions[flag:sub(1,1):upper()..flag:sub(2,#flag)]();
		end
	end
	flags.stats = not flags.stats;
	hotbar.Visible = not flags.stats;
	buttons.Visible = not flags.stats;
	shared.gui_open = flags.stats;
	script.Parent.Parent.Stats:TweenPosition(
		flags.stats and UDim2.new(0.5,0,0.5,0) or UDim2.new(0.5,0,-1,0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.25,
		true
	)
end

functions.Shop = function()
	for flag,value in pairs(flags) do
		if(value and flag ~= "shop") then
			functions[flag:sub(1,1):upper()..flag:sub(2,#flag)]();
		end
	end
	flags.shop = not flags.shop;
	hotbar.Visible = not flags.shop;
	buttons.Visible = not flags.shop;
	script.Parent.Parent.Inventory.ChooseSlot.Visible = false;
	shared.gui_open = flags.shop;
	script.Parent.Parent.Shop:TweenPosition(
		flags.shop and UDim2.new(0.5,0,0.5,0) or UDim2.new(0.5,0,-1,0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.25,
		true
	)
end

functions.Inventory = function()
	for flag,value in pairs(flags) do
		if(value and flag ~= "inventory") then
			functions[flag:sub(1,1):upper()..flag:sub(2,#flag)]();
		end
	end
	pcall(function()
		shared.unequip_all();
	end)
	flags.inventory = not flags.inventory;
	hotbar.Visible = not flags.inventory;
	buttons.Visible = not flags.inventory;
	shared.gui_open = flags.inventory;
	script.Parent.Parent.Inventory:TweenPosition(
		flags.inventory and UDim2.new(0.5,0,0.5,0) or UDim2.new(0.5,0,-1,0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.25,
		true
	)
end

functions.Clans = function()
	for flag,value in pairs(flags) do
		if(value and flag ~= "clans") then
			functions[flag:sub(1,1):upper()..flag:sub(2,#flag)]();
		end
	end
	pcall(function()
		shared.unequip_all();
	end)
	flags.clans = not flags.clans;
	hotbar.Visible = not flags.clans;
	buttons.Visible = not flags.clans;
	shared.gui_open = flags.clans;
	script.Parent.Parent.Clans:TweenPosition(
		flags.clans and UDim2.new(0.5,0,0.5,0) or UDim2.new(0.5,0,-1,0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.25,
		true
	)
end

functions.Index = function()
	for flag,value in pairs(flags) do
		if(value and flag ~= "index") then
			functions[flag:sub(1,1):upper()..flag:sub(2,#flag)]();
		end
	end
	pcall(function()
		shared.unequip_all();
	end)
	flags.index = not flags.index;
	hotbar.Visible = not flags.index;
	buttons.Visible = not flags.index;
	shared.gui_open = flags.index;
	script.Parent.Parent.Index:TweenPosition(
		flags.index and UDim2.new(0.5,0,0.5,0) or UDim2.new(0.5,0,-1,0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.25,
		true
	)
end

local link = function(name,button)
	button.MouseButton1Click:Connect(functions[name]);
end

for _,v in pairs({"Inventory","Stats","Settings","Shop","Index","Clans"}) do
	local object = script.Parent:WaitForChild(v);
	if(object:IsA("ImageButton")) then
		link(v,object);
	else
		link(v,object:WaitForChild("Button"));
	end
end

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

local mobile = platform() == "Mobile";

for k,v in pairs({"Settings","Stats","Shop","Inventory","Index"}) do
	local e = script.Parent.Parent:WaitForChild(v);
	if(e:IsA("ObjectValue")) then
		e = e.Value;
	end
	
	local button = e:WaitForChild("Topbar"):WaitForChild("Close");
	button.MouseButton1Click:Connect(function()
		functions[v]();
	end)
	mouse.Move:Connect(function()
		button.Round.Visible = table.find(game:GetService("Players").LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(mouse.X,mouse.Y),button);
	end)
end

for k,v in pairs({"Inventory","Stats","Settings","Shop","Index","Clans"}) do
	local e = script.Parent:WaitForChild(v);
	if(e:IsA("ObjectValue")) then
		e = e.Value;
	end
	e:FindFirstChildOfClass("UISizeConstraint").MaxSize = Vector2.new(mobile and 35*1.5 or 35,mobile and 35*1.5 or 35);
	e.MouseEnter:Connect(function()
		e.TextLabel.Visible = true;
	end)
	e.MouseLeave:Connect(function()
		e.TextLabel.Visible = false;
	end)
end