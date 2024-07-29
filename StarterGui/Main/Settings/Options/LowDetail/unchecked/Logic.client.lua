local toggle = script.Parent;
local filled = toggle.filled;
local cover = toggle.Cover;
local state = false;
local tweening,key = nil,nil;

local options = {Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.16,true};
local original,cached = {},{};
local connected = false;

local signalChanged = Instance.new("BindableEvent");
signalChanged:Fire();

local connect = function(object)
	object.Enabled = not state;
end

local item = function(obj)
	if(obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Sparkles") or obj:IsA("Trail")) then
		if(not cached[obj]) then
			cached[obj] = obj;
			local connection;
			connect(obj);
			connection = signalChanged.Event:Connect(function()
				if(obj:GetFullName() ~= obj.Name) then
					connect(obj);
				else
					connection:Disconnect();
				end
			end)
		end
	end
end

local on = function(bool)
	if(not connected) then
		connected = true;
		workspace.DescendantAdded:Connect(item);
		for _,obj in pairs(workspace:GetDescendants()) do
			item(obj);
		end
	end
	signalChanged:Fire(bool);
end

local clicked = function()
	key = tick();
	local last = key;
	state = not state;
	tweening = true;
	if(state) then
		filled:TweenSize(UDim2.new(1,0,1,0),unpack(options));
		cover:TweenSize(UDim2.new(0,0,0,0),unpack(options));
	else
		filled:TweenSize(UDim2.new(0,0,0,0),unpack(options));
		cover:TweenSize(UDim2.new(1,0,1,0),unpack(options));
	end
	game.ReplicatedStorage.events.setSetting:FireServer("lowDetail",state);
	on(state);
	
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

game.ReplicatedStorage:WaitForChild("events"):WaitForChild("getOptions").OnClientEvent:Connect(function(data)
	if(data.lowDetail) then
		if(not state) then
			clicked();
		end
	end
end)

toggle.MouseButton1Click:Connect(clicked);
filled.MouseButton1Click:Connect(clicked);