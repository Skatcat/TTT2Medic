AddCSLuaFile()

ROLE.color = Color(80, 140, 90, 255) -- ...
ROLE.dkcolor = Color(29, 94, 40, 255) -- ...
ROLE.bgcolor = Color(175, 255, 140, 255) -- ...
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
		LANG.AddToLanguage("Deutsch", MEDIC.name, "Überlebender")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. MEDIC.name,
			[[Du bist ein Arzt!
				Versuche zu überleben und beschütze dein Team, wenn es möglich sein sollte!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. MEDIC.abbr, "Er war ein Überlebender...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. MEDIC.abbr, "Diese Person war ein Überlebender!")
		LANG.AddToLanguage("Deutsch", "target_" .. MEDIC.name, "Überlebender")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. MEDIC.name, [[Der Arzt heilt Leute!]])
	end)
end

-- nothing special, just a inno that is able to access the [C] shop
