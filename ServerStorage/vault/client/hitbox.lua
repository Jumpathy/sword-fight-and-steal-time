local SHOW_DEBUG_RAY_LINES: boolean = false

-- Allow RaycastModule to write to the output
local SHOW_OUTPUT_MESSAGES: boolean = false

-- The tag name. Used for cleanup.
local DEFAULT_COLLECTION_TAG_NAME: string = "_RaycastHitboxV4Managed"

--- Initialize required modules
local CollectionService: CollectionService = game:GetService("CollectionService")

local connection = {}
connection.__index = connection

function connection:Create()
	return setmetatable({}, connection)
end

function connection:Connect(Listener)
	self[1] = Listener
end

function connection:Fire(...)
	if not self[1] then return end

	local newThread = coroutine.create(self[1])
	coroutine.resume(newThread, ...)
end

function connection:Destroy()
	self[1] = nil
end

local Signal = connection;

local success,HitboxData = pcall(function()
	--!nocheck
	--- Creates and manages the hitbox class
	-- @author Swordphin123

	-- Instance options
	local DEFAULT_ATTACHMENT_INSTANCE: string = "DmgPoint"
	local DEFAULT_GROUP_NAME_INSTANCE: string = "Group"

	-- Debug / Test ray visual options
	local DEFAULT_DEBUGGER_RAY_DURATION: number = 0.25

	-- Debug Message options
	local DEFAULT_DEBUG_LOGGER_PREFIX: string = "[ RCHV4 ]\n"
	local DEFAULT_MISSING_ATTACHMENTS: string = "No attachments found in object: %s. Can be safely ignored if using SetPoints."
	local DEFAULT_ATTACH_COUNT_NOTICE: string = "%s attachments found in object: %s."

	-- Hitbox values
	local MINIMUM_SECONDS_SCHEDULER: number = 1 / 60
	local DEFAULT_SIMULATION_TYPE: RBXScriptSignal = game:GetService("RunService").Heartbeat

	--- Variable definitions
	local CollectionService: CollectionService = game:GetService("CollectionService")
	local success,VisualizerCache = pcall(function()
		--!strict
		--- Cache LineHandleAdornments or create new ones if not in the cache
		-- @author Swordphin123

		-- Debug / Test ray visual options
		local DEFAULT_DEBUGGER_RAY_COLOUR: Color3 = Color3.fromRGB(255, 0, 0)
		local DEFAULT_DEBUGGER_RAY_WIDTH: number = 4
		local DEFAULT_DEBUGGER_RAY_NAME: string = "_RaycastHitboxDebugLine"
		local DEFAULT_FAR_AWAY_CFRAME: CFrame = CFrame.new(0, math.huge, 0)

		local cache = {}
		cache.__index = cache
		cache.__type = "RaycastHitboxVisualizerCache"
		cache._AdornmentInUse = {}
		cache._AdornmentInReserve = {}

		--- AdornmentData type
		export type AdornmentData = {
			Adornment: LineHandleAdornment,
			LastUse: number
		}

		--- Internal function to create an AdornmentData type
		--- Creates a LineHandleAdornment and a timer value
		function cache:_CreateAdornment(): AdornmentData
			local line: LineHandleAdornment = Instance.new("LineHandleAdornment")
			line.Name = DEFAULT_DEBUGGER_RAY_NAME
			line.Color3 = DEFAULT_DEBUGGER_RAY_COLOUR
			line.Thickness = DEFAULT_DEBUGGER_RAY_WIDTH

			line.Length = 0
			line.CFrame = DEFAULT_FAR_AWAY_CFRAME

			line.Adornee = workspace.Terrain
			line.Parent = workspace.Terrain

			return {
				Adornment = line,
				LastUse = 0
			}
		end

		--- Gets an AdornmentData type. Creates one if there isn't one currently available.
		function cache:GetAdornment(): AdornmentData?
			if #cache._AdornmentInReserve <= 0 then
				--- Create a new LineAdornmentHandle if none are in reserve
				local adornment: AdornmentData = cache:_CreateAdornment()
				table.insert(cache._AdornmentInReserve, adornment)
			end

			local adornment: AdornmentData? = table.remove(cache._AdornmentInReserve, 1)

			if adornment then
				adornment.Adornment.Visible = true
				adornment.LastUse = os.clock()
				table.insert(cache._AdornmentInUse, adornment)
			end

			return adornment
		end

		--- Returns an AdornmentData back into the cache.
		-- @param AdornmentData
		function cache:ReturnAdornment(adornment: AdornmentData)
			adornment.Adornment.Length = 0
			adornment.Adornment.Visible = false
			adornment.Adornment.CFrame = DEFAULT_FAR_AWAY_CFRAME
			table.insert(cache._AdornmentInReserve, adornment)
		end

		--- Clears the cache in reserve. Should only be used if you want to free up some memory.
		--- If you end up turning on the visualizer again for this session, the cache will fill up again.
		--- Does not clear adornments that are currently in use.
		function cache:Clear()
			for i = #cache._AdornmentInReserve, 1, -1 do
				if cache._AdornmentInReserve[i].Adornment then
					cache._AdornmentInReserve[i].Adornment:Destroy()
				end

				table.remove(cache._AdornmentInReserve, i)
			end
		end

		return cache
	end)
	
	local ActiveHitboxes: {[number]: any} = {}
	local s,Solvers = pcall(function()
		local solvers = {};

		--!strict
		--- Calculates ray origin and directions for attachment-based raycast points
		-- @author Swordphin123

		local solver = {}

		--- Solve direction and length of the ray by comparing current and last frame's positions
		-- @param point type
		function solver:Solve(point: {[string]: any}): (Vector3, Vector3)
			--- If LastPosition is nil (caused by if the hitbox was stopped previously), rewrite its value to the current point position
			if not point.LastPosition then
				point.LastPosition = point.Instances[1].WorldPosition
			end

			local origin: Vector3 = point.LastPosition
			local direction: Vector3 = point.Instances[1].WorldPosition - point.LastPosition

			return origin, direction
		end

		function solver:UpdateToNextPosition(point: {[string]: any}): Vector3
			return point.Instances[1].WorldPosition
		end

		function solver:Visualize(point: {[string]: any}): CFrame
			return CFrame.lookAt(point.Instances[1].WorldPosition, point.LastPosition)
		end

		solvers.a = solver;

		local ss = {}

		local EMPTY_VECTOR: Vector3 = Vector3.new()

		function ss:Solve(point: {[string]: any}): (Vector3, Vector3)
			--- Translate localized bone positions to world space values
			local originBone: Bone = point.Instances[1]
			local vector: Vector3 = point.Instances[2]
			local worldCFrame: CFrame = originBone.TransformedWorldCFrame
			local pointToWorldSpace: Vector3 = worldCFrame.Position + worldCFrame:VectorToWorldSpace(vector)

			--- If LastPosition is nil (caused by if the hitbox was stopped previously), rewrite its value to the current point position
			if not point.LastPosition then
				point.LastPosition = pointToWorldSpace
			end

			local origin: Vector3 = point.LastPosition
			local direction: Vector3 = pointToWorldSpace - (point.LastPosition or EMPTY_VECTOR)

			point.WorldSpace = pointToWorldSpace

			return origin, direction
		end

		function ss:UpdateToNextPosition(point: {[string]: any}): Vector3
			return point.WorldSpace
		end

		function ss:Visualize(point: {[string]: any}): CFrame
			return CFrame.lookAt(point.WorldSpace, point.LastPosition)
		end

		solvers.b = ss;

		local c = {}

		--- Solve direction and length of the ray by comparing both attachment1 and attachment2's positions
		-- @param point type
		function c:Solve(point: {[string]: any}): (Vector3, Vector3)
			local origin: Vector3 = point.Instances[1].WorldPosition
			local direction: Vector3 = point.Instances[2].WorldPosition - point.Instances[1].WorldPosition

			return origin, direction
		end

		function c:UpdateToNextPosition(point: {[string]: any}): Vector3
			return point.Instances[1].WorldPosition
		end

		function c:Visualize(point: {[string]: any}): CFrame
			return CFrame.lookAt(point.Instances[1].WorldPosition, point.Instances[2].WorldPosition)
		end

		solvers.c = c;

		--!strict
		--- Calculates ray origin and directions for vector-based raycast points
		-- @author Swordphin123

		local d = {}

		local EMPTY_VECTOR: Vector3 = Vector3.new()

		function d:Solve(point: {[string]: any}): (Vector3, Vector3)
			--- Translate localized Vector3 positions to world space values
			local originPart: BasePart = point.Instances[1]
			local vector: Vector3 = point.Instances[2]
			local pointToWorldSpace: Vector3 = originPart.Position + originPart.CFrame:VectorToWorldSpace(vector)

			--- If LastPosition is nil (caused by if the hitbox was stopped previously), rewrite its value to the current point position
			if not point.LastPosition then
				point.LastPosition = pointToWorldSpace
			end

			local origin: Vector3 = point.LastPosition
			local direction: Vector3 = pointToWorldSpace - (point.LastPosition or EMPTY_VECTOR)

			point.WorldSpace = pointToWorldSpace

			return origin, direction
		end

		function d:UpdateToNextPosition(point: {[string]: any}): Vector3
			return point.WorldSpace
		end

		function d:Visualize(point: {[string]: any}): CFrame
			return CFrame.lookAt(point.WorldSpace, point.LastPosition)
		end

		solvers.d = d;

		return {
			data = solvers,
			keys = {
				["Attachment"] = "a",
				["Bone"] = "b",
				["LinkAttachments"] = "c",
				["Vector3"] = "d"
			}
		}
	end)
	
	local Hitbox = {}
	Hitbox.__index = Hitbox
	Hitbox.__type = "RaycastHitbox"

	Hitbox.CastModes = {
		LinkAttachments = 1,
		Attachment = 2,
		Vector3 = 3,
		Bone = 4,
	}

	--- Point type
	type Point = {
		Group: string?,
		CastMode: number,
		LastPosition: Vector3?,
		WorldSpace: Vector3?,
		Instances: {[number]: Instance | Vector3}
	}

	-- AdornmentData type
	type AdornmentData = VisualizerCache.AdornmentData

	function Hitbox:HitStart(seconds: number?)
		if self.HitboxActive then
			self:HitStop()
		end

		if seconds then
			self.HitboxStopTime = os.clock() + math.max(MINIMUM_SECONDS_SCHEDULER, seconds)
		end

		self.HitboxActive = true
	end

	--- Disables the raycasts for the hitbox object, and clears all current hit targets.
	--- Also automatically cancels any current time scheduling for the current hitbox.
	function Hitbox:HitStop()
		self.HitboxActive = false
		self.HitboxStopTime = 0
		table.clear(self.HitboxHitList)
	end

	--- Queues the hitbox to be destroyed in the next frame
	function Hitbox:Destroy()
		self.HitboxPendingRemoval = true

		if self.HitboxObject then
			CollectionService:RemoveTag(self.HitboxObject, self.Tag)
		end

		self:HitStop()
		self.OnHit:Destroy()
		self.OnUpdate:Destroy()
	end

	--- Searches for attachments for the given instance (if applicable)
	function Hitbox:Recalibrate()
		local descendants: {[number]: Instance} = self.HitboxObject:GetDescendants()
		local attachmentCount: number = 0

		for _, attachment: any in ipairs(descendants) do
			if not attachment:IsA("Attachment") or attachment.Name ~= DEFAULT_ATTACHMENT_INSTANCE then
				continue
			end

			local group: string? = attachment:GetAttribute(DEFAULT_GROUP_NAME_INSTANCE)
			local point: Point = self:_CreatePoint(group, Hitbox.CastModes.Attachment, attachment.WorldPosition)

			table.insert(point.Instances, attachment)
			table.insert(self.HitboxRaycastPoints, point)

			attachmentCount += 1
		end

		if self.DebugLog then
			print(string.format("%s%s", DEFAULT_DEBUG_LOGGER_PREFIX,
				attachmentCount > 0 and string.format(DEFAULT_ATTACH_COUNT_NOTICE, attachmentCount, self.HitboxObject.Name) or
					string.format(DEFAULT_MISSING_ATTACHMENTS, self.HitboxObject.Name))
			)
		end
	end

	--- Creates a link between two attachments. The module will constantly raycast between these two attachments.
	-- @param attachment1 Attachment object (can have a group attribute)
	-- @param attachment2 Attachment object
	function Hitbox:LinkAttachments(attachment1: Attachment, attachment2: Attachment)
		local group: string? = attachment1:GetAttribute(DEFAULT_GROUP_NAME_INSTANCE)
		local point: Point = self:_CreatePoint(group, Hitbox.CastModes.LinkAttachments)

		point.Instances[1] = attachment1
		point.Instances[2] = attachment2
		table.insert(self.HitboxRaycastPoints, point)
	end

	--- Removes the link of an attachment. Putting one of any of the two original attachments you used in LinkAttachment will automatically sever the other
	-- @param attachment
	function Hitbox:UnlinkAttachments(attachment: Attachment)
		for i = #self.HitboxRaycastPoints, 1, -1 do
			if #self.HitboxRaycastPoints[i].Instances >= 2 then
				if self.HitboxRaycastPoints[i].Instances[1] == attachment or self.HitboxRaycastPoints[i].Instances[2] == attachment then
					table.remove(self.HitboxRaycastPoints, i)
				end
			end
		end
	end

	--- Creates raycast points using only vector3 values.
	-- @param object BasePart or Bone, the part you want the points to be locally offset from
	-- @param table of vector3 values that are in local space relative to the basePart or bone
	-- @param optional group string parameter that names the group these points belong to
	function Hitbox:SetPoints(object: BasePart | Bone, vectorPoints: {[number]: Vector3}, group: string?)
		for _: number, vector: Vector3 in ipairs(vectorPoints) do
			local point: Point = self:_CreatePoint(group, Hitbox.CastModes[object:IsA("Bone") and "Bone" or "Vector3"])

			point.Instances[1] = object
			point.Instances[2] = vector
			table.insert(self.HitboxRaycastPoints, point)
		end
	end

	--- Removes raycast points using only vector3 values. Use the same vector3 table from SetPoints
	-- @param object BasePart or Bone, the original instance you used for SetPoints
	-- @param table of vector values that are in local space relative to the basePart
	function Hitbox:RemovePoints(object: BasePart | Bone, vectorPoints: {[number]: Vector3})
		for i = #self.HitboxRaycastPoints, 1, -1 do
			local part = (self.HitboxRaycastPoints[i] :: Point).Instances[1]

			if part == object then
				local originalVector = (self.HitboxRaycastPoints[i] :: Point).Instances[2]

				for _: number, vector: Vector3 in ipairs(vectorPoints) do
					if vector == originalVector :: Vector3 then
						table.remove(self.HitboxRaycastPoints, i)
						break
					end
				end
			end
		end
	end

	--- Internal function that returns a point type
	-- @param group string name
	-- @param castMode numeric enum value
	-- @param lastPosition Vector3 value
	function Hitbox:_CreatePoint(group: string?, castMode: number, lastPosition: Vector3?): Point
		return {
			Group = group,
			CastMode = castMode,
			LastPosition = lastPosition,
			WorldSpace = nil,
			Instances = {},
		}
	end

	--- Internal function that finds an existing hitbox from a given instance
	-- @param instance object
	function Hitbox:_FindHitbox(object: any)
		for _: number, hitbox: any in ipairs(ActiveHitboxes) do
			if hitbox.HitboxObject == object then
				return hitbox
			end
		end
	end

	--- Runs for the very first time whenever a hitbox is created
	--- Do not run this more than once, you may introduce memory leaks if you do so
	function Hitbox:_Init()
		if not self.HitboxObject then return end

		local tagConnection: RBXScriptConnection

		local function onTagRemoved(instance: Instance)
			if instance == self.HitboxObject then
				tagConnection:Disconnect()
				self:Destroy()
			end
		end

		self:Recalibrate()
		table.insert(ActiveHitboxes, self)
		CollectionService:AddTag(self.HitboxObject, self.Tag)

		tagConnection = CollectionService:GetInstanceRemovedSignal(self.Tag):Connect(onTagRemoved)
	end

	local function Init()
		--- Reserve table sizing for solver tables
		local solversCache = {};
		
		DEFAULT_SIMULATION_TYPE:Connect(function(step: number)
			--- Iterate through all the hitboxes
			for i = #ActiveHitboxes, 1, -1 do
				--- Skip this hitbox if the hitbox will be garbage collected this frame
				if ActiveHitboxes[i].HitboxPendingRemoval then
					local hitbox: any = table.remove(ActiveHitboxes, i)
					setmetatable(hitbox, nil)
					continue
				end

				for _: number, point: Point in ipairs(ActiveHitboxes[i].HitboxRaycastPoints) do
					--- Reset this point if the hitbox is inactive
					if not ActiveHitboxes[i].HitboxActive then
						point.LastPosition = nil
						continue
					end
					
					--- Calculate rays
					local castMode: any = solversCache[point.CastMode]
					local origin: Vector3, direction: Vector3 = castMode:Solve(point)
					local raycastResult: RaycastResult = workspace:Raycast(origin, direction, ActiveHitboxes[i].RaycastParams)

					--- Draw debug rays
					if ActiveHitboxes[i].Visualizer then
						local adornmentData: AdornmentData? = VisualizerCache:GetAdornment()

						if adornmentData then
							local debugStartPosition: CFrame = castMode:Visualize(point)
							adornmentData.Adornment.Length = direction.Magnitude
							adornmentData.Adornment.CFrame = debugStartPosition
						end
					end

					--- Update the current point's position
					point.LastPosition = castMode:UpdateToNextPosition(point)

					--- If a ray detected a hit
					if raycastResult then
						local part: BasePart = raycastResult.Instance
						local model: Instance?
						local humanoid: Instance?
						local target: Instance?

						if ActiveHitboxes[i].DetectionMode == 1 then
							model = part:FindFirstAncestorOfClass("Model")
							if model then
								humanoid = model:FindFirstChildOfClass("Humanoid")
							end
							target = humanoid
						else
							target = part
						end

						--- Found a target. Fire the OnHit event
						if target then
							if ActiveHitboxes[i].DetectionMode <= 2 then
								if ActiveHitboxes[i].HitboxHitList[target] then
									continue
								else
									--ActiveHitboxes[i].HitboxHitList[target] = true
								end
							end

							ActiveHitboxes[i].OnHit:Fire(part, humanoid, raycastResult, point.Group)
						end
					end

					--- Hitbox Time scheduler
					if ActiveHitboxes[i].HitboxStopTime > 0 then
						if ActiveHitboxes[i].HitboxStopTime <= os.clock() then
							ActiveHitboxes[i].HitboxStopTime = 0
							ActiveHitboxes[i]:HitStop()
						end
					end

					--- OnUpdate event that fires every frame for every point
					ActiveHitboxes[i].OnUpdate:Fire(point.LastPosition)
				end
			end

			local adornmentsInUse: number = #VisualizerCache._AdornmentInUse

			--- Iterates through all the debug rays to see if they need to be cached or cleaned up
			if adornmentsInUse > 0 then
				for i = adornmentsInUse, 1, -1 do
					if (os.clock() - VisualizerCache._AdornmentInUse[i].LastUse) >= DEFAULT_DEBUGGER_RAY_DURATION then
						local adornment: AdornmentData? = table.remove(VisualizerCache._AdornmentInUse, i)

						if adornment then
							VisualizerCache:ReturnAdornment(adornment)
						end
					end
				end
			end
		end)

		--- Require all solvers
		for castMode: string, enum: number in pairs(Hitbox.CastModes) do
			solversCache[enum] = Solvers.data[Solvers.keys[castMode]];
		end
	end

	Init()

	return Hitbox
end)


local RaycastHitbox = {}
RaycastHitbox.__index = RaycastHitbox
RaycastHitbox.__type = "RaycastHitboxModule"

-- Detection mode enums
RaycastHitbox.DetectionMode = {
	Default = 1,
	PartMode = 2,
	Bypass = 3,
}

--- Creates or finds a hitbox object. Returns an hitbox object
-- @param required object parameter that takes in either a part or a model
function RaycastHitbox.new(object: any?)
	local hitbox: any

	if object and CollectionService:HasTag(object, DEFAULT_COLLECTION_TAG_NAME) then
		hitbox = HitboxData:_FindHitbox(object)
	else
		hitbox = setmetatable({
			RaycastParams = nil,
			DetectionMode = RaycastHitbox.DetectionMode.Default,
			HitboxRaycastPoints = {},
			HitboxPendingRemoval = false,
			HitboxStopTime = 0,
			HitboxObject = object,
			HitboxHitList = {},
			HitboxActive = false,
			Visualizer = SHOW_DEBUG_RAY_LINES,
			DebugLog = SHOW_OUTPUT_MESSAGES,
			OnUpdate = Signal:Create(),
			OnHit = Signal:Create(),
			Tag = DEFAULT_COLLECTION_TAG_NAME,
		}, HitboxData)

		hitbox:_Init()
	end

	return hitbox
end

--- Finds a hitbox object if valid, else return nil
-- @param Object instance
function RaycastHitbox:GetHitbox(object: any?)
	if object then
		return HitboxData:_FindHitbox(object)
	end
end

return RaycastHitbox