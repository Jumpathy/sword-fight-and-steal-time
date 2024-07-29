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
			ID = "rbxassetid://6757689262",
			Volume = 0.7,
			Length = 0.6
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
		Up = CFrame.new(-7.62939453e-06, -3.81469727e-06, 0.980514526, 1, -1.65310169e-07, -6.45706544e-10, 6.45728859e-10, 1.35030206e-07, 1, -1.65310169e-07, -1, 1.35030206e-07),
		Out = CFrame.new(0.194084167, -0.0469179153, 0.980514526, 1, 3.42788908e-08, 6.05363297e-08, -3.42788731e-08, 1, -2.80316499e-07, -6.05363368e-08, 2.80316499e-07, 1),
	},
	
	KillEffect = function(character)
		character.Humanoid.BreakJointsOnDeath = false;
		local bv = Instance.new("BodyVelocity",character.HumanoidRootPart);
		bv.Velocity = Vector3.new(0,300,300);
		bv.MaxForce = Vector3.new(15000,15000,15000);
		game:GetService("Debris"):AddItem(bv,1);
	end,
}