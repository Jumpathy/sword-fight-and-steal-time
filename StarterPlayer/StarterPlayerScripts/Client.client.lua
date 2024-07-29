coroutine.wrap(function()
	local board = workspace:WaitForChild("Map"):WaitForChild("Boards"):WaitForChild("TimeRain"):WaitForChild("BottomBoard"):WaitForChild("SurfaceGui"):WaitForChild("ScrollingFrame");
	local board2 = workspace:WaitForChild("Map"):WaitForChild("Boards"):WaitForChild("Donate"):WaitForChild("BottomBoard"):WaitForChild("SurfaceGui"):WaitForChild("ScrollingFrame");

	for k,v in pairs({"15","30","50","100","1500"}) do
		local main = board:WaitForChild(v);
		if(v == "1500") then
			main = main:WaitForChild("Label");
		end
		main.MouseButton1Click:Connect(function()
			if(v == "15") then
				game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer,1201515043);
			elseif(v == "30") then
				game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer,1201515110);
			elseif(v == "50") then
				game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer,1201515152);
			elseif(v == "100") then
				game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer,1201515195);
			elseif(v == "1500") then
				game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer,1201515272);
			end
		end)
	end

	local combination = function(o,c)
		o.MouseEnter:Connect(function()
			c(true);
		end)
		o.MouseLeave:Connect(function()
			c(false);
		end)
	end

	local products = {
		1201514826,
		1201514850,
		1201514869,
		1201514890,
		1201514922,
		1201514937
	}

	for k,v in pairs({"10","50","100","500","1000","5000"}) do
		local main = board2:WaitForChild(v);
		main.MouseButton1Click:Connect(function()
			game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer,products[k]);
		end)
	end
	
	local msg = function(title,text)
		game:GetService("StarterGui"):SetCore("SendNotification",{
			Title = title,
			Text = text,
			Duration = 5,
		})
	end
	game.ReplicatedStorage:WaitForChild("events"):WaitForChild("notif").OnClientEvent:Connect(msg);
	shared.doNotify = msg;

	local callback = function(item)
		local ogText = item.Text;
		local alternate = item:GetAttribute("AlternateText");
		combination(item,function(state)
			item.Text = (state and ogText .. alternate or ogText);
		end)
	end

	local functioned = {};
	game.ReplicatedStorage:WaitForChild("events"):WaitForChild("boardUpdate").OnClientEvent:Connect(function(board)
		for _,child in pairs(board:GetChildren()) do
			if(child:IsA("Frame")) then
				if(not functioned[child]) then
					functioned[child] = true;
					callback(child.User);
				end
			end
		end
	end)
	game.ReplicatedStorage:WaitForChild("events"):WaitForChild("boardUpdate"):FireServer();

	game.ReplicatedStorage:WaitForChild("events"):WaitForChild("1v1").OnClientEvent:Connect(function(data,initiator,key)
		if(data ~= "offerTp") then
			local callback = function(v)
				game.ReplicatedStorage:WaitForChild("events"):WaitForChild("1v1"):FireServer(v,key);
			end

			local bindable = Instance.new("BindableFunction");
			bindable.OnInvoke = callback;

			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = initiator,
				Text = "Sent you a 1v1 request!",
				Icon = "rbxassetid://7122571219",
				Duration = 15,
				Callback = bindable;
				Button1 = "Accept",
				Button2 = "Decline"
			})
		else
			local callback = function(v)
				if(v == "Yes") then
					game.ReplicatedStorage:WaitForChild("events"):WaitForChild("1v1"):FireServer("teleportTo1v1");
				end
			end

			local bindable = Instance.new("BindableFunction");
			bindable.OnInvoke = callback;

			game:GetService("StarterGui"):SetCore("SendNotification",{
				Title = initiator,
				Text = "Would you like to spectate the 1v1 that has just started?";
				Icon = "rbxassetid://7122571219",
				Duration = 20,
				Callback = bindable;
				Button1 = "Yes",
				Button2 = "No"
			})
		end
	end)

	coroutine.wrap(function()
		pcall(function()
			local coreCall do
				local MAX_RETRIES = 8

				local StarterGui = game:GetService('StarterGui')
				local RunService = game:GetService('RunService')

				function coreCall(method,...)
					local result = {}
					for retries = 1,MAX_RETRIES do
						result = {pcall(StarterGui[method],StarterGui,...)}
						if result[1] then
							break
						end
						RunService.Stepped:Wait()
					end
					return unpack(result)
				end
			end

			assert(coreCall('SetCore','ResetButtonCallback',false))
		end)
	end)();
end)();

coroutine.wrap(function()
	local event = game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("swordFX");

	local data = {};

	event.OnClientEvent:Connect(function(effectType,...)
		if(effectType == "lightning") then
			local a,b = ({...})[1],({...})[2];
			if(data[a] == nil) then
				data[a] = require(game.ReplicatedStorage.lightning).init(({...})[1],({...})[2]);
			end
		elseif(effectType == "undoLightning") then
			local a,b = ({...})[1],({...})[2];
			if(data[a]) then
				data[a]:Destroy();
				data[a] = nil;
			end
		elseif(effectType == "smite") then
			require(game.ReplicatedStorage.lightning).smite(({...})[1]);
		end
	end)
end)();

coroutine.wrap(function()
	local icon = require(game.ReplicatedStorage:WaitForChild("Icon"));
	local event = game.ReplicatedStorage:WaitForChild("events"):WaitForChild("ping");

	local fps = icon.new():setLabel("0 FPS")

	fps.selected:Connect(function()
		fps:deselect();
	end)

	local ping = icon.new():setLabel("0 ping")

	ping.selected:Connect(function()
		ping:deselect();
	end)

	local i = 0;
	local s = tick();
	game:GetService("RunService").RenderStepped:Connect(function()
		i += 1;
		if(tick()-s>=1) then
			s = tick();
			fps:setLabel(i .. " FPS");
			i = 0;
		end
	end)

	while wait(0.5) do
		local s = tick();
		event:InvokeServer();
		ping:setLabel(math.floor(((tick() - s) / 2) * 1000) .. " ping");
	end
end)();

coroutine.wrap(function()
	if(not game:IsLoaded()) then
		game.Loaded:Wait();
	end

	local cached,colors = {},{
		[80] = Color3.fromRGB(0,255,111),
		[60] = Color3.fromRGB(255,255,50),
		[40] = Color3.fromRGB(255,85,0),
		[20] = Color3.fromRGB(255,0,0)
	}

	local getTextSize = function(overhead)
		return game:GetService("TextService"):GetTextSize(
			"OnlyTwentyC",
			overhead.Username.AbsoluteSize.Y,
			overhead.Username.Font,
			Vector2.new(math.huge,math.huge)
		)
	end

	local getColor = function(n)
		local default = colors[20];
		local highest = 0;
		for num,col in pairs(colors) do
			if(num > highest and n >= num) then
				highest = num;
			end
		end
		return(highest > 1 and colors[highest] or default);
	end

	local cache = function(object)
		repeat
			game:GetService("RunService").Heartbeat:Wait();
		until(object.Parent ~= nil);

		cached[object] = true;
		local username = object:WaitForChild("Username");

		local humanoid = object.Parent.Parent:WaitForChild("Humanoid");
		humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			pcall(function()
				local health = humanoid.Health;
				local maxHealth = humanoid.MaxHealth;
				local percentage = health / maxHealth;
				local color = getColor(percentage*100);
				object.HP.Bar.BackgroundColor3 = color;
				object.HP.Bar:TweenSize(UDim2.new(percentage,0,1,0),Enum.EasingDirection.Out,Enum.EasingStyle.Bounce,0.16,true);
			end)
		end)
	end

	game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("onOverhead").OnClientEvent:Connect(function(overheads)
		for owner,overhead in pairs(overheads) do
			if(not cached[overhead]) then
				coroutine.wrap(cache)(overhead);
			end
		end
	end)

	game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("onOverhead"):FireServer();
end)();