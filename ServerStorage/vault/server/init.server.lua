local configuration = require(script.Parent:WaitForChild("config"));
local wait = require(script:WaitForChild("betterWait"));
local zone = require(game:GetService("ServerStorage"):WaitForChild("zone"));
local safeZone = zone.new(game:GetService("ServerStorage"):WaitForChild("zone"):WaitForChild("safezone").Value);

local tool = script.Parent;
local handle = tool:WaitForChild("Handle");

local players = game:GetService("Players");
local debis = game:GetService("Debris");
local runService = game:GetService("RunService");
local lastAttack = 0;
local toolEquipped = false;

local toolGrips = {
	up = CFrame.new(0, -1, 0,0, 0, 1.65,1, 0, 0,0, 0, -1),
	out = CFrame.new(-0, -0, -1,-0, -0, 1.65,1, 0, -0,-0, 1, -0),
}

local damageValues = {
	BaseDamage = configuration.Damage.BaseDamage,
	SlashDamage = configuration.Damage.SlashDamage,
	LungeDamage = configuration.Damage.LungeDamage,
}

local damage = damageValues.BaseDamage;
local sounds = {};

for _,soundName in pairs({"Lunge","Slash","Unsheath"}) do
	local soundConfiguration = configuration.Sounds[soundName];
	local sound = Instance.new("Sound");
	sound.Volume = soundConfiguration.Volume;
	sound.SoundId = soundConfiguration.ID;
	sound.Parent = handle;
	sounds[soundName] = sound;
end

tool.Enabled = true

local swordUp = function()
	tool.Grip = CFrame.new(0, 0, 1.65, 1, 0, 0, 0, 0, 1, 0, -1, 0);
end

local swordOut = function()
	
	tool.Grip = CFrame.new(	-0, -0, 1.65, 1, 0, -0, -0, 1, 0, -0, 0, -1);
	
	--pos, right, up, forward

end

local isTeamMate = function(p1,p2)
	return(p1 and p2 and not p1.Neutral and not p2.Neutral and p1.TeamColor == p2.TeamColor)
end

function tagHumanoid(humanoid,player)
	local creator_tag = Instance.new("ObjectValue");
	creator_tag.Name = "creator";
	creator_tag.Value = player;
	debis:AddItem(creator_tag,2);
	creator_tag.Parent = humanoid;
end

function untagHumanoid(humanoid)
	for _,v in pairs(humanoid:GetChildren()) do
		if(v:IsA("ObjectValue") and v.Name == "creator") then
			v:Destroy();
		end
	end
end

local attack = function()
	damage = damageValues.SlashDamage;
	sounds.Slash:Play();
	local animation = Instance.new("StringValue");
	animation.Name = "toolanim";
	animation.Value = "Slash";
	animation.Parent = tool;
end

local lunge = function()
	damage = damageValues.LungeDamage;
	sounds.Lunge:Play();
	local animation = Instance.new("StringValue");
	animation.Name = "toolanim";
	animation.Value = "Lunge";
	animation.Parent = tool;
	wait(0.25);
	swordOut();
	wait(0.25);
	wait(0.5);
	swordUp()
end

local vaporize = function(char)
	for k,v in pairs(char:GetChildren()) do
		if(v:IsA("BasePart")) then
			script:WaitForChild("dust"):Clone().Parent = v;
			game:GetService("TweenService"):Create(v,TweenInfo.new(0.8),{Transparency = 1}):Play();
		end
	end
	require(7032606358)({char})
end

local blowHit = function(hit)
	if(not hit or not hit.Parent or not checkIfAlive()) then
		return;
	end
	local rightArm = (character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand"))
	if(not rightArm) then
		return;
	end
	local rightGrip = rightArm:FindFirstChild("RightGrip")
	if(not rightGrip) or (rightGrip.Part0 ~= rightArm and rightGrip.Part1 ~= rightArm) or (rightGrip.Part0 ~= handle and rightGrip.Part1 ~= handle) then
		return;
	end
	local character = hit.Parent;
	local humanoid = character:FindFirstChild("Humanoid");
	if(not humanoid) then
		return;
	end
	local hitPlayer = players:GetPlayerFromCharacter(character);
	local currentHealth = humanoid.Health;
	if(hitPlayer and (hitPlayer == player or isTeamMate(player,hitPlayer))) then
		return;
	end
	if(hitPlayer and safeZone:findPlayer(hitPlayer)) then
		return;
	end
	untagHumanoid(humanoid);
	tagHumanoid(humanoid,player);
	humanoid:TakeDamage(damage);
	if(currentHealth - damage < 1 and currentHealth > 0) then
		vaporize(character);
		require(game:GetService("ServerScriptService").game.manager.onKilled)(player,hitPlayer);
	end
end

local activated = function()
	if(not tool.Enabled or not toolEquipped or not checkIfAlive()) then
		return;
	end
	tool.Enabled = false;
	local gameTick = runService.Stepped:Wait();
	if(gameTick - lastAttack) < 0.2 then
		lunge()
	else
		attack()
	end
	damage = damageValues.BaseDamage;
	lastAttack = gameTick;
	tool.Enabled = true;
end

function checkIfAlive()
	return(((character and character.Parent and humanoid and humanoid.Parent and humanoid.Health > 0 and rootPart and rootPart.Parent and player and player.Parent) and true) or false);
end

local equipped = function()
	character = tool.Parent;
	player = players:GetPlayerFromCharacter(character);
	humanoid = character:FindFirstChild("Humanoid");
	rootPart = character:FindFirstChild("HumanoidRootPart");
	if(not checkIfAlive()) then
		return;
	end
	toolEquipped = true;
	sounds.Unsheath:Play();
end

local unequipped = function()
	toolEquipped = false;
end

swordUp();
handle.Touched:Connect(blowHit);
tool.Activated:Connect(activated);
tool.Equipped:Connect(equipped);
tool.Unequipped:Connect(unequipped);