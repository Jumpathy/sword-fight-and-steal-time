--MADE BY OneLegend (NOT THE SCRIPT) Thanks to CyberFromLU for letting me Publish! LOCAL SCRIPT: JUST RUN!
-------------------------------------------------------------------------------------
Players = game:GetService("Players")
Me = Players.LocalPlayer
Char = Me.Character
necko = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0) 
ShootColors = {"Bright yellow", "New Yeller", "Bright orange", "Neon orange", "Really red", "Bright red"}
PlaceId = game.PlaceId

Selected = false
Attacking = false
Accuracy = 5
Debounce = true
Hurt = false
Damage = {15,42}

ContentProvider = game:GetService("ContentProvider")

V3 = Vector3.new
C3 = Color3.new
BN = BrickColor.new
CN = CFrame.new
CA = CFrame.Angles
MR = math.rad
MRA = math.random
MP = math.pi
MH = math.huge
UD = UDim2.new

function RC(Pos, Dir, Max, Ignore)
	return workspace:FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999)), Ignore)
end

function RayC(Start, En, MaxDist, Ignore)
	return RC(Start, (En - Start), MaxDist, Ignore)
end

function ComputePos(pos1, pos2)
	return CN(pos1, V3(pos2.x, pos1.y, pos2.z))
end

function DetectSurface(pos, part)
	local surface = nil
	local pospos = part.CFrame
	local pos2 = pospos:pointToObjectSpace(pos)
	local siz = part.Size
	local shaep = part.Shape
	if shaep == Enum.PartType.Ball or shaep == Enum.PartType.Cylinder then
		surface = {"Anything", CN(pospos.p, pos)*CN(0, 0, -(pospos.p - pos).magnitude)*CA(MR(-90), 0, 0)}
	else
		if pos2.Y > ((siz.Y/2)-0.04) then
			surface = {"Top", CA(0, 0, 0)}
		elseif pos2.Y < -((siz.Y/2)-0.04) then
			surface = {"Bottom", CA(-MP, 0, 0)}
		elseif pos2.X > ((siz.X/2)-0.04) then
			surface = {"Right", CA(0, 0, MR(-90))}
		elseif pos2.X < -((siz.X/2)-0.04) then
			surface = {"Left", CA(0, 0, MR(90))}
		elseif pos2.Z > ((siz.Z/2)-0.04) then
			surface = {"Back", CA(MR(90), 0, 0)}
		elseif pos2.Z < -((siz.Z/2)-0.04) then
			surface = {"Front", CA(MR(-90), 0, 0)}
		end
	end
	return surface
end

function Compute(pos1, pos2)
	local pos3 = Vector3.new(pos2.x, pos1.y, pos2.z)
	return CN(pos1, pos3)
end

function waitChild(n, p)
	local c = p:findFirstChild(n)
	if c then return c end
	while true do
		c = p.ChildAdded:wait()
		if c.Name == n then return c end
	end
end

function Notime(func)
	coroutine.resume(coroutine.create(function()
		func()
	end))
end

Torso = waitChild("Torso", Char)
Head = waitChild("Head", Char)
Rarm = waitChild("Right Arm", Char)
Larm = waitChild("Left Arm", Char)
Rleg = waitChild("Right Leg", Char)
Lleg = waitChild("Left Leg", Char)
Neck = waitChild("Neck", Torso)
Hum = waitChild("Humanoid", Char)

RSH = waitChild("Right Shoulder", Torso)
LSH = waitChild("Left Shoulder", Torso)
RH = waitChild("Right Hip", Torso)
LH = waitChild("Left Hip", Torso)

RSH.Part0 = Torso
LSH.Part0 = Torso
RH.Part0 = Torso
LH.Part0 = Torso

Add = {
	Mesh = function(P, ID, Scale, Tex)
		local m = Instance.new("SpecialMesh")
		m.MeshType = "FileMesh"
		m.MeshId = ID or ""
		m.Scale = Scale or V3(1, 1, 1)
		m.TextureId = Tex or ""
		m.Parent = P
		return m
	end,
	Sphere = function(P, Scale)
		local m = Instance.new("SpecialMesh")
		m.MeshType = "Sphere"
		m.Scale = Scale or V3(1, 1, 1)
		m.Parent = P
		return m
	end
}

Sounds = {
	Shoot = {Id = "http://www.roblox.com/asset/?id=2697431", Pitch = 0.3, Volume = 0.5},
	Boom = {Id = "http://www.roblox.com/asset/?id=2692806", Pitch = 0.55, Volume = 0.4},
	Slash = {Id = "rbxasset://sounds//swordslash.wav", Pitch = 0.5, Volume = 0.5},
	Hit = {Id = "http://www.roblox.com/asset/?id=2801263", Pitch = 0.85, Volume = 0.35},
	Reload = {Id = "rbxasset://sounds\\metal.ogg", Pitch = 1, Volume = 0.45},
}

for _,v in pairs(Sounds) do
	ContentProvider:Preload(v.Id)
end

function PlaySound(Sound, bool)
	local s = Instance.new("Sound")
	s.Looped = false
	s.Volume = Sound.Volume
	s.SoundId = Sound.Id
	if bool then
		s.Pitch = MRA((Sound.Pitch*0.75)*1000, (Sound.Pitch*1.15)*1000)/1000
	else
		s.Pitch = Sound.Pitch
	end
	s.PlayOnRemove = true
	s.Parent = Torso
	Notime(function()
		wait()
		s.Parent = nil
	end)
end

function GetParts(pos, dist)
	local parts = {}
	local function o(p)
		for _,v in pairs(p:children()) do
			if v:IsA("BasePart") then
				if (pos - v.Position).magnitude <= dist then
					table.insert(parts, {v, (pos - v.Position).magnitude, v.Anchored})
				end
			end
			o(v)
		end
	end
	o(workspace)
	return parts
end

function GetHum(P)
	for _,v in pairs(P:children()) do
		if v:IsA("Humanoid") then
			if v.Health > 0 then
				return v
			end
		end
	end
end

function GetGroup(Pos, Distance, Hit)
	local tab = {}
	for _,v in pairs(workspace:children()) do
		local h = GetHum(v)
		local t = v:findFirstChild("Torso")
		if h and t and v ~= Hit.Parent then
			if (t.Position - Pos).magnitude <= Distance then
				table.insert(tab, {h, v, (t.Position - Pos).magnitude})
			end
		end
	end
	if Hit then
		local h = GetHum(Hit.Parent)
		if h then
			table.insert(tab, {h, Hit.Parent, 0})
		end
	end
	return tab
end

function Tag(hum)
	if PlaceId == 48513881 then
		local tag = Instance.new("ObjectValue")
		tag.Name = "creator"
		tag.Value = Me
		tag.Parent = hum
	end
end

function Part(Par, Anc, Colli, Tran, Ref, Col, Siz)
	local p = Instance.new("Part")
	p.formFactor = "Custom"
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Transparency = Tran
	p.Reflectance = Ref
	p.Anchored = Anc
	p.CanCollide = Colli
	p.BrickColor = Col
	p.Size = Siz
	p.Locked = true
	p.Parent = Par
	p:BreakJoints()
	return p
end

function Weld(P0, P1, C0, C1)
	local w = Instance.new("Weld")
	w.Part0 = P0
	w.Part1 = P1
	if C0 then
		w.C0 = C0
	end
	if C1 then
		w.C1 = C1
	end
	w.Parent = P0
	return w
end

for _,v in pairs(Char:children()) do
	if v.Name == "Hand Cannon" then
		v:remove()
	end
end

Model = Instance.new("Model")
Model.Name = "Hand Cannon"

FTorso = Part(Model, false, false, 1, 0, Torso.BrickColor, V3(2, 2, 1))
FW = Weld(Torso, FTorso)

RAB = Part(Model, false, false, 1, 0, BN("White"), V3(0.2, 0.2, 0.2))
LAB = Part(Model, false, false, 1, 0, BN("White"), V3(0.2, 0.2, 0.2))
RLB = Part(Model, false, false, 1, 0, BN("White"), V3(0.2, 0.2, 0.2))
LLB = Part(Model, false, false, 1, 0, BN("White"), V3(0.2, 0.2, 0.2))

RABW = Weld(Torso, RAB, CN(), CN(-1.5, -0.5, 0))
LABW = Weld(Torso, LAB, CN(), CN(1.5, -0.5, 0))
RLBW = Weld(Torso, RLB, CN(), CN(-0.5, 1, 0))
LLBW = Weld(Torso, LLB, CN(), CN(0.5, 1, 0))

RAW = Weld(RAB, nil, CN(), CN(0, 0.5, 0))
LAW = Weld(LAB, nil, CN(), CN(0, 0.5, 0))
RLW = Weld(RLB, nil, CN(), CN(0, 1, 0))
LLW = Weld(LLB, nil, CN(), CN(0, 1, 0))

TW = Weld(Torso, nil, CN(0.7, 0.8, 1.2), CA(0, MR(180), MR(55)))

Weapon = Instance.new("Model")
Weapon.Name = "Cannon"

HB = Part(Weapon, false, false, 1, 0, BN("White"), V3(0.2, 0.2, 0.2))
HBW = Weld(Rarm, HB, CN(0, -0.7, 0), CA(0, MR(90), MR(90)))
HW = Weld(HB, nil)

Handle = Part(Weapon, false, false, 0, 0, BN("Dark grey"), V3(0.5, 0.5, 0.3))
Add.Mesh(Handle, "http://www.roblox.com/asset/?id=3270017", V3(1, 0.7, 2.2), "")
TW.Part1 = Handle

Main = Part(Weapon, false, false, 0, 0, BN("Dark grey"), V3(1.5, 1.5, 2.5))
Add.Mesh(Main, "http://www.roblox.com/asset/?id=3270017", V3(1.6, 1.6, 15), "")
Weld(Handle, Main, CA(0, MR(90), MR(90)), CN(1, 0, 0.2))

Main2 = Part(Weapon, false, false, 0, 0, BN("Gun metallic"), V3(1, 1, 1.5))
Add.Mesh(Main2, "http://www.roblox.com/asset/?id=3270017", V3(1.2, 1.2, 8), "")
Weld(Main, Main2, CN(), CN(0, 0, 1.7))

Handle2 = Part(Weapon, false, false, 0, 0, BN("Dark grey"), V3(0.5, 0.5, 0.3))
Add.Mesh(Handle2, "http://www.roblox.com/asset/?id=3270017", V3(0.7, 0.8, 2.2), "")
Weld(Main2, Handle2, CA(0, MR(90), MR(90)), CN(-0.65, 0, 0))

Tip = Part(Weapon, false, false, 0, 0, BN("Earth yellow"), V3(1.6, 1.6, 0.6))
Add.Sphere(Tip, V3(1.05, 1.05, 1))
Weld(Main, Tip, CN(), CN(0, 0, -1.15))

Tip4 = Part(Weapon, false, false, 0, 0, BN("Black"), V3(1.2, 1.2, 0.3))
Add.Mesh(Tip4, "http://www.roblox.com/asset/?id=3270017", V3(1.7, 1.7, 10), "")
Weld(Main, Tip4, CN(), CN(0, 0, -0.15))

for i = 1.3, 1.45, 0.1 do
	local Tip3 = Part(Weapon, false, false, 0, 0, BN("Dark grey"), V3(1.2, 1.2, 0.3))
	Add.Mesh(Tip3, "http://www.roblox.com/asset/?id=3270017", V3(i, i, 2), "")
	Weld(Main2, Tip3, CN(), CN(0, 0, 0.6))
end

for i = -0.95, 0.66, 1.55 do
	local Tip3 = Part(Weapon, false, false, 0, 0, BN("Dark Curry"), V3(1.2, 1.2, 0.3))
	Add.Mesh(Tip3, "http://www.roblox.com/asset/?id=3270017", V3(1.65, 1.65, 3), "")
	Weld(Main, Tip3, CN(), CN(0, 0, i))
end

for i = 1.3, 1.5, 0.1 do
	local Tip2 = Part(Weapon, false, false, 0, 0, BN("Earth yellow"), V3(1.6, 1.6, 0.6))
	Add.Mesh(Tip2, "http://www.roblox.com/asset/?id=3270017", V3(i, i, 2), "")
	Weld(Main, Tip2, CN(), CN(0, 0, 1.1))
end

for i = -0.3, 1, 0.15 do
	local p = Part(Weapon, false, false, 0.7, 0, BN("Black"), V3(0.2, 0.2, 0.2))
	Add.Sphere(p, V3(6, 6, 2))
	Weld(Main2, p, CN(0, 0, i))
end

function Show_Damage(P, D)
	local mo = Instance.new("Model")
	mo.Name = "- "..D
	local p = Part(mo, false, false, 0, 0, BN("Bright red"), V3(0.2, 0.2, 0.2))
	p.Name = "Head"
	local m = Instance.new("SpecialMesh")
	m.MeshType = "Brick"
	m.Scale = Vector3.new(4.5, 2.3, 4.5)
	m.Parent = p
	local bp = Instance.new("BodyPosition", p)
	bp.maxForce = V3(MH, MH, MH)
	bp.P = 9001
	bp.position = CN(P) * CN(0, 1.5, 0).p
	local h = Instance.new("Humanoid")
	h.Health = 0
	h.MaxHealth = 0
	h.Name = "asd"
	h.Parent = mo
	local nah = true
	mo.Parent = workspace
	p.CFrame = CN(P) 
	Notime(function()
		wait(1.5)
		for i = 0, 1, 0.05 do
			p.Transparency = i
			if nah then mo.Name = "" nah = false else mo.Name = "- "..D nah = true end
			wait()
		end
		mo:remove()
	end)
end

function Kill(hit)
	if Debounce and Hurt then
		local Hu = GetHum(hit.Parent)
		if Hu then
			Debounce = false
			local Dmg = MRA(Damage[1], Damage[2])
			Hu.Health = Hu.Health - Dmg
			Show_Damage(Tip.Position, Dmg)
			PlaySound(Sounds.Hit, true)
			Tag(Hu)
			local chance = MRA(1, 10)
			if chance >=5 then
				Hu.PlatformStand = true
				wait(0.15)
				hit.Velocity = (CN(Torso.CFrame * CN(0, 0.5, 0).p, hit.Position).lookVector * 45)
				hit.RotVelocity = V3(MRA(-10, 10), MRA(-10, 10), MRA(-10, 10))
				wait(0.3)
				Hu.PlatformStand = false
			end
		end
	end
end

Main.Touched:connect(Kill)

Weapon.Parent = Model
Model.Parent = Char

if script.Parent.ClassName ~= "HopperBin" then
	h = Instance.new("HopperBin", Me.Backpack)
	h.Name = "Hand Cannon"
	script.Parent = h
end

bin = h


function Attach(t)
	RSH.Part0 = t
	LSH.Part0 = t
	RH.Part0 = t
	LH.Part0 = t
	RABW.Part0 = t
	LABW.Part0 = t
	LLBW.Part0 = t
	RLBW.Part0 = t
	if t == Torso then
		FTorso.Transparency = 1
	else
		Torso.Transparency = 1
	end
	t.Transparency = 0
end

function SelectAnim()
	RAW.Part1 = Rarm
	for i = 0.25, 1, 0.25 do
		RAW.C0 = CA(MR(-10*i), 0, MR(-5*i))
		wait()
	end
	for i = 0.1, 1, 0.1 do
		RAW.C0 = CA(MR(-10-90*i), 0, MR(-5-30*i))
		wait()
	end
	for i = 0.5, 1, 0.5 do
		RAW.C0 = CA(MR(-100-5*i), 0, MR(-35))
		wait()
	end
	HW.Part1 = Handle
	HW.C0 = CA(MR(50), 0, MR(-37))
	TW.Part1 = nil
	Attach(FTorso)
	LAW.Part1 = Larm
	for i = 0.25, 1, 0.25 do
		RAW.C0 = CA(MR(-105+10*i), 0, MR(-35+5*i))
		LAW.C0 = CA(MR(15*i), 0, MR(5*i))
		FW.C0 = CA(0, MR(-5*i), 0)
		HW.C0 = CA(MR(50-5*i), 0, MR(-37))
		wait()
	end
	for i = 0.06, 1, 0.06 do
		RAW.C0 = CA(MR(-95+95*i), MR(35*i), MR(-30+50*i))
		LAW.C0 = CA(MR(15+25*i), 0, MR(5+15*i)) * CN(0, -0.4*i, 0)
		FW.C0 = CA(0, MR(-5-30*i), 0)
		HW.C0 = CA(MR(45), 0, MR(-37+15*i))
		wait()
	end
	Hum.WalkSpeed = 10
	for i = 0.1, 1, 0.1 do
		RAW.C0 = CA(MR(15*i), MR(35+10*i), MR(20+8*i))
		LAW.C0 = CA(MR(40+7*i), 0, MR(20+6*i)) * CN(0, -0.4-0.2*i, 0)
		FW.C0 = CA(0, MR(-35-10*i), 0)
		HW.C0 = CA(MR(45-11*i), 0, MR(-22+15*i))
		wait()
	end
	for i = 0.25, 1, 0.25 do
		RAW.C0 = CA(MR(15+5*i), MR(45+5*i), MR(28+2*i))
		LAW.C0 = CA(MR(47+3*i), 0, MR(26+4*i)) * CN(0, -0.6, 0)
		FW.C0 = CA(0, MR(-45-5*i), 0)
		HW.C0 = CA(MR(34-4*i), 0, MR(-7+7*i))
		wait()
	end
end

function DeselAnim()
	for i = 0.25, 1, 0.25 do
		RAW.C0 = CA(MR(20-5*i), MR(50-5*i), MR(30-5*i))
		LAW.C0 = CA(MR(50-5*i), 0, MR(30-5*i)) * CN(0, -0.6+0.1*i, 0)
		FW.C0 = CA(0, MR(-50+5*i), 0)
		HW.C0 = CA(MR(30+5*i), 0, MR(-10*i))
		wait()
	end
	for i = 0.15, 1, 0.15 do
		RAW.C0 = CA(MR(15-30*i), MR(45-10*i), MR(25-5*i))
		LAW.C0 = CA(MR(45-20*i), 0, MR(25-15*i)) * CN(0, -0.5+0.2*i, 0)
		FW.C0 = CA(0, MR(-45+10*i), 0)
		HW.C0 = CA(MR(35+10*i), 0, MR(-10-15*i))
		wait()
	end
	for i = 0.12, 1, 0.12 do
		RAW.C0 = CA(MR(-15-70*i), MR(35-30*i), MR(20-30*i))
		LAW.C0 = CA(MR(25-25*i), 0, MR(10-10*i)) * CN(0, -0.3+0.3*i, 0)
		FW.C0 = CA(0, MR(-35+20*i), 0)
		HW.C0 = CA(MR(45+5*i), 0, MR(-25-12*i))
		wait()
	end
	LAW.Part1 = nil
	HW.C0 = CA(MR(50), 0, MR(-37))
	for i = 0.25, 1, 0.25 do
		RAW.C0 = CA(MR(-85-20*i), MR(5-5*i), MR(-10-25*i))
		FW.C0 = CA(0, MR(-15+15*i), 0)
		wait()
	end
	Attach(Torso)
	HW.Part1 = nil
	TW.Part1 = Handle
	Hum.WalkSpeed = 16
	for i = 0.15, 1, 0.15 do
		RAW.C0 = CA(MR(-105+95*i), 0, MR(-35+30*i))
		wait()
	end
	for i = 0.33, 1, 0.33 do
		RAW.C0 = CA(MR(-10+10*i), 0, MR(-5+5*i))
		wait()
	end
	RAW.Part1 = nil
end

--Norms:
--RAW.C0 = CA(MR(20), MR(50), MR(30))
--LAW.C0 = CA(MR(50), 0, MR(30)) * CN(0, -0.6, 0)
--FW.C0 = CA(0, MR(-50), 0)
--HW.C0 = CA(MR(30), 0, 0)
--
--

function Explode(Par, Pos, surface)
	Notime(function()
		local cf = CN(Pos) * CA(Par.CFrame:toEulerAnglesXYZ()) * surface[2] * CN(0, 1, 0)
		if surface[1] == "Anything" then
			cf = surface[2]
		end
		local col = Par.BrickColor.Color
		local r, g, b = col.r, col.g, col.b
		local col1, col2, col3 = C3(MRA(r*60, r*100)/100, MRA(g*60, g*100)/100, MRA(b*60, b*100)/100), C3(MRA(r*60, r*100)/100, MRA(g*60, g*100)/100, MRA(b*60, b*100)/100), C3(MRA(r*60, r*100)/100, MRA(g*60, g*100)/100, MRA(b*60, b*100)/100)
		local p = Part(workspace, true, false, 0, 0, BN(col1.r, col1.g, col1.b), V3(0.2, 0.2, 0.2))
		local p2 = Part(workspace, true, false, 0, 0, BN(col2.r, col2.g, col2.b), V3(0.2, 0.2, 0.2))
		local p3 = Part(workspace, true, false, 0, 0, BN(col3.r, col3.g, col3.b), V3(0.2, 0.2, 0.2))
		p.CFrame = cf
		p2.CFrame = cf
		p3.CFrame = cf
		local m = Add.Mesh(p, "http://www.roblox.com/asset/?id=20329976", V3(1, 1, 1))
		local m2 = Add.Mesh(p2, "http://www.roblox.com/asset/?id=20329976", V3(1, 1, 1))
		local m3 = Add.Mesh(p3, "http://www.roblox.com/asset/?id=20329976", V3(1, 1, 1))
		for i = -0.2, 1, 0.12 do
			p2.Transparency = i+0.1
			p.Transparency = i
			p3.Transparency = i+0.2
			m.Scale = V3(1+2.5*i, 1.4+1*i, 1+2.5*i)
			m2.Scale = V3(0.8+2*i, 1.2+1*i, 0.8+2*i)
			m3.Scale = V3(0.5+1*i, 1+1*i, 0.5+1*i)
			wait()
		end
		p2:remove()
		p3:remove()
		p:remove()
	end)
end

function Shoot(Pos)
	coroutine.resume(coroutine.create(function()
	local acc = Accuracy*100
	local Start = Main2.CFrame * CN(0, 0, -0.5).p
	local Face = CN(Start, Pos) * CA(MR(MRA(-acc, acc))/100, MR(MRA(-acc, acc))/100, MR(MRA(-acc, acc))/100)
	local Cannonball = Part(Model, true, false, 0, 0, BN("Black"), V3(1.3, 1.3, 1.3))
	Add.Sphere(Cannonball)
	Cannonball.CFrame = Face
	local Go = 3
	local Drop = 0.55/(Go*3)
	local Dist = 500
	local lastP = Start
	local omg = 0
	for i = Go, Dist, Go do
		Drop = Drop + 1/(Go*3)
		omg = omg + Drop
		local dropping = CA(MR(-Drop), 0, 0)
		if omg > 130 then
			dropping = CN()
		end
		Face = Face * dropping * CN(0, 0, -Go)
		Cannonball.CFrame = Face
		local Magn = (Face.p - lastP).magnitude
		local T = Part(Model, true, false, 0.1, 0, BN("Mid gray"), V3(0.2, 1, 0.2))
		local M = Instance.new("SpecialMesh",T)
		M.MeshType = "Head"
		M.Scale = V3(5, Magn, 5)
		T.CFrame = CN(lastP, Face.p) * CA(MR(-90), 0, 0) * CN(0, Magn/2, 0)
		Notime(function()
			wait(0.1)
			for i = 0.1, 1, 0.1 do
				T.Transparency = i+0.1
				M.Scale = V3(5-5*i, Magn+0.5, 5-5*i)
				wait()
			end
			T:remove()
		end)
		local Hit, Hitpos = RayC(lastP, Face.p, Go*2, Char)
		lastP = Face.p
		if Hit then
			PlaySound(Sounds.Boom, true)
			local s = DetectSurface(Hitpos, Hit)
			Explode(Hit, Hitpos, s)
			Cannonball.CFrame = CN(Hitpos)
			local hu = GetHum(Hit.Parent)
			if hu == nil and Hit.Parent.className ~= "Hat" and Hit.Anchored then
				coroutine.resume(coroutine.create(function()
					wait(10)
					for i = 0, 1, 0.04 do
						Cannonball.Transparency = i
						wait()
					end
					Cannonball:remove()
				end))
			else
				Cannonball:remove()
			end
			local Noobs = GetGroup(Hitpos, 5, Hit)
			for _,v in pairs(Noobs) do
				local dm = 60/((v[3]+3)/3)
				dm = MRA(dm*0.9, dm*1.04)
				v[1].Health = v[1].Health - dm
				local t = v[2]:findFirstChild("Head")
				if t then
					Show_Damage(t.Position, dm)
				end
				pcall(function()
				Tag(v[1])
				end)
			end
			local Parts = GetParts(Hitpos, 7)
			for _,v in pairs(Parts) do
				if v[3] == false then
					Notime(function()
						if v[1].Name == "Brick wall" then
							v[1]:BreakJoints()
							v[1].Velocity = (CN(Hitpos, v[1].Position).lookVector * (110/((v[2]+2)/3)))
							wait(0.1)
							v[1].Velocity = (CN(Hitpos, v[1].Position).lookVector * (110/((v[2]+2)/3)))
						else
							v[1].Velocity = (CN(Hitpos, v[1].Position).lookVector * (80/((v[2]+2)/3)))
						end
					end)
				end
			end
			break
		end
		wait()
	end
	end))
end

function ShootAnim(pos)
	RLW.Part1 = Rleg
	LLW.Part1 = Lleg
	local cf = ComputePos(Torso.Position, pos)
	local bp = Instance.new("BodyPosition",Torso)
	bp.maxForce = V3(MH, 0, MH)
	bp.P = 10000
	PlaySound(Sounds.Shoot, true)
	local effect = Part(Model, false, false, 0, 0, BN(ShootColors[MRA(1,#ShootColors)]), V3(0.2, 0.2, 0.2))
	local effect2 = Part(Model, false, false, 0, 0, BN(ShootColors[MRA(1,#ShootColors)]), V3(0.2, 0.2, 0.2))
	local m1 = Add.Mesh(effect, "http://www.roblox.com/asset/?id=20329976", V3(1,1,1))
	local m2 = Add.Mesh(effect2, "http://www.roblox.com/asset/?id=20329976", V3(1,1,1))
	local w1 = Weld(Main2, effect, CA(MR(-90), 0, 0), CN(0, -1, 0))
	local w2 = Weld(Main2, effect2, CA(MR(-90), 0, 0), CN(0, -1, 0))
	for i = 0, 1, 0.5 do
		RAW.C0 = CA(MR(20-50*i), MR(50-25*i), MR(30+45*i))
		LAW.C0 = CA(MR(50-10*i), 0, MR(30+20*i)) * CN(0, -0.6-0.3*i, 0)
		RLW.C0 = CA(MR(30*i), 0, MR(-15*i))
		LLW.C0 = CA(MR(10*i), 0, MR(-35*i))
		FW.C0 = CA(MR(5*i), MR(-50-15*i), 0)
		HW.C0 = CA(MR(30), MR(35*i), MR(-25*i))
		Neck.C0 = necko * CA(MR(10*i), 0, 0)
		bp.position = cf * CN(0, 0, 3*i).p
		m1.Scale = V3(0.5+0.6*i, 0.4+0.2*i, 0.5+0.6*i)
		m2.Scale = V3(0.3+0.5*i, 0.5+1*i, 0.3+0.5*i)
		w1.C1 = CN(0, -1-0.2*i, 0)
		w2.C1 = CN(0, -1-0.5*i, 0)
		effect.Transparency = 0.2*i
		effect2.Transparency = 0.2*i
		wait()
	end
	for i = 0.2, 1, 0.2 do
		RAW.C0 = CA(MR(-30-10*i), MR(25-5*i), MR(75+5*i))
		LAW.C0 = CA(MR(40-5*i), 0, MR(50+5*i)) * CN(0, -0.9-0.05*i, 0)
		RLW.C0 = CA(MR(30+5*i), 0, MR(-15))
		LLW.C0 = CA(MR(10+5*i), 0, MR(-35-5*i))
		FW.C0 = CA(MR(5+5*i), MR(-65-5*i), 0)
		HW.C0 = CA(MR(30), MR(35+5*i), MR(-25-5*i))
		Neck.C0 = necko * CA(MR(10+5*i), 0, 0)
		bp.position = cf * CN(0, 0, 3+1*i).p
		m1.Scale = V3(1+1*i, 0.7+0.9*i, 1+1*i)
		m2.Scale = V3(0.8+0.6*i, 1.5+1.6*i, 0.8+0.6*i)
		w1.C1 = CN(0, -1.2-0.6*i, 0)
		w2.C1 = CN(0, -1.5-1.8*i, 0)
		effect.Transparency = 0.2+0.9*i
		effect2.Transparency = 0.2+0.9*i
		wait()
	end
	effect:remove()
	effect2:remove()
	for i = 0.2, 1, 0.2 do
		bp.position = cf * CN(0, 0, 4+0.8*i).p
		wait()
	end
	for i = 0.08, 1, 0.06 do
		RAW.C0 = CA(MR(-40+50*i), MR(20+15*i), MR(80-35*i))
		LAW.C0 = CA(MR(35-30*i), 0, MR(55-45*i)) * CN(0, -0.95+0.5*i, 0)
		RLW.C0 = CA(MR(35-35*i), 0, MR(-15+25*i))
		LLW.C0 = CA(MR(15-15*i), 0, MR(-40+30*i))
		FW.C0 = CA(MR(10-7*i), MR(-70+40*i), 0)
		HW.C0 = CA(MR(30), MR(40-40*i), MR(-30-10*i))
		Neck.C0 = necko * CA(MR(15+5*i), 0, MR(20*i))
		bp.position = cf * CN(0, 0, 4.8+0.8*i).p
		wait()
	end
	bp:remove()
	for i = 0.33, 1, 0.33 do
		RAW.C0 = CA(MR(10+10*i), MR(35+5*i), MR(45-5*i))
		LAW.C0 = CA(MR(5), 0, MR(10)) * CN(0, -0.45+0.1*i, 0)
		FW.C0 = CA(MR(3-3*i), MR(-30+5*i), 0)
		HW.C0 = CA(MR(30), 0, MR(-40-10*i))
		wait()
	end
	for i = 0.12, 1, 0.12 do
		RAW.C0 = CA(MR(20+5*i), MR(40+5*i), MR(40+5*i))
		LAW.C0 = CA(MR(5), 0, MR(10)) * CN(0, -0.35-0.3*i, 0)
		FW.C0 = CA(0, MR(-25+5*i), 0)
		HW.C0 = CA(MR(30), 0, MR(-50-5*i))
		wait()
	end
	local b = Part(Model, false, false, 0, 0, BN("Black"), V3(1.1, 1.1, 1.1))
	local m = Add.Sphere(b)
	local w = Weld(Larm, b, CN(), CN(0, 1.4, 0))
	for i = 0.16, 1, 0.16 do
		LAW.C0 = CA(MR(5+30*i), 0, MR(10+10*i)) * CN(0, -0.65+0.65*i, 0)
		RAW.C0 = CA(MR(25), MR(45+3*i), MR(40))
		m.Scale = V3(0.5+0.5*i, 0.5+0.5*i, 0.5+0.5*i)
		Neck.C0 = necko * CA(MR(20-10*i), 0, MR(20-15*i))
		wait()
	end
	for i = 0.1, 1, 0.1 do
		LAW.C0 = CA(MR(35+105*i), 0, MR(20+20*i)) * CN(0, -0.9*i, 0)
		RAW.C0 = CA(MR(25), MR(48+6*i), MR(40))
		Neck.C0 = necko * CA(MR(10-10*i), 0, MR(5-35*i))
		wait()
	end
	for i = 0.16, 1, 0.16 do
		LAW.C0 = CA(MR(140-10*i), 0, MR(40-15*i)) * CN(0, -0.9-0.2*i, 0)
		RAW.C0 = CA(MR(25), MR(54), MR(40))
		Neck.C0 = necko * CA(MR(5*i), 0, MR(-30))
		w.C0 = CN(1.5*i, 0.55*i, 1.1*i)
		wait()
	end
	PlaySound(Sounds.Reload, true)
	b:remove()
	w:remove()
	for i = 0.2, 1, 0.2 do
		LAW.C0 = CA(MR(130-10*i), 0, MR(25-15*i)) * CN(0, -1.1+0.2*i, 0)
		RAW.C0 = CA(MR(25-10*i), MR(54), MR(40))
		Neck.C0 = necko * CA(MR(5-3*i), 0, MR(-30+5*i))
		HW.C0 = CA(MR(30), 0, MR(-55+10*i))
		FW.C0 = CA(0, MR(-20-5*i), 0)
		wait()
	end
	for i = 0.11, 1, 0.11 do
		LAW.C0 = CA(MR(120-60*i), 0, MR(10+15*i)) * CN(0, -0.9+0.3*i, 0)
		RAW.C0 = CA(MR(15+5*i), MR(54-4*i), MR(40-10*i))
		Neck.C0 = necko * CA(MR(2-2*i), 0, MR(-25+25*i))
		HW.C0 = CA(MR(30), 0, MR(-45+45*i))
		FW.C0 = CA(0, MR(-25-20*i), 0)
		RLW.C0 = CA(0, 0, MR(10-8*i))
		LLW.C0 = CA(0, 0, MR(-10+8*i))
		wait()
	end
	Neck.C0 = necko
	for i = 0.25, 1, 0.25 do
		LAW.C0 = CA(MR(60-10*i), 0, MR(25+5*i)) * CN(0, -0.6, 0)
		RAW.C0 = CA(MR(20), MR(50), MR(30))
		HW.C0 = CA(MR(30), 0, 0)
		FW.C0 = CA(0, MR(-45-5*i), 0)
		RLW.C0 = CA(0, 0, MR(2-2*i))
		LLW.C0 = CA(0, 0, MR(-2+2*i))
		wait()
	end
	RLW.Part1 = nil
	LLW.Part1 = nil
	RAW.C0 = CA(MR(20), MR(50), MR(30))
	LAW.C0 = CA(MR(50), 0, MR(30)) * CN(0, -0.6, 0)
	FW.C0 = CA(0, MR(-50), 0)
	HW.C0 = CA(MR(30), 0, 0)
	Neck.C0 = necko
end

function Melee()
	PlaySound(Sounds.Slash, true)
	for i = 0.25, 1, 0.25 do
		RAW.C0 = CA(MR(20+5*i), MR(50-5*i), MR(30+3*i))
		LAW.C0 = CA(MR(50), 0, MR(30+4*i)) * CN(0, -0.6-0.05*i, 0)
		HW.C0 = CA(MR(30), MR(5*i), 0)
		FW.C0 = CA(0, MR(-50-5*i), 0)
		wait()
	end
	for i = 0.12, 1, 0.12 do
		RAW.C0 = CA(MR(25+25*i), MR(45-30*i), MR(33+7*i))
		LAW.C0 = CA(MR(50), 0, MR(34+11*i)) * CN(0, -0.65-0.25*i, 0)
		HW.C0 = CA(MR(30), MR(5+25*i), 0)
		FW.C0 = CA(0, MR(-55-25*i), 0)
		wait()
	end
	for i = 0.33, 1, 0.33 do
		RAW.C0 = CA(MR(50+15*i), MR(15-5*i), MR(40-10*i)) * CN(0, -0.2*i, 0)
		LAW.C0 = CA(MR(50+10*i), 0, MR(45-5*i)) * CN(0, -0.9+0.15*i, 0)
		HW.C0 = CA(MR(30+2*i), MR(30+5*i), 0)
		FW.C0 = CA(0, MR(-80+10*i), MR(-5*i))
		wait()
	end
	Hurt = true
	Debounce = true
	for i = 0.07, 1, 0.07 do
		RAW.C0 = CA(MR(65+55*i), MR(10), MR(30-70*i)) * CN(0, -0.2-1.1*i, 0)
		LAW.C0 = CA(MR(60+120*i), 0, MR(40-70*i)) * CN(0, -0.75+0.7*i, 0)
		HW.C0 = CA(MR(32+6*i), MR(35+20*i), MR(-4*i))
		FW.C0 = CA(0, MR(-70+110*i), 0)
		wait()
	end
	for i = 0.16, 1, 0.16 do
		RAW.C0 = CA(MR(120+10*i), MR(10), MR(-40-5*i)) * CN(0, -1.3-0.1*i, 0)
		LAW.C0 = CA(MR(180+15*i), 0, MR(-30-20*i)) * CN(0, -0.05+0.1*i, 0)
		HW.C0 = CA(MR(38+2*i), MR(55-6*i), MR(-4-1*i))
		FW.C0 = CA(0, MR(40+10*i), 0)
		wait()
	end
	Hurt = false
	for i = 0.2, 1, 0.2 do
		RAW.C0 = CA(MR(130+5*i), MR(10), MR(-45-2*i)) * CN(0, -1.4-0.05*i, 0)
		LAW.C0 = CA(MR(195+5*i), 0, MR(-50-8*i)) * CN(0, 0.05+0.05*i, 0)
		HW.C0 = CA(MR(40), MR(49-2*i), MR(-5))
		FW.C0 = CA(0, MR(50+3*i), 0)
		wait()
	end
	wait(0.2)
	for i = 0.2, 1, 0.2 do
		RAW.C0 = CA(MR(135-10*i), MR(10+5*i), MR(-47+10*i)) * CN(0, -1.45+0.25*i, 0)
		LAW.C0 = CA(MR(200-10*i), 0, MR(-58+10*i)) * CN(0, 0.1-0.1*i, 0)
		HW.C0 = CA(MR(40), MR(47-5*i), MR(-5+5*i))
		FW.C0 = CA(0, MR(53-10*i), 0)
		wait()
	end
	for i = 0.08, 1, 0.08 do
		RAW.C0 = CA(MR(125-90*i), MR(15+30*i), MR(-37+57*i)) * CN(0, -1.2+1.1*i, 0)
		LAW.C0 = CA(MR(190-125*i), 0, MR(-48+68*i)) * CN(0, -0.5*i, 0)
		HW.C0 = CA(MR(40-7*i), MR(42-37*i), 0)
		FW.C0 = CA(0, MR(43-82*i), 0)
		wait()
	end
	for i = 0.2, 1, 0.2 do
		RAW.C0 = CA(MR(35-15*i), MR(45+5*i), MR(20+10*i)) * CN(0, -0.1+0.1*i, 0)
		LAW.C0 = CA(MR(65-15*i), 0, MR(20+10*i)) * CN(0, -0.5-0.1*i, 0)
		HW.C0 = CA(MR(33-3*i), MR(5-5*i), 0)
		FW.C0 = CA(0, MR(-41-9*i), 0)
		wait()
	end
	RLW.Part1 = nil
	LLW.Part1 = nil
	RAW.C0 = CA(MR(20), MR(50), MR(30))
	LAW.C0 = CA(MR(50), 0, MR(30)) * CN(0, -0.6, 0)
	FW.C0 = CA(0, MR(-50), 0)
	HW.C0 = CA(MR(30), 0, 0)
	Neck.C0 = necko
end

function onSelected(mouse)
	SelectAnim()
	Selected = true
	mouse.Button1Down:connect(function()
		if Attacking == false then
			Attacking = true
			mouse.Button1Up:wait()
			Shoot(mouse.Hit.p)
			ShootAnim(mouse.Hit.p)
			Attacking = false
		end
	end)
	mouse.KeyDown:connect(function(key)
		key = key:lower()
		if key == "q" then
			if Attacking == false then
				Attacking = true
				Melee()
				Attacking = false
			end
		end
	end)
end

function onDeselected(mouse)
	Selected = false
	DeselAnim()
end

bin.Selected:connect(onSelected)
bin.Deselected:connect(onDeselected)
