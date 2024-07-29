local tweenInfo = TweenInfo.new(
	2,
	Enum.EasingStyle.Bounce,
	Enum.EasingDirection.Out,
	-1,
	true,
	0.75
)

local tween = game:GetService("TweenService"):Create(script.Parent,tweenInfo,{
	Rotation = 360
})

tween:Play();