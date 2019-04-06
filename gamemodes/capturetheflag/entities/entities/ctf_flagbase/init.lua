AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/ctf_flagbase/ctf_flagbase.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity.IsBase = true
	self.Entity.HasFlag = true
end

function ENT:Think()
	local capturePoint = self.Entity:GetPos() + self.Entity:GetUp() * 10

	local flag = self.Entity.Flag
	local otherFlag = self.Entity.OtherFlag
	local hasFlag = self.Entity.HasFlag
	local carrier = NULL

	if IsValid(otherFlag) then
		carrier = otherFlag.Carrier
	end

	if flag:IsValid() and IsValid(otherFlag) and IsValid(carrier) and (carrier:GetPos() - capturePoint):Length() < 50 and hasFlag then
		otherFlag:ReturnFlag()

		local winTeam = self.Entity:GetNWInt("Team")
		TeamScored(winTeam)
	end
end