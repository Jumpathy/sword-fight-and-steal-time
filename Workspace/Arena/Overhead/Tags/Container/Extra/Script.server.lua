local thing = script.Parent
local uiGradient = thing:WaitForChild("UIGradient")
local tweenService = game:GetService("TweenService")

while true do
	local tween = tweenService:Create(uiGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {Offset = Vector2.new(-1, 0)})
	tween:Play()
	wait(2)
	uiGradient.Offset = Vector2.new(1, 0)
	local tween2 = tweenService:Create(uiGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {Offset = Vector2.new(0, 0)})
	tween2:Play()
	wait(2)
end
