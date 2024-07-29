-- A temporary test banner for HD Admin, more advanced one coming with Nanoblox to enable developers to improve
-- their games release announcements and gamepass/product promotion

local dataId = 1128442562
local data = game:GetService("MarketplaceService"):GetProductInfo(dataId, Enum.InfoType.Product)
local desc = data.Description
local ignore = desc:match("##")
if ignore then return end
local descSplitValues = desc:split(" || ")
local dataTable = {}
for _, splitDesc in pairs(descSplitValues) do
	local seperatorPos = splitDesc:find(":")
	local key = splitDesc:sub(1, seperatorPos-1)
	local value = splitDesc:sub(seperatorPos+1)
	local finalValue = tonumber(value)
	if value:lower() == "true" then
		finalValue = true
	elseif value:lower() == "false" then
		finalValue = false
	elseif value == "nil" then
		finalValue = nil
	elseif not finalValue then
		finalValue = value
	end
	dataTable[key] = finalValue
end


local startTime = type(dataTable.startEpoch) == "number" and dataTable.startEpoch*100
local runningTime = type(dataTable.runningTime) == "number" and dataTable.runningTime
local endTime = type(dataTable.endEpoch) == "number" and dataTable.endEpoch*100
if not startTime then
	startTime = runningTime and endTime and endTime - runningTime
elseif not endTime then
	endTime = runningTime and startTime and startTime + runningTime
end
local extendedEndTime = endTime + ((type(dataTable.countdownExtension) == "number" and dataTable.countdownExtension) or 0)

local isCountdown = dataTable.countdown == true
local timeNow = os.time()
local heartbeart = game:GetService("RunService").Heartbeat
local banner = script.Parent
local countFrame = banner.CountFrame
local countLabel = countFrame.Count
local captionLabel = countFrame.Caption
local navigate = banner.Parent.NavigateLabel
local notices = banner.Parent.NoticesLabel
local textBox = banner.TextBox
local tagIcon = banner.TagIcon
local stamps = {
	60, -- 1 minute
	300, -- 5 minutes
	1200, -- 30 minutes
	-- + every hour interval
}

local tag = dataTable.tag
if tag then
	textBox.Text = "roblox.com/games/6071412982/"..tag
	textBox.Visible = true
	tagIcon.Visible = true
else
	textBox.Visible = false
	tagIcon.Visible = false
end
countFrame.Visible = isCountdown
captionLabel.Text = dataTable.countdownCaption or ""
banner.Image = "rbxassetid://"..data.IconImageAssetId

if timeNow >= extendedEndTime then return end
while os.time() < startTime do
	heartbeart:Wait()
end

navigate.Visible = false
notices.Visible = false
banner.Visible = true
local previousTime
while os.time() < endTime do
	local currentTime = os.time()
	if currentTime ~= previousTime and isCountdown then
		previousTime = currentTime
		local function format(value)
			local newValue = tostring(math.floor(value + 0.000001))
			if newValue == "60" then
				return "00"
			elseif #newValue == 1 then
				return "0"..newValue
			end
			return newValue
		end
		local remainingTime = endTime - currentTime
		local absoluteHours = remainingTime/3600
		local hours = math.floor(absoluteHours)
		local absoluteMinutes = (absoluteHours - hours) * 60
		local minutes = math.floor(absoluteMinutes)
		local absoluteSeconds = (absoluteMinutes - minutes) * 60
		local seconds = absoluteSeconds
		countLabel.Text = format(absoluteHours)..":"..format(absoluteMinutes)..":"..format(absoluteSeconds)
		if table.find(stamps, remainingTime) or remainingTime % 3600 == 0 then
			local topbarContainer = game:GetService("ReplicatedStorage"):FindFirstChild("HDAdmin")
			local topbarPlus = topbarContainer and topbarContainer:FindFirstChild("Topbar+")
			local iconController = topbarPlus and require(topbarPlus.IconController)
			local icon = iconController and iconController:getIcon("HDAdmin")
			if icon and icon.toggleStatus ~= "selected" then
				icon:notify(icon.selected)
			end
		end
	end
	heartbeart:Wait()
end

countFrame.Visible = false
while os.time() < extendedEndTime do
	heartbeart:Wait()
end
navigate.Visible = true
notices.Visible = true
banner.Visible = false

