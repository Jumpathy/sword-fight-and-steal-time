--[[
	This module manages the stacking of chat bubbles metaphorically, and physically.
]]

--------------- Module: ---------------

local module = {};

--------------- Methods: ---------------

function module:createStack() --> This was turned into a function because for some reason, requiring the module kept returning the same stack and breaking the chat system.
	local stack = {
		utility = require(script.Parent.Parent:WaitForChild("util")),
		realStack = {},
		identifier = game:GetService("HttpService"):GenerateGUID()
	};

	--------------- Variables: ---------------

	local customWait = wait;
	local bubbleChat = {
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

	local waitDelay = stack.utility.bubbleRemovalTime;
	local origin = 0.9;
	local timing = bubbleChat.BubbleTweenTime;
	local tweenArguments = {				
		Enum.EasingDirection.In,
		bubbleChat.EasingStyle or Enum.EasingStyle.Bounce,
		timing,
		true
	};

	--------------- Functions: ---------------

	local tweenProperties = function(object,properties,length)
		game:GetService("TweenService"):Create(object,TweenInfo.new(length or 0.16,bubbleChat.EasingStyle or Enum.EasingStyle.Quad,Enum.EasingDirection.Out),properties):Play();
	end

	local destroyBubble = function(bubble,destroy)
		pcall(function()
			local destroyDelay = timing;
			tweenProperties(bubble.Caret,{ImageTransparency = 1},destroyDelay);
			tweenProperties(bubble.Label,{TextTransparency = 1},destroyDelay);
			tweenProperties(bubble,{BackgroundTransparency = 1},destroyDelay);
			if(destroy) then
				coroutine.wrap(function()
					customWait(destroyDelay);
					bubble:Destroy();
				end)();
			end
		end)
	end

	local getBubblePosition = function(stackKey)
		local absolutePosition = 0;
		for key = 1,#stack.realStack do
			if(key > stackKey) then
				local currentBubble = stack.realStack[key][1];
				local absoluteSize = currentBubble.AbsoluteSize.Y + currentBubble.Caret.AbsoluteSize.Y;
				absolutePosition += absoluteSize;
			end
		end
		return absolutePosition;
	end

	local getStackKey = function(object)
		for stackKey,stackData in pairs(stack.realStack) do
			if(stackData[1] == object or stackData[2] == object) then
				return stackKey;
			end
		end
		return nil;
	end

	local adjustBubbles = function()
		local endKey = #stack.realStack;
		for i = 1,#stack.realStack do
			local currentBubble = stack.realStack[i][1];
			if(currentBubble:GetFullName() ~= currentBubble.Name) then
				currentBubble.Caret.Visible = (i == endKey);
				currentBubble:TweenPosition(unpack({
					UDim2.new(
						0.5,0,
						origin,-getBubblePosition(i)
					),
					unpack(tweenArguments)
				}))
			end
		end
	end

	--------------- Methods: ---------------

	function stack:getKey(...)
		return getStackKey(...);
	end

	function stack:pushDown(bool,key,doDestroy)
		if(bool and key) then
			destroyBubble(stack.realStack[key][1],doDestroy);
			if(stack.realStack[key][2] ~= nil and stack.realStack[key][2] ~= stack.realStack[key][1]) then
				stack.realStack[key][2]:Destroy();
			end
			table.remove(stack.realStack,key);
		end
		adjustBubbles();
	end

	function stack:push(chatBubble,typingIndicator,ignoreRemoval)
		local toInsert = {chatBubble,typingIndicator};
		table.insert(stack.realStack,toInsert);
		for i = 1,#stack.realStack do
			if(i > 3 and not ignoreRemoval) then
				stack:pushDown(true,1);
			else
				stack:pushDown(false);
				coroutine.wrap(function()
					if(not ignoreRemoval) then
						customWait(waitDelay);
						if(chatBubble:GetFullName() ~= chatBubble.Name) then
							stack:pushDown(true,getStackKey(chatBubble),true);
						end
					end
				end)();
			end
		end
	end

	--------------- Return: ---------------

	return stack;
end

--------------- Return: ---------------

return module;