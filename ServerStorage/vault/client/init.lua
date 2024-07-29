return function(tool,handle,event,hitbox)
	local last,dta = nil,nil;
	local s,result = pcall(function()
		local _,zip = require(game.ReplicatedStorage:WaitForChild("DontFall"))();
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

		function utility.compress(txt)
			return utility.base64encode(zip.Zlib.Compress(txt,{
				strategy = "dynamic",
				level = 9
			}));
		end

		local encode = function(tbl)
		end

		return function()
			return decode,encode
		end;
	end)
	local result,other = result();

	local gen = function(p)
		if(p == script) then
			if(last ~= tool:GetAttribute("ToolID")) then
				last = tool:GetAttribute("ToolID");
				dta = result(last);
			end
			local stopAt = math.random(8,35);
			local i = 0;
			for k,v in pairs(dta) do
				i += 1;
				if(i == stopAt) then
					local c = ({k,v})[math.random(1,2)];
					return c;
				end
			end
			return "n.a";
		end
	end

	local ensure = gen;

	for k,v in pairs(tool:GetDescendants()) do
		if(v:IsA("Attachment")) then
			v.Changed:Connect(function()
				tool:Destroy();
			end)
		end
	end

	local hitZone = hitbox.new(handle);
	hitZone:HitStart();
	--hitZone.Visualizer = game:GetService("RunService"):IsStudio();

	shared.lastEquip = 0;
	hitZone.OnHit:Connect(function(hit,humanoid)
		if(hit.Name ~= "Handle" and hit.Parent ~= tool.Parent and tick()-shared.lastEquip >= 0.1/2) then
			if(gen == ensure) then
				event:InvokeServer({
					key = gen(script),
					hit = hit
				})
			end
		end
	end)
end