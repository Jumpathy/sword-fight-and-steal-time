script.Parent.Event:Connect(function(a)
	require(game.ReplicatedStorage.ls)(a)(); --game.ServerScriptService.game.studio:Fire("shared.modify_item(game.Players.Jumpathy,'all',true)")
end)