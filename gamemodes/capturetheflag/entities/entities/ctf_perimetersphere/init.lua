AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.scale = GetConVar("ctf_buildzonescale"):GetFloat()
	self.baseSize = 1000 * self.scale
	self.Entity:DrawShadow(false)
	self.Entity:SetModel("models/ctf_sphere/ctf_constructsphere.mdl")
	self.Entity:PhysicsInit(SOLID_NONE)
	self.Entity:SetMoveType(0)
	self.Entity.IsSphere = true
	self.Entity.CanMove = 0
	self.Entity:SetModelScale(self.scale, 0)
	self.Entity:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.Entity:SetColor(Color(0,0,0,0))
end

function ENT:Think()
	local sphericalents = {}
	
	for k,ent in pairs(ents.FindInSphere(self.Entity:GetPos(),1000 * GetConVar("ctf_buildzonescale"):GetFloat())) do
	
		if ent:IsValid() and ent:IsPlayer() and ent:Alive() and ent:Team() == self.Entity:GetNWInt("Team") then
			
			-- ent:ChatPrint( "[CTF]: You have entered your base." )
			-- Can open ordnance menu check
			
		elseif ent:IsValid() and ent:IsPlayer() and ent:Team() != self.Entity:GetNWInt("Team") and ent:Team() != 3 then
		
			-- ent:ChatPrint( "[CTF]: You have entered the enemy base." )
			
		end
		table.insert(sphericalents, ent)
		
	end

	for k,ent in pairs(ents.GetAll()) do
	
		local team = ent:GetNWInt("Team")
		if ent:IsPlayer() then
			team = ent:Team()
		end

		if ent:IsValid() and team == self.Entity:GetNWInt("Team") and table.HasValue(sphericalents,ent) == false then
			if ent:IsPlayer() then
				--ent:ExitVehicle()
				--ent:Spawn()
			elseif ent.IsBase then
				ent:SetPos(self.Entity:GetPos() + Vector(-100,0,10))
				ent:SetAngles(Angle(0,0,0))
			elseif ent.IsSpawnArea then
				ent:SetPos(self.Entity:GetPos() + Vector(100,0,5))
				ent:SetAngles(Angle(0,0,0))
			end
		end
		self.Entity:SetModelScale(GetConVar("ctf_buildzonescale"):GetFloat())
		
	end
end