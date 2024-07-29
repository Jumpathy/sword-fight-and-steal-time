local objects = {};

game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("killfeed").OnClientEvent:Connect(function(killer,target,distance)
	local template = script.Frame:Clone();
	template.Parent = script.Parent;
	
	if(#objects >= 4) then
		objects[1]:Destroy();
		table.remove(objects,1);
	end

	local textSize = template.TextLabel.AbsoluteSize.Y;
	template.Parent = script;

	local raw = killer.." killed " .. target .. " from a distance of " .. distance .. " studs   ";
	local rich = string.format([[<font color = "rgb(150,150,150)" face="GothamSemibold">%s</font> killed <font color = "rgb(150,150,150)" face="GothamSemibold">%s</font> from a distance of <font color = "rgb(150,150,150)" face="GothamSemibold">%s studs</font>]],killer,target,distance)
	local s = game:GetService("TextService"):GetTextSize(raw,textSize,Enum.Font.Gotham,Vector2.new(math.huge,math.huge));

	template.Size = UDim2.new(0,s.X,0,s.Y*2);
	template.TextLabel.TextSize = textSize;
	template.Parent = script.Parent;
	template.TextLabel.Text = rich;
	table.insert(objects,template);
	
	wait(2);
	if(table.find(objects,template)) then
		game:GetService("TweenService"):Create(template,TweenInfo.new(0.16),{Transparency = 1}):Play();
		game:GetService("TweenService"):Create(template.TextLabel,TweenInfo.new(0.16),{TextTransparency = 1}):Play();
		wait(0.16);
		if(table.find(objects,template)) then
			template:Destroy();
			table.remove(objects,table.find(objects,template));
		end
	end
end)