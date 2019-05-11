AddCSLuaFile()

if CLIENT then

   SWEP.PrintName    = "Surgery Knife"
   SWEP.Slot         = 7
  
   SWEP.ViewModelFlip = false

   SWEP.EquipMenuData = {
      type = "item_weapon",
      desc = "Heal yourself for 100HP \nor a friend for up to 25HP \nLeft click to heal a friend \nRight click to heal yourself"
   };

   SWEP.Icon = "vgui/ttt/icon_medkit"
end

SWEP.Base               = "weapon_tttbase"

SWEP.Spawnable			= true
SWEP.UseHands			= true

SWEP.ViewModel              = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel             = "models/weapons/w_knife_t.mdl"

SWEP.ViewModelFOV		= 54

SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Kind = WEAPON_EQUIP2
SWEP.LimitedStock = false -- only buyable once
SWEP.WeaponID = AMMO_KERFUNKLE

SWEP.HealAmount = 25 -- Maximum heal amount per use
SWEP.MaxAmmo = 25 -- Maximum ammo

local HealSound = Sound( "items/smallmedkit1.wav" )
local DenySound = Sound( "items/medshotno1.wav" )

function SWEP:Initialize()

	self:SetHoldType( "knife" )

	if ( CLIENT ) then return end
	
end

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end
	if ( !self:CanPrimaryAttack() ) then return end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 90,
		filter = self.Owner
	} )

	local ent = tr.Entity
	
	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxHealth() - ent:Health(), self.HealAmount ) end

	if ( IsValid( ent ) && ent:IsPlayer() && ent:Health() < 100 ) then

		ent:SetHealth( math.min( ent:GetMaxHealth(), ent:Health() + 25 ) )
		ent:EmitSound( HealSound )
		self.Weapon:TakePrimaryAmmo(1)
		self:SetNextPrimaryFire( CurTime() + 2 )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	else

		self.Owner:EmitSound( DenySound )
		self:SetNextPrimaryFire( CurTime() + 2 )

	end

end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then return end
	if ( self.Weapon:Clip1() < 2 ) then return end
	
	local ent = self.Owner
	
	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxHealth() - ent:Health(), self.HealAmount ) end

	if ( IsValid( ent ) && ent:Health() < ent:GetMaxHealth() ) then

		ent:SetHealth( math.min( ent:GetMaxHealth(), ent:Health() + 25 ) )
		self.Weapon:TakePrimaryAmmo(2)
		self:SetNextSecondaryFire( CurTime() + 5 )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	else

		ent:EmitSound( DenySound )
		self:SetNextSecondaryFire( CurTime() + 1 )

	end

end

function SWEP:OnRemove()
	if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
      RunConsoleCommand("lastinv")
	end
	
	timer.Stop( "medkit_ammo" .. self:EntIndex() )
	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )
	
	return true

end

if SERVER then
	hook.Add("Initialize", "AddSurknifeToDefaultLoadout", function()
		local wep = weapons.GetStored("ttt_surgeryknife")

		if wep then
			wep.InLoadoutFor = wep.InLoadoutFor or {}

			if not table.HasValue(wep.InLoadoutFor, ROLE_MEDIC) then
				table.insert(wep.InLoadoutFor, ROLE_MEDIC)
			end
		end
	end)
end

