local sounds = {
	"rbxassetid://1840302775",
}

while true do
	local random = sounds[math.random(1,#sounds)];
	local canContinue = false;
	script.Parent.SoundId = random;
	script.Parent.TimePosition = 0;
	script.Parent:Play();
	local signal;
	signal = script.Parent.Ended:Connect(function()
		signal:Disconnect();
		canContinue = true;
	end)
	repeat
		game:GetService("RunService").Heartbeat:Wait();
	until canContinue;
end