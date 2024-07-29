local config = require(game.ReplicatedStorage:WaitForChild("config"));
local options = {"Gamepasses","Limited","TimeKills","Tags"};
local globalButtons = {};
local ripple_place = script.Parent.Parent:WaitForChild("Ripple_Bottom");
local pages = script.Parent.Parent:WaitForChild("Pages");

local ms = game.Players.LocalPlayer:GetMouse()
local Sample = Instance.new("ImageLabel")
Sample.Name = "Sample"
Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Sample.BackgroundTransparency = 1.000
Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
Sample.ImageTransparency = 0.600
Sample.ZIndex = 3;
Sample.ImageColor3 = Color3.fromRGB(148,227,255);

if(config.giftingEnabled or game:GetService("Players").LocalPlayer:GetRankInGroup(11241776) > 200) then
	table.insert(options,"Gifting");
end

local create_ripple = function(btn,container)
	coroutine.wrap(function()
		local c = Sample:Clone()
		c.Parent = container;
		local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
		c.Position = UDim2.new(0, x, 0, y)
		local len, size = 0.5, nil
		if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
			size = (btn.AbsoluteSize.X * 1.5)
		else
			size = (btn.AbsoluteSize.Y * 1.5)
		end
		c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
		for i = 1, 10 do
			c.ImageTransparency = c.ImageTransparency + 0.05
			wait(len / 12)
		end
		c:Destroy()
	end)();
end

local tweenColor = function(button,color)
	game:GetService("TweenService"):Create(button,TweenInfo.new(0.16,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0.1),{[button.ClassName == "TextButton" and "TextColor3" or "ImageColor3"] = color}):Play();
end

local selectedPage;
for _,option in pairs(options) do
	local ripple = ripple_place:WaitForChild(option);
	local buttons = {script.Parent:WaitForChild(option):WaitForChild("Button"),script.Parent:WaitForChild(option):WaitForChild("Text")};
	for i = 1,2 do
		table.insert(globalButtons,buttons[i]);
	end
	ripple.Visible = true;
	buttons[1].Parent.Visible = true;
	for _,button in pairs(buttons) do
		local selectFunc = function()
			local page = pages:WaitForChild(option);
			
			for _,v in pairs(globalButtons) do
				if(v.Parent.Name == button.Parent.Name) then
					tweenColor(v,Color3.fromRGB(148,227,255));
					tweenColor(v,Color3.fromRGB(148,227,255));
				else
					tweenColor(v,Color3.fromRGB(255,255,255));
					tweenColor(v,Color3.fromRGB(255,255,255));
				end
			end
			create_ripple(buttons[2],ripple.Container);
			
			if(selectedPage ~= option) then
				local direction = table.find(options,(selectedPage or option)) < table.find(options,option);
				local nextPagePosition = UDim2.new(0,0,0,0);
				local currentPagePosition = not direction and UDim2.new(1,0,0,0) or UDim2.new(-1,0,0,0);
				
				for _,p in pairs(pages:GetChildren()) do
					if(p == page) then
						p:TweenPosition(nextPagePosition,Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.16,true);
					else
						p:TweenPosition(currentPagePosition,Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.16,true);
					end
					p.Visible = (p.Name == option or p.Name == selectedPage);
				end
				selectedPage = option;
			end
		end
		button.MouseButton1Click:Connect(selectFunc);
		if(option == "Gamepasses") then
			selectFunc();
		end
	end
end