-- Referenced by doing ``main.main:GetModule("API")``

local hd = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- << VARIABLES >>
--local topBarFrame = main.gui.CustomTopBar



-- << API >>
function hd:SetTopbarTransparency(number)
	number = tonumber(number) or 0.5
	--topBarFrame.BackgroundTransparency = number
end

function hd:SetTopbarEnabled(boolean)
	if type(boolean) ~= "boolean" then
		boolean = true
	end
	--main.topbarEnabled = boolean
	--topBarFrame.Visible = boolean
	--main:GetModule("TopBar"):CoreGUIsChanged()
	local hdIcon = main:GetModule("TopbarIcon")
	if hdIcon then
		hdIcon:setEnabled(boolean)
	end
end



return hd