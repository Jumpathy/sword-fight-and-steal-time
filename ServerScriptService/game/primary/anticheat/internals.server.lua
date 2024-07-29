local communication = game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("communicate");
local _,zip = require(game.ReplicatedStorage:WaitForChild("DontFall"))();
local strikes = {};

local utility = {};
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

function utility.base64decode(data)
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

function utility.base64encode(data)
	return ((data:gsub('.', function(x) 
		local r,b='',x:byte()
		for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
		return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c=0
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
		return b:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#data%3+1])
end

local decode = function(tbl)
	local new = {};
	local tbl = game:GetService("HttpService"):JSONDecode(zip.Zlib.Decompress(utility.base64decode(tbl),{
		strategy = "dynamic",
		level = 9
	}));
	for k,v in pairs(tbl) do
		local key = utility.base64decode(k);
		local t = v:sub(1,1);
		local v = utility.base64decode(v:sub(2,#v));
		local typeOf = t == "b" and "bool" or t == "s" and "string" or t == "n" and "number";
		if(typeOf == "bool") then
			v = (v == "true");
		elseif(typeOf == "string") then
			v = v;
		elseif(typeOf == "number") then
			v = tonumber(v);
		end
		new[key] = v;
	end
	return new;
end

local encode = function(tbl)
	local new = {};
	for k,v in pairs(tbl) do
		new[utility.base64encode(k)] = typeof(v):sub(1,1)..utility.base64encode(tostring(v));
	end
	return utility.compress(game:GetService("HttpService"):JSONEncode(new));
end

local find = function(char)
	for k,v in pairs(char:GetDescendants()) do
		if(v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("BodyMover") or v:IsA("BodyGyro")) then
			return true;
		end
	end
	return false;
end

local player = function(plr)
	local charRemoved = false;
	local charAdded = tick();
	plr:SetAttribute("id",game:GetService("HttpService"):GenerateGUID());
	local func = function(char)
		plr:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("Hotbar").Visible = true;
		charAdded = tick();
		strikes[plr] = {};
	end
	if(plr.Character) then
		func(plr.Character);
	end
	plr.CharacterAdded:Connect(function(c)
		func(c);
		charRemoved = false;
	end)
	plr.CharacterRemoving:Connect(function()
		charRemoved = true;
		plr:SetAttribute("id",game:GetService("HttpService"):GenerateGUID());
	end)
	while wait(1) do
		if(strikes[plr]) then
			if(#strikes[plr] == 0) then
				coroutine.wrap(function()
					wait(10);
					if(#strikes[plr] == 0 and (tick()-charAdded) > 4 and not game:GetService("RunService"):IsStudio()) then
						--plr:Kick("[Unexpected error 3]");
					end
				end)();
			elseif(tick()-strikes[plr][#strikes[plr]] > 2) then
				--plr:Kick("[Unexpected error 4]");
			end
		end
	end
end
for k,v in pairs(game:GetService("Players"):GetPlayers()) do
	player(v);
end
game:GetService("Players").PlayerAdded:Connect(player);

local kicked = {};
communication.OnServerEvent:Connect(function(player,data)
	local success,tbl = pcall(function()
		return decode(data:sub(1,2000));
	end)
	if(not success) then
	elseif(tbl and tick()-tbl.tick <= 2) then
		pcall(function()
			if(player:GetAttribute("id") == tbl.id) then
				table.insert(strikes[player],tick());
				local kickLog = {};
				local old = player.Character;
				wait();
				if(player.Character == old) then
					if(tbl.ws >= 17 and player.Character.Humanoid.WalkSpeed == 16) then
						table.insert(kickLog,"[WalkSpeed Exploits]");
					end
					if(tbl.jp > player.Character.Humanoid.JumpPower and tbl.jp >= 50) then
						table.insert(kickLog,"[JumpPower Exploits]");
					end
					if(tbl.bp and not find(player.Character)) then
						local s,r = pcall(function()
							local hdMain = require(game:GetService("ReplicatedStorage"):WaitForChild("HDAdminSetup")):GetMain()
							local hd = hdMain:GetModule("API")
							local plrRankId, plrRankName, plrRankType = hd:GetRank(player)
							return plrRankId;
						end)
						if(s and r < 3) then
							table.insert(kickLog,"[Fly exploits]");
						end
					end
				end
				if(#kickLog >= 1 and not kicked[player] and not player:GetAttribute("byp")) then
					kicked[player] = true;
					local exploits = table.concat(kickLog," "):sub(1,100);
					game.ReplicatedStorage.events.makeMsg:FireAllClients(player.Name .. " was caught using: " .. exploits .. ", smh.");
					warn("PLAYER",player.Name,game:GetService("HttpService"):JSONEncode(kickLog));
					player:Kick("[No]");
				end
			end
		end)
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	game.ReplicatedStorage:SetAttribute("d",tick()^2);
end)