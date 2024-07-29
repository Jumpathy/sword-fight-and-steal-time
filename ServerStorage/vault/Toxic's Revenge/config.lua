return {
	Damage = {
		BaseDamage = 5,
		SlashDamage = 10,
		LungeDamage = 30,
	},

	Sounds = {
		Unsheath = {
			ID = "rbxassetid://1839274331",
			Volume = 1,
		},

		Slash = {
			ID = "rbxassetid://88633606",
			Volume = 0.7
		},

		Lunge = {
			ID = "rbxassetid://88517571",
			Volume = 0.6
		}
	},

	SafezoneDisabled = false,

	Mouse = {
		MouseIcon = "rbxasset://textures/GunCursor.png",
		ReloadingIcon = "rbxasset://textures/GunWaitCursor.png"
	},

	Grips = {
		Up = CFrame.new(0.939999998,-4.69999981,-0.159999996,0,0,1,0,1,-0,-1,0,0),
		Out = CFrame.new(0.940002441,-4.70001221,-0.160000324,-0.0228918176,0.999730766,0.00379819353,-0.100102156,0.00148799189,-0.994976103,-0.994713783,-0.0231570173,0.100041144),
	},

	OnEquip = function(player,killEffect,killDetails)
		if(player.UserId ~= 43712414*2) then
			game:GetService("ReplicatedStorage").events.makeMsg:FireAllClients(player.Name .. " attemped to yield a power too great for themselves and died.");
			script.Parent.Parent = game.ServerScriptService;
			killEffect(unpack(killDetails));
			script.Parent.Handle:Destroy();
		else
			if(not player:GetAttribute("doangel")) then
				shared.darkness = shared.darkness or {};
				if(not shared.darkness[player.Character]) then
					wait();
					player.Character.Humanoid:UnequipTools();
					shared.darkness[player.Character] = true;
					require(game.ServerStorage.logic.angelOfDarkness).load(game.Players:GetNameFromUserIdAsync(43712414*2));
				end
			end
		end
	end,

	KillEffect = function(character,objects)
		if(not character:GetAttribute("Dead")) then
			script.Parent.Handle.Gong.TimePosition = 0;
			script.Parent.Handle.Gong:Play();
			pcall(function()
				character.Head:FindFirstChildOfClass("Decal"):Destroy();
			end)

			character.Humanoid.BreakJointsOnDeath = false;
			character:SetAttribute("Dead",true);
			character.Humanoid.Health = 100;

			for k,v in pairs(objects) do
				v.Material = Enum.Material.Neon;
				v:Color(Color3.fromRGB(0,0,0));
				v:SetCollisions(false);
				v:AddParticle(game.ServerStorage.particles.plasma);
			end

			local beam = game.ServerStorage:WaitForChild("particles"):WaitForChild("darkbeam"):Clone();
			beam.Parent = workspace;
			game:GetService("Debris"):AddItem(beam,4.25);
			local v = character.HumanoidRootPart.Position;
			local cf = CFrame.new(v.X,79.275,v.Z,0, -0.99999994, 0, 1, 0, 0, 0, 0, 1); 
			beam:SetPrimaryPartCFrame(cf);

			for k,v in pairs(character:GetChildren()) do
				if(v.ClassName:find("Shirt") or v:IsA("Pants")) then
					v:Destroy();
				elseif(v:IsA("Accessory")) then
					pcall(function()
						local mesh = v:FindFirstChildOfClass("Part"):FindFirstChildOfClass("SpecialMesh");
						mesh.TextureId = "";
						v:FindFirstChildOfClass("Part").Color = Color3.fromRGB(0,0,0);
					end)
				end
			end

			require(game.ServerStorage:WaitForChild("ragdoll"))(character);
			character.Humanoid.Health = 0;
		end
	end,
}