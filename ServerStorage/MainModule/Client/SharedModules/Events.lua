-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- << EVENTS >>
local module = {
	
	----------------------------------------------------------------------
	["DoubleJumped"] = function(bindable, parent, ...)
		local humanoid = parent
		local jumps = 0
		local jumpDe = true
		humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
			if jumpDe then
				jumpDe = false
				jumps = jumps + 1
				if jumps == 4 then
					bindable:Fire()
				end
				wait()
				jumpDe = true
				wait(0.2)
				jumps = jumps - 1
			end
		end)
	end;
		
	
	
	
	----------------------------------------------------------------------
	["EventName"] = function(bindable, parent, ...)
		
	end;
	
	
	
	
	----------------------------------------------------------------------
	
};



-- << EVENT HANLDER >>
function module:New(eventName, parent, ...) 
	local bindable = Instance.new("BindableEvent")
	module[eventName](bindable, parent, ...)
	bindable.Parent = parent
    return bindable
end



return module