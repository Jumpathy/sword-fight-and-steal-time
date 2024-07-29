local config = require(script.Parent:WaitForChild("config"));
local tool = script.Parent;
local handle = tool:WaitForChild("Handle");
local mouse = game:GetService("Players").LocalPlayer:GetMouse();
local event = tool:WaitForChild("interact");
local hitbox = require(script:WaitForChild("hitbox"));
local args = {tool,handle,event,hitbox};

require(script:WaitForChild("init"))(unpack(args));

local updateIcon = function()
	mouse.Icon = (tool.Enabled and config.Mouse.MouseIcon or config.Mouse.ReloadingIcon);
end

local onEquipped = function(toolMouse)
	shared.lastEquip = tick();
	updateIcon();
end

tool.Equipped:Connect(onEquipped);
tool:GetPropertyChangedSignal("Enabled"):Connect(function()
	game:GetService("RunService").Heartbeat:Wait();
	updateIcon();
end);
game:GetService("RunService").Heartbeat:Wait();
config.KillEffect = nil;
script.Parent.loader.Parent = nil;
script.Parent.config.Parent = nil;
script.init.Parent = nil;
script.hitbox:Destroy();