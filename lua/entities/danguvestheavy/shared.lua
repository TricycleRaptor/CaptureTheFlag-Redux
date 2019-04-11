ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Heavy Vest"
ENT.Category		= "Ballistic Vests"
ENT.MdlRef			= "models/danguyenvest/Elitevest.mdl"
ENT.Cost			= 100

ENT.Spawnable		= true
ENT.AdminOnly = false
ENT.DoNotDuplicate = false

if SERVER then

AddCSLuaFile("shared.lua")

function ENT:Initialize()

	self.Entity:SetNWInt( 'VestKevlarDurability', 100 )

	local durabilvest = self.Entity:GetNWInt( 'VestKevlarDurability' )

	local model = ("models/danguyenvest/Elitevest.mdl")
	
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
		if ( activator:GetNWBool("danguHVVest")==true ) then
			activator:PrintMessage(HUD_PRINTTALK, "You are already wearing this")
		return end
		activator:GetActiveWeapon():SendWeaponAnim( ACT_VM_DRAW )
		activator:PrintMessage(HUD_PRINTTALK, "Heavy vest equipped. You feel very encumbered")
		activator:SetWalkSpeed(125)
		activator:SetRunSpeed(250)
		activator:SetJumpPower(130)
		activator:EmitSound("items/ammopickup.wav")
		activator:SetNWBool("danguHVVest",true)
		
		
		self.Entity:Remove()
		
		--detect other vests and remove them
		if ( activator:GetNWBool("danguLWVest")==true ) then --Lightweight Vest
			activator:SetNWBool("danguLWVest",false)
			
			local ent = ents.Create("danguvestsmall")
			ent:SetPos(activator:GetPos() + Vector(0,0,15))
			ent:Spawn()
			ent:SetNWInt( 'VestKevlarDurability', activator:GetNWInt( 'DanguKevlarDurability' ) )
			
			if ent:GetNWInt( 'VestKevlarDurability' )<=20 then
				ent:SetColor(Color(255,160,160,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=40 then
				ent:SetColor(Color(255,180,180,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=60 then
				ent:SetColor(Color(255,200,200,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=80 then
				ent:SetColor(Color(255,230,230,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )>80 then
				ent:SetColor(Color(255,255,255,255))
			end
			
			ent:Activate()
			
		elseif ( activator:GetNWBool("danguBLVest")==true ) then --Ballistic Vest
			activator:SetNWBool("danguBLVest",false)
			
			local ent = ents.Create("danguvestnormal")
			ent:SetPos(activator:GetPos() + Vector(0,0,15))
			ent:Spawn()
			ent:SetNWInt( 'VestKevlarDurability', activator:GetNWInt( 'DanguKevlarDurability' ) )
			
			if ent:GetNWInt( 'VestKevlarDurability' )<=20 then
				ent:SetColor(Color(255,160,160,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=40 then
				ent:SetColor(Color(255,180,180,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=60 then
				ent:SetColor(Color(255,200,200,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=80 then
				ent:SetColor(Color(255,230,230,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )>80 then
				ent:SetColor(Color(255,255,255,255))
			end
			
			ent:Activate()
			
		elseif ( activator:GetNWBool("danguKevlarSuit")==true ) then --Kevlar Suit
			activator:SetNWBool("danguKevlarSuit",false)
			local ent = ents.Create("danguvestfullbody2")
			ent:SetPos(activator:GetPos())
			ent:Spawn()
			ent:Activate()
			activator:SetModel("models/player/police.mdl")
		elseif ( activator:GetNWBool("danguCMVest")==true ) then --Custom Vest
			activator:SetNWBool("danguCMVest",false)
			
			local ent = ents.Create("danguvestcustom")
			ent:SetPos(activator:GetPos() + Vector(0,0,15))
			ent:Spawn()
			ent:SetNWInt( 'VestKevlarDurability', activator:GetNWInt( 'DanguKevlarDurability' ) )
			
			if ent:GetNWInt( 'VestKevlarDurability' )<=20 then
				ent:SetColor(Color(255,160,160,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=40 then
				ent:SetColor(Color(255,180,180,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=60 then
				ent:SetColor(Color(255,200,200,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=80 then
				ent:SetColor(Color(255,230,230,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )>80 then
				ent:SetColor(Color(255,255,255,255))
			end
			
			ent:Activate()
			
		elseif ( activator:GetNWBool("danguStbVest")==true ) then --Stab Vest
			activator:SetNWBool("danguStbVest",false)
			
			local ent = ents.Create("danguveststab")
			ent:SetPos(activator:GetPos() + Vector(0,0,15))
			ent:Spawn()
			
			ent:SetNWInt( 'VestKevlarDurability', activator:GetNWInt( 'DanguKevlarDurability' ) )
			
			if ent:GetNWInt( 'VestKevlarDurability' )<=20 then
				ent:SetColor(Color(255,160,160,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=40 then
				ent:SetColor(Color(255,180,180,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=60 then
				ent:SetColor(Color(255,200,200,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )<=80 then
				ent:SetColor(Color(255,230,230,255))
			elseif ent:GetNWInt( 'VestKevlarDurability' )>80 then
				ent:SetColor(Color(255,255,255,255))
			end
			
			ent:Activate()
			
		end
		
		activator:SetNWInt( 'DanguKevlarDurability', self.Entity:GetNWInt( 'VestKevlarDurability' ) )
	end
end

end
print("The vest works!")