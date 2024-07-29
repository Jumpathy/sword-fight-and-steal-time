local stat = script:WaitForChild("TextLabel"):Clone();
local player = game:GetService("Players").LocalPlayer;
local leaderstats = player:WaitForChild("leaderstats",50);
local format = require(script:WaitForChild("format"));
local labels = {};

function roundNumber(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

for _,name in pairs({"Time","Kills","Deaths","K/D","Streak"}) do
	local link = function()
		local value = leaderstats:WaitForChild(name).Value;
		if(name == "K/D") then
			value = roundNumber(value,1);
		else
			value = format.FormatStandard(value);
		end
		local label = labels[name] or script:WaitForChild("TextLabel"):Clone();
		label.Text = string.format([[ <font color = "rgb(150,150,150)" face="GothamSemibold">%s:</font> %s]],name,value);
		label.Parent = script.Parent;
		labels[name] = label;
	end
	leaderstats:WaitForChild(name):GetPropertyChangedSignal("Value"):Connect(link);
	link();
end