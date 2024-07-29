local cs = require(script.Parent);

shared.get_speaker = function(name)
	return cs:GetSpeaker(name);
end