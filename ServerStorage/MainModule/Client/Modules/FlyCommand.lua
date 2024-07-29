local main = _G.HDAdminMain

local module = {}


local function setCollisionGroupRecursive(object, groupName)
	for a,b in pairs(object:GetDescendants()) do
		if b:IsA("BasePart") then
			main.physicsService:SetPartCollisionGroup(b, groupName)
		end
	end
end


function module:Fly(commandName, noclip)
	local lockType = "PlatformStand"
	if commandName == "fly2" then
		lockType = "Sit"
	end
	local hrp = main:GetModule("cf"):GetHRP()
	local humanoid = main:GetModule("cf"):GetHumanoid()
	if hrp and humanoid then
		-------------------------------------
		--[[
		--I attempted to use Constraints but can't get speed modifications to work with AlignPosition, so for now I'll be using legacy BodyPositions
		local flyPart = Instance.new("Part")
		flyPart.Anchored = true
		flyPart.CanCollide = false
		flyPart.Transparency = 1
		flyPart.Color = Color3.fromRGB(255,0,0)
		flyPart.Name = "HDAdminFlyPart"
		flyPart.Size = Vector3.new(1,1,1)
		flyPart.CFrame = hrp.CFrame * CFrame.new(0,4,0)
		flyPart.Parent = workspace
		local flyAttachment0 = Instance.new("Attachment")
		flyAttachment0.Name = "Attachment0"
		flyAttachment0.Parent = hrp
		local flyAttachment1 = Instance.new("Attachment")
		flyAttachment1.Name = "Attachment1"
		flyAttachment1.Parent = flyPart
		local flyForce = Instance.new("AlignPosition")
		flyForce.Name = "HDAdminFlyForce"
		flyForce.Attachment0 = flyAttachment0
		flyForce.Attachment1 = flyAttachment1
		flyForce.Enabled = false
		flyForce.Responsiveness = 5
		flyForce.ApplyAtCenterOfMass = false
		flyForce.Enabled = true
		flyForce.Parent = hrp
		local bodyGyro = Instance.new("BodyGyro")
		bodyGyro.D = 50
		bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
		bodyGyro.P = 200
		bodyGyro.Name = "HDAdminFlyGyro"
		bodyGyro.CFrame = hrp.CFrame
		bodyGyro.Parent = hrp
		local tiltMax = 25
		local tiltAmount = 0
		local tiltInc = 1
		-------------------------------------
		local lastUpdate = tick()
		local lastPosition = hrp.Position
		repeat
			local delta = tick()-lastUpdate
			local look = (main.camera.Focus.p-main.camera.CFrame.p).unit
			local speed = (main.commandSpeeds[commandName])*10
			local move, directionalVector = getNextMovement(delta, speed)
			local pos = hrp.Position
			local targetCFrame = CFrame.new(pos,pos+look) * move
			local responsiveness = 12000/speed
			if move.p ~= Vector3.new() then
				tiltAmount = tiltAmount + tiltInc
				flyForce.Responsiveness = responsiveness
				flyPart.CFrame = targetCFrame
			else
				tiltAmount = 1
				if (hrp.Position - lastPosition).magnitude > 6 then
					flyPart.CFrame = hrp.CFrame
				end
			end
			if math.abs(tiltAmount) > tiltMax then
				tiltAmount = tiltMax
			end
			if flyForce.Responsiveness == responsiveness then
				--bodyGyro.CFrame = targetCFrame
				local tiltX = tiltAmount * directionalVector.X * -0.5
				local tiltZ = tiltAmount * directionalVector.Z
				bodyGyro.CFrame = targetCFrame * CFrame.Angles(math.rad(tiltZ), 0, 0)
			end
			lastUpdate = tick()
			lastPosition = hrp.Position
			humanoid[lockType] = true
			wait()
		until not main.commandsActive[commandName] or not humanoid or not hrp
		flyPart:Destroy()
		flyForce:Destroy()
		flyAttachment0:Destroy()
		bodyGyro:Destroy()
		if humanoid then
			humanoid[lockType] = false
		end--]]
		local flyForce = Instance.new("BodyPosition")
		flyForce.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		flyForce.Position = hrp.Position + Vector3.new(0,4,0)
		flyForce.Name = "HDAdminFlyForce"
		flyForce.Parent = hrp
		local bodyGyro = Instance.new("BodyGyro")
		bodyGyro.D = 50
		bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		if noclip then
			bodyGyro.P = 2000
		else
			bodyGyro.P = 200
		end
		bodyGyro.Name = "HDAdminFlyGyro"
		bodyGyro.CFrame = hrp.CFrame
		bodyGyro.Parent = hrp
		local tiltMax = 25
		local tiltAmount = 0
		local tiltInc = 1
		local static = 0
		-------------------------------------
		if noclip then
			setCollisionGroupRecursive(workspace, "Group1")
			setCollisionGroupRecursive(main.player.Character, "Group2")
		end
		-------------------------------------
		local lastUpdate = tick()
		local lastPosition = hrp.Position
		repeat
			local delta = tick()-lastUpdate
			local look = (main.camera.Focus.p-main.camera.CFrame.p).unit
			local speed = main.commandSpeeds[commandName]
			local move, directionalVector = main:GetModule("cf"):GetNextMovement(delta, speed*10)
			local pos = hrp.Position
			local targetCFrame = CFrame.new(pos,pos+look) * move
			local targetD = 750 + (speed*0.2)
			if noclip then
				targetD = targetD/2
			end
			if move.p ~= Vector3.new() then
				static = 0
				flyForce.D = targetD
				tiltAmount = tiltAmount + tiltInc
				flyForce.Position = targetCFrame.p
			else
				static = static + 1
				tiltAmount = 1
				local maxMag = 6
				local mag = (hrp.Position - lastPosition).magnitude
				if mag > maxMag and static >= 4 then
					flyForce.Position = hrp.Position
				end
			end
			if math.abs(tiltAmount) > tiltMax then
				tiltAmount = tiltMax
			end
			if flyForce.D == targetD then
				local tiltX = tiltAmount * directionalVector.X * -0.5
				local tiltZ = (noclip and 0) or tiltAmount * directionalVector.Z
				bodyGyro.CFrame = targetCFrame * CFrame.Angles(math.rad(tiltZ), 0, 0)
			end
			lastUpdate = tick()
			lastPosition = hrp.Position
			humanoid[lockType] = true
			wait()
		until not main.commandsActive[commandName] or not humanoid or not hrp
		flyForce:Destroy()
		bodyGyro:Destroy()
		if humanoid then
			humanoid[lockType] = false
		end--]]
		-------------------------------------
		if noclip then
			setCollisionGroupRecursive(workspace, "Group3")
		end
		-------------------------------------
		
	end
	main.commandsActive[commandName] = nil
	--main:GetModule("cf"):CreateNewCommandMenu(commandName, {"Input", "Speed"}, 1) -- todo: do this here
end

return module