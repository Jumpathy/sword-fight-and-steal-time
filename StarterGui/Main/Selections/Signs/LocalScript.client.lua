local link = function(key,callback)
	local plr,called = game.Players.LocalPlayer,false;
	if(not plr:GetAttribute(key)) then
		plr.AttributeChanged:Connect(function()
			if(plr:GetAttribute(key) == true and not called) then
				called = true;
				callback();
			end
		end)
	elseif(not called) then
		called = true;
		callback();
	end
end

link("Signs",function()
	script.Parent.Visible = true;
end)