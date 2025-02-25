--[[
	This module sets up the bubble chat system by linking all the internal modules together.
]]

--------------- Load: ---------------

if(not game:IsLoaded()) then
	game.Loaded:Wait();
end

--------------- Variables: ---------------

local onFiltered = Instance.new("BindableEvent");
local typingIndicator = Instance.new("BindableEvent");
local indicatorEvent = game.ReplicatedStorage.events.typingIndicator;

--------------- Functions: ---------------

local mentionTag = function(name)
	return "@" .. name;
end

local getColorTag = function(text,color)
	local tbl = {color.R,color.G,color.B};
	for i = 1,#tbl do
		tbl[i] = tostring(math.floor(tbl[i]*255));
	end
	return '<font color="rgb('..table.concat(tbl,",")..')">'..text..'</font>';
end

local markMentions = function(message)
	return message;
end

local connect = function(functions,player)
	local indicator = functions.chatBubble.typingIndicator();
	indicator.Name = "TypingIndicator";
	
	local down = function()
		functions.stack:pushDown(true,functions.stack:getKey(indicator),false);
		indicator.Visible = false;
	end
	
	local connection;
	connection = onFiltered.Event:Connect(function(messageObject)
		if(messageObject.Player and messageObject.Player == player) then
			down();
			local container = functions.ui.Container;
			local sentMessage = messageObject.Message;
			local bubble,connection = functions.chatBubble.create(markMentions(sentMessage));
			local conn;
			conn = game:GetService("RunService").Heartbeat:Connect(function()
				if(bubble:GetFullName() == bubble.Name) then
					conn:Disconnect();
					connection:Disconnect();
				end
			end)
		end
	end)
	
	local connection2;
	local wasTyping = false;
	connection2 = typingIndicator.Event:Connect(function(plr,isTyping)
		if(plr == player) then
			if(isTyping) then
				down();
				pcall(function()
					indicator.Caret.ImageTransparency = 0;
				end)
				indicator.Visible = true;
				functions.stack:push(indicator,indicator,true);
			else
				down();
			end
		end
	end)

	return function()
		connection:Disconnect();
	end
end

shared.fire_event = function(message,plr)
	message.Player = plr;
	onFiltered:Fire(message);
end

local bindToPlayer = function(player)
	local load = function(character)
		local billboardGui = require(script:WaitForChild("billboardGui"));
		local functions = billboardGui.create(character:WaitForChild("Head"),player.UserId,player);
		local disconnect = connect(functions,player)
		local connection;
		connection = game:GetService("RunService").Heartbeat:Connect(function()
			if(character:GetFullName() == character.Name) then
				connection:Disconnect();
				disconnect();
				functions.ui:Destroy();
			end
		end)
	end

	player.CharacterAdded:Connect(load);
	if(player.Character) then
		load(player.Character);
	end
end

indicatorEvent.OnClientEvent:Connect(function(p,v)
	typingIndicator:Fire(p,v);
end)

--------------- Connections: ---------------

for _,player in pairs(game:GetService("Players"):GetPlayers()) do
	coroutine.wrap(function()
		bindToPlayer(player);
	end)();
end
game:GetService("Players").PlayerAdded:Connect(bindToPlayer);

return require(script:WaitForChild("apiAccess"));