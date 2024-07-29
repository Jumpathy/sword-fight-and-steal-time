local View = script.Parent;
while not _G.GetLibraries do wait() end;

-- Load libraries
local Support, Cheer = _G.GetLibraries(
	'F3X/SupportLibrary@^1.0.0',
	'F3X/Cheer@^0.0.0'
);

-- Create component
local Component = Cheer.CreateComponent('BTTooltip', View);

local Connections = {};

function Component.Start()

	-- Hide the view
	View.Visible = false;

	-- Show the tooltip on hover
	Connections.ShowOnEnter = Support.AddGuiInputListener(View.Parent, 'Began', 'MouseMovement', true, Component.Show);
	Connections.HideOnLeave = Support.AddGuiInputListener(View.Parent, 'Ended', 'MouseMovement', true, Component.Hide);

	-- Clear connections when the component is removed
	Component.OnRemove:connect(ClearConnections);

	-- Return component for chaining
	return Component;

end;

function Component.Show()
	View.Visible = true;
end;

function Component.Hide()
	View.Visible = false;
end;

function ClearConnections()
	-- Clears out temporary connections

	for ConnectionKey, Connection in pairs(Connections) do
		Connection:disconnect();
		Connections[ConnectionKey] = nil;
	end;

end;

return Component.Start();