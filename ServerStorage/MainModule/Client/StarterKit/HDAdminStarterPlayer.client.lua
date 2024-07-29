-- << RETRIEVE FRAMEWORK >>
local main = require(game:GetService("ReplicatedStorage"):WaitForChild("HDAdminSetup")):GetMain(true)
main:Initialize("Client")



-- << SETUP >>
main:GetModule("PageAbout"):UpdateRankName()
main:GetModule("PageAbout"):UpdateProfileIcon()
main:GetModule("PageAbout"):CreateUpdates()
main:GetModule("PageAbout"):UpdateContributors()
main:GetModule("PageAbout"):CreateCredits()
main:GetModule("PageCommands"):CreateCommands()
main:GetModule("PageCommands"):CreateMorphs()
main:GetModule("PageCommands"):CreateDetails()
main:GetModule("PageSpecial"):SetupDonorCommands()
main:GetModule("PageAdmin"):SetupRanks()
main:GetModule("GUIs"):DisplayPagesAccordingToRank()



-- << LOAD ASSETS >>
local assetsToLoad = {main.gui}
main.contentProvider:PreloadAsync(assetsToLoad)