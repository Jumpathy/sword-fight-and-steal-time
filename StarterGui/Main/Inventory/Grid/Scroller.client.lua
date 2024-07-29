local scale = function()
	script.Parent.CanvasSize = UDim2.new(0,0,0,script.Parent.Layout.AbsoluteContentSize.Y);
end

script.Parent:WaitForChild("Layout"):GetPropertyChangedSignal("AbsoluteContentSize"):Connect(scale);
scale();