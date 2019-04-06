include("shared.lua")

function ENT:Draw()

	local team = self.Entity:GetNWInt("Team")
	if team == 1 then
		self.Entity:SetSkin(0)
	elseif team == 2 then
		self.Entity:SetSkin(1)
	end

	if IsValid(FlagCarrier[team]) then
		local ent = FlagCarrier[team]
		local angles = ent:GetAngles()
		angles.p = 0
		angles.r = 0
		self.Entity:SetAngles(angles)

		self.Entity:SetPos(ent:GetPos() - angles:Forward() * 10)
	end

	if FlagCarrier[team] != LocalPlayer() || LocalPlayer():GetViewEntity() != LocalPlayer() then
		self.Entity:DrawModel()
	end
end