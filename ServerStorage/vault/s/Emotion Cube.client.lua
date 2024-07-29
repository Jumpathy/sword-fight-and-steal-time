plyr = game.Players.LocalPlayer
char = plyr.Character
torso = char.Torso
head = char.Head
Run = game:service'RunService'
sizeCu = 2
local MODE = "Lime green"
coroutine.wrap(function()
while true do
coroutine.wrap(function()
		local charge = Instance.new("Part", char)
		charge.FormFactor = "Custom"
		charge.TopSurface = 0
		charge.BottomSurface = 0
		charge.Transparency = 0.4
		charge.BrickColor = BrickColor.new(MODE)
		charge.Anchored = true
		charge.CanCollide = false
		charge.Size = Vector3.new(sizeCu, sizeCu, sizeCu)
				charge.CFrame = head.CFrame * CFrame.new(0, 5.8, 0) * CFrame.Angles(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2))
		wait()
		for tra = 0.4, 1, 0.1 do
			charge.Transparency = tra
			wait()
		end
		charge:Destroy()
		end)()
		wait(0.06)
end
end)()

happy = {"yay", "good", "like", "come here", "yolo", "swag", "win","nice","xD" ,"lol","yus","yes","omg", "ogm", "umg", "thnx", "thx", "thanz", "thanx", "thank you", "thank yoo", "rofl", "hax" , "Z0mg", "hackz" , "hack","impossible","boss","epix","epic", "awesome"} --is THat Good, yes
anger = {"narb","bad","shut up", "noob", "get off","stop", "hate", "ugly", "bish","no", "idiot", "stfu", "gtfo" ,"fk y", "troll", "mad","angry"}
sad = {"sad","why?", "D:"}
plyr.Chatted:connect(function(msg)
	if msg:lower():match(string.lower("AFK")) or msg:upper():match(string.upper("AFK")) then
		MODE = "Br. yellowish orange"
	end
	
                for i, t in pairs(happy) do        
                        if msg:lower():match(string.lower(t)) or msg:upper():match(string.upper(t)) then
                                MODE = "Lime green"
                        end
                end
                for f, h in pairs(sad) do        
                        if msg:lower():match(string.lower(h)) or msg:upper():match(string.upper(h)) then
                                MODE = "Royal purple" ---Make it Purple
                        end
                end
                                for v, k in pairs(anger) do        
                        if msg:lower():match(string.lower(k)) or msg:upper():match(string.upper(k)) then
                                MODE = "Really red"
                        end
                end
        end) 



