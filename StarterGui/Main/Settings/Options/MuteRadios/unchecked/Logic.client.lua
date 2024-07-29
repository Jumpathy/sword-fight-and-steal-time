local toggle = script.Parent;
local filled = toggle.filled;
local cover = toggle.Cover;
local state = false;
local tweening = false;
local key;

local options = {Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.16,true};
local original = {};

local clicked = function()
	state = not state;
	key = game:GetService("HttpService"):GenerateGUID();
	local last = key;
	tweening = true;
	if(state) then
		filled:TweenSize(UDim2.new(1,0,1,0),unpack(options));
		cover:TweenSize(UDim2.new(0,0,0,0),unpack(options));

	else
		filled:TweenSize(UDim2.new(0,0,0,0),unpack(options));
		cover:TweenSize(UDim2.new(1,0,1,0),unpack(options));
	end

	game.ReplicatedStorage.events.setSetting:FireServer("muteRadios",state);
	toggle.Circle.Size = UDim2.new(0,0,0,0);
	toggle.Circle.ImageTransparency = 0.8;
	toggle.Circle:TweenSize(UDim2.new(1.5,0,1.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true);
	game:GetService("TweenService"):Create(toggle.Circle,TweenInfo.new(0.75),{ImageTransparency = 1}):Play();
	coroutine.wrap(function()
		wait(0.3);
		if(key == last) then
			tweening = false;
		end
	end)();
end

toggle.MouseButton1Click:Connect(clicked);
filled.MouseButton1Click:Connect(clicked);

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("getOptions").OnClientEvent:Connect(function(data)
	if(data.muteRadios) then
		if(not state) then
			clicked();
		end
	end
end)

script.Parent.MouseLeave:Connect(function()
	if(not tweening) then
		toggle.Circle.ImageTransparency = 0.8;
		toggle.Circle:TweenSize(UDim2.new(0,0,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true);
	end
end)

script.Parent.MouseEnter:Connect(function()
	if(not tweening and not state) then
		toggle.Circle.ImageTransparency = 0.8;
		toggle.Circle.Size = UDim2.new(0,0,0,0);
		toggle.Circle:TweenSize(UDim2.new(1.5,0,1.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true);
	end
end)

while wait() do
	local sounds = game.ReplicatedStorage.events.getRadioSounds:InvokeServer();
	for k,v in pairs(sounds) do
		if(not original[v]) then
			original[v] = v.Volume;
		end
		v.Volume = state and 0 or original[v];
	end
end