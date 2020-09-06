if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_med.vmt")
end

-- creates global var "TEAM_SERIALKILLER" and other required things
-- TEAM_[name], data: e.g. icon, color,...
roles.InitCustomTeam(ROLE.name, {
		icon = "vgui/ttt/dynamic/roles/icon_med",
		color = Color(49, 105, 109, 255)
})


ROLE.color = Color(219, 133, 73, 255) -- ...
ROLE.dkcolor = Color(219, 133, 73, 255) -- ...
ROLE.bgcolor = Color(219, 133, 73, 255) -- ...
ROLE.abbr = "med" -- abbreviation
ROLE.defaultTeam = TEAM_INNOCENT -- the team name: roles with same team name are working together
ROLE.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment
ROLE.radarColor = Color(150, 150, 150) -- color if someone is using the radar
ROLE.surviveBonus = 0 -- bonus multiplier for every survive while another player was killed
ROLE.scoreKillsMultiplier = 1 -- multiplier for kill of player of another team
ROLE.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
ROLE.unknownTeam = true -- player don't know their teammates

ROLE.conVarData = {
	pct = 0.15, -- necessary: percentage of getting this role selected (per player)
	maximum = 2, -- maximum amount of roles in a round
	minPlayers = 7, -- minimum amount of players until this role is able to get selected
	credits = 0, -- the starting credits of a specific role
	togglable = true, -- option to toggle a role for a client if possible (F1 menu)
}

-- now link this subrole with its baserole
hook.Add("TTT2BaseRoleInit", "TTT2ConBRIWithMed", function()
	MEDIC:SetBaseRole(ROLE_INNOCENT)
end)

if CLIENT then
	hook.Add("TTT2FinishedLoading", "MedInitT", function()
		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", MEDIC.name, "Medic")
		LANG.AddToLanguage("English", "info_popup_" .. MEDIC.name,
			[[You are a Medic!
				Try to heal fellow innocents!]])
		LANG.AddToLanguage("English", "body_found_" .. MEDIC.abbr, "This was a Medic...")
		LANG.AddToLanguage("English", "search_role_" .. MEDIC.abbr, "This person was a Medic!")
		LANG.AddToLanguage("English", "target_" .. MEDIC.name, "Medic")
		LANG.AddToLanguage("English", "ttt2_desc_" .. MEDIC.name, [[The Medic can heal people!]])

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", MEDIC.name, "Sanitäter")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. MEDIC.name,
			[[Du bist ein Sanitäter!
				Versuche zu überleben und beschütze dein Team, wenn es möglich sein sollte!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. MEDIC.abbr, "Er war ein Sanitäter...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. MEDIC.abbr, "Diese Person war ein Sanitäter!")
		LANG.AddToLanguage("Deutsch", "target_" .. MEDIC.name, "Sanitäter")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. MEDIC.name, [[Der Sanitäter heilt Leute!]])
		
		---------------------------------
		
		LANG.AddToLanguage("Русский", MEDIC.name, "Медик")
		LANG.AddToLanguage("Русский", "info_popup_" .. MEDIC.name,
			[[Вы медик!
				Попробуйте по возможности лечить невиновных товарищей!]])
		LANG.AddToLanguage("Русский", "body_found_" .. MEDIC.abbr, "Он был медиком...")
		LANG.AddToLanguage("Русский", "search_role_" .. MEDIC.abbr, "Этот человек был медиком!")
		LANG.AddToLanguage("Русский", "target_" .. MEDIC.name, "Медик")
		LANG.AddToLanguage("Русский", "ttt2_desc_" .. MEDIC.name, [[Медик может лечить людей!]])

	end)
end

-- nothing special, just a inno that is able to access the [C] shop
