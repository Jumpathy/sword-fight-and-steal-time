local tool = script.Parent;
local swordModule = game:GetService("ServerStorage"):WaitForChild("logic"):WaitForChild("sword");
local configuration = require(tool:WaitForChild("config"));

require(swordModule)(
	tool,configuration
)