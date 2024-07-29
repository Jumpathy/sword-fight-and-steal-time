local autofill = script.Parent.Label;
local box = script.Parent;
shared.lastSelectedName = 0;

box:GetPropertyChangedSignal("Text"):Connect(function()
	autofill.Text = "";
	shared.lastSelectedName = 0;
	for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
		if(plr.DisplayName:sub(0,#box.Text) == box.Text and #box.Text >= 1) then
			autofill.Text = plr.DisplayName .. (plr.Name ~= plr.DisplayName and " @"..plr.Name or "");
			shared.lastSelectedName = plr.UserId;
		elseif(plr.Name:sub(0,#box.Text) == box.Text and #box.Text >= 1) then
			autofill.Text = plr.Name;
			shared.lastSelectedName = plr.UserId;
		end
	end
end)