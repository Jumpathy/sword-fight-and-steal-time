local Instance = shared.custom_instance;

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
		Up = CFrame.new(-0, -2.29017711, -0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		Out = CFrame.new(3.81469727e-06, -2.29017639, 0, 1, 3.95811846e-08, 1.12945635e-08, 1.12945635e-08, 3.19485158e-16, -1, -3.95811846e-08, 1, -1.27567026e-16),
	},
	
	KillEffect = function(character,objects)
		for k,v in pairs(character:GetChildren()) do
			if(v:IsA("Accessory")) then
				v:Destroy();
			elseif(v.Name == "Head") then
				pcall(function()
					v:FindFirstChildOfClass("Decal"):Destroy();
				end)
			elseif(v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic")) then
				v:Destroy();
			end
		end

		local tweenPosition = function(part,len,pos)
			local info = TweenInfo.new(len,Enum.EasingStyle.Linear,Enum.EasingDirection.Out);
			game:GetService("TweenService"):Create(part, info, {
				Position = pos;
			}):Play();
		end

		local tweenSize = function(part,len,size)
			local info = TweenInfo.new(len,Enum.EasingStyle.Linear,Enum.EasingDirection.Out);
			game:GetService("TweenService"):Create(part, info, {
				Size = size;
			}):Play();
		end

		local tweenProperty = function(part,len,property,value)
			local info = TweenInfo.new(len,Enum.EasingStyle.Linear,Enum.EasingDirection.Out);
			game:GetService("TweenService"):Create(part, info, {
				[property] = value
			}):Play();
		end
		
		local ball = Instance.new("Part",character);
		ball.Shape = Enum.PartType.Ball;
		ball.Anchored = true;
		ball.Color = Color3.fromRGB(255,255,0);
		ball.Position = character.HumanoidRootPart.Position;
		ball.Anchored = true;
		ball.Size = Vector3.new(1,1,1);
		ball.BottomSurface = Enum.SurfaceType.Smooth; 
		ball.TopSurface = Enum.SurfaceType.Smooth;
		ball.Material = Enum.Material.Neon;
		
		for k,v in pairs(game.ServerStorage.particles.StarFX:GetChildren()) do
			v:Clone().Parent = ball;
		end
		
		local sound = Instance.new("Sound",ball);
		sound.SoundId = "rbxassetid://137463716";
		sound.RollOffMaxDistance = 250;
		sound:Play();
		
		tweenSize(ball,0.55,Vector3.new(5,5,5));

		for k,v in pairs(objects) do
			v.Anchored = true;
			v.Color = Color3.fromRGB(255,255,0);
			v.Material = Enum.Material.Neon;
			if(v.Name ~= "HumanoidRootPart") then
				tweenPosition(v:Get(),0.25,character.HumanoidRootPart.Position);
			end
		end

		wait(0.4);
		for k,v in pairs(objects) do
			v.Transparency = 1;
		end

		tweenPosition(ball,1.35,ball.Position + Vector3.new(0,50,0));
		tweenProperty(ball,0.95,"Transparency",1);
	end,
}