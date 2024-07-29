    wait();
    local using = false
    local user=game:service'Players'.LocalPlayer;
    local char=user.Character;
    local hum=char.Humanoid;
    local head=char.Head;
    local part
    for i,v in ipairs{user.Backpack,char}do
            for i,v in ipairs(v:children())do
                    if(v.Name=='ala_ball')then
                            v:Destroy();
                    end;
            end;
    end;
     

           
    local function raycasting(pos,dir)
            local ray=Ray.new(pos,dir);
            return workspace:FindPartOnRay(ray,char,false)or workspace:FindPartOnRay(ray,char,true);
    end;

    local function HSV(H,S,V) 
        H = H % 360 
        local C = V * S 
        local H2 = H/60 
        local X = C * (1 - math.abs((H2 %2) -1)) 
        local color = Color3.new(0,0,0) 
        if H2 <= 0 then 
        color = Color3.new(C,0,0) 
        elseif 0 <= H2 and H2 <= 1 then 
        color = Color3.new(C,X,0) 
        elseif 1 <= H2 and H2 <= 2 then 
        color = Color3.new(X,C,0) 
        elseif 2 <= H2 and H2 <= 3 then 
        color = Color3.new(0,C,X) 
        elseif 3 <= H2 and H2 <= 4 then 
        color = Color3.new(0,X,C) 
        elseif 4 <= H2 and H2 <= 5 then 
        color = Color3.new(X,0,C) 
        elseif 5 <= H2 and H2 <= 6 then 
        color = Color3.new(C,0,X) 
        end 
        local m = V - C
        return Color3.new(color.r + m, color.g + m, color.b + m) 
    end
     

	local function MLGDisable()
			 hum.PlatformStand=false;
            for i,v in ipairs(char:children())do
                    if(v.Name=='ala_ball')then
                            v:Destroy();
                    end;
            end;
            for i,v in ipairs(char:children()) do
                    if v:IsA'Part' then
                        v.Transparency=0;
                    end
            end
           	hum.MaxHealth = 100
            char:findFirstChild'HumanoidRootPart'.Transparency=1
			part.Transparency = 1
            game:service'SoundService'.DistanceFactor = 10
       	 	game:service'SoundService'.DopplerScale=1
			using = false
	end

	game.Players.LocalPlayer:GetMouse().KeyDown:connect(function(key)
		if key == "y" then
			MLGDisable()
		end
		if key == "t" then
			if using == true then
				MLGDisable()
			end
			wait(0.15)
			if using == false then
				using = true
        	local hue = 0
        	local colur = 0
            local keys={};
           
            game.Players.LocalPlayer:GetMouse().KeyDown:connect(function(key)
                    keys[key]=true;
            end);
           
            game.Players.LocalPlayer:GetMouse().KeyUp:connect(function(key)
                    keys[key]=false;
            end);

            game:service'SoundService'.DistanceFactor = 50
            game:service'SoundService'.DopplerScale=0
           
            local speed=7;
            local max_speed=150;

            hum.MaxHealth = math.huge
           
            	 part=Instance.new'Part';
                    part.Shape=0;
                    part.Friction=10;
                    part.Elasticity=1;
                    part.TopSurface=0;
                    part.FormFactor=0;
                    part.Anchored=true;
                    part.BottomSurface=0;
                    part.Name='ala_ball';
                    part.CanCollide=false;
                    part.Transparency=1;
                    part.CFrame=head.CFrame;
                    part.Size=Vector3.new(10,10,10);
                    part.Parent=char;
            local weld=Instance.new('Weld',part);
                    weld.Part0=part;
                    weld.Part1=head;
                    part.Anchored=false;
                    part.CanCollide=true;
                    hum.PlatformStand=true;
            local sound=Instance.new('Sound',head);
                    sound.SoundId='rbxassetid://204035618';
                    sound.Volume=1;
                    sound.Looped=true;
                    sound:play();
                    for i,v in ipairs(char:children()) do
                        if v:IsA'Part' then
                            v.Transparency=1;
                        end
                    end
                    local PointLight = Instance.new('PointLight',head)
                    PointLight.Range = 20
                    local bbg = Instance.new('BillboardGui',head)
                    bbg.Adornee=head
                    bbg.Size=UDim2.new(8,0,8,0)
					bbg.AlwaysOnTop = true
                    local img = Instance.new('ImageLabel',bbg)
                    img.BackgroundTransparency=1
                    img.Size=UDim2.new(1,0,1,0)

            coroutine.wrap(function()
                while (part.Parent) do
                    pcall(function()
                        img.Image='rbxassetid://152333727'
                    end)
                    wait(0.1)
                    pcall(function()
                        img.Image='rbxassetid://152333747'
                    end)
					wait(0.1)
                    pcall(function()
                        img.Image='rbxassetid://152333792'
                    end)
					wait(0.1)
                    pcall(function()
                        img.Image='rbxassetid://152333817'
                    end)
					wait(0.1)
                    pcall(function()
                        img.Image='rbxassetid://152333831'
                    end)
					wait(0.1)
                    pcall(function()
                        img.Image='rbxassetid://152333855'
                    end)
					wait(0.1)
                    pcall(function()
                        img.Image='rbxassetid://152333875'
                    end)
					wait(0.1)
                    pcall(function()
                        img.Image='rbxassetid://152333892'
                    end)
                end
            end)()
            while(part.Parent)do
                    if(keys[' ']and raycasting(part.Position,Vector3.new(0,-10,0)))then
                            part.Velocity=part.Velocity+Vector3.new(0,30,0);
                    end;
                   
                    if(keys.w or keys.a or keys.s or keys.d)then
                            local r=-math.pi/2;
                           
                            if(keys.s)then
                                    r=r-math.pi;
                            end;
                           
                            if(keys.a)then
                                    if(keys.w)then
                                            r=r-math.pi/4;
                                    elseif(keys.s)then
                                            r=r+math.pi/4;
                                    else
                                            r=r-math.pi/2;
                                    end;
                            end;
                           
                            if(keys.d)then
                                    if(keys.w)then
                                            r=r+math.pi/4;
                                    elseif(keys.s)then
                                            r=r-math.pi/4;
                                    else
                                            r=r+math.pi/2;
                                    end;
                            end;
                   
                            local cam=workspace.CurrentCamera;
                            local crd=cam.CoordinateFrame;
                            local dir=(crd.lookVector*Vector3.new(1,0,1)).unit;
                                    local x=dir.x;
                                    local z=dir.z;
                            local dir=Vector3.new(
                                    math.cos(r)*x-math.sin(r)*z,
                                    0,
                                    math.sin(r)*x+math.cos(r)*z
                            );
                            part.RotVelocity=dir*speed;
                            speed=math.min(max_speed,speed+2/speed);
                    else
                            speed=math.min(math.abs(part.Velocity.magnitude/5),max_speed);
                    end;
                    wait();
                    hue = ((hue+25)%360)
                    colur = HSV(hue,1,1)
                    PointLight.Color = Color3.new(colur.r,colur.g,colur.b)
            end;
            pcall(function()
                bbg:Destroy()
            end)
            pcall(function()
                sound:Destroy()
            end)
            pcall(function()
                PointLight:Destroy()
            end)
			end
		end
		if key == "r" then
			if using == true then
				MLGDisable()
			end
			wait(0.15)
			if using == false then
				using = true
        	local hue = 0
        	local colur = 0
            local keys={};
           
            game.Players.LocalPlayer:GetMouse().KeyDown:connect(function(key)
                    keys[key]=true;
            end);
           
            game.Players.LocalPlayer:GetMouse().KeyUp:connect(function(key)
                    keys[key]=false;
            end);

            game:service'SoundService'.DistanceFactor = 50
            game:service'SoundService'.DopplerScale=0
           
            local speed=7;
            local max_speed=150;

            hum.MaxHealth = math.huge
           
            	 part=Instance.new'Part';
                    part.Shape=0;
                    part.Friction=10;
                    part.Elasticity=1;
                    part.TopSurface=0;
                    part.FormFactor=0;
                    part.Anchored=true;
                    part.BottomSurface=0;
                    part.Name='ala_ball';
                    part.CanCollide=false;
                    part.Transparency=1;
                    part.CFrame=head.CFrame;
                    part.Size=Vector3.new(10,10,10);
                    part.Parent=char;
            local weld=Instance.new('Weld',part);
                    weld.Part0=part;
                    weld.Part1=head;
                    part.Anchored=false;
                    part.CanCollide=true;
                    hum.PlatformStand=true;
            local sound=Instance.new('Sound',head);
                    sound.SoundId='rbxassetid://177276825';
                    sound.Volume=1;
                    sound.Looped=true;
                    sound:play();
                    for i,v in ipairs(char:children()) do
                        if v:IsA'Part' then
                            v.Transparency=1;
                        end
                    end
                    local PointLight = Instance.new('PointLight',head)
                    PointLight.Range = 20
                    local bbg = Instance.new('BillboardGui',head)
                    bbg.Adornee=head
                    bbg.Size=UDim2.new(8,0,8,0)
					bbg.AlwaysOnTop = true
                    local img = Instance.new('ImageLabel',bbg)
                    img.BackgroundTransparency=1
                    img.Size=UDim2.new(1,0,1,0)
                    img.Image='rbxassetid://185945467'
            coroutine.wrap(function()
                while (part.Parent) do
                   pcall(function()
                        img.Image='rbxassetid://183747849'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://183747854'
                    end)
					wait()
                    pcall(function()
                        img.Image='rbxassetid://183747863'
                    end)
					wait()
                    pcall(function()
                        img.Image='rbxassetid://183747870'
                    end)
					wait()
                    pcall(function()
                        img.Image='rbxassetid://183747877'
                    end)
					wait()
                    pcall(function()
                        img.Image='rbxassetid://183747879'
                    end)
					wait()
                    pcall(function()
                        img.Image='rbxassetid://183747885'
                    end)
					wait()
                    pcall(function()
                        img.Image='rbxassetid://183747890'
                    end)
                end
            end)()
            while(part.Parent)do
                    if(keys[' ']and raycasting(part.Position,Vector3.new(0,-10,0)))then
                            part.Velocity=part.Velocity+Vector3.new(0,30,0);
                    end;
                   
                    if(keys.w or keys.a or keys.s or keys.d)then
                            local r=-math.pi/2;
                           
                            if(keys.s)then
                                    r=r-math.pi;
                            end;
                           
                            if(keys.a)then
                                    if(keys.w)then
                                            r=r-math.pi/4;
                                    elseif(keys.s)then
                                            r=r+math.pi/4;
                                    else
                                            r=r-math.pi/2;
                                    end;
                            end;
                           
                            if(keys.d)then
                                    if(keys.w)then
                                            r=r+math.pi/4;
                                    elseif(keys.s)then
                                            r=r-math.pi/4;
                                    else
                                            r=r+math.pi/2;
                                    end;
                            end;
                   
                            local cam=workspace.CurrentCamera;
                            local crd=cam.CoordinateFrame;
                            local dir=(crd.lookVector*Vector3.new(1,0,1)).unit;
                                    local x=dir.x;
                                    local z=dir.z;
                            local dir=Vector3.new(
                                    math.cos(r)*x-math.sin(r)*z,
                                    0,
                                    math.sin(r)*x+math.cos(r)*z
                            );
                            part.RotVelocity=dir*speed;
                            speed=math.min(max_speed,speed+2/speed);
                    else
                            speed=math.min(math.abs(part.Velocity.magnitude/5),max_speed);
                    end;
                    wait();
                    hue = ((hue+25)%360)
                    colur = HSV(hue,1,1)
                    PointLight.Color = Color3.new(colur.r,colur.g,colur.b)
            end;
            pcall(function()
                bbg:Destroy()
            end)
            pcall(function()
                sound:Destroy()
            end)
            pcall(function()
                PointLight:Destroy()
            end)
			end
		end
		if key == "e" then
			if using == true then
				MLGDisable()
			end
			wait(0.15)
			if using == false then
				using = true
        	local hue = 0
        	local colur = 0
            local keys={};
           
            game.Players.LocalPlayer:GetMouse().KeyDown:connect(function(key)
                    keys[key]=true;
            end);
           
            game.Players.LocalPlayer:GetMouse().KeyUp:connect(function(key)
                    keys[key]=false;
            end);

            game:service'SoundService'.DistanceFactor = 50
            game:service'SoundService'.DopplerScale=0
           
            local speed=7;
            local max_speed=150;

            hum.MaxHealth = math.huge
           
            local part=Instance.new'Part';
                    part.Shape=0;
                    part.Friction=10;
                    part.Elasticity=1;
                    part.TopSurface=0;
                    part.FormFactor=0;
                    part.Anchored=true;
                    part.BottomSurface=0;
                    part.Name='ala_ball';
                    part.CanCollide=false;
                    part.Transparency=1;
                    part.CFrame=head.CFrame;
                    part.Size=Vector3.new(10,10,10);
                    part.Parent=char;
            local weld=Instance.new('Weld',part);
                    weld.Part0=part;
                    weld.Part1=head;
                    part.Anchored=false;
                    part.CanCollide=true;
                    hum.PlatformStand=true;
            local sound=Instance.new('Sound',head);
                    sound.SoundId='rbxassetid://228536200';
                    sound.Volume=1;
                    sound.Looped=true;
                    sound:play();
                    for i,v in ipairs(char:children()) do
                        if v:IsA'Part' then
                            v.Transparency=1;
                        end
                    end
                    local PointLight = Instance.new('PointLight',head)
                    PointLight.Range = 20
                    local bbg = Instance.new('BillboardGui',head)
                    bbg.Adornee=head
                    bbg.Size=UDim2.new(8,0,8,0)
					bbg.AlwaysOnTop = true
                    local img = Instance.new('ImageLabel',bbg)
                    img.BackgroundTransparency=1
                    img.Size=UDim2.new(1,0,1,0)
                    img.Image='rbxassetid://185945467'
            coroutine.wrap(function()
                while (part.Parent) do
                    pcall(function()
                        img.Image='rbxassetid://131395838'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395847'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395855'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395860'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395868'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395884'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395884'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395891'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395897'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395901'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395946'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395957'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395966'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395972'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395979'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395986'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395989'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395993'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131395997'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396003'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396007'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396012'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396016'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396019'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396024'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396029'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396037'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396042'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396044'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396046'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396054'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396063'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396068'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396072'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396078'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396091'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396098'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396102'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396108'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396110'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396113'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396116'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396121'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396125'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396133'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396137'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396142'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396146'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396156'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396162'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396164'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396169'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396173'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396176'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396181'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396185'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396188'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://131396192'
                    end)
                    wait()
                end
            end)()
            while(part.Parent)do
                    if(keys[' ']and raycasting(part.Position,Vector3.new(0,-10,0)))then
                            part.Velocity=part.Velocity+Vector3.new(0,30,0);
                    end;
                   
                    if(keys.w or keys.a or keys.s or keys.d)then
                            local r=-math.pi/2;
                           
                            if(keys.s)then
                                    r=r-math.pi;
                            end;
                           
                            if(keys.a)then
                                    if(keys.w)then
                                            r=r-math.pi/4;
                                    elseif(keys.s)then
                                            r=r+math.pi/4;
                                    else
                                            r=r-math.pi/2;
                                    end;
                            end;
                           
                            if(keys.d)then
                                    if(keys.w)then
                                            r=r+math.pi/4;
                                    elseif(keys.s)then
                                            r=r-math.pi/4;
                                    else
                                            r=r+math.pi/2;
                                    end;
                            end;
                   
                            local cam=workspace.CurrentCamera;
                            local crd=cam.CoordinateFrame;
                            local dir=(crd.lookVector*Vector3.new(1,0,1)).unit;
                                    local x=dir.x;
                                    local z=dir.z;
                            local dir=Vector3.new(
                                    math.cos(r)*x-math.sin(r)*z,
                                    0,
                                    math.sin(r)*x+math.cos(r)*z
                            );
                            part.RotVelocity=dir*speed;
                            speed=math.min(max_speed,speed+2/speed);
                    else
                            speed=math.min(math.abs(part.Velocity.magnitude/5),max_speed);
                    end;
                    wait();
                    hue = ((hue+25)%360)
                    colur = HSV(hue,1,1)
                    PointLight.Color = Color3.new(colur.r,colur.g,colur.b)
            end;
            pcall(function()
                bbg:Destroy()
            end)
            pcall(function()
                sound:Destroy()
            end)
            pcall(function()
                PointLight:Destroy()
            end)
			end
		end
		if key == "q" then
			if using == true then
				MLGDisable()
			end
			wait(0.15)
			if using == false then
			using = true
        	local hue = 0
        	local colur = 0
            local keys={};
           
            game.Players.LocalPlayer:GetMouse().KeyDown:connect(function(key)
                    keys[key]=true;
            end);
           
            game.Players.LocalPlayer:GetMouse().KeyUp:connect(function(key)
                    keys[key]=false;
            end);

            game:service'SoundService'.DistanceFactor = 50
            game:service'SoundService'.DopplerScale=0
           
            local speed=7;
            local max_speed=150;

            hum.MaxHealth = math.huge
           
            	 part=Instance.new'Part';
                    part.Shape=0;
                    part.Friction=10;
                    part.Elasticity=1;
                    part.TopSurface=0;
                    part.FormFactor=0;
                    part.Anchored=true;
                    part.BottomSurface=0;
                    part.Name='ala_ball';
                    part.CanCollide=false;
                    part.Transparency=1;
                    part.CFrame=head.CFrame;
                    part.Size=Vector3.new(10,10,10);
                    part.Parent=char;
            local weld=Instance.new('Weld',part);
                    weld.Part0=part;
                    weld.Part1=head;
                    part.Anchored=false;
                    part.CanCollide=true;
                    hum.PlatformStand=true;
            local sound=Instance.new('Sound',head);
                    sound.SoundId='rbxassetid://177078299';
                    sound.Volume=1;
                    sound.Looped=true;
                    sound:play();
                    for i,v in ipairs(char:children()) do
                        if v:IsA'Part' then
                            v.Transparency=1;
                        end
                    end
                    local PointLight = Instance.new('PointLight',head)
                    PointLight.Range = 20
                    local bbg = Instance.new('BillboardGui',head)
                    bbg.Adornee=head
                    bbg.Size=UDim2.new(8,0,8,0)
					bbg.AlwaysOnTop = true
                    local img = Instance.new('ImageLabel',bbg)
                    img.BackgroundTransparency=1
                    img.Size=UDim2.new(1,0,1,0)
                    img.Image='rbxassetid://185945467'
            coroutine.wrap(function()
                while (part.Parent) do
                    pcall(function()
                        img.Image='rbxassetid://185945467'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945486'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945493'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945515'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945527'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945553'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945573'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945586'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945612'
                    end)
                    wait()
                    pcall(function()
                        img.Image='rbxassetid://185945634'
                    end)
                    wait()
                end
            end)()
            while(part.Parent)do
                    if(keys[' ']and raycasting(part.Position,Vector3.new(0,-10,0)))then
                            part.Velocity=part.Velocity+Vector3.new(0,30,0);
                    end;
                   
                    if(keys.w or keys.a or keys.s or keys.d)then
                            local r=-math.pi/2;
                           
                            if(keys.s)then
                                    r=r-math.pi;
                            end;
                           
                            if(keys.a)then
                                    if(keys.w)then
                                            r=r-math.pi/4;
                                    elseif(keys.s)then
                                            r=r+math.pi/4;
                                    else
                                            r=r-math.pi/2;
                                    end;
                            end;
                           
                            if(keys.d)then
                                    if(keys.w)then
                                            r=r+math.pi/4;
                                    elseif(keys.s)then
                                            r=r-math.pi/4;
                                    else
                                            r=r+math.pi/2;
                                    end;
                            end;
                   
                            local cam=workspace.CurrentCamera;
                            local crd=cam.CoordinateFrame;
                            local dir=(crd.lookVector*Vector3.new(1,0,1)).unit;
                                    local x=dir.x;
                                    local z=dir.z;
                            local dir=Vector3.new(
                                    math.cos(r)*x-math.sin(r)*z,
                                    0,
                                    math.sin(r)*x+math.cos(r)*z
                            );
                            part.RotVelocity=dir*speed;
                            speed=math.min(max_speed,speed+2/speed);
                    else
                            speed=math.min(math.abs(part.Velocity.magnitude/5),max_speed);
                    end;
                    wait();
                    hue = ((hue+25)%360)
                    colur = HSV(hue,1,1)
                    PointLight.Color = Color3.new(colur.r,colur.g,colur.b)
            end;
            pcall(function()
                bbg:Destroy()
            end)
            pcall(function()
                sound:Destroy()
            end)
            pcall(function()
                PointLight:Destroy()
            end)
			end
		end
	end)
	