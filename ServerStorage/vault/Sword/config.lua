return {
	Damage = {
		BaseDamage = 5,
		SlashDamage = 10,
		LungeDamage = 30,
	},
	
	Sounds = {
		Unsheath = {
			ID = "http://www.roblox.com/asset/?id=12222225",
			Volume = 1,
		},

		Slash = {
			ID = "http://www.roblox.com/asset/?id=12222216",
			Volume = 0.7
		},

		Lunge = {
			ID = "http://www.roblox.com/asset/?id=12222208",
			Volume = 0.6
		}
	},
	
	Mouse = {
		MouseIcon = "rbxasset://textures/GunCursor.png",
		ReloadingIcon = "rbxasset://textures/GunWaitCursor.png"
	},
	
	Grips = {
		Up = CFrame.new(0,0,-1.5,0,0,1,1,0,0,0,1,0),
		Out = CFrame.new(0,0,-1.5,0,-1,-0,-1,0,-0,0,0,-1),
	},
	
	KillEffect = function(character)
		
	end,
}