include("shared.lua")

function ENT:Draw()
	if self.Entity:GetNWInt("Team") == 1 then
		self.Entity:SetSkin(0)
	elseif self.Entity:GetNWInt("Team") == 2 then
		self.Entity:SetSkin(1)
	end

	self.Entity:DrawModel()
end