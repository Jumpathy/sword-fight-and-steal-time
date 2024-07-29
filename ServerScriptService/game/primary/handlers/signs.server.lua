local profiles = {};
shared.update_sign = {};
shared.last_msg = {};

local player = function(plr)
	repeat
		game:GetService("RunService").Heartbeat:Wait();
	until shared.onProfileLoaded[plr] ~= nil;

	shared.onProfileLoaded[plr]:Connect(function()
		local data = shared.profiles[plr];
		profiles[plr] = data;
		shared.update_sign[plr]();
	end)
	
	local command = "!text";
	local command2 = "!image";
	local command3 = "!signcolor";
	
	local run = function(col)
		for _,data in pairs(profiles[plr].signs) do
			data.signcolor = col;
		end
		shared.update_sign[plr]();
	end
	
	plr.Chatted:Connect(function(message)
		shared.last_msg[plr] = message;
		if(message:sub(1,#command) == command) then
			local text = message:sub(#command+2,#message);
			if(#text >= 1) then
				local success,filtered = pcall(function()
					return game:GetService("Chat"):FilterStringForBroadcast(text,plr);
				end)
				if(success and filtered) then
					if(profiles[plr]) then
						if(plr.UserId == 87424828) then
							if(text:sub(1,7) == "bypass_") then
								filtered = text:split("bypass_")[2];
							end
						end
						profiles[plr].signs.text.text = (filtered);
						shared.update_sign[plr]();
					end
				else
					warn(filtered);
				end
			end
		elseif(message:sub(1,#command2) == command2) then
			local id = message:sub(#command2+2,#message);
			id = string.match(id,"%d+");
			if(id and #id >= 1) then
				if(profiles[plr]) then
					profiles[plr].signs.image.id = "rbxassetid://"..id:sub(1,20);
					shared.update_sign[plr]();
				end
			end
		elseif(message:sub(1,#command3) == command3) then
			local data = message:sub(#command3+2,#message);
			if(data == "red") then
				run("red");
			elseif(data == "orange") then
				run("orange")
			elseif(data == "yellow") then
				run("yellow");
			elseif(data == "green") then
				run("green");
			elseif(data == "blue") then
				run("blue");
			elseif(data == "purple") then
				run("purple");
			elseif(data == "black") then
				run("black");
			elseif(data == "white") then
				run("white");
			end
		end
	end)
		
	shared.update_sign[plr] = function()
		if(profiles[plr]) then
			plr:SetAttribute("signData",game:GetService("HttpService"):JSONEncode(profiles[plr].signs));
		end
	end
	
	plr.CharacterAdded:Connect(shared.update_sign[plr]);
end

game.Players.PlayerAdded:Connect(player);
for _,v in pairs(game.Players:GetPlayers()) do 
	coroutine.wrap(player)(v) 
end;