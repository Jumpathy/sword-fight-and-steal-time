--[[
		local shoot = require(script:WaitForChild("shoot"));
		local cf = character.HumanoidRootPart.CFrame;
		local newCf = cf:ToWorldSpace(CFrame.new(0,0,30));
		local pos = Vector3.new(newCf.X,newCf.Y,newCf.Z);

		shoot(pos,30,character)(
			character.HumanoidRootPart.Position
		):Connect(function(position,arrow)
			
		end)
		]]

return function(position1,speed,parent)
	-- REMEMBER: THERE'S RESOURCES TO HELP YOU AT https://etithespirit.github.io/FastCastAPIDocs

	-- Constants
	local DEBUG = false								-- Whether or not to use debugging features of FastCast, such as cast visualization.
	local BULLET_SPEED = speed							-- Studs/second - the speed of the bullet
	local BULLET_MAXDIST = 1000							-- The furthest distance the bullet can travel 
	local BULLET_GRAVITY = Vector3.new(0, 0, 0)		-- The amount of gravity applied to the bullet in world space (so yes, you can have sideways gravity)
	local MIN_BULLET_SPREAD_ANGLE = 0					-- THIS VALUE IS VERY SENSITIVE. Try to keep changes to it small. The least accurate the bullet can be. This angle value is in degrees. A value of 0 means straight forward. Generally you want to keep this at 0 so there's at least some chance of a 100% accurate shot.
	local MAX_BULLET_SPREAD_ANGLE = 0					-- THIS VALUE IS VERY SENSITIVE. Try to keep changes to it small. The most accurate the bullet can be. This angle value is in degrees. A value of 0 means straight forward. This cannot be less than the value above. A value of 90 will allow the gun to shoot sideways at most, and a value of 180 will allow the gun to shoot backwards at most. Exceeding 180 will not add any more angular varience.
	local FIRE_DELAY = 0								-- The amount of time that must pass after firing the gun before we can fire again.
	local BULLETS_PER_SHOT = 1							-- The amount of bullets to fire every shot. Make this greater than 1 for a shotgun effect.
	local PIERCE_DEMO = true							-- True if the pierce demo should be used. See the CanRayPierce function for more info.
	local event = Instance.new("BindableEvent");
	event.Parent = parent;
	
	local FastCast = require(script.FastCastRedux)
	local Debris = game:GetService("Debris")
	local table = require(script.FastCastRedux.Table)
	local PartCacheModule = require(script:WaitForChild("PartCache"))
	local CanFire = true

	local RNG = Random.new()
	local TAU = math.pi * 2
	FastCast.DebugLogging = DEBUG
	FastCast.VisualizeCasts = DEBUG

	local CosmeticBulletsFolder = parent:FindFirstChild("CosmeticBulletsFolder") or Instance.new("Folder",parent);
	CosmeticBulletsFolder.Name = "CosmeticBulletsFolder"

	local Caster = FastCast.new()
	local CosmeticBullet = game.ServerStorage:WaitForChild("Arrow"):Clone();
	
	local CastParams = RaycastParams.new()
	CastParams.IgnoreWater = true
	CastParams.FilterType = Enum.RaycastFilterType.Blacklist
	CastParams.FilterDescendantsInstances = {}
	local CosmeticPartProvider = PartCacheModule.new(CosmeticBullet, 100, CosmeticBulletsFolder)
	local CastBehavior = FastCast.newBehavior()
	CastBehavior.RaycastParams = CastParams
	CastBehavior.MaxDistance = BULLET_MAXDIST
	CastBehavior.HighFidelityBehavior = FastCast.HighFidelityBehavior.Default
	CastBehavior.CosmeticBulletProvider = CosmeticPartProvider
	CastBehavior.CosmeticBulletContainer = CosmeticBulletsFolder
	CastBehavior.Acceleration = BULLET_GRAVITY
	CastBehavior.AutoIgnoreContainer = false

	local function CanRayPierce(cast, rayResult, segmentVelocity)
		local hits = cast.UserData.Hits
		if (hits == nil) then
			cast.UserData.Hits = 1
		else
			cast.UserData.Hits += 1
		end

		if (cast.UserData.Hits >= 2) then
			return false
		end

		local hitPart = rayResult.Instance
		if(hitPart.Parent == parent) then
			
		end

		return true
	end

	local function Fire(direction)
		local directionalCF = CFrame.new(Vector3.new(), direction)
		local direction = (directionalCF * CFrame.fromOrientation(0, 0, RNG:NextNumber(0, TAU)) * CFrame.fromOrientation(math.rad(RNG:NextNumber(MIN_BULLET_SPREAD_ANGLE, MAX_BULLET_SPREAD_ANGLE)), 0, 0)).LookVector
		local modifiedBulletSpeed = (direction * BULLET_SPEED)
		if PIERCE_DEMO then
			CastBehavior.CanPierceFunction = CanRayPierce
		end
		local simBullet = Caster:Fire(position1, direction, modifiedBulletSpeed, CastBehavior)
	end

	local function OnRayHit(cast, raycastResult, segmentVelocity, cosmeticBulletObject)
		local hitPart = raycastResult.Instance
		local hitPoint = raycastResult.Position
		local normal = raycastResult.Normal
	end

	local function OnRayUpdated(cast, segmentOrigin, segmentDirection, length, segmentVelocity, cosmeticBulletObject)
		if cosmeticBulletObject == nil then return end;
		local bulletLength = cosmeticBulletObject.Size.Z / 2;
		local baseCFrame = CFrame.new(segmentOrigin, segmentOrigin + segmentDirection);
		local final = baseCFrame * CFrame.new(0, 0, -(length - bulletLength));
		cosmeticBulletObject.CFrame = final:VectorToWorldSpace(position1);
		event:Fire(cosmeticBulletObject.CFrame);
	end

	local function OnRayPierced(cast, raycastResult, segmentVelocity, cosmeticBulletObject)
		if(raycastResult.Instance.Parent == parent) then
			cosmeticBulletObject:Destroy();
		end
	end

	local function OnRayTerminated(cast)
		local cosmeticBullet = cast.RayInfo.CosmeticBulletObject
		if cosmeticBullet ~= nil then
			if CastBehavior.CosmeticBulletProvider ~= nil then
				CastBehavior.CosmeticBulletProvider:ReturnPart(cosmeticBullet)
			else
				cosmeticBullet:Destroy()
			end
		end
	end

	Caster.RayHit:Connect(OnRayHit)
	Caster.LengthChanged:Connect(OnRayUpdated)
	Caster.CastTerminating:Connect(OnRayTerminated)
	Caster.RayPierced:Connect(OnRayPierced)

	return function(mousePoint)
		Fire((mousePoint - position1).Unit)
		return event.Event;
	end
end