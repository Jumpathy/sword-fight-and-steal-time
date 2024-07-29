local autofill = script.Parent.Label;
local box = script.Parent;

box:GetPropertyChangedSignal("Text"):Connect(function()
	autofill.Text = "";
	shared.lastName = 0;
	for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
		if(plr.DisplayName:sub(0,#box.Text) == box.Text and #box.Text >= 1) then
			autofill.Text = plr.DisplayName .. (plr.Name ~= plr.DisplayName and " @"..plr.Name or "");
			shared.lastName = plr.UserId;
		elseif(plr.Name:sub(0,#box.Text) == box.Text and #box.Text >= 1) then
			autofill.Text = plr.Name;
			shared.lastName = plr.UserId;
		end
	end
end)

game.ReplicatedStorage.request1v1.OnClientEvent:Connect(function()
	script.Parent.Parent.Parent.Parent.Position = UDim2.new(0.5,0,-1.25,0);
	box.Text = "";
	script.Parent.Parent.Parent.Parent:TweenPosition(UDim2.new(0.5,0,0.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true);
	
end)