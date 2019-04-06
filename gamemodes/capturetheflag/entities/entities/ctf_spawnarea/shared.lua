ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "SpawnArea"
ENT.Author = "Nefusadi"
ENT.Purpose = "Area in which people spawn"

ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:PhysicsUpdate( phys )
	local angles = phys:GetAngles()
	phys:GetEntity():SetAngles(Angle(0,angles.y,0))
	phys:SetAngles(Angle(0,angles.y,0))
end