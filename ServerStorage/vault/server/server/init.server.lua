local timeRain = function(name,amount,del,attribute)
	local tweenService = game:GetService("TweenService")
	local info = TweenInfo.new(5)

	local function tweenModel(model, CF)
		local CFrameValue = Instance.new("CFrameValue")
		CFrameValue.Value = model:GetPrimaryPartCFrame()

		CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
			model:SetPrimaryPartCFrame(CFrameValue.Value)
		end)

		local tween = tweenService:Create(CFrameValue, info, {Value = CF})
		tween:Play()

		tween.Completed:Connect(function()
			model.Rotate.Disabled = false;
			CFrameValue:Destroy()
		end)
	end

	local copy = function(tbl)
		local shallow = {};
		for k,v in pairs(tbl) do
			shallow[k] = v;
		end
		return shallow;
	end

	local standard = "(Really red / **AN ADMINISTRATOR GEM HAS BEEN SPAWNED, THIS HAS AN INCREDIBLE AMOUNT OF TIME.**)"
	game:GetService("ReplicatedStorage").events.makeMsg:FireAllClients(standard);

	local timePositions = copy(require(game:GetService("ReplicatedStorage"):WaitForChild("timeRainPositions")));
	local randomPositions = {};

	for i = 1,amount do
		local key = math.random(1,#timePositions);
		table.insert(randomPositions,timePositions[key]);
		table.remove(timePositions,key);
	end

	for _,position in pairs(randomPositions) do
		local gem = game:GetService("ServerStorage").particles.TimeGem:Clone();
		gem:SetPrimaryPartCFrame(CFrame.new(position.X,position.Y,position.Z));
		gem.Parent = workspace;
		if(attribute) then
			gem:SetAttribute(attribute,true);
		end
		tweenModel(gem,CFrame.new(position.X,1.875,position.Z))
		if(not del == 0) then
			wait(del or 1);
		end
	end
end

timeRain("Jumpathy",1,nil,"ADMIN")