--Creates a display Gui for the soft shutdown.

local gui = function()
	local SoftShutdownGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local TextLabel_2 = Instance.new("TextLabel")
	local TextLabel_3 = Instance.new("TextLabel")

	--Properties:

	SoftShutdownGui.Name = "SoftShutdownGui"
	SoftShutdownGui.DisplayOrder = 100

	Frame.Parent = SoftShutdownGui
	Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Frame.Position = UDim2.new(-0.5, 0, -0.5, 0)
	Frame.Size = UDim2.new(2, 0, 2, 0)
	Frame.ZIndex = 10

	TextLabel.Parent = Frame
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Position = UDim2.new(0.25, 0, 0.409652501, 0)
	TextLabel.Size = UDim2.new(0.5, 0, 0.0638030842, 0)
	TextLabel.ZIndex = 10
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.Text = "ATTENTION"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextStrokeTransparency = 0.000
	TextLabel.TextWrapped = true

	TextLabel_2.Parent = Frame
	TextLabel_2.BackgroundTransparency = 1.000
	TextLabel_2.Position = UDim2.new(0.25, 0, 0.474999994, 0)
	TextLabel_2.Size = UDim2.new(0.5, 0, 0.0374517329, 0)
	TextLabel_2.ZIndex = 10
	TextLabel_2.Font = Enum.Font.GothamSemibold
	TextLabel_2.Text = "This server is being updated"
	TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.TextScaled = true
	TextLabel_2.TextStrokeTransparency = 0.000
	TextLabel_2.TextWrapped = true

	TextLabel_3.Parent = Frame
	TextLabel_3.BackgroundTransparency = 1.000
	TextLabel_3.Position = UDim2.new(0.25, 0, 0.519111991, 0)
	TextLabel_3.Size = UDim2.new(0.5, 0, 0.0299999993, 0)
	TextLabel_3.ZIndex = 10
	TextLabel_3.Font = Enum.Font.GothamSemibold
	TextLabel_3.Text = "Please wait & don't leave."
	TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_3.TextScaled = true
	TextLabel_3.TextStrokeTransparency = 0.000
	TextLabel_3.TextWrapped = true
	
	return SoftShutdownGui,Frame;
end



return gui;