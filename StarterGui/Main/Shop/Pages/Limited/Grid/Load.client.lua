local shop = game:GetService("ReplicatedStorage"):WaitForChild("shop");
local passes = shop:WaitForChild("limiteds");
local amount = passes:WaitForChild("numPasses").Value;

if(not #passes:GetChildren() == amount + 1) then
	repeat 
		game:GetService("RunService").Heartbeat:Wait()
	until #passes:GetChildren() == amount + 1
end

local getImage = function(id,infoType)
	local success,result = pcall(function()
		return game:GetService("MarketplaceService"):GetProductInfo(id,infoType);
	end)
	return result and "rbxassetid://"..result.IconImageAssetId or "";
end

local viewportSize = function(callback)
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		game:GetService("RunService").Heartbeat:Wait();
		callback(workspace.CurrentCamera.ViewportSize);
	end);
	callback(workspace.CurrentCamera.ViewportSize);
end

viewportSize(function(size)
	local d = math.clamp(math.floor((size.X * .092336103416436)),0,100);
	script.Parent.Layout.CellSize = UDim2.new(0,d,0,d);
end)

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

for _,gamepass in pairs(passes:GetChildren()) do
	if(gamepass:IsA("Folder")) then
		local name = gamepass:WaitForChild("name").Value;
		local id = gamepass:WaitForChild("id").Value;
		local description = gamepass:WaitForChild("description").Value;
		local owns = false;

		local template = script:WaitForChild("GamePass"):Clone();
		local image = getImage(id,Enum.InfoType.GamePass);
		template.Button.Image = image;
		template.DisplayName.Text = name;
		template.Parent = script.Parent;

		template.Button.MouseButton1Click:Connect(function()
			if(not owns) then
				game:GetService("MarketplaceService"):PromptGamePassPurchase(game:GetService("Players").LocalPlayer,id);
			end
		end)

		if(gamepass:FindFirstChild("internalName")) then
			name = gamepass.internalName.Value;
		end

		link(name,function()
			owns = true;
			template.Button.Image = gamepass.blurImage.Value;
			--template.Button.Owns.Visible = false;
			template.DisplayName.Text = "Owned";
		end)
	end
end