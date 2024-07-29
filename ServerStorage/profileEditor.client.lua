local DatGUI = require(game.ReplicatedStorage:WaitForChild("gui"))

local profile,holderId = game.ReplicatedStorage.manipulate:InvokeServer("getData");

local swords = game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("swordData"):InvokeServer();
local gui = DatGUI.new({
	closeable = true,
	fixed = false,
	closed = false
});

local change = function(key,value,...)
	if(key == "tag") then
		profile.tag = value;
	elseif(key == "stat") then
		local statName = value;
		local statValue = ({...})[1];
		profile.leaderstats[statName] = statValue;
	elseif(key == "option") then
		local optionName = value;
		local optionValue = ({...})[1];
		if(type(optionValue) == "boolean") then
			profile.options[optionName] = optionValue;
		end
	elseif(key == "slot") then
		local slotNumber = "Slot"..value;
		local slotValue = ({...})[1];
		profile.slots[slotNumber] = slotValue;
	elseif(key == "color") then
		if(value == "rainbow") then
			profile.options.colorPicker.rainbow = ({...})[1];
		else
			profile.options.colorPicker.color = {
				math.floor(({...})[1].R*255),
				math.floor(({...})[1].G*255),
				math.floor(({...})[1].B*255)
			}
		end
	elseif(key == "addSword") then
		profile.inventory[value] = true;
	elseif(key == "removeSword") then
		profile.inventory[value] = false;
	end
end

print(profile,"loaded")

local mainSettings = gui.addFolder("Data",{
	closeable = true,
	fixed = false,
	closed = true
})

mainSettings.add({Tag = profile.tag},"Tag").listen().onChange(function(value)
	change("tag",value);
end)

local swordGui = gui.addFolder("Swords",{
	closeable = true,
	fixed = false,
	closed = true
})

local notify = function(message)
	game:GetService("StarterGui"):SetCore("SendNotification",{
		Title = "System",
		Text = message,
		Duration = 5,
	})
end

local swordArray,valueArray,selectedSword,unEscaped = {},{},"","";

for k,v in pairs(swords) do
	table.insert(swordArray,v.name);
	table.insert(valueArray,k);
end

swordGui.add({Select = 1},"Select",valueArray).listen().onChange(function(value,text)
	local key = table.find(valueArray,value);
	local escapedName = (swordArray[key]);
	selectedSword = escapedName;
	unEscaped = value;
end)

swordGui.add({Action = 1},"Action",{"Add","Remove"}).listen().onChange(function(value,text)
	notify(unEscaped ~= "" and (value == "Remove" and "Remov" or "Add") .. "ed item \"".. unEscaped .. "\"" or "Please select an item first!");
	if(unEscaped ~= "") then
		change(value:lower().."Sword",selectedSword);
	end
end)

local slots = gui.addFolder("Slots",{
	closeable = true,
	fixed = false,
	closed = true
})

local unescape = function(t)
	return valueArray[table.find(swordArray,t)];
end

local escape = function(t)
	return swordArray[table.find(valueArray,t)];
end

for i = 1,5 do
	slots.add({["Slot " .. tostring(i)] = unescape(profile.slots["Slot"..i])},"Slot " .. tostring(i),valueArray).listen().onChange(function(value,text)
		change("slot",i,escape(value));
	end)
end

local leaderstats = gui.addFolder("Leaderstats",{
	closeable = true,
	fixed = false,
	closed = true
})

for statName,value in pairs(profile.leaderstats) do
	leaderstats.add({[statName] = value},statName).step(1).listen().onChange(function(value)
		change("stat",statName,value);
	end)
end

local options = gui.addFolder("Options",{
	closeable = true,
	fixed = false,
	closed = true
})

for optionName,value in pairs(profile.options) do
	if(type(value) == "boolean") then
		options.add({[optionName] = value},optionName).listen().onChange(function(value)
			change("option",optionName,value);
		end)
	end
end

if(profile.options.colorPicker == nil) then
	profile.options.colorPicker = {
		color = {0,0,0},
		rainbow = false
	}
end

local cp = profile.options.colorPicker.rainbow;

options.add({["Rainbow"] = cp ~= nil and cp or false},"Rainbow").listen().onChange(function(value)
	change("color","rainbow",value);
end)

options.add({["Color"] = Color3.fromRGB(unpack(profile.options.colorPicker.color))},"Color").listen().onChange(function(value)
	change("color","col",value);
end)

mainSettings.add({Action = 1},"Action",{"Save","Confirm"}).listen().onChange(function(value,text)
	warn("[UPDATE REQUESTED]");
	game.ReplicatedStorage.events.manipulate:InvokeServer("updateProfile",profile);
end)