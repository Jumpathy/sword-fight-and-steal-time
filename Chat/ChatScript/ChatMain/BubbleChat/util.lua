--[[
	This utility module contains some utility functions as well as the configuration.
]]

--------------- Module: ---------------

local utility = {
	bubbleRemovalTime = 8,
	relativeSize = 320,
};

--------------- Variables: ---------------

local configuration = {
	MaxTextDisplayDistance = 40, --> This is how many studs away your camera is before the text is replaced with "..."
	MaxDisplayDistance = 100, --> This is how many studs away your camera is before the chat bubbles disappear until zoomed back in range.
	TextSize = 16, --> This is the chat bubble's text size.
	Padding = 8, --> Padding in offset on each side of the message.
	Font = Enum.Font.GothamSemibold, --> The chat bubble's primary font.
	TypingIndicatorColor = Color3.fromRGB(255,255,255), --> Player typing indicator color.
	BubbleBackgroundColor = Color3.fromRGB(20,20,20), --> The chat bubble's background color.
	BubbleTextColor = Color3.fromRGB(255,255,255), --> The chat bubble's text color.
	EasingStyle = Enum.EasingStyle.Bounce, --> The chat bubble's tween style
	Roundness = 0.15, --> The chat bubble's roundness (1 being the absolute max, 0 being the absolute minimum)
	BubbleTweenTime = 0.2 --> The time it takes for tweens to complete (recommended to max at 0.5)
}

--------------- Configuration: ---------------

utility.padding = configuration.Padding;
utility.textSize = configuration.TextSize;
utility.maxDistance = configuration.MaxDisplayDistance;
utility.maxTextDistance = configuration.MaxTextDisplayDistance;
utility.font = configuration.Font;
utility.backgroundColor = configuration.BubbleBackgroundColor;
utility.textColor = configuration.BubbleTextColor;
utility.typingIndicatorColor = configuration.TypingIndicatorColor or Color3.fromRGB(255,255,255);

--------------- Methods: ---------------

function utility:getBounds(text,textSize,font,width)
	local bounds = game:GetService("TextService"):GetTextSize(text,textSize,font,Vector2.new(width,10000));
	return bounds;
end

--------------- Return: ---------------

return utility;