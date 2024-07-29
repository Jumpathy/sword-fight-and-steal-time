return function(char)
	local joints = {} 
	local welds = {} 
	local fakeLimbs = {}
	local ragdolling = false

	if not ragdolling then
		ragdolling = true; char.Humanoid.PlatformStand = true

		local leftArm = char["Left Arm"]
		local rightArm = char["Right Arm"]
		local leftLeg = char["Left Leg"]
		local rightLeg = char["Right Leg"]
		local head = char.Head
		local torso = char.Torso
		
		local function cloneJoints(character)
			for _,this in ipairs(character.Torso:GetChildren()) do
				if this:isA("Motor6D") and this.Name ~= "Neck" then
					joints[this.Name] = this:Clone()
				end
			end
		end	
		local function createGlue(part0, part1, name)
			local glue = Instance.new("Glue", torso)
			glue.Part0 = part0;glue.Part1 = part1;glue.Name = name
			welds[#welds+1] = glue
			return glue
		end	
		local function createLimb(parent, position, size)
			local limb = Instance.new("Part", parent)
			limb.Position = position;limb.Size = size;limb.Transparency = 1
			fakeLimbs[#fakeLimbs+1] = limb
			return limb
		end
		local function createWeld(parent, p0, p1)
			local weld = Instance.new("Weld", parent)
			weld.Part0 = p0;weld.Part1 = p1;
			weld.C0 = CFrame.new(0,-0.2,0) * CFrame.fromEulerAnglesXYZ(0, 0, math.pi/2)
			welds[#welds+1] = weld
			return weld
		end

		cloneJoints(char)
		-- LEFT LEG --
		char.Torso["Left Hip"]:Destroy()
		local glue = createGlue(torso, leftLeg, "Left leg")
		glue.C0 = CFrame.new(-0.5, -1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
		glue.C1 = CFrame.new(-0, 1, 0, -0, -0, -1, 0, 1, 0, 1, 0, 0)
		local fakeLeftLeg = createLimb(leftLeg, Vector3.new(0,999,0), Vector3.new(1.5, 1, 1))
		createWeld(fakeLeftLeg, leftLeg, fakeLeftLeg)
		-- RIGHT LEG --
		char.Torso["Right Hip"]:destroy()
		local glue = createGlue(torso, rightLeg, "Right leg")
		glue.C0 = CFrame.new(0.5, -1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
		glue.C1 = CFrame.new(0, 1, 0, 0, 0, 1, 0, 1, 0, -1, -0, -0)
		local fakeRightLeg = createLimb(rightLeg, Vector3.new(0,999,0), Vector3.new(1.5, 1, 1))
		createWeld(fakeRightLeg, rightLeg, fakeRightLeg)	
		-- RIGHT ARM --
		char.Torso["Right Shoulder"]:destroy()
		local glue = createGlue(torso, rightArm, "Right shoulder")
		glue.C0 = CFrame.new(1.5, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
		glue.C1 = CFrame.new(0, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)	
		local fakeRightArm = createLimb(rightArm, Vector3.new(0,999,0), Vector3.new(1.8,1,1))
		createWeld(fakeRightArm, rightArm, fakeRightArm)
		-- LEFT ARM --
		char.Torso["Left Shoulder"]:destroy()
		local glue4 = createGlue(torso, leftArm, "Left shoulder")
		glue4.C0 = CFrame.new(-1.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
		glue4.C1 = CFrame.new(0, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)		
		local fakeLeftArm = createLimb(leftArm, Vector3.new(0,999,0), Vector3.new(1.5, 1, 1))	
		createWeld(fakeLeftArm, leftArm, fakeLeftArm)
		
		for _,part in pairs({fakeLeftLeg,fakeRightLeg,fakeLeftArm,fakeRightArm,torso}) do
			game:GetService("PhysicsService"):SetPartCollisionGroup(part,"sword_effects")
		end
	end
end