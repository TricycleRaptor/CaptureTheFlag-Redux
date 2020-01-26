
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "AR2 Ammo Crate"
ENT.Author			= "TricycleRaptor"
ENT.Information		= ""
ENT.Category		= "Half-Life 2"
ENT.Cost			= 500
ENT.Model			= "models/items/ammocrate_ar2.mdl"

ENT.Spawnable		= false
ENT.AdminOnly		= false

if SERVER then

function ENT:Initialize()
	
	self:SetModel("models/weapons/shell.mdl")
	self:SetNoDraw(true)
	self:DrawShadow(false)
	
	self.ammo_crate_ar2 = ents.Create("item_ammo_crate")
	self.ammo_crate_ar2:SetPos( self:GetPos() + Vector(0,0,-15))
	self.ammo_crate_ar2:SetAngles( self:GetAngles() )
	self.ammo_crate_ar2:SetKeyValue( "AmmoType", 2 )
	self.ammo_crate_ar2:SetOwner( self.Owner )
	self.ammo_crate_ar2:Spawn()
	self.ammo_crate_ar2:Activate()
	local ammo_crate_ar2_name = "ammo_crate_ar2" .. self.ammo_crate_ar2:EntIndex()
	self.ammo_crate_ar2:SetName( ammo_crate_ar2_name )

end
function ENT:Think()
	if !IsValid (self.ammo_crate_ar2) then
	self:Remove()
	end
end
function ENT:OnRemove()
	if IsValid (self.ammo_crate_ar2) then
	self.ammo_crate_ar2:Remove()
	end
end
end