
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "SMG Ammo Crate"
ENT.Author			= "TricycleRaptor"
ENT.Information		= ""
ENT.Category		= "Half-Life 2"
ENT.Cost			= 500
ENT.Model			= "models/items/ammocrate_smg1.mdl"

ENT.Spawnable		= false
ENT.AdminOnly		= false

if SERVER then

function ENT:Initialize()
	
	self:SetModel("models/weapons/shell.mdl")
	self:SetNoDraw(true)
	self:DrawShadow(false)
	
	self.ammo_crate_smg = ents.Create("item_ammo_crate")
	self.ammo_crate_smg:SetPos( self:GetPos() + Vector(0,0,-15))
	self.ammo_crate_smg:SetAngles( self:GetAngles() )
	self.ammo_crate_smg:SetKeyValue( "AmmoType", 1 )
	self.ammo_crate_smg:SetOwner( self.Owner )
	self.ammo_crate_smg:Spawn()
	self.ammo_crate_smg:Activate()
	local ammo_crate_smg_name = "ammo_crate_smg" .. self.ammo_crate_smg:EntIndex()
	self.ammo_crate_smg:SetName( ammo_crate_smg_name )

end
function ENT:Think()
	if !IsValid (self.ammo_crate_smg) then
	self:Remove()
	end
end
function ENT:OnRemove()
	if IsValid (self.ammo_crate_smg) then
	self.ammo_crate_smg:Remove()
	end
end
end