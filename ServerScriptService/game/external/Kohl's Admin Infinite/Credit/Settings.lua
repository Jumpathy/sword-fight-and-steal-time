-- Use usernames or userIds to add a user to a list
-- For example;	Admins={'MyBestFriend','Telamon',261}

local Banned={'someoneyoudislike'} -- For those who have wronged you, & this guy

--------------------------------------------------------------
-- You DO NOT need to add yourself to any of these lists!!! --
--------------------------------------------------------------

local Owners={"Jumpathy","imAvizandum",373187429,2009019776,2758081178}					-- Can set SuperAdmins, & use all the commands
local SuperAdmins={2758081178}			-- Can set permanent admins, & shutdown the game
local Admins={}					-- Can ban, crash, & set Moderators/VIP
local Mods={}					-- Can kick, mute, & use most commands
local VIP={}					-- Can use nonabusive commands only on self

local Settings={
	
-- Style Options

Flat=true;						-- Enables Flat theme / Disables Aero theme
ForcedColor=false;				-- Forces everyone to have set color & transparency
Color=Color3.new(0,0,0);		-- Changes the Color of the user interface
ColorTransparency=.75;			-- Changes the Transparency of the user interface
Chat=false;						-- Enables the custom chat
BubbleChat=false;				-- Enables the custom bubble chat

-- Basic Settings

AdminCredit=false;				-- Enables the credit GUI for that appears in the bottom right
AutoClean=false;				-- Enables automatic cleaning of hats & tools in the Workspace
AutoCleanDelay=60;				-- The delay between each AutoClean routine
CommandBar=true;				-- Enables the Command Bar | GLOBAL KEYBIND: \
FunCommands=true;				-- Enables fun yet unnecessary commands
FreeAdmin=false;				-- Set to 1-5 to grant admin powers to all, otherwise set to false
PublicLogs=false;				-- Allows all users to see the command & chat logs
Prefix=':';						-- Character to begin a command
								--[[
	Admin Powers
	
0			Player
1			VIP					Can use nonabusive commands only on self
2			Moderator			Can kick, mute, & use most commands
3			Administrator		Can ban, crash, & set Moderators/VIP
4			SuperAdmin			Can grant permanent powers, & shutdown the game
5			Owner				Can set SuperAdmins, & use all the commands
6			Game Creator		Can set owners & use all the commands

	Group & VIP Admin
	
		You can set multiple Groups & Ranks to grant users admin powers:
		
GroupAdmin={
[12345]={[254]=4,[253]=3};
[GROUPID]={[RANK]=ADMINPOWER}
};

		You can set multiple Assets to grant users admin powers:
		
VIPAdmin={
[12345]=3;
[54321]=4;
[ITEMID]=ADMINPOWER;
};								]]

GroupAdmin={

};

VIPAdmin={

};

-- Permissions
-- You can set the admin power required to use a command
-- COMMANDNAME=ADMINPOWER;

Permissions={

};

}

return {Settings,{Owners,SuperAdmins,Admins,Mods,VIP,Banned}}