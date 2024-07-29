script.Parent.MouseEnter:Connect(function()
	script.Parent.Round.Visible = true;
end)

script.Parent.MouseLeave:Connect(function()
	script.Parent.Round.Visible = false;
end)

script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent:TweenPosition(UDim2.new(0.5,0,-1.25,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true);
end)