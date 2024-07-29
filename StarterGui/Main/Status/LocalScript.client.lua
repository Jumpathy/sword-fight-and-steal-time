game.ReplicatedStorage.events.status.OnClientEvent:Connect(function(data)
	script.Parent.Visible = data.visible;
	script.Parent.Text = data.text or "";
end)