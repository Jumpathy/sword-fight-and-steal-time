local module = {}


-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- << VARIABLES >>
local frame = main.gui.MainFrame.Pages["Special"]
local pages = {
	donor = frame.Donor;
}
local templateGame = pages.donor.TemplateGame
local firstLabel = pages.donor["A Space"]
local finalLabel = pages.donor["AZ Space"]
local unlockDonor = pages.donor["AG Unlock"]
local teleportFrame = main.warnings.Teleport



-- << SETUP >>
-- Donor Commands
local donorCommands = {}
for _, command in pairs(main.commandInfo) do
	if command.RankName == "Donor" then
		table.insert(donorCommands, command)
	end
end

--Game which use Donor
local gamesWithDonor = {
	-- Its currently too time consuming and unfair to maintain donor games
	-- A new automated discover will be introduced with the successor of HD Admin, Nanoblox
	--[[{574407221, "Super Hero Tycoon"};
	{2921400152, "4PLR Tycoon"};
	{1828225164, "Guest World"};
	{591993002, "OHD Roleplay World"};
	{4823091615 , "Paradise Life"};
	{49254942, "2 Player House Tycoon"};
	{3169584572, "Meme Music"};
	{2764548803, "Island Hotel"};
	{3093229294, "Animations: Mocap"};
	{3411100258, "evry bordr gam evr"};
	{3108078982, "HD Admin House"};
	{12996397, "Mega Fun Obby 🌟"};
	{184558572, "Survive the Disasters"};
	{4522347649, "[FREE ADMIN]"};
	{4913581664, "Cart Ride Into Rdite!"};--]]
	
	--{0, ""};
	}
local coreFunctions
repeat wait() coreFunctions = main:GetModule("cf") until coreFunctions.RandomiseTable
local gamesWithDonorSorted = coreFunctions:RandomiseTable(gamesWithDonor, 86400)
for i, gameData in pairs(gamesWithDonorSorted) do
	local gameId = gameData[1]
	local gameName = gameData[2]
	local row = math.ceil(i/2)
	local column = i % 2 
	local gamePage
	if column == 1 then
		gamePage = templateGame:Clone()
		gamePage.Name = "AI Game".. row
		gamePage.Visible = true
		gamePage.Parent = pages.donor
	else
		gamePage = pages.donor["AI Game".. row]
	end
	local gameThumbnail = gamePage["GameImage"..column]
	local gameLabel = gamePage["GameName"..column]
	local image = "https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid=".. gameId .."&fmt=png&wd=420&ht=420"
	gameThumbnail.Image = image
	gameLabel.Text = gameName
	gameThumbnail.Visible = true
	gameLabel.Visible = true
	--Teleport to game
	local selectButton = gameThumbnail.Select
	local clickFrame = gameThumbnail.ClickFrame
	selectButton.MouseButton1Click:Connect(function()
		teleportFrame.ImageLabel.Image = image
		teleportFrame.TeleportTo.TextLabel.Text = gameName.."?"
		teleportFrame.MainButton.PlaceId.Value = gameId
		main:GetModule("cf"):ShowWarning("Teleport")
	end)
	selectButton.MouseEnter:Connect(function()
		if not main.warnings.Visible then
			clickFrame.Visible = true
		end
	end)
	selectButton.MouseLeave:Connect(function()
		clickFrame.Visible = false
	end)
	teleportFrame.Visible = true
end



--Unlock
pages.donor["AG Unlock"].Unlock.MouseButton1Down:Connect(function()
	main.marketplaceService:PromptGamePassPurchase(main.player, main.products.Donor)
end)



-- << FUNCTIONS >>
function module:SetupDonorCommands()
	main:GetModule("PageCommands"):SetupCommands(donorCommands, pages.donor, 0)
	module:UpdateDonorFrame()
end

function module:UpdateDonorFrame()
	if main.pdata.Donor then
		unlockDonor.Visible = false
	else
		unlockDonor.Visible = true
	end
	pages.donor.CanvasSize = UDim2.new(0, 0, 0, (finalLabel.AbsolutePosition.Y - firstLabel.AbsolutePosition.Y) + finalLabel.AbsoluteSize.Y*1)
end



return module