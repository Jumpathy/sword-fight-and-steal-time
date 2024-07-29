local platform = function()
	--------------- Variables: ---------------

	local pf = "Desktop";
	local uis = game:GetService("UserInputService");
	local guis = game:GetService("GuiService");

	--------------- Detection: ---------------

	if(uis.TouchEnabled) then 
		if(uis.GyroscopeEnabled or uis.AccelerometerEnabled) then  
			pf = "Mobile";
		end
	else
		if(guis:IsTenFootInterface()) then 
			pf = "Console";
		end
	end

	--------------- Return: ---------------

	return pf;
end

if(platform() == "Desktop") then
	script.Parent.TextLabel:FindFirstChildOfClass("UITextSizeConstraint").MaxTextSize = 14;
elseif(platform() == "Mobile") then
	script.Parent.TextLabel:FindFirstChildOfClass("UITextSizeConstraint").MaxTextSize = 10;
else
	script.Parent.TextLabel:FindFirstChildOfClass("UITextSizeConstraint").MaxTextSize = 15;
end