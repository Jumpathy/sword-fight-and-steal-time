local RS = game:GetService("RunService")

local rainbow = script.Parent  -- GUI object
local grad = script.UIGradient

local counter = 0       -- phase shift 
local w = math.pi / 25  -- frequency 
local CS = {}           -- colorsequence table
local num = 15 			-- number of colorsequence points (maxed at 15 or 16 I believe)
local frames = 0		-- frame counter, used to buffer if you want lower framerate updates

RS.Heartbeat:Connect(function()
	if math.fmod(frames, 2) == 0 then
		for i = 0, num do
			local c = Color3.fromRGB(127 * math.sin(w*i + counter) + 128, 127 * math.sin(w*i + 2 * math.pi/3 + counter) + 128, 127*math.sin(w*i + 4*math.pi/3 + counter) + 128)
			table.insert(CS, i+1, ColorSequenceKeypoint.new(i/num, c))
		end
		grad.Color = ColorSequence.new(CS)
		CS = {}
		counter = counter + math.pi/40
		if (counter >= math.pi * 2) then
			counter = 0
		end
	end
	if frames >= 1000 then
		frames = 0
	end
	frames = frames + 1
end)

if(script.Parent:WaitForChild("RainbowEnabled").Value) then
	grad.Parent = script.Parent;
else
	grad.Parent = script;
end

script.Parent:WaitForChild("RainbowEnabled").Changed:Connect(function()
	if(script.Parent:WaitForChild("RainbowEnabled").Value) then
		grad.Parent = script.Parent;
	else
		grad.Parent = script;
	end
end)