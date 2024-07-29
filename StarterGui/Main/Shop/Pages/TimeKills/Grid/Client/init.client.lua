wait(2);
local data = game.ReplicatedStorage.events.swordData:InvokeServer();
local format = require(script:WaitForChild("format"));

script.Parent.CanvasSize = UDim2.new(0,0,0,script.Parent:WaitForChild("Layout").AbsoluteContentSize.Y);
script.Parent:WaitForChild("Layout"):GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	script.Parent.CanvasSize = UDim2.new(0,0,0,script.Parent.Layout.AbsoluteContentSize.Y);
end)

for swordName,data in pairs(data) do
	if(data.shopData) then
		if(not game.Players.LocalPlayer.Inventory:GetAttribute(data.name)) then
			local shopData = data.shopData;
			local instance = shared.get_item(data.name);
			instance.Parent = script.Parent;
			instance.Background.Txt.Font = Enum.Font.Gotham;
			instance.Background.Txt.TextSize = 12;
			instance.Background.Txt.Text = format.FormatStandard(data.shopData.price) .. " ".. data.shopData.category;
			local conn;
			local entered = false;
			
			local e = function()
				if(game:GetService("Players").LocalPlayer.leaderstats[data.shopData.category == "Time" and "Top Time" or "Kills"].Value >= data.shopData.price) then
					game.ReplicatedStorage.events.unlock:FireServer(swordName);
					--conn:Disconnect();
					for _,v in pairs(instance:GetDescendants()) do
						for _,property in pairs({"BackgroundTransparency","TextTransparency","ImageTransparency"}) do
							pcall(function()
								game:GetService("TweenService"):Create(v,TweenInfo.new(0.16,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{[property] = 1}):Play();
							end)
						end
					end
					wait(0.16);
					instance:Destroy();
				end
			end
			
			game:GetService("UserInputService").InputBegan:Connect(function(input)
				if(input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
					if(entered) then
						e();
					end
				end
			end)
			
			--conn = instance.Background.MouseButton1Click:Connect(e)

			instance.Background.MouseEnter:Connect(function()
				entered = true;
				instance.Background.Txt.Visible = true;
			end)
			instance.Background.MouseLeave:Connect(function()
				entered = false;
				instance.Background.Txt.Visible = false;
			end)
		end
	end
end