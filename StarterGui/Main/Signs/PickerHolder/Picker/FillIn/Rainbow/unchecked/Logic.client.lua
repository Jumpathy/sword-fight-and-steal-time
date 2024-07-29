local toggle = script.Parent;
local filled = toggle.filled;
local cover = toggle.Cover;
local state = false;

local options = {Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.16,true};
local original = {};

local clicked = function()
	state = not state;
	if(state) then
		filled:TweenSize(UDim2.new(1,0,1,0),unpack(options));
		cover:TweenSize(UDim2.new(0,0,0,0),unpack(options));
	else
		filled:TweenSize(UDim2.new(0,0,0,0),unpack(options));
		cover:TweenSize(UDim2.new(1,0,1,0),unpack(options));
	end
	game.ReplicatedStorage.events.overheadInteraction:FireServer("setRainbow",state);
	shared.rainbow_enabled = state;
	shared.doUpdate();
	
	toggle.Circle.Size = UDim2.new(0,0,0,0);
	toggle.Circle.ImageTransparency = 0.8;
	toggle.Circle:TweenSize(UDim2.new(1.5,0,1.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true);
	game:GetService("TweenService"):Create(toggle.Circle,TweenInfo.new(0.75),{ImageTransparency = 1}):Play();
end

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("getOptions").OnClientEvent:Connect(function(data)
	if(data.colorPicker and data.colorPicker.rainbow) then
		if(not state) then
			clicked();
		end
	end
end)

toggle.MouseButton1Click:Connect(clicked);
filled.MouseButton1Click:Connect(clicked);