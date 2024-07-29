local link = function(id,callback)
	local cache = {};
	game.ReplicatedStorage:WaitForChild("events").getOwnedPasses.OnClientEvent:Connect(function(owned)
		if(owned[id] and not cache[id]) then
			cache[id] = true;
			callback();
		end
	end)
	game.ReplicatedStorage:WaitForChild("events").getOwnedPasses:FireServer();
end

link("Instant Respawn",function()
	local toggle = script:WaitForChild("InstantRespawn");
	toggle.unchecked.Logic.Disabled = false;
	toggle.Parent = script.Parent;
end)

link("Colored Username",function()
	script:WaitForChild("ColorPicker").Parent = script.Parent;
end)