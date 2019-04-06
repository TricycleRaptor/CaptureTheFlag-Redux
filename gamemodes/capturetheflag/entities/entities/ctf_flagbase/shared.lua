ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "FlagBase"
ENT.Author = "Nefusadi"
ENT.Purpose = "Base to hold the Flag"

ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:PhysicsUpdate( phys )
	local angles = phys:GetAngles()
	phys:GetEntity():SetAngles(Angle(0,angles.y,0))
	phys:SetAngles(Angle(0,angles.y,0))
end