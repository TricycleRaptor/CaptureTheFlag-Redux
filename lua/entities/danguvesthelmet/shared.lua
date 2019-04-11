ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Combat Helmet"
ENT.Category		= "Ballistic Vests"
ENT.MdlRef			= "models/swat_helmets/swathelmet/camo_swat.mdl"
ENT.Cost			= 200

ENT.Spawnable		= true
ENT.AdminOnly = false
ENT.DoNotDuplicate = false

if SERVER then

AddCSLuaFile("shared.lua")

function ENT:Initialize()

	local model = ("models/swat_helmets/swathelmet/camo_swat.mdl")
	
	self.Entity:SetModel(model)
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
end

function ENT:Use(activator, caller)

	
	if (activator:IsPlayer()) then
		if ( activator:GetNWBool("danguCombatHelm")==true ) then
			activator:PrintMessage(HUD_PRINTTALK, "You are already wearing this")
		return end
		activator:GetActiveWeapon():SendWeaponAnim( ACT_VM_DRAW )
		activator:PrintMessage(HUD_PRINTTALK, "Helmet equipped. Your head is now protected")
		activator:EmitSound("items/ammopickup.wav")
		activator:SetNWBool("danguCombatHelm",true)
		
		self.Entity:Remove()
		
		if ( activator:GetNWBool("danguKevlarSuit")==true ) then --Kevlar Suit
			activator:SetNWBool("danguKevlarSuit",false)
			local ent = ents.Create("danguvestfullbody2")
			ent:SetPos(activator:GetPos())
			ent:Spawn()
			ent:Activate()
			activator:SetWalkSpeed(200)
			activator:SetRunSpeed(400)
			activator:SetJumpPower(200)
			activator:SetModel("models/player/police.mdl")
		end
	end
end

end
print("The helmet works!")