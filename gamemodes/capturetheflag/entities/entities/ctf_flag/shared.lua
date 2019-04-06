ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Flag"
ENT.Author = "Nefusadi"
ENT.Purpose = "Flag for Capturing"

ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:Think()
	if SERVER then
		if self.Entity.IsHeld and not self.Entity.Carrier:Alive() then
			self.Entity.IsHeld = false
			self.Entity.Carrier = NULL
			self.Entity:PhysWake()
			self.Entity:SetParent()
			self.Entity:SetAngles(Angle(0,0,0))
			self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			self.DroppedTime = CurTime()
	
			BroadcastFlagDropped(self.Entity:GetNWInt("Team"))
		elseif not self.Entity.IsHeld and not self.Entity.IsOnBase and CurTime() - self.DroppedTime > 15 then
			self.Entity:ReturnFlag()
			BroadcastFlagReturned(self.Entity:GetNWInt("Team"))
		end
	
		if self.Entity.Carrier == NULL or self.Entity.Carrier == nil then
			self.Entity.IsHeld = false
		end
	end

	if self.Entity:GetNWInt("Team") == 1 then
		self.Entity:SetSkin(0)
	elseif self.Entity:GetNWInt("Team") == 2 then
		self.Entity:SetSkin(1)
	end

	if (SERVER and IsValid(self.Entity.Carrier)) or (CLIENT and IsValid(FlagCarrier[self.Entity:GetNWInt("Team")])) then
		local ent = NULL
		if SERVER then
			ent = self.Entity.Carrier
		else
			ent = FlagCarrier[self.Entity:GetNWInt("Team")]
		end

		local angles = ent:GetAngles()
		angles.p = 0
		angles.r = 0
		self.Entity:SetAngles(angles)

		self.Entity:SetPos(ent:GetPos() - angles:Forward() * 10)
	end

	local numFrames = self.Entity:GetFlexNum()

	if numFrames == 0 then return end

	local totalTime = 2
	local frameTime = totalTime / numFrames

	local animTime = CurTime() % totalTime

	for i=0,(numFrames-1) do
		local progress = animTime / frameTime - i
		if progress <= 0 or progress > 1 then
			progress = 0
		end
		local prev = i - 1
		if prev < 0 then
			prev = numFrames - 1
		end
		self.Entity:SetFlexWeight(i, progress)
		if (progress > 0) then
			self.Entity:SetFlexWeight(prev, 1 - progress)
			return
		end
	end
end