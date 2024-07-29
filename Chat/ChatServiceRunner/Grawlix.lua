local utility = {};

function utility.shuffle(x)
	local shuffled = {}
	for i, v in ipairs(x) do
		local pos = math.random(1, #shuffled+1)
		table.insert(shuffled, pos, v)
	end
	return shuffled;
end

function utility.shallowCopy(t)
	local new = {};
	for k,v in pairs(t) do
		new[k] = v;
	end
	return new;
end

function utility:customCensorReplace(newMessage,oldMessage)
	local tags = {};
	local baseCharacters = {"@","#","$","%","&","*","!"};
	local characters;
	local key = -1;

	for i = 1,#oldMessage do
		if(newMessage:sub(i,i) ~= oldMessage:sub(i,i) and newMessage:sub(i,i) == "#") then
			table.insert(tags,i);
		end
	end

	for i = 1,10 do
		baseCharacters = utility.shuffle(baseCharacters);
	end

	local getNextCharacter = function()
		key += 1; if(key == 0 or key >= #baseCharacters) then
			if(key >= #baseCharacters) then key = -1; end
			characters = utility.shuffle(utility.shallowCopy(baseCharacters));
		end
		local k = math.random(1,#characters);
		local selected = characters[k];
		table.remove(characters,k);
		return selected;
	end

	for _,position in pairs(tags) do
		--newMessage = newMessage:sub(0,position-1) .. getNextCharacter() .. newMessage:sub(position + 1,#newMessage);
	end

	return newMessage;
end

function utility.select(array,startPos,endPos)
	local returnTable = {};
	for i = 1,#array do
		if(i >= startPos and i <= (endPos or #array)) then
			table.insert(returnTable,array[i]);
		end
	end
	return returnTable;
end

return function(new,old)
	return utility:customCensorReplace(new,old);
end