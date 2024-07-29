return {
	Damage = {
		BaseDamage = 5,
		SlashDamage = 10,
		LungeDamage = 30,
	},
	
	Sounds = {
		Unsheath = {
			ID = "http://www.roblox.com/asset/?id=134747889",
			Volume = 1,
		},

		Slash = {
			ID = "rbxasset://sounds//swordslash.wav",
			Volume = 0.7
		},

		Lunge = {
			ID = "rbxasset://sounds//swordlunge.wav",
			Volume = 0.6
		}
	},
	
	Mouse = {
		MouseIcon = "rbxasset://textures/GunCursor.png",
		ReloadingIcon = "rbxasset://textures/GunWaitCursor.png"
	},
	
	Grips = {
		Up = CFrame.new(0, -2.29999995, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Out = CFrame.new(-3.81469727e-06, -2.30000305, -7.62939453e-06, 1, 1.04308178e-07, -4.0233175e-07, -4.0233175e-07, -9.68577183e-08, -1, -1.04308228e-07, 1, -9.68576757e-08),
	},
	
	KillEffect = function(character)
		local sound = Instance.new("Sound",character);
		sound.SoundId = "http://www.roblox.com/Asset?ID=96667969";
		sound:Play();
	end,
}