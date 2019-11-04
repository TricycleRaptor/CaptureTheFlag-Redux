
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "RPG Ammo Crate"
ENT.Author			= "FiLzO, TricycleRaptor"
ENT.Information		= ""
ENT.Category		= "Half-Life 2"
ENT.Cost			= 500
ENT.Model			= "models/Items/ammoCrate_Rockets.mdl"

ENT.Spawnable		= false
ENT.AdminOnly		= false

if SERVER then

function ENT:Initialize()
	
	self:SetModel("models/weapons/shell.mdl")
	self:SetNoDraw(true)
	self:DrawShadow(false)
	
	self.ammo_crate_rpg = ents.Create("item_ammo_crate")
	self.ammo_crate_rpg:SetPos( self:GetPos() + Vector(0,0,-15))
	self.ammo_crate_rpg:SetAngles( self:GetAngles() )
	self.ammo_crate_rpg:SetKeyValue( "AmmoType", 3 )
	self.ammo_crate_rpg:SetOwner( self.Owner )
	self.ammo_crate_rpg:Spawn()
	self.ammo_crate_rpg:Activate()
	local ammo_crate_rpg_name = "ammo_crate_rpg" .. self.ammo_crate_rpg:EntIndex()
	self.ammo_crate_rpg:SetName( ammo_crate_rpg_name )

end
function ENT:Think()
	if !IsValid (self.ammo_crate_rpg) then
	self:Remove()
	end
end
function ENT:OnRemove()
	if IsValid (self.ammo_crate_rpg) then
	self.ammo_crate_rpg:Remove()
	end
end
end
