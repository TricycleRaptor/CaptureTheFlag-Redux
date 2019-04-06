SWEP.PrintName			= "Base Locator" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Author			= "Nefusadi" -- These two options will be shown when you have the weapon highlighted in the weapon selection menu
SWEP.Instructions		= "Left mouse set the origin for your team's base"
SWEP.Spawnable = false
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.ViewModel			= "models/weapons/v_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"

local ShootSound = Sound( "Metal.SawbladeStick" )

--
-- Called when the left mouse button is pressed
--
function SWEP:PrimaryAttack()

	self:SetupTeamArea()

end


--
-- Called when the rightmouse button is pressed
--
function SWEP:SecondaryAttack()
-- does nothing
end

function SWEP:SetupTeamArea()

	if ( CLIENT ) then 
		return
	end

	local tr = util.TraceLine( util.GetPlayerTrace( self:GetOwner() ) )
	if not tr.Hit then return end

	doBuild(self:GetOwner():Team(), tr.HitPos, self:GetOwner())
end