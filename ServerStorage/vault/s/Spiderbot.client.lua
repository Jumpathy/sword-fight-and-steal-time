Player = game.Players.LocalPlayer
Char = Player.Character
Head = Char.Head
Torso = Char.Torso 
h = Char.Humanoid
necko=CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
local gairo = Instance.new("BodyGyro") 
gairo.Parent = nil 
if Char:findFirstChild("Weapon",true) ~= nil then 
Char:findFirstChild("Weapon",true).Parent = nil 
end 
bets = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," "}
--col = {"Really black,"Black"}
--col = {"Really red","Really black","Black"}
col = {"Really black","Really black","Really red"}
Anims = {}
act = {key = {}}
for i=1,#bets do table.insert(act.key,bets) end 
act.mousedown = false 
act.keydown = false 
act.Walking = false
act.Jumping = false 
act.Anim = ""
hitted=false
roflcopter=false
bodypos=Instance.new("BodyPosition")
holdshoot=false
Prop = {}
difficulty=0.05
Prop.LegLength = 5
Prop.LegWide = 1
Prop.BallSize = 0.9
--[[difficulty=0.1
Prop.LegLength = 4
Prop.LegWide = 0.8
Prop.BallSize = 1
difficulty=0.01
Prop.LegLength = 50
Prop.LegWide = 10
Prop.BallSize = 10.3
Prop.LegLength = 150
Prop.LegWide = 60
Prop.BallSize = 60.3]]
coroutine.resume(coroutine.create(function()
for i=0,50 do
wait()
h.WalkSpeed=18
--h.WalkSpeed=5
walksped=h.WalkSpeed
h.MaxHealth=math.huge
h.Health=math.huge
end
end))
Spider = {w = {}}
attack = false 
attackdebounce = false
it = Instance.new
bc = BrickColor.new
v3 = Vector3.new
cf = CFrame.new
ca = CFrame.Angles
pi = math.pi
rd = math.rad
br = BrickColor.new
function r(pa,ob)
pcall(function() pa[ob]:Remove() end)
end 
function p(pa,sh,x,y,z,c,a,tr,re,bc)
local fp = it("Part",pa)
fp.formFactor = "Custom"
fp.Shape = sh
fp.Size = v3(x,y,z)
fp.CanCollide = c
fp.Anchored = false
fp.BrickColor = br(bc)
fp.Transparency = tr
fp.Reflectance = re
fp.BottomSurface = 0
fp.TopSurface = 0
fp.CFrame = Torso.CFrame + Vector3.new(0,50,0)
fp.Velocity = Vector3.new(0,10,0)
fp:BreakJoints()
return fp 
end 
function weld(pa,p0,p1,x,y,z,a,b,c)
local fw = it("Weld",pa)
fw.Part0 = p0 fw.Part1 = p1
fw.C0 = cf(x,y,z) *ca(a,b,c)
return fw
end
function spm(ty,pa,ss)
local sp = it("SpecialMesh",pa)
sp.MeshType = ty
sp.Scale = Vector3.new(ss,ss,ss)
end
pcall(function() Torso.Spider:Remove() end)
wait(0.1)
pack = it("Model",Torso)
pack.Name = "Spider"
Spider.Back = p(pack,"Block",1.2,1.7,0.5,false,false,0,0,col[1])
--Right Arm
Spider.RAb1 = p(pack,"Ball",1,1,1,false,false,0,0,col[2]) spm("Sphere",Spider.RAb1,Prop.BallSize)
Spider.w.RAb1 = weld(Spider.RAb1,Spider.Back,Spider.RAb1,0.5,0.6,0.35,0,0,0) Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.RAa1 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.RAa1 = weld(Spider.RAa1,Spider.RAb1,Spider.RAa1,0,Prop.LegLength/2,0,0,0,0)
Spider.RAb2 = p(pack,"Ball",1,1,1,false,false,0,0,col[2]) spm("Sphere",Spider.RAb2,Prop.BallSize)
Spider.w.RAb2 = weld(Spider.RAb2,Spider.RAa1,Spider.RAb2,0,(Prop.LegLength/2),0,0,0,0) Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.RAa2 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.RAa2 = weld(Spider.RAa2,Spider.RAb2,Spider.RAa2,0,Prop.LegLength/2,0,0,0,0)
--Left Arm
Spider.LAb1 = p(pack,"Ball",1,1,1,false,false,0,0,col[2]) spm("Sphere",Spider.LAb1,Prop.BallSize)
Spider.w.LAb1 = weld(Spider.LAb1,Spider.Back,Spider.LAb1,-0.5,0.6,0.35,0,0,0) Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.LAa1 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.LAa1 = weld(Spider.LAa1,Spider.LAb1,Spider.LAa1,0,Prop.LegLength/2,0,0,0,0)
Spider.LAb2 = p(pack,"Ball",1,1,1,false,false,0,0,col[2]) spm("Sphere",Spider.LAb2,Prop.BallSize)
Spider.w.LAb2 = weld(Spider.LAb2,Spider.LAa1,Spider.LAb2,0,(Prop.LegLength/2),0,0,0,0) Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
Spider.LAa2 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.LAa2 = weld(Spider.LAa2,Spider.LAb2,Spider.LAa2,0,Prop.LegLength/2,0,0,0,0)
--Upper Right
Spider.URb1 = p(pack,"Ball",1,1,1,false,false,0,0,col[3]) spm("Sphere",Spider.URb1,Prop.BallSize)
Spider.w.URb1 = weld(Spider.URb1,Spider.Back,Spider.URb1,0.5,-0.6,0.35,0,0,0) Spider.w.URb1.C1 = CFrame.Angles(math.rad(80),math.rad(40),0)
Spider.URa1 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.URa1 = weld(Spider.URa1,Spider.URb1,Spider.URa1,0,Prop.LegLength/2,0,0,0,0)
Spider.URb2 = p(pack,"Ball",1,1,1,false,false,0,0,col[3]) spm("Sphere",Spider.URb2,Prop.BallSize)
Spider.w.URb2 = weld(Spider.URb2,Spider.URa1,Spider.URb2,0,(Prop.LegLength/2),0,0,0,0) Spider.w.URb2.C1 = CFrame.Angles(math.rad(100),math.rad(0),0)
Spider.URa2 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.URa2 = weld(Spider.URa2,Spider.URb2,Spider.URa2,0,Prop.LegLength/2,0,0,0,0)
--Upper Left
Spider.ULb1 = p(pack,"Ball",1,1,1,false,false,0,0,col[3]) spm("Sphere",Spider.ULb1,Prop.BallSize)
Spider.w.ULb1 = weld(Spider.ULb1,Spider.Back,Spider.ULb1,-0.5,-0.6,0.35,0,0,0) Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80),math.rad(-40),0)
Spider.ULa1 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.ULa1 = weld(Spider.ULa1,Spider.ULb1,Spider.ULa1,0,Prop.LegLength/2,0,0,0,0)
Spider.ULb2 = p(pack,"Ball",1,1,1,false,false,0,0,col[3]) spm("Sphere",Spider.ULb2,Prop.BallSize)
Spider.w.ULb2 = weld(Spider.ULb2,Spider.ULa1,Spider.ULb2,0,(Prop.LegLength/2),0,0,0,0) Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100),math.rad(0),0)
Spider.ULa2 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.ULa2 = weld(Spider.ULa2,Spider.ULb2,Spider.ULa2,0,Prop.LegLength/2,0,0,0,0)
--Lower Right
Spider.LRb1 = p(pack,"Ball",1,1,1,false,false,0,0,col[3]) spm("Sphere",Spider.LRb1,Prop.BallSize)
Spider.w.LRb1 = weld(Spider.LRb1,Spider.Back,Spider.LRb1,0.5,-0.6,0.35,0,0,0) Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80),math.rad(-40),0)
Spider.LRa1 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.LRa1 = weld(Spider.LRa1,Spider.LRb1,Spider.LRa1,0,Prop.LegLength/2,0,0,0,0)
Spider.LRb2 = p(pack,"Ball",1,1,1,false,false,0,0,col[3]) spm("Sphere",Spider.LRb2,Prop.BallSize)
Spider.w.LRb2 = weld(Spider.LRb2,Spider.LRa1,Spider.LRb2,0,(Prop.LegLength/2),0,0,0,0) Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100),math.rad(0),0)
Spider.LRa2 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.LRa2 = weld(Spider.LRa2,Spider.LRb2,Spider.LRa2,0,Prop.LegLength/2,0,0,0,0)
--Lower Left
Spider.LLb1 = p(pack,"Ball",1,1,1,false,false,0,0,col[3]) spm("Sphere",Spider.LLb1,Prop.BallSize)
Spider.w.LLb1 = weld(Spider.LLb1,Spider.Back,Spider.LLb1,-0.5,-0.6,0.35,0,0,0) Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80),math.rad(40),0)
Spider.LLa1 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.LLa1 = weld(Spider.LLa1,Spider.LLb1,Spider.LLa1,0,Prop.LegLength/2,0,0,0,0)
Spider.LLb2 = p(pack,"Ball",1,1,1,false,false,0,0,col[3]) spm("Sphere",Spider.LLb2,Prop.BallSize)
Spider.w.LLb2 = weld(Spider.LLb2,Spider.LLa1,Spider.LLb2,0,(Prop.LegLength/2),0,0,0,0) Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100),math.rad(0),0)
Spider.LLa2 = p(pack,"Block",Prop.LegWide,Prop.LegLength,Prop.LegWide,true,false,0,0,col[1])
Spider.w.LLa2 = weld(Spider.LLa2,Spider.LLb2,Spider.LLa2,0,Prop.LegLength/2,0,0,0,0)
local prt1 = Instance.new("Part") 
prt1.formFactor = 1 
prt1.Parent = pack 
prt1.CanCollide = false 
prt1.BrickColor = br(col[1])
prt1.Name = "Part1" 
prt1.Size = Vector3.new(1,1,1) 
prt1.Position = Torso.Position 
local prt2 = Instance.new("Part") 
prt2.formFactor = 1 
prt2.Parent = pack 
prt2.CanCollide = false 
prt2.BrickColor = BrickColor.new("Really red") 
prt2.Name = "Part2" 
prt2.Reflectance=0.3
prt2.Size = Vector3.new(1,2,1) 
prt2.Position = Torso.Position 
local prt3 = Instance.new("Part") 
prt3.formFactor = 1 
prt3.Parent = pack 
prt3.CanCollide = false 
prt3.BrickColor = BrickColor.new("Medium stone grey") 
prt3.Name = "Part3" 
prt3.Reflectance=0.6
prt3.Size = Vector3.new(1,2,1) 
prt3.Position = Torso.Position 
local prt4 = Instance.new("Part") 
prt4.formFactor = 1 
prt4.Parent = pack 
prt4.CanCollide = false 
prt4.BrickColor = BrickColor.new("Really red") 
prt4.Name = "Part4" 
prt4.Reflectance=0.3
prt4.Size = Vector3.new(1,1,1) 
prt4.Position = Torso.Position 
local prt5 = Instance.new("Part") 
prt5.formFactor = 1 
prt5.Parent = pack 
prt5.CanCollide = false 
prt5.BrickColor = br(col[1])
prt5.Name = "Part5" 
prt5.Size = Vector3.new(1,1,1) 
prt5.Position = Torso.Position 
local prt6 = Instance.new("Part") 
prt6.formFactor = 1 
prt6.Parent = pack 
prt6.CanCollide = false 
prt6.BrickColor = br(col[1])
prt6.Name = "Part6" 
prt6.Size = Vector3.new(1,1,1) 
prt6.Position = Torso.Position 
local prt7 = Instance.new("Part") 
prt7.formFactor = 1 
prt7.Parent = pack 
prt7.CanCollide = false 
prt7.BrickColor = BrickColor.new("Really black") 
prt7.Name = "Part7" 
prt7.Size = Vector3.new(1,1,1) 
prt7.Position = Torso.Position 
local prt8 = Instance.new("Part") 
prt8.formFactor = 1 
prt8.Parent = pack 
prt8.CanCollide = false 
prt8.BrickColor = br(col[1])
prt8.Name = "Part8" 
prt8.Size = Vector3.new(1,1,1) 
prt8.Position = Torso.Position 
local prt9 = Instance.new("Part") 
prt9.formFactor = 1 
prt9.Parent = pack 
prt9.CanCollide = false 
prt9.BrickColor = br(col[1])
prt9.Name = "Part9" 
prt9.Size = Vector3.new(1,1,1) 
prt9.Position = Torso.Position 
local prt10 = Instance.new("Part") 
prt10.formFactor = 1 
prt10.Parent = pack 
prt10.CanCollide = false 
prt10.BrickColor = br(col[1])
prt10.Name = "Part10" 
prt10.Size = Vector3.new(1,1,1) 
prt10.Position = Torso.Position 
local prt11 = Instance.new("Part") 
prt11.formFactor = 1 
prt11.Parent = pack 
prt11.CanCollide = false 
prt11.BrickColor = br(col[1])
prt11.Name = "Part11" 
prt11.Size = Vector3.new(1,1,1) 
prt11.Position = Torso.Position 
local prt12 = Instance.new("Part") 
prt12.formFactor = 1 
prt12.Parent = pack 
prt12.CanCollide = false 
prt12.BrickColor = br(col[1])
prt12.Name = "Part12" 
prt12.Size = Vector3.new(1,1,1) 
prt12.Position = Torso.Position 
local msh1 = Instance.new("BlockMesh")
msh1.Parent = prt1
--msh1.Scale = Vector3.new(0.9,0.8,3)
msh1.Scale = Vector3.new(Prop.LegWide/0.9,Prop.LegWide/1,Prop.LegLength/1.3)
local msh2 = Instance.new("BlockMesh")
msh2.Parent = prt2
--msh2.Scale = Vector3.new(0.3,2.5,1)
msh2.Scale = Vector3.new(Prop.LegWide/2.5,Prop.LegLength/1.6,Prop.LegWide*1.3)
local msh3 = Instance.new("BlockMesh")
msh3.Parent = prt3
--msh3.Scale = Vector3.new(0.1,2.6,1.5)
msh3.Scale = Vector3.new(Prop.LegWide/6,Prop.LegLength/1.6,Prop.LegWide*1.9)
local msh4 = Instance.new("SpecialMesh")
msh4.Parent = prt4
msh4.MeshType = "Wedge"
--msh4.Scale = Vector3.new(0.3,2,1)
msh4.Scale = Vector3.new(Prop.LegWide/2.5,Prop.LegLength/2,Prop.LegWide*1.3)
local msh5 = Instance.new("CylinderMesh")
msh5.Parent = prt5
--msh5.Scale = Vector3.new(1.5,1,1.5)
msh5.Scale = Vector3.new(Prop.LegWide*2,Prop.LegLength/4,Prop.LegWide*2)
local msh6 = Instance.new("CylinderMesh")
msh6.Parent = prt6
--msh6.Scale = Vector3.new(2.5,1.6,2.5)
msh6.Scale = Vector3.new(Prop.LegWide*3.1,Prop.LegLength/2.5,Prop.LegWide*3.1)
local msh7 = Instance.new("CylinderMesh")
msh7.Parent = prt7
--msh7.Scale = Vector3.new(1.4,1.7,1.4)
msh7.Scale = Vector3.new(Prop.LegWide*1.8,Prop.LegLength/2.3,Prop.LegWide*1.8)
local msh8 = Instance.new("BlockMesh")
msh8.Parent = prt8
--msh8.Scale = Vector3.new(0.5,2,0.5)
msh8.Scale = Vector3.new(Prop.LegWide/1.6,Prop.LegLength/2,Prop.LegWide/1.6)
local msh9 = Instance.new("BlockMesh")
msh9.Parent = prt9
--msh9.Scale = Vector3.new(0.5,2,0.5)
msh9.Scale = Vector3.new(Prop.LegWide/1.6,Prop.LegLength/2,Prop.LegWide/1.6)
local msh10 = Instance.new("BlockMesh")
msh10.Parent = prt10
--msh10.Scale = Vector3.new(0.5,2,0.5)
msh10.Scale = Vector3.new(Prop.LegWide/1.6,Prop.LegLength/2,Prop.LegWide/1.6)
local msh11 = Instance.new("BlockMesh")
msh11.Parent = prt11
--msh11.Scale = Vector3.new(0.5,2,0.5)
msh11.Scale = Vector3.new(Prop.LegWide/1.6,Prop.LegLength/2,Prop.LegWide/1.6)
local msh12 = Instance.new("BlockMesh")
msh12.Parent = prt12
--msh12.Scale = Vector3.new(0.5,2,0.5)
msh12.Scale = Vector3.new(0,0,0)
local wld1 = Instance.new("Weld")
wld1.Parent = prt1
wld1.Part0 = prt1
wld1.Part1 = Spider.RAa2
--wld1.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-0.5,0) 
wld1.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-Prop.LegLength/6,0) 
local wld2 = Instance.new("Weld")
wld2.Parent = prt2
wld2.Part0 = prt2
wld2.Part1 = prt1
--wld2.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-3,0) 
wld2.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-Prop.LegLength/1.3,0) 
local wld3 = Instance.new("Weld")
wld3.Parent = prt3
wld3.Part0 = prt3
wld3.Part1 = prt1
--wld3.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-3,0) 
wld3.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-Prop.LegLength/1.3,0) 
local wld4 = Instance.new("Weld")
wld4.Parent = prt4
wld4.Part0 = prt4
wld4.Part1 = prt2
wld4.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-4.2,0) 
wld4.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-Prop.LegLength/1.1,0) 
local wld5 = Instance.new("Weld")
wld5.Parent = prt5
wld5.Part0 = prt5
wld5.Part1 = Spider.LAa2
--wld5.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-2.5,0) 
wld5.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-Prop.LegLength/1.6,0) 
local wld6 = Instance.new("Weld")
wld6.Parent = prt6
wld6.Part0 = prt6
wld6.Part1 = prt5
--wld6.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-1.5,0) 
wld6.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,-Prop.LegLength/2.6,0) 
local wld7 = Instance.new("Weld")
wld7.Parent = prt7
wld7.Part0 = prt7
wld7.Part1 = prt6
wld7.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) * CFrame.new(0,0,0) 
local wld8 = Instance.new("Weld")
wld8.Parent = prt8
wld8.Part0 = prt8
wld8.Part1 = prt6
--wld8.C0 = CFrame.fromEulerAnglesXYZ(0,0,-0.5) * CFrame.new(1.5,-1,0) 
wld8.C0 = CFrame.fromEulerAnglesXYZ(0,0,-0.5) * CFrame.new(Prop.LegWide*2,-Prop.LegLength/4,0) 
local wld9 = Instance.new("Weld")
wld9.Parent = prt9
wld9.Part0 = prt9
wld9.Part1 = prt6
--wld9.C0 = CFrame.fromEulerAnglesXYZ(0,0,0.5) * CFrame.new(-1.5,-1,0) 
wld9.C0 = CFrame.fromEulerAnglesXYZ(0,0,0.5) * CFrame.new(-Prop.LegWide*2,-Prop.LegLength/4,0) 
local wld10 = Instance.new("Weld")
wld10.Parent = prt10
wld10.Part0 = prt10
wld10.Part1 = prt6
--wld10.C0 = CFrame.fromEulerAnglesXYZ(-0.5,0,0) * CFrame.new(0,-1,-1.5) 
wld10.C0 = CFrame.fromEulerAnglesXYZ(-0.5,0,0) * CFrame.new(0,-Prop.LegLength/4,-Prop.LegWide*2) 
local wld11 = Instance.new("Weld")
wld11.Parent = prt11
wld11.Part0 = prt11
wld11.Part1 = prt6
--wld11.C0 = CFrame.fromEulerAnglesXYZ(0.5,0,0) * CFrame.new(0,-1,1.5) 
wld11.C0 = CFrame.fromEulerAnglesXYZ(0.5,0,0) * CFrame.new(0,-Prop.LegLength/4,Prop.LegWide*2) 
local wld12 = Instance.new("Weld")
wld12.Parent = prt12
wld12.Part0 = prt12
wld12.Part1 = prt6
--wld12.C0 = CFrame.fromEulerAnglesXYZ(1.57,0,0) * CFrame.new(0,0,0) 
wld12.C0 = CFrame.fromEulerAnglesXYZ(-1.57,0,0) * CFrame.new(0,0,0) 
wait()
Spider.w.Back = weld(Spider.Back,Torso,Spider.Back,0,0,0.5,0,0,0)
wait()
Torso.CFrame = Torso.CFrame + Vector3.new(0,10,0)
function Anim()
attack=true
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-(120*i)),math.rad(70-(70*i)),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100+(10*i)),math.rad(40+(50*i)),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-(120*i)),math.rad(-70+(70*i)),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+(10*i)),math.rad(-40-(50*i)),0)
end
bodypos=Instance.new("BodyPosition")
bodypos.P=500
bodypos.D=100
bodypos.maxForce=Vector3.new(0,math.huge,0)
bodypos.position=Head.Position+Vector3.new(0,50,0)
bodypos.Parent=Head
while roflcopter==true do
for i = 0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-(120)),math.rad(70-(70)),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100+(10)),math.rad(90+(360*i)),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-(120)),math.rad(-70+(70)),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+(10)),math.rad(-90+(360*i)),0)
end
end
bodypos.Parent=nil
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-(120-120*i)),math.rad(70-(70-70*i)),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100+(10-10*i)),math.rad(90-(50*i)),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-(120-120*i)),math.rad(-70+(70-70*i)),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+(10-10*i)),math.rad(-90+(50*i)),0)
end
attack=false
end
function RoflCopter()
act.Jumping=true
for i=0,1,0.1 do
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100+80*i),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80),math.rad(-40),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100-80*i),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100+80*i),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80),math.rad(40),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100-80*i),math.rad(0),0)
end
bodypos.P=500
bodypos.D=100
bodypos.maxForce=Vector3.new(0,math.huge,0)
bodypos.position=Head.Position+Vector3.new(0,10,0)
bodypos.Parent=Head
while roflcopter==true do
derpcon1=Spider.LRa2.Touched:connect(function(hit) Damagefunc1(hit,Prop.LegLength,5) end) 
derpcon2=Spider.LLa2.Touched:connect(function(hit) Damagefunc1(hit,Prop.LegLength,5) end) 
derpcon3=Spider.URa2.Touched:connect(function(hit) Damagefunc1(hit,Prop.LegLength,5) end) 
derpcon4=Spider.ULa2.Touched:connect(function(hit) Damagefunc1(hit,Prop.LegLength,5) end) 
for i=0,1,0.1 do
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80),math.rad(-40+360*i),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100+80),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80),math.rad(-40+360*i),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100-80),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80),math.rad(40+360*i),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100+80),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80),math.rad(40+360*i),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100-80),math.rad(0),0)
end
derpcon1:disconnect()
derpcon2:disconnect()
derpcon3:disconnect()
derpcon4:disconnect()
end
bodypos.Parent=nil
for i=0,1,0.1 do
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100+80-80*i),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80),math.rad(-40),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100-80+80*i),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100+80-80*i),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80),math.rad(40),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100-80+80*i),math.rad(0),0)
end
act.Jumping=false
end
function Shoot()
attack=true
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-50*i),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+20*i),math.rad(-40+40*i),0)
end
gairo.Parent = Head
gairo.maxTorque = Vector3.new(4e+005,4e+005,4e+005)*math.huge 
gairo.P = 20e+003 
gairo.cframe = Head.CFrame 
for i=0,1,0.1 do
wait()
Torso.Neck.C0=necko*CFrame.fromEulerAnglesXYZ(0,0,1.57*i)
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-50+20*i),math.rad(-70-20*i),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+20+80*i),math.rad(-40+40),0)
end
wait(0.1)
for i = 1,3 do
DerpMagic(prt7,Prop.LegWide*4,Prop.LegWide*4,Prop.LegWide*4,0,1,0,BrickColor.new("Black")) 
shoottrail2(prt7) 
wait(0.5)
end
for i=0,1,0.1 do
wait()
Torso.Neck.C0=necko*CFrame.fromEulerAnglesXYZ(0,0,1.57-1.57*i)
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-50+20+30*i),math.rad(-70-20+20*i),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+20+80-100*i),math.rad(-40+40-40*i),0)
end
gairo.Parent=nil
Torso.Neck.C0=necko
attack=false
end
function Shoot2()
attack=true
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-60*i),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+15*i),math.rad(-40-60*i),0)
end
for i=0,0.3,0.1 do
wait(0.1)
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-60),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+15+40*i),math.rad(-40-60),0)
DerpMagic(prt7,Prop.LegWide*4,Prop.LegWide*4,Prop.LegWide*4,0,1,0,BrickColor.new("Black")) 
shoottrail2(prt7) 
end
for i=0,1,0.1 do
wait() 
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-60+60*i),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+15+20-55*i),math.rad(-40-60+60*i),0)
end
attack=false
end
function Shoot3()
attack=true
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-50*i),math.rad(-70+70*i),math.rad(90*i))
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+60*i),math.rad(-40+40*i),math.rad(3*i))
end
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-50+60*i),math.rad(-70+70),math.rad(90))
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+60+40*i),math.rad(-40+40),math.rad(3))
DerpMagic(prt7,Prop.LegWide*4,Prop.LegWide*4,Prop.LegWide*4,0,1,0,BrickColor.new("Black")) 
shoottrail2(prt7) 
end
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120-50+60-10*i),math.rad(-70+70-70*i),math.rad(90-90*i))
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+60+40-100*i),math.rad(-40+40-40*i),math.rad(3-3*i))
end
attack=false
end
function Shoot4()
attack=true
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120+60*i),math.rad(-70+70*i),math.rad(0))
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+50*i),math.rad(-40+40*i),math.rad(0))
end
for i=0,1,0.1 do
wait()
DerpMagic(prt7,Prop.LegWide*4,Prop.LegWide*4,Prop.LegWide*4,0,1,0,BrickColor.new("Black")) 
shoottrail2(prt7) 
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120+60),math.rad(-70+70),math.rad(0))
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+50+50*i),math.rad(-40+40),math.rad(0))
end
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120),math.rad(70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120+60-60*i),math.rad(-70+70-70*i),math.rad(0))
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100+50+50-100*i),math.rad(-40+40-40*i),math.rad(0))
end
attack=false
end
function Attack()
attack=true
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-80*i),math.rad(70-70*i),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40-40*i),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
ss(1) 
con1=prt2.Touched:connect(function(hit) slashdamage1(hit,Prop.LegLength*3,20) end) 
con2=Spider.RAa2.Touched:connect(function(hit) slashdamage1(hit,Prop.LegLength*3,20) end) 
for i=0,1,0.2 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-80+90*i),math.rad(70-70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100+70*i),math.rad(40-40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
wait(0.1) 
con1:disconnect()
con2:disconnect()
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120+10-10*i),math.rad(70-70+70*i),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100+70-70*i),math.rad(40-40+40*i),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
attack=false
end
function MegaBonk()
attack=true
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-80*i),math.rad(70-70*i),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40-40*i),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
wait(0.1) 
for i=0,1,0.02 do
wait()
MMMAGIC(prt4,Prop.BallSize*2,Prop.BallSize*2,Prop.BallSize*2,0,Prop.LegLength/2,0,BrickColor.new("Really black")) 
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-80-30*i),math.rad(70-70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100-30*i),math.rad(40-40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
ss(1.3)
con1=prt2.Touched:connect(function(hit) Damagefunc2(hit,Prop.LegLength*10,100) end) 
con2=Spider.RAa2.Touched:connect(function(hit) Damagefunc2(hit,Prop.LegLength*10,100) end) 
for i=0,1,0.2 do
wait()
MMMAGIC(prt4,Prop.BallSize*2,Prop.BallSize*2,Prop.BallSize*2,0,Prop.LegLength/2,0,BrickColor.new("Really black")) 
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-80-30+110*i),math.rad(70-70),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100-30+120*i),math.rad(40-40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
MMMAGIC(prt4,Prop.BallSize*4,Prop.BallSize*4,Prop.BallSize*4,0,Prop.LegLength/2,0,BrickColor.new("Really black")) 
wait(0.5) 
con1:disconnect()
con2:disconnect()
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-110+110),math.rad(70-70+70*i),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100-30+120-100*i),math.rad(40-40+40*i),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
attack=false
end
function DualAttack()
attack=true
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-30*i),math.rad(70-90*i),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(40+40*i),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
ss(1)
con1=prt2.Touched:connect(function(hit) slashdamage1(hit,Prop.LegLength*3,20) end) 
con2=Spider.RAa2.Touched:connect(function(hit) slashdamage1(hit,Prop.LegLength*3,20) end) 
for i=0,1,0.2 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-30),math.rad(70-90+100*i),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100+50*i),math.rad(40+40),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
con1:disconnect()
con2:disconnect()
for i=0,1,0.1 do
wait()
Spider.w.RAb1.C1 = CFrame.Angles(math.rad(120-30+30*i),math.rad(70-90+100-10*i),0)
Spider.w.RAb2.C1 = CFrame.Angles(math.rad(-100+50-50*i),math.rad(40+40-40*i),0)
Spider.w.LAb1.C1 = CFrame.Angles(math.rad(120),math.rad(-70),0)
Spider.w.LAb2.C1 = CFrame.Angles(math.rad(-100),math.rad(-40),0)
end
attack=false
end
function Stomp()
attack=true
local vel2 = Instance.new("BodyVelocity")
vel2.Parent = Player.Character.Torso
vel2.maxForce = Vector3.new(4e+005,4e+005,4e+005)*1
vel2.velocity = Vector3.new(0,1,0) * 20 
wait(0.05)
vel2.Parent=nil
act.Jumping=true
Char.Humanoid.WalkSpeed=0
for i=0,1,0.1 do 
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80-50*i),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100+50*i),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80),math.rad(-40),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80-50*i),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100+50*i),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80),math.rad(40),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100),math.rad(0),0)
end
for i=0,1,0.1 do 
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80-50),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100+50),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80-50*i),math.rad(-40+40*i),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100-30*i),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80-50),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100+50),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80-50*i),math.rad(40-40*i),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100-30*i),math.rad(0),0)
end
ss(0.9)
con1=Spider.URa1.Touched:connect(function(hit) DBHit(hit,50,Prop.LegLength*2) end) 
con2=Spider.URa2.Touched:connect(function(hit) DBHit(hit,50,Prop.LegLength*2) end) 
for i=0,1,0.2 do 
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80-50+50*i),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100+50-50*i),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80-50+50*i),math.rad(-40+40),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100-30+30*i),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80-50+50*i),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100+50-50*i),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80-50+50*i),math.rad(40-40),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100-30+30*i),math.rad(0),0)
end
wait(0.1) 
con1:disconnect()
con2:disconnect()
for i=0,1,0.1 do 
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80-50+50),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100+50-50),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80-50+50),math.rad(-40+40-40*i),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100-30+30),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80-50+50),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100+50-50),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80-50+50),math.rad(40-40+40*i),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100-30+30),math.rad(0),0)
end
Char.Humanoid.WalkSpeed=walksped
act.Jumping=false
attack=false
end
function Jump()
attack=true
act.Jumping=true
for i=0,1,0.1 do 
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80+50*i),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100-50*i),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80-50*i),math.rad(-40),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100+50*i),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80+50*i),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100-50*i),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80-50*i),math.rad(40),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100+50*i),math.rad(0),0)
end
for i=0,1,0.2 do 
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80+50-100*i),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100-50+100*i),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80-50+100*i),math.rad(-40),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100+50-100*i),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80+50-100*i),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100-50+100*i),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80-50+100*i),math.rad(40),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100+50-100*i),math.rad(0),0)
end
local vel2 = Instance.new("BodyVelocity")
vel2.Parent = Player.Character.Torso
vel2.maxForce = Vector3.new(4e+005,4e+005,4e+005)*1
vel2.velocity = Vector3.new(0,1,0) * 100 
wait(0.1)
vel2.Parent=nil
for i=0,1,0.1 do 
wait()
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80+50-100+50*i),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100-50+100-50*i),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80-50+100-50*i),math.rad(-40),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100+50-100+50*i),math.rad(0),0)
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80+50-100+50*i),math.rad(40),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100-50+100-50*i),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80-50+100-50*i),math.rad(40),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100+50-100+50*i),math.rad(0),0)
end
act.Jumping=false
attack=false
end
function shoottrail2(pos1) 
coroutine.resume(coroutine.create(function()
spread2 = 0 
range2 = Prop.LegLength*150
rangepower = Prop.LegLength*1.5
local spreadvector = (Vector3.new(math.random(-spread2,spread2),math.random(-spread2,spread2),math.random(-spread2,spread2)) / 100) * (pos1.Position).magnitude/100
--local dir = Head.CFrame.lookVector+spreadvector 
local dir = prt12.CFrame.lookVector+spreadvector
local hit2,pos = rayCast(pos1.Position,dir,10,pack)
local rangepos = range2
local function drawtrail(From,To)
local effectsmsh = Instance.new("CylinderMesh")
effectsmsh.Scale = Vector3.new(1,1,1)
effectsmsh.Name = "Mesh"
local effectsg = Instance.new("Part")
effectsg.formFactor = 3
effectsg.CanCollide = false
effectsg.Name = "Eff"
effectsg.Locked = true
effectsg.Anchored = true
effectsg.Size = Vector3.new(Prop.LegLength/4,Prop.LegLength/5,Prop.LegLength/4)
effectsg.Parent = pack
effectsmsh.Parent = effectsg
effectsg.BrickColor = BrickColor.new("Really black") 
effectsg.Reflectance = 0.25
local LP = From
local point1 = To
local mg = (LP - point1).magnitude
effectsmsh.Scale = Vector3.new(1,mg*5,1)
effectsg.CFrame = CFrame.new((LP+point1)/2,point1) * CFrame.Angles(math.rad(90),0,0)
coroutine.resume(coroutine.create(function()
for i = 0 , 1 , 0.2 do
wait()
effectsg.Transparency = 1*i
effectsmsh.Scale = Vector3.new(1-1*i,mg*5,1-1*i)
end 
effectsg.Parent = nil 
end))
end
local newpos = pos1.Position
local inc = rangepower
repeat
wait() 
rangepos = rangepos - 10
dir = dir 
hit2,pos = rayCast(newpos,dir,inc,pack)
drawtrail(newpos,pos)
newpos = newpos + (dir * inc)
if alt==1 then 
inc = 10 
if inc >= 20 then
inc = inc - 10
end
end 
if hit2 ~= nil then
rangepos = 0
end
until rangepos <= 0
if hit2 ~= nil then
local effectsmsh = Instance.new("SpecialMesh")
effectsmsh.MeshId = "http://www.roblox.com/asset/?id=15887356"
--effectsmsh.Scale = Vector3.new(1,1,2.5)
effectsmsh.Scale = Vector3.new(3,3,3)
local effectsg = Instance.new("Part")
effectsg.formFactor = 3
effectsg.CanCollide = false
effectsg.Name = "Arrow"
effectsg.Locked = true
effectsg.Transparency = 1 
effectsg.Size = Vector3.new(0.2,0.2,0.2)
effectsg.Parent = pack 
effectsg.BrickColor = BrickColor.new("Really black") 
effectsmsh.Parent = effectsg
effectsg.CFrame = CFrame.new(newpos,pos) + CFrame.new(newpos,pos).lookVector*2.5*2
local efwel = Instance.new("Weld") 
efwel.Parent = effectsg 
efwel.Part0 = effectsg 
efwel.Part1 = hit2 
efwel.Parent = nil 
effectsg.Anchored = true 
local HitPos = effectsg.Position + CFrame.new(newpos,pos).lookVector*0.75
--local HitPos = prt1.Position + CFrame.new(newpos,pos).lookVector*0.75
--local HitPos = prt1.Position + (prt1.CFrame.lookVector * .5) 
local CJ = CFrame.new(HitPos) 
local C0 = effectsg.CFrame:inverse() * CJ
local C1 = hit2.CFrame:inverse() * CJ 
--efwel.C0 = C0
--efwel.C1 = C1
--efwel.Parent = effectsg 
Damg = Prop.LegLength*5
coroutine.resume(coroutine.create(function()
msound(1) 
coroutine.resume(coroutine.create(function()
local c = game.Workspace:GetChildren();
for i = 1, #c do
local hum = c:findFirstChild("Humanoid")
if hum ~= nil and hum.Health ~= 0 then
local head = c:findFirstChild("Head");
if head ~= nil then
local targ = head.Position - effectsg.Position;
local mag = targ.magnitude;
if mag <= Prop.LegLength*3 then 
wait() 
DBHit(head,effectsg,Prop.LegLength) 
end 
end 
end 
end
end)) 
EVENMOARMAGIX(effectsg,Prop.LegLength*3,Prop.LegLength*2,Prop.LegLength*3,0,0,0,0,0,0,BrickColor.new("Black")) 
for i = 0,5 do 
wait() 
MMMAGIC(effectsg,Prop.LegLength*3,Prop.LegLength*2,Prop.LegLength*3,0,0,0,BrickColor.new("Black")) 
end 
end))
coroutine.resume(coroutine.create(function()
wait(3)
effectsg.Parent = nil
end))
if hit2.Parent:FindFirstChild("Humanoid") ~= nil then
hum = hit2.Parent.Humanoid
attackdebounce = false 
Damagefunc1(hit2,Damg,50)
elseif hit2.Parent.Parent ~= nil and hit2.Parent.Parent:FindFirstChild("Humanoid") ~= nil then
hum = hit2.Parent.Parent.Humanoid
attackdebounce = false 
Damagefunc1(hit2,Damg,50)
end
end
end))
end
function rayCast(Pos, Dir, Max, Ignore) -- Origin Position , Direction, MaxDistance , Ignore Descendants
return game.Workspace:FindPartOnRay(Ray.new(Pos, Dir.unit * (Max or 999.999)), Ignore) 
end 
function MMMAGIC(part,x1,y1,z1,x2,y2,z2,color) 
local msh1 = Instance.new("BlockMesh") 
msh1.Scale = Vector3.new(0.5,0.5,0.5) 
S=Instance.new("Part")
S.Name="Effect"
S.formFactor=0
S.Size=Vector3.new(x1,y1,z1)
S.BrickColor=color
S.Reflectance = 0
S.TopSurface=0
S.BottomSurface=0
S.Transparency=0
S.Anchored=true
S.CanCollide=false
S.CFrame=part.CFrame*CFrame.new(x2,y2,z2)*CFrame.fromEulerAnglesXYZ(math.random(-50,50),math.random(-50,50),math.random(-50,50))
S.Parent=pack
msh1.Parent = S
coroutine.resume(coroutine.create(function(Part,CF) for i=1, 9 do Part.Mesh.Scale = Part.Mesh.Scale + Vector3.new(0.1,0.1,0.1) Part.CFrame=Part.CFrame*CFrame.fromEulerAnglesXYZ(math.random(-50,50),math.random(-50,50),math.random(-50,50)) Part.Transparency=i*.1 wait() end Part.Parent=nil end),S,S.CFrame)
end 
function UltimaMMMAGIC(part,x1,y1,z1,x2,y2,z2,color) 
local msh1 = Instance.new("BlockMesh") 
msh1.Scale = Vector3.new(x1,y1,z1) 
S=Instance.new("Part")
S.Name="Effect"
S.formFactor=0
S.Size=Vector3.new(1,1,1)
S.BrickColor=color
S.Reflectance = 0
S.TopSurface=0
S.BottomSurface=0
S.Transparency=0
S.Anchored=true
S.CanCollide=false
S.CFrame=part.CFrame*CFrame.new(x2,y2,z2)*CFrame.fromEulerAnglesXYZ(math.random(-50,50),math.random(-50,50),math.random(-50,50))
S.Parent=pack
msh1.Parent = S
coroutine.resume(coroutine.create(function(Part,CF) for i=1, 9 do Part.Mesh.Scale = Part.Mesh.Scale + Vector3.new(0.1,0.1,0.1) Part.CFrame=Part.CFrame*CFrame.fromEulerAnglesXYZ(math.random(-50,50),math.random(-50,50),math.random(-50,50)) Part.Transparency=i*.1 wait() end Part.Parent=nil end),S,S.CFrame)
end 
function MOREMAGIX(part,cframe,x,y,z,color) 
p2=Instance.new("Part")
p2.Name="Blast"
p2.TopSurface=0
p2.BottomSurface=0
p2.CanCollide=false
p2.Anchored=true
p2.BrickColor=color
p2.Size=Vector3.new(x,y,z)
p2.formFactor="Symmetric"
p2.CFrame=part.CFrame*CFrame.new(0,cframe,0)
p2.Parent=pack
m=Instance.new("BlockMesh")
m.Parent=p2
m.Name="BlastMesh"
coroutine.resume(coroutine.create(function(part,dir) for loll=1, 15 do part.BlastMesh.Scale=part.BlastMesh.Scale-Vector3.new(.09,.09,.09) part.Transparency=loll/20 part.CFrame=part.CFrame*CFrame.new(dir)*CFrame.fromEulerAnglesXYZ(math.random(-100,100)/100, math.random(-100,100)/100, math.random(-100,100)/100) wait() end part.Parent=nil end),p2,Vector3.new(math.random(-10,10)/10,math.random(-10,10)/10,math.random(-10,10)/10))
end 
function EVENMOARMAGIX(part,x1,y1,z1,x2,y2,z2,x3,y3,z3,color) 
local msh1 = Instance.new("SpecialMesh") 
msh1.Scale = Vector3.new(0.5,0.5,0.5) 
msh1.MeshType = "Sphere" 
S=Instance.new("Part")
S.Name="Effect"
S.formFactor=0
S.Size=Vector3.new(x1,y1,z1)
S.BrickColor=color
S.Reflectance = 0
S.TopSurface=0
S.BottomSurface=0
S.Transparency=0
S.Anchored=true
S.CanCollide=false
S.CFrame=part.CFrame*CFrame.new(x2,y2,z2)*CFrame.fromEulerAnglesXYZ(x3,y3,z3)
S.Parent=pack
msh1.Parent = S
coroutine.resume(coroutine.create(function(Part,CF) for i=1, 9 do Part.Mesh.Scale = Part.Mesh.Scale + Vector3.new(0.15,0.15,0.15) Part.Transparency=i*.1 wait() end Part.Parent=nil end),S,S.CFrame)
end 
function WaveEffect(part,x1,y1,z1,x2,y2,z2,x3,y3,z3,color) 
local msh1 = Instance.new("SpecialMesh") 
msh1.Scale = Vector3.new(x1,y1,z1) 
msh1.MeshId = "http://www.roblox.com/asset/?id=20329976" 
S=Instance.new("Part")
S.Name="Effect"
S.formFactor=0
S.Size=Vector3.new(1,1,1)
S.BrickColor=color
S.Reflectance = 0
S.TopSurface=0
S.BottomSurface=0
S.Transparency=0
S.Anchored=true
S.CanCollide=false
S.CFrame=part.CFrame*CFrame.new(x2,y2,z2)*CFrame.fromEulerAnglesXYZ(x3,y3,z3)
S.Parent=pack
msh1.Parent = S
coroutine.resume(coroutine.create(function(Part,CF) for i=1, 9 do Part.Mesh.Scale = Part.Mesh.Scale + Vector3.new(0.15,0.3,0.15) Part.Transparency=i*.1 wait() end Part.Parent=nil end),S,S.CFrame)
end 
function BlastEffect(part,x1,y1,z1,x2,y2,z2,x3,y3,z3,color) 
local msh1 = Instance.new("SpecialMesh") 
msh1.Scale = Vector3.new(x1,y1,z1) 
msh1.MeshId = "http://www.roblox.com/asset/?id=1323306" 
S=Instance.new("Part")
S.Name="Effect"
S.formFactor=0
S.Size=Vector3.new(1,1,1)
S.BrickColor=color
S.Reflectance = 0
S.TopSurface=0
S.BottomSurface=0
S.Transparency=0
S.Anchored=true
S.CanCollide=false
S.CFrame=part.CFrame*CFrame.new(x2,y2,z2)*CFrame.fromEulerAnglesXYZ(x3,y3,z3)
S.Parent=pack
msh1.Parent = S
coroutine.resume(coroutine.create(function(Part,CF) for i=1, 9 do Part.Mesh.Scale = Part.Mesh.Scale + Vector3.new(0.15,0.15,0.15) Part.Transparency=i*.1 wait() end Part.Parent=nil end),S,S.CFrame)
end 
function DerpMagic(part,x1,y1,z1,x2,y2,z2,color) 
local msh1 = Instance.new("BlockMesh") 
msh1.Scale = Vector3.new(0.5,0.5,0.5) 
S=Instance.new("Part")
S.Name="Effect"
S.formFactor=0
S.Size=Vector3.new(x1,y1,z1)
S.BrickColor=color
S.Reflectance = 0
S.TopSurface=0
S.BottomSurface=0
S.Transparency=0
S.Anchored=true
S.CanCollide=false
S.CFrame=part.CFrame*CFrame.new(x2,y2,z2)*CFrame.fromEulerAnglesXYZ(math.random(-50,50),math.random(-50,50),math.random(-50,50))
S.Parent=pack
msh1.Parent = S
coroutine.resume(coroutine.create(function(Part,CF) for i=1, 9 do Part.Mesh.Scale = Part.Mesh.Scale + Vector3.new(0.1,0.1,0.1) Part.Transparency=i*.1 wait() end Part.Parent=nil end),S,S.CFrame)
end 
function ss(pitch) 
local SlashSound = Instance.new("Sound") 
--SlashSound.SoundId = "rbxasset://sounds\\swordslash.wav" 
SlashSound.SoundId = "http://roblox.com/asset/?id=10209645" 
SlashSound.Parent = workspace 
SlashSound.Volume = .7 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function equipsound(pitch) 
local SlashSound = Instance.new("Sound") 
SlashSound.SoundId = "rbxasset://sounds\\unsheath.wav" 
SlashSound.Parent = workspace 
SlashSound.Volume = .5 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function magicsound(pitch) 
local SlashSound = Instance.new("Sound") 
SlashSound.SoundId = "http://www.roblox.com/asset/?id=2248511" 
SlashSound.Parent = workspace 
SlashSound.Volume = .5 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function critsound(pitch) 
local SlashSound = Instance.new("Sound") 
SlashSound.SoundId = "http://www.roblox.com/asset/?id=2801263" 
SlashSound.Parent = workspace 
SlashSound.Volume = .7 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function spikesound(pitch) 
local SlashSound = Instance.new("Sound") 
SlashSound.SoundId = "http://www.roblox.com/asset/?id=3264793" 
SlashSound.Parent = workspace 
SlashSound.Volume = .7 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function msound(pitch) 
local SlashSound = Instance.new("Sound") 
SlashSound.SoundId = "http://www.roblox.com/asset?id=2101148" 
SlashSound.Parent = workspace 
SlashSound.Volume = .7 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function lasersound(pitch) 
local SlashSound = Instance.new("Sound") 
SlashSound.SoundId = "rbxasset://sounds/Launching rocket.wav" 
SlashSound.Parent = workspace 
SlashSound.Volume = .5 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function omnomnom(pitch) 
local SlashSound = Instance.new("Sound") 
SlashSound.SoundId = "http://www.roblox.com/asset/?id=12544690" 
SlashSound.Parent = workspace 
SlashSound.Volume = .5 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function msound(pitch) 
local SlashSound = Instance.new("Sound") 
SlashSound.SoundId = "http://www.roblox.com/asset?id=2101148" 
SlashSound.Parent = workspace 
SlashSound.Volume = .7 
SlashSound.Pitch = pitch 
SlashSound.PlayOnRemove = true 
coroutine.resume(coroutine.create(function() 
wait(0) 
SlashSound.Parent = nil 
end)) 
end 
function MMMAGIC(part,x1,y1,z1,x2,y2,z2,color) 
local msh1 = Instance.new("BlockMesh") 
msh1.Scale = Vector3.new(0.5,0.5,0.5) 
S=Instance.new("Part")
S.Name="Effect"
S.formFactor=0
S.Size=Vector3.new(x1,y1,z1)
S.BrickColor=color
S.Reflectance = 0
S.TopSurface=0
S.BottomSurface=0
S.Transparency=0
S.Anchored=true
S.CanCollide=false
S.CFrame=part.CFrame*CFrame.new(x2,y2,z2)*CFrame.fromEulerAnglesXYZ(math.random(-50,50),math.random(-50,50),math.random(-50,50))
S.Parent=workspace
msh1.Parent = S
coroutine.resume(coroutine.create(function(Part,CF) for i=1, 9 do Part.Mesh.Scale = Part.Mesh.Scale + Vector3.new(0.1,0.1,0.1) Part.CFrame=Part.CFrame*CFrame.fromEulerAnglesXYZ(math.random(-50,50),math.random(-50,50),math.random(-50,50)) Part.Transparency=i*.1 wait() end Part.Parent=nil end),S,S.CFrame)
end 
attackdebounce = false
Damagefunc1=function(hit,Damage,Knockback)
if hit.Parent==nil then
return
end
CPlayer=Bin 
h=hit.Parent:FindFirstChild("Humanoid")
if h~=nil and hit.Parent.Name~=Char.Name and hit.Parent:FindFirstChild("Torso")~=nil then
if attackdebounce == false then 
critsound(2) 
attackdebounce = true 
coroutine.resume(coroutine.create(function() 
wait(0.1) 
attackdebounce = false 
end)) 
Damage=Damage
--[[ if game.Players:GetPlayerFromCharacter(hit.Parent)~=nil then
return
end]]
c=Instance.new("ObjectValue")
c.Name="creator"
c.Value=game.Players.LocalPlayer
c.Parent=h
game:GetService("Debris"):AddItem(c,.5)
-- print(c.Value)
if math.random(0,99)+math.random()<=5 then
CRIT=true
Damage=Damage*150
--[[ Knockback=Knockback*2
r=Instance.new("BodyAngularVelocity")
r.P=3000
r.maxTorque=Vector3.new(500000000,50000000000,500000000)*50000
r.angularvelocity=Vector3.new(math.random(-20,20),math.random(-20,20),math.random(-20,20))
r.Parent=hit.Parent.Torso]]
--critsound(2) 
end
Damage=Damage+math.random(50,100)
-- Blood(hit.CFrame*CFrame.new(math.random(-10,10)/10,math.random(-10,10)/10,0),math.floor(Damage/20))
h:TakeDamage(Damage)
showDamage(hit.Parent,Damage,50)
vp=Instance.new("BodyVelocity")
vp.P=500
vp.maxForce=Vector3.new(math.huge,0,math.huge)
-- vp.velocity=Character.Torso.CFrame.lookVector*Knockback
vp.velocity=Torso.CFrame.lookVector*Knockback+Torso.Velocity/1.05
if Knockback>0 then
vp.Parent=hit.Parent.Torso
end
game:GetService("Debris"):AddItem(vp,.25)
--[[ r=Instance.new("BodyAngularVelocity")
r.P=3000
r.maxTorque=Vector3.new(500000000,50000000000,500000000)*50000
r.angularvelocity=Vector3.new(math.random(-20,20),math.random(-20,20),math.random(-20,20))
r.Parent=hit.Parent.Torso]]
game:GetService("Debris"):AddItem(r,.5)
c=Instance.new("ObjectValue")
c.Name="creator"
c.Value=Player
c.Parent=h
game:GetService("Debris"):AddItem(c,.5)
CRIT=false
hitDeb=true
AttackPos=6
end
end 
end
Damagefunc2=function(hit,Damage,Knockback)
if hit.Parent==nil then
return
end
CPlayer=Bin 
h=hit.Parent:FindFirstChild("Humanoid")
if h~=nil and hit.Parent.Name~=Char.Name and hit.Parent:FindFirstChild("Torso")~=nil then
if attackdebounce == false then 
critsound(1) 
attackdebounce = true 
coroutine.resume(coroutine.create(function() 
wait(0.1) 
attackdebounce = false 
end)) 
Damage=Damage
--[[ if game.Players:GetPlayerFromCharacter(hit.Parent)~=nil then
return
end]]
c=Instance.new("ObjectValue")
c.Name="creator"
c.Value=game.Players.LocalPlayer
c.Parent=h
game:GetService("Debris"):AddItem(c,.5)
-- print(c.Value)
if math.random(0,99)+math.random()<=5 then
CRIT=true
Damage=Damage*100
--[[ Knockback=Knockback*2
r=Instance.new("BodyAngularVelocity")
r.P=3000
r.maxTorque=Vector3.new(500000000,50000000000,500000000)*50000
r.angularvelocity=Vector3.new(math.random(-20,20),math.random(-20,20),math.random(-20,20))
r.Parent=hit.Parent.Torso]]
--critsound(2) 
end
Damage=Damage+math.random(50,100)
-- Blood(hit.CFrame*CFrame.new(math.random(-10,10)/10,math.random(-10,10)/10,0),math.floor(Damage/20))
h:TakeDamage(Damage)
showDamage(hit.Parent,Damage,50)
vp=Instance.new("BodyVelocity")
vp.P=500
vp.maxForce=Vector3.new(math.huge,0,math.huge)
-- vp.velocity=Character.Torso.CFrame.lookVector*Knockback
vp.velocity=Torso.CFrame.lookVector*Knockback+Torso.Velocity/1.05
rl=Instance.new("BodyAngularVelocity")
rl.P=3000
rl.maxTorque=Vector3.new(5000,5000,5000)*500000000
rl.angularvelocity=Vector3.new(math.random(-10,10),math.random(-10,10),math.random(-10,10))
rl.Parent=t
game:GetService("Debris"):AddItem(rl,.2)
vl=Instance.new("BodyVelocity")
vl.P=4500
vl.maxForce=Vector3.new(math.huge,math.huge,math.huge)
vl.velocity=Vector3.new(Torso.Velocity.x,0,Torso.Velocity.z)*1.05+Vector3.new(0,10,0)
vl.Parent=t
game:GetService("Debris"):AddItem(vl,.2)
if Knockback>0 then
vp.Parent=hit.Parent.Torso
end
game:GetService("Debris"):AddItem(vp,.25)
--[[ r=Instance.new("BodyAngularVelocity")
r.P=3000
r.maxTorque=Vector3.new(500000000,50000000000,500000000)*50000
r.angularvelocity=Vector3.new(math.random(-20,20),math.random(-20,20),math.random(-20,20))
r.Parent=hit.Parent.Torso]]
game:GetService("Debris"):AddItem(r,.5)
c=Instance.new("ObjectValue")
c.Name="creator"
c.Value=Player
c.Parent=h
game:GetService("Debris"):AddItem(c,.5)
CRIT=false
hitDeb=true
AttackPos=6
end
end 
end
slashdamage1=function(hit,Damage,Knockback)
if hit.Parent==nil then
return
end
CPlayer=Bin 
h=hit.Parent:FindFirstChild("Humanoid")
if h~=nil and hit.Parent.Name~=Char.Name and hit.Parent:FindFirstChild("Torso")~=nil then
if attackdebounce == false then 
attackdebounce = true 
coroutine.resume(coroutine.create(function() 
wait(0.1) 
attackdebounce = false 
end)) 
Damage=Damage
--[[ if game.Players:GetPlayerFromCharacter(hit.Parent)~=nil then
return
end]]
c=Instance.new("ObjectValue")
c.Name="creator"
c.Value=game.Players.LocalPlayer
c.Parent=h
game:GetService("Debris"):AddItem(c,.5)
-- print(c.Value)
if math.random(0,99)+math.random()<=5 then
Damage=Damage*50
--[[ Knockback=Knockback*2
r=Instance.new("BodyAngularVelocity")
r.P=3000
r.maxTorque=Vector3.new(500000000,50000000000,500000000)*50000
r.angularvelocity=Vector3.new(math.random(-20,20),math.random(-20,20),math.random(-20,20))
r.Parent=hit.Parent.Torso]]
--critsound(2) 
end
Damage=Damage+math.random(65,90)
-- Blood(hit.CFrame*CFrame.new(math.random(-10,10)/10,math.random(-10,10)/10,0),math.floor(Damage/20))
h:TakeDamage(Damage)
showDamage(hit.Parent,Damage,50)
vp=Instance.new("BodyVelocity")
vp.P=500
vp.maxForce=Vector3.new(math.huge,0,math.huge)
-- vp.velocity=Character.Torso.CFrame.lookVector*Knockback
vp.velocity=Torso.CFrame.lookVector*Knockback+Torso.Velocity/1.05
if Knockback>0 then
vp.Parent=hit.Parent.Torso
end
game:GetService("Debris"):AddItem(vp,.25)
--[[ r=Instance.new("BodyAngularVelocity")
r.P=3000
r.maxTorque=Vector3.new(500000000,50000000000,500000000)*50000
r.angularvelocity=Vector3.new(math.random(-20,20),math.random(-20,20),math.random(-20,20))
r.Parent=hit.Parent.Torso]]
game:GetService("Debris"):AddItem(r,.5)
c=Instance.new("ObjectValue")
c.Name="creator"
c.Value=Player
c.Parent=h
game:GetService("Debris"):AddItem(c,.5)
CRIT=false
hitDeb=true
AttackPos=6
end
end 
end
DBHit=function(hit,DB,Dmg) --credits to turdulator for making this function 
if hit.Parent==nil then
return
end
h=hit.Parent:FindFirstChild("Humanoid")
if h==nil then
h=hit.Parent.Parent:FindFirstChild("Humanoid")
end
t=hit.Parent:FindFirstChild("Torso")
if h~=nil and t~=nil then
--[[ if h.Parent==Character then
return
end]]
critsound(1.5) 
Damage=Dmg+math.random(20,100)
h:TakeDamage(Damage) 
c=Instance.new("ObjectValue")
c.Name="creator"
c.Value=game.Players.LocalPlayer
c.Parent=h
game:GetService("Debris"):AddItem(c,.5)
showDamage(hit.Parent,Damage,59) 
vl=Instance.new("BodyVelocity")
vl.P=4500
vl.maxForce=Vector3.new(math.huge,math.huge,math.huge)
vl.velocity=Vector3.new(Torso.Velocity.x,0,Torso.Velocity.z)*1.05+Vector3.new(0,10,0)
vl.Parent=t
game:GetService("Debris"):AddItem(vl,.2)
rl=Instance.new("BodyAngularVelocity")
rl.P=3000
rl.maxTorque=Vector3.new(5000,5000,5000)*500000000
rl.angularvelocity=Vector3.new(math.random(-10,10),math.random(-10,10),math.random(-10,10))
rl.Parent=t
game:GetService("Debris"):AddItem(rl,.2)
else
if hit.CanCollide==false then
return
end
MagicCom:disconnect()
-- DBExplode(DB)
CRIT=false
end
end
showDamage=function(Char,Dealt,du)
m=Instance.new("Model")
m.Name=tostring(Dealt)
h=Instance.new("Humanoid")
h.Health=math.huge
h.MaxHealth=math.huge
h.Parent=m
c=Instance.new("Part")
c.Transparency=0
c.BrickColor=BrickColor:Red()
c.Name="Head"
c.TopSurface=0
c.BottomSurface=0
c.formFactor="Plate"
c.Size=Vector3.new(1,.4,1)
ms=Instance.new("CylinderMesh")
ms.Bevel=.1
ms.Scale=Vector3.new(.8,.8,.8)
ms.Parent=c
c.Reflectance=0
Instance.new("BodyGyro").Parent=c
c.Parent=m
c.CFrame=CFrame.new(Char["Head"].CFrame.p+Vector3.new(0,1.5,0))
f=Instance.new("BodyPosition")
f.P=2000
f.D=100
f.maxForce=Vector3.new(math.huge,math.huge,math.huge)
f.position=c.Position+Vector3.new(0,3,0)
f.Parent=c
game:GetService("Debris"):AddItem(m,.5+du)
c.CanCollide=false
m.Parent=workspace
c.CanCollide=false
end
Anims.Walking = function()
derpcon1=Spider.LRa2.Touched:connect(function(hit) Damagefunc1(hit,Prop.LegLength,5) end) 
derpcon2=Spider.LLa2.Touched:connect(function(hit) Damagefunc1(hit,Prop.LegLength,5) end) 
derpcon3=Spider.URa2.Touched:connect(function(hit) Damagefunc1(hit,Prop.LegLength,5) end) 
derpcon4=Spider.ULa2.Touched:connect(function(hit) Damagefunc1(hit,Prop.LegLength,5) end) 
for i=0,1,difficulty do 
if act.Jumping ~= true then 
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80+(20*i)),math.rad(-40-(40*i)),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100-(20*i)),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80-(20*i)),math.rad(-40-(40*i)),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100+(20*i)),math.rad(0),0)
wait()
end 
end
coroutine.resume(coroutine.create(function()
for i=0,1,difficulty do 
if act.Jumping ~= true then 
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80+(20*i)),math.rad(40+(40*i)),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100-(20*i)),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80-(20*i)),math.rad(40+(40*i)),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100+(20*i)),math.rad(0),0)
wait()
end
end 
for i=1,0,-difficulty do 
if act.Jumping ~= true then 
Spider.w.LLb1.C1 = CFrame.Angles(math.rad(-80+(20*i)),math.rad(40+(40*i)),0)
Spider.w.LLb2.C1 = CFrame.Angles(math.rad(-100-(20*i)),math.rad(0),0)
Spider.w.URb1.C1 = CFrame.Angles(math.rad(80-(20*i)),math.rad(40+(40*i)),0)
Spider.w.URb2.C1 = CFrame.Angles(math.rad(100+(20*i)),math.rad(0),0)
wait()
end 
end 
end))
for i=1,0,-difficulty do 
if act.Jumping ~= true then 
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80+(20*i)),math.rad(-40-(40*i)),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100-(20*i)),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80-(20*i)),math.rad(-40-(40*i)),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100+(20*i)),math.rad(0),0)
wait()
end
end 
derpcon1:disconnect()
derpcon2:disconnect()
derpcon3:disconnect()
derpcon4:disconnect()
if act.Jumping ~= true then 
Spider.w.LRb1.C1 = CFrame.Angles(math.rad(-80),math.rad(-40),0)
Spider.w.LRb2.C1 = CFrame.Angles(math.rad(-100),math.rad(0),0)
Spider.w.ULb1.C1 = CFrame.Angles(math.rad(80),math.rad(-40),0)
Spider.w.ULb2.C1 = CFrame.Angles(math.rad(100),math.rad(0),0)
end
end 
--[[while true do 
wait()
if act.Walking == true then return end
if Torso.Velocity.magnitude >= 19 then 
act.Walking = true
Anims.Walking()
act.Walking = false 
end 
end ]]
t = it("HopperBin", Player.Backpack)
t.Name = "Spiderbot"
script.Parent = t
t.Selected:connect(function(mouse) t:Remove()
Mouse = mouse
mouse.KeyDown:connect(function(k) act.keydown = true 
pcall(function() act.key[k:lower()] = true end)
local kk = k:lower()
if kk == "w" or kk == "a" or kk == "s" or kk == "d" then
if act.Walking == true then return end
while act.key["w"] == true or act.key["a"] == true or act.key["s"] == true or act.key["d"] == true do
act.Walking = true
Anims.Walking()
wait()
end
act.Walking = false 
end
if kk == "q" then 
if roflcopter==false then
roflcopter=true
RoflCopter()
elseif roflcopter==true then
roflcopter=false
end
--[[if roflcopter==false then
roflcopter=true
Anim()
elseif roflcopter==true then
roflcopter=false
end]]
end
if kk == "e" then 
bodypos.position=bodypos.position+Vector3.new(0,10,0)
end
if kk == "r" then 
bodypos.position=bodypos.position-Vector3.new(0,10,0)
end 
if attack == true then return end
if kk == "f" then 
Shoot()
end 
if kk == "g" then 
Shoot2()
end
if kk == "h" then
Shoot3()
end
if kk == "j" then
Shoot4()
end
if kk == "z" then 
Attack()
end
if kk == "x" then
DualAttack()
end
if kk == "c" then 
MegaBonk()
end 
if kk == "v" then
Stomp()
end
if kk == " " then
Jump()
end
end)
mouse.KeyUp:connect(function(k) act.keydown = false 
pcall(function() act.key[k:lower()] = false end)
end) 
end)
wait(0.1)