
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Shotgun Ammo Crate"
ENT.Author			= "TricycleRaptor"
ENT.Information		= ""
ENT.Category		= "Half-Life 2"
ENT.Cost			= 500
ENT.Model			= "models/items/ammocrate_buckshot.mdl"

ENT.Spawnable		= false
ENT.AdminOnly		= false

if SERVER then

function ENT:Initialize()
	
	self:SetModel("models/weapons/shell.mdl")
	self:SetNoDraw(true)
	self:DrawShadow(false)
	
	self.ammo_crate_shotgun = ents.Create("item_ammo_crate")
	self.ammo_crate_shotgun:SetPos( self:GetPos() + Vector(0,0,-15))
	self.ammo_crate_shotgun:SetAngles( self:GetAngles() )
	self.ammo_crate_shotgun:SetKeyValue( "AmmoType", 4 )
	self.ammo_crate_shotgun:SetOwner( self.Owner )
	self.ammo_crate_shotgun:Spawn()
	self.ammo_crate_shotgun:Activate()
	local ammo_crate_buckshot_name = "ammo_crate_shotgun" .. self.ammo_crate_shotgun:EntIndex()
	self.ammo_crate_shotgun:SetName( ammo_crate_bucksot_name )

end
function ENT:Think()
	if !IsValid (self.ammo_crate_shotgun) then
	self:Remove()
	end
end
function ENT:OnRemove()
	if IsValid (self.ammo_crate_shotgun) then
	self.ammo_crate_shotgun:Remove()
	end
end
end