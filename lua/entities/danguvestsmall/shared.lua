ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Lightweight Vest"
ENT.Category		= "Ballistic Vests"
ENT.MdlRef			= "models/dayz/vest_police.mdl"
ENT.Cost			= 30

ENT.Spawnable		= true
ENT.AdminOnly = false
ENT.DoNotDuplicate = false
ENT.Editable = true

if SERVER then

AddCSLuaFile("shared.lua")

function ENT:Initialize()

	self.Entity:SetNWInt( 'VestKevlarDurability', 100 )

	local durabilvest = self.Entity:GetNWInt( 'VestKevlarDurability' )

	local model = ("models/dayz/vest_police.mdl")
	
	self.Entity:SetModel(model)
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	self.Entity:SetColor(Color(255,255,255,255))
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
end

function ENT:Use(activator, caller)
	
	if (activator:IsPlayer()) then
		if ( activator:GetNWBool("danguLWVest")==true ) then
			activator:PrintMessage(HUD_PRINTTALK, "You are already wearing this")
		return end
		activator:GetActiveWeapon():SendWeaponAnim( ACT_VM_DRAW )
		activator:PrintMessage(HUD_PRINTTALK, "Lightweight vest equipped.")
		
		if(GAMEMODE_NAME == "capturetheflag") then
		
		local plyClass = PLAYER_CLASSES[activator:GetNWInt("playerClass")]
		
			if (plyClass.name == "Machinegunner") or (plyClass.name == "Demolitionist") then
		
				activator:SetWalkSpeed(200)
				activator:SetRunSpeed(240)
				activator:SetJumpPower(200)
		
			else
		
				activator:SetWalkSpeed(200)
				activator:SetRunSpeed(275)
				activator:SetJumpPower(200)
		
			end
			
		else
		
			activator:SetWalkSpeed(200)
			activator:SetRunSpeed(400)
			activator:SetJumpPower(200)
			
		end
		
		activator:EmitSound("items/ammopickup.wav")
		activator:SetNWBool("danguLWVest",true)
		
		self.Entity:Remove()
		
		--detect other vests and remove them
		if ( activator:GetNWBool("danguBLVest")==true ) then --Ballistic Vest
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

		elseif ( activator:GetNWBool("danguHVVest")==true ) then --Heavy Vest
			activator:SetNWBool("danguHVVest",false)
			
			local ent = ents.Create("danguvestheavy")
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
