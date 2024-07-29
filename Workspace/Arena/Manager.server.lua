script.Parent:WaitForChild("Interact").Event:Connect(function(class,...)
	if(class == "countdown") then
		local args = {...};
		local sound = script.Parent.Countdown.Sound;
		local sound2 = script.Parent.Countdown.Sound2;
		local label = script.Parent.Countdown.Tags.Container.Extra;
		local gradient = label.UIGradient;
		gradient.Enabled = false;
		label.Parent.Visible = true;
		for i = 1,args[1]+1 do
			if(args[1]+1 - i >= 1) then
				sound.TimePosition = 0;
				sound:Play();
				label.Text = (args[1]+1)-i;
				wait(1);
			else
				gradient.Enabled = true;
				sound2.TimePosition = 0;
				sound2:Play();
				sound:Stop();
				label.Text = "GO!";
				break;
			end
		end
		args[2]();
		wait(2);
		label.Parent.Visible = false;
	elseif(class == "setPlayers") then
		local args = {...};
		local label = script.Parent.Overhead.Tags.Container.pName;
		label.Text = args[1];
	elseif(class == "musicManage") then
		local args = {...};
		if(args[1] == "play") then
			script.Parent.Overhead.Music.TimePosition = 0;
			script.Parent.Overhead.Music.Looped = true;
			script.Parent.Overhead.Music:Play();
		elseif(args[1] == "stop") then
			script.Parent.Overhead.Music:Stop();
		end
	elseif(class == "victoryScreech") then
		local command = {...};
		command = command[1];
		if(command) then
			if(command == "play") then
				script.Parent.Overhead.Victory.TimePosition = 0;
				script.Parent.Overhead.Victory:Play();
			elseif(command == "stop") then
				script.Parent.Overhead.Victory.TimePosition = 0;
				script.Parent.Overhead.Victory:Stop();
			end
		end
	end
end)