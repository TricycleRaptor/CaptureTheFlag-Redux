AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity.IsFlag = true
	self.Entity.CanMove = 0
	self.Entity:SetModel("models/ctf_flag/ctf_flag.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

	self.Entity:SetTrigger(true)
end

function ENT:ReturnFlag()
	local flagBase = self.Entity.FlagBase
	if flagBase == NULL then return end

	self.Entity:SetParent()
	self.Entity:SetPos(flagBase:GetPos() + flagBase:GetUp() * 10)
	self.Entity:SetAngles(flagBase:GetAngles())
	self.Entity.IsHeld = false
	self.Entity.IsOnBase = true
	self.Entity.Carrier = NULL
	flagBase.HasFlag = true
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
end

function ENT:StartTouch(entity)
	if entity:IsValid() and entity:IsPlayer() and entity:Alive() and entity:Team() != self.Entity:GetNWInt("Team") and (entity:Team() == 1 or entity:Team() == 2) and not self.Entity.IsHeld and MatchHasBegun then
		self.Entity.IsHeld = true
		self.Entity.IsOnBase = false
		self.Entity.FlagBase.HasFlag = false
		self.Entity.Carrier = entity
		local angles = entity:GetAngles()
		angles.p = 0
		angles.r = 0
		self.Entity:SetPos(entity:GetPos() - angles:Forward() * 10)
		self.Entity:SetParent(entity)
		self.Entity:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

		BroadcastFlagPickedUp(entity)

	elseif entity:IsValid() and entity:IsPlayer() and entity:Alive() and entity:Team() == self.Entity:GetNWInt("Team") and !self.Entity.IsHeld and not self.Entity.IsOnBase then
		self.Entity:ReturnFlag()
		BroadcastFlagReturned(self.Entity:GetNWInt("Team"))
	end
end