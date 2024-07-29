local module = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain
local load = main.loadModule
local cf = load("cf")
local credits = load("Credits")
local updates = load("Updates")



-- << VARIABLES >>
local frame = main.gui.MainFrame.Pages.About
local info = frame.Info
local updatesFrame = frame.Updates
local creditsFrame = frame.Credits



-- << INFO >>
info.m1.Text = "Welcome back, "..main.player.Name.."!"
info.Take.MouseButton1Down:Connect(function()
	main.marketplaceService:PromptPurchase(main.player, 857927023)
end)
function module:UpdateProfileIcon()
	info.PlayerImage.Image = cf:GetUserImage(main.player.UserId)
end
function module:UpdateRankName()
	info.m2RankName.Text = "'".. cf:GetRankName(main.pdata.Rank).."'"
end



-- << UPDATES >>
local displayNewUpdatesFor = 86400*10.5
local template1 = updatesFrame.Template
template1.Visible = false
function module:CreateUpdates()
	cf:ClearPage(updatesFrame)
	local totalLabels = 0
	for _, updateGroup in pairs(updates) do
		local updateTime = 0
		totalLabels = totalLabels + #updateGroup
		for i,v in pairs(updateGroup) do
			local label = template1:Clone()
			if i == 1 then
				updateTime = v[1]
				label.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
				label.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				label.TextLabel.Text = v[2]
			else
				label.BackgroundColor3 = cf:GetLabelBackgroundColor(i)
				label.TextLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
				label.TextLabel.Text = v[1]
				if updateTime > os.time() - displayNewUpdatesFor then
					label.New.Visible = true
					label.TextLabel.Position = UDim2.new(0.16, 0,0.15, 0)
					label.TextLabel.Size = UDim2.new(0.8, 0,0.7, 0)
				end
			end
			label.Visible = true
			label.Parent = updatesFrame
		end
	end
	updatesFrame.CanvasSize = UDim2.new(0,0,0,totalLabels*template1.AbsoluteSize.Y)
end



-- << CREDITS >>
local template2 = creditsFrame.Template
template2.Visible = false
--Update contributors
function module:UpdateContributors()
	-- The Team
	--[[local groupInfo = main.hdAdminGroup.Info
	for roleName, roleInfo in pairs(groupInfo.Roles) do
		if roleInfo.Name then
			table.insert(credits[1], {})
		end
	end--]]
	
	-- Command Contributors
	local commandContriubtorsToAdd = {}
	for userName, amount in pairs(main.infoOnAllCommands.Contributors) do
		table.insert(commandContriubtorsToAdd, {userName, amount})
	end
	table.sort(commandContriubtorsToAdd, function(a,b) return a[2] > b[2] end)
	for i,v in pairs(commandContriubtorsToAdd) do
		local newRow = {v[1], {"Commands: ".. v[2]}}
		table.insert(credits[3], newRow)
	end
end
--MainFunction
function module:CreateCredits()
	cf:ClearPage(creditsFrame)
	local totalY = 0
	for _, updateGroup in pairs(credits) do
		local aspectRatio = 6
		for i,v in pairs(updateGroup) do
			local label
			if i == 1 then
				label = template1:Clone()
				aspectRatio = v[1]
				label.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
				label.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				label.TextLabel.Text = v[2]
				label.Parent = creditsFrame
			else
				label = template2:Clone()
				label.Parent = creditsFrame
				label.UIAspectRatioConstraint.AspectRatio = aspectRatio
				label.BackgroundColor3 = cf:GetLabelBackgroundColor(i)
				label.PlrName.Text = v[1]
				label.PlayerImage.Image = cf:GetUserImage(cf:GetUserId(v[1]))
				local labelSizeX = label.PlayerImage.AbsoluteSize.Y
				label.PlayerImage.Size = UDim2.new(0,labelSizeX,1,0)
				for i = 1,3 do
					local descLabel = label:FindFirstChild("Desc"..i)
					if descLabel then
						local desc = v[2][i]
						if desc then
							descLabel.Text = desc
						else
							descLabel.Text = ""
						end
						local xOffset = labelSizeX*1.15
						local yScalePos
						local yScaleSize
						local yScaleSize2
						if aspectRatio <= 5 then
							yScalePos = 0.33+((i-1)*0.25)
							yScaleSize = 0.255
							yScaleSize2 = 0.31
						else
							yScalePos = 0.36+((i-1)*0.25)
							yScaleSize = 0.26 -- Size
							yScaleSize2 = 0.32 -- Pos
						end
						descLabel.Position = UDim2.new(0, xOffset, yScalePos, 0)
						descLabel.Size = UDim2.new(0.75, 0, yScaleSize, 0)
						label.PlrName.Position = UDim2.new(0, xOffset, label.PlrName.Position.Y.Scale, label.PlrName.Position.Y.Offset)
						label.PlrName.Size = UDim2.new(0.75, 0, yScaleSize2, 0)
					end
				end
			end
			label.Name = "Label"
			label.Visible = true
			totalY = totalY + label.AbsoluteSize.Y
		end
	end
	creditsFrame.CanvasSize = UDim2.new(0,0,0,totalY)
end



return module