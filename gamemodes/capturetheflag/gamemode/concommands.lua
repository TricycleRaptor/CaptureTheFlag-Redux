BuyNoise = Sound("buttons/button14.wav")
DenyNoise = Sound("buttons/button10.wav")

function buyEntity(ply, cmd, args)

	if(args[1] != nil) then
		local ent = ents.Create(args[1])
		local tr = ply:GetEyeTrace()
		local balance = ply:GetNWInt("playerMoney")
		
		if(ent:IsValid()) then
			local ClassName = ent:GetClass()
		
			if(!tr.Hit) then return end
		
			local entCount = ply:GetNWInt(ClassName .. "count")
			
			-- TO DO: 
			-- Add team entity count check
			-- Write separate function for buying vehicles to give the SetPos vector additional room on the X and Y coordinates so spawning a vehicle doesn't kill
			-- Troubleshoot Y coordinate in SetPos vector so vehicles do not get stuck in the ground on spawn
			
			if(balance >= ent.Cost) then
			
				ply:EmitSound("buttons/button14.wav") --Serverside
			
				ply:SetNWInt("playerMoney", balance - ent.Cost)
			
				ent.Owner = ply
				ent:SetPos(Vector((ply:GetShootPos() + ply:GetForward() * 200), 500, 500))
				ent:Spawn()
				ent:Activate()
			
				ply:SetNWInt(ClassName .. "count", entCount + 1)
			
			else
			
				ply:EmitSound("buttons/button10.wav") --Serverside
			
			end
		
		end
	end
end
concommand.Add("ctf_buyentity", buyEntity)

function buySimfphysVehicle( ply, vname, tr )

	if not vname then return end

	local Tickrate = 1 / engine.TickInterval()
	
	if ( Tickrate <= 25 ) and not ply.IsInformedAboutTheServersLowTickrate then
		ply:PrintMessage( HUD_PRINTTALK, "(SIMFPHYS) WARNING! Server tickrate is "..Tickrate.." we recommend 33 or greater for this addon to work properly!")
		ply:PrintMessage( HUD_PRINTTALK, "Known problems caused by a too low tickrate:")
		ply:PrintMessage( HUD_PRINTTALK, "- Wobbly suspension")
		ply:PrintMessage( HUD_PRINTTALK, "- Wheelspazz or shaking after an crash on bumps or while drifting")
		ply:PrintMessage( HUD_PRINTTALK, "- Moondrive (wheels turning slower than they should)")
		ply:PrintMessage( HUD_PRINTTALK, "- Worse vehicle performance (less grip, slower accelerating)")
		
		ply.IsInformedAboutTheServersLowTickrate = true
	end
	
	local VehicleList = list.Get( "simfphys_vehicles" )
	local vehicle = VehicleList[ vname ] -- Not working

	if not vehicle then return end
	
	if not tr then
		tr = ply:GetEyeTraceNoCursor()
	end

	local Angles = ply:GetAngles()
	Angles.pitch = 0
	Angles.roll = 0
	Angles.yaw = Angles.yaw + 180 + (vehicle.SpawnAngleOffset and vehicle.SpawnAngleOffset or 0)

	local pos = tr.HitPos + Vector(0,0,25) + (vehicle.SpawnOffset or Vector(0,0,0))

	local Ent = simfphys.SpawnVehicle( ply, pos, Angles, vehicle.Model, vehicle.Class, vname, vehicle )
	
	if not IsValid( Ent ) then return end

	ply:AddCleanup( "vehicles", Ent )
	
end
concommand.Add( "ctf_simfphys_buyvehicle", function( ply, cmd, args ) buySimfphysVehicle( ply, args[1] ) end )

local function VehicleMemDupe( ply, Entity, Data )
	table.Merge( Entity, Data )
end
duplicator.RegisterEntityModifier( "VehicleMemDupe", VehicleMemDupe )

function setPlayerClass(ply, cmd, args)
	
	if(args[1] != nil) then
		ply:SetNWInt("playerClass", tonumber(args[1]))
	end
	
end
concommand.Add("ctf_setclass",setPlayerClass)
