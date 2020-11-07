totalServerVehicles = GetConVarNumber("sbox_maxvehicles")

function buyEntity(ply, cmd, args)

	if(args[1] != nil) then
		local ent = ents.Create(args[1])
		local tr = ply:GetEyeTraceNoCursor()
		local pos = tr.HitPos + Vector(0,0,30)
		
		local Angles = ply:GetAngles()
		Angles.pitch = 0
		Angles.roll = 0
		Angles.yaw = Angles.yaw + 180
		
		local balance = ply:GetNWInt("playerMoney")
		
		if(ent:IsValid()) then
			local ClassName = ent:GetClass()
		
			if(!tr.Hit) then return end
		
			local entCount = ply:GetNWInt(ClassName .. "count")
			
			if(balance >= ent.Cost) then
			
				ply:EmitSound("ambient/levels/labs/coinslot1.wav") --Serverside
			
				ply:SetNWInt("playerMoney", balance - ent.Cost)
				local plyAngles = ply:GetShootPos() + ply:GetForward() * 200
			
				ent.Owner = ply
				PropProtection.TeamMakePropOwner(ply:Team(), ent)
				ent:SetPos(pos)
				ent:SetAngles(Angle(Angles))
				ent:Spawn()
				ent:Activate()
			
				ply:SetNWInt(ClassName .. "count", entCount + 1)
			
			else
			
				ply:EmitSound("buttons/combine_button_locked.wav") --Serverside
			
			end
		
		end
	end
end
concommand.Add("ctf_buyentity", buyEntity)

function buyLFSVehicle(ply, cmd, args)

	if(args[1] != nil) then
		local ent = ents.Create(args[1])
		local tr = ply:GetEyeTraceNoCursor()
		local pos = tr.HitPos + Vector(0,0,200)
		
		local Angles = ply:GetAngles()
		Angles.pitch = 0
		Angles.roll = 0
		Angles.yaw = Angles.yaw + 180
		
		local balance = ply:GetNWInt("playerMoney")
		local totalPlayerVehicles = ply:GetCount("vehicles")
		
		if(ent:IsValid()) then
			local ClassName = ent:GetClass()
		
			if(!tr.Hit) then return end
		
			local entCount = ply:GetNWInt(ClassName .. "count")
			
			-- TO DO: 
			-- Make a new variable that encompasses all vehicles, since lfs uses sbox_maxsents and lfs uses sbox_maxvehicles
			
			if(balance >= ent.Cost and (totalPlayerVehicles < totalServerVehicles)) then
			
				ply:EmitSound("ambient/levels/labs/coinslot1.wav") --Serverside
				ply:SetNWInt("playerMoney", balance - ent.Cost)
				
				ent:CPPISetOwner(ply,ent)
				PropProtection.TeamMakePropOwner(ply:Team(), ent)
				
				ent:SetPos(pos)
				ent:SetAngles(Angle(Angles))
				ent:Spawn()
				ent:Activate()

				ply:AddCleanup( "vehicles", Ent )
			
			elseif (totalPlayerVehicles >= totalServerVehicles) then

				ply:EmitSound("buttons/combine_button_locked.wav") --Serverside
				ply:ChatPrint( "[CTF]: You have hit your personal vehicle limit." )

			else
			
				ply:EmitSound("buttons/combine_button_locked.wav") --Serverside
			
			end
		
		end
	end
end
concommand.Add("ctf_LFS_buyvehicle", buyLFSVehicle)

function buyPrewarVehicle( ply, vname, tr )

	local balance = ply:GetNWInt("playerMoney")
	local totalPlayerVehicles = ply:GetCount("vehicles")

	if not vname then return end

	local Tickrate = 1 / engine.TickInterval()
	
	local vehiclePrewarPrewarList = list.Get( "simfphys_ctf_prewar" )
	local vehiclePrewar = vehiclePrewarPrewarList[ vname ]

	if not vehiclePrewar then return end
	
	if ((balance >= vehiclePrewar["Cost"]) and (totalPlayerVehicles < totalServerVehicles)) then
	
		ply:EmitSound("ambient/levels/labs/coinslot1.wav")
		ply:SetNWInt("playerMoney", balance - vehiclePrewar["Cost"])
	
		if not tr then
			tr = ply:GetEyeTraceNoCursor()
		end

		local Angles = ply:GetAngles()
		Angles.pitch = 0
		Angles.roll = 0
		Angles.yaw = Angles.yaw + 180 + (vehiclePrewar.SpawnAngleOffset and vehiclePrewar.SpawnAngleOffset or 0)

		local pos = tr.HitPos + Vector(0,0,25) + (vehiclePrewar.SpawnOffset or Vector(0,0,0))

		local Ent = simfphys.SpawnVehicle( ply, pos, Angles, vehiclePrewar.Model, vehiclePrewar.Class, vname, vehiclePrewar )
	
		if not IsValid( Ent ) then return end

		ply:AddCleanup( "vehicles", Ent )
	
	elseif (totalPlayerVehicles >= totalServerVehicles) then

		ply:EmitSound("buttons/combine_button_locked.wav") --Serverside
		ply:ChatPrint( "[CTF]: You have hit your personal vehicle limit." )

	else
	
		ply:EmitSound("buttons/combine_button_locked.wav")
	
	end
	
end
concommand.Add( "ctf_simfphys_buyprewar", function( ply, cmd, args ) buyPrewarVehicle( ply, args[1] ) end )

function buyReconVehicle( ply, vname, tr )

	local balance = ply:GetNWInt("playerMoney")
	local totalPlayerVehicles = ply:GetCount("vehicles")

	if not vname then return end

	local Tickrate = 1 / engine.TickInterval()
	
	local vehicleReconList = list.Get( "simfphys_ctf_recon" )
	local vehicleRecon = vehicleReconList[ vname ]

	if not vehicleRecon then return end
	
	if ((balance >= vehicleRecon["Cost"]) and (totalPlayerVehicles < totalServerVehicles)) then
	
		ply:EmitSound("ambient/levels/labs/coinslot1.wav")
		ply:SetNWInt("playerMoney", balance - vehicleRecon["Cost"])
	
		if not tr then
			tr = ply:GetEyeTraceNoCursor()
		end

		local Angles = ply:GetAngles()
		Angles.pitch = 0
		Angles.roll = 0
		Angles.yaw = Angles.yaw + 180 + (vehicleRecon.SpawnAngleOffset and vehicleRecon.SpawnAngleOffset or 0)

		local pos = tr.HitPos + Vector(0,0,25) + (vehicleRecon.SpawnOffset or Vector(0,0,0))

		local Ent = simfphys.SpawnVehicle( ply, pos, Angles, vehicleRecon.Model, vehicleRecon.Class, vname, vehicleRecon )
	
		if not IsValid( Ent ) then return end

		ply:AddCleanup( "vehicles", Ent )
	
	elseif (totalPlayerVehicles >= totalServerVehicles) then

		ply:EmitSound("buttons/combine_button_locked.wav") --Serverside
		ply:ChatPrint( "[CTF]: You have hit your personal vehicle limit." )

	else
	
		ply:EmitSound("buttons/combine_button_locked.wav")
	
	end
	
end
concommand.Add( "ctf_simfphys_buyrecon", function( ply, cmd, args ) buyReconVehicle( ply, args[1] ) end )

function buyTankVehicle( ply, vname, tr )

	local balance = ply:GetNWInt("playerMoney")
	local totalPlayerVehicles = ply:GetCount("vehicles")

	if not vname then return end

	local Tickrate = 1 / engine.TickInterval()
	
	local vehicleTankList = list.Get( "simfphys_ctf_tanks" )
	local vehicleTank = vehicleTankList[ vname ]

	if not vehicleTank then return end
	
	if ((balance >= vehicleTank["Cost"]) and (totalPlayerVehicles < totalServerVehicles)) then
	
		ply:EmitSound("ambient/levels/labs/coinslot1.wav")
		ply:SetNWInt("playerMoney", balance - vehicleTank["Cost"])
	
		if not tr then
			tr = ply:GetEyeTraceNoCursor()
		end

		local Angles = ply:GetAngles()
		Angles.pitch = 0
		Angles.roll = 0
		Angles.yaw = Angles.yaw + 180 + (vehicleTank.SpawnAngleOffset and vehicleTank.SpawnAngleOffset or 0)

		local pos = tr.HitPos + Vector(0,0,25) + (vehicleTank.SpawnOffset or Vector(0,0,0))

		local Ent = simfphys.SpawnVehicle( ply, pos, Angles, vehicleTank.Model, vehicleTank.Class, vname, vehicleTank )
	
		if not IsValid( Ent ) then return end

		ply:AddCleanup( "vehicles", Ent )
	
	elseif (totalPlayerVehicles >= totalServerVehicles) then

		ply:EmitSound("buttons/combine_button_locked.wav") --Serverside
		ply:ChatPrint( "[CTF]: You have hit your personal vehicle limit." )

	else
	
		ply:EmitSound("buttons/combine_button_locked.wav")
	
	end
	
end
concommand.Add( "ctf_simfphys_buytank", function( ply, cmd, args ) buyTankVehicle( ply, args[1] ) end )

function setPlayerClass(ply, cmd, args)
	
	if(args[1] ~= nil) then
		ply:SetNWInt("playerClass", tonumber(args[1]))
	end
	
end
concommand.Add("ctf_setclass",setPlayerClass)

local function GiveCreditsAutoComplete( cmd, stringargs )
	
	stringargs = string.Trim(stringargs)
	stringargs = string.lower(stringargs)
	
	local tbl = {}
	
	for k,v in pairs(player.GetAll()) do
		local nick = v:Nick()
		if string.find( string.lower( nick ), stringargs ) then
			nick = "\"" .. nick .. "\""
			nick = "ctf_givecredits " .. nick
			
			table.insert(tbl, nick)
		end
	end
	
	return tbl
end

function giveCredits(ply, cmd, args)

	if ( !IsValid( ply ) ) then return end -- No dedicated server console support
	
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
	
		if(args[1] ~= nil and args[2] ~= nil) then
			
			for k,v in pairs(player.GetAll()) do
			
				if(v:Nick() == tostring(args[1])) then
					local curMoney = v:GetNWInt("playerMoney")
					local newMoney = curMoney + tonumber(args[2])
					v:SetNWInt("playerMoney", newMoney)
					v:ChatPrint("[CTF]: You were awarded " .. tonumber(args[2]) .. "cR from " .. ply:Nick() .. ".")
				end
				
			end
			
		end
		
	end

end
concommand.Add("ctf_givecredits", giveCredits, GiveCreditsAutoComplete, "Give the specified player credits.")

function ctf_setteam( ply, cmd, args, argStr)
	local teamNum = tonumber(args[1])
	if (teamNum == nil) then
		ply:ConCommand("ctf_team")
		return
	end

	teamNum = math.Round(teamNum)
	if (teamNum < 1) then
		teamNum = 1
	elseif teamNum > 2 then
		teamNum = 2
	end
	local teamName = "Red"
	if (teamNum == 2) then
		teamName = "Blue"
	end

	ply:SetTeam(0)
	
	for k,v in pairs(ply:GetChildren()) do
		if v.IsFlag then
			v:ReturnFlag()
			BroadcastFlagReturned(v:GetNWInt("Team"))
		end
	end

	ply:PrintMessage( HUD_PRINTTALK, "[CTF]: Welcome to the " .. teamName .. " Team, " .. ply:Nick() .. ".")
	if team.NumPlayers(teamNum) < 1 and !TeamSetUp[teamNum] then
		ply:ChatPrint( "[CTF]: Please select a location for your base." )
		ply.IsCaptain = true
	elseif team.NumPlayers(teamNum) >= 1 and !TeamSetUp[teamNum] then
		ply:ChatPrint( "[CTF]: Please wait for your team captain to pick a base location." )
		ply.IsCaptain = false
	end
	ply:UnSpectate()
	ply:SetTeam( teamNum )
	ply:Spawn()
 
end
concommand.Add( "ctf_setteam", ctf_setteam )

function ctf_spectate( ply )

	ply:SetTeam( 3 )
	ply:Spawn()
	ply:StripWeapons()
	ply:Spectate( OBS_MODE_ROAMING )
	ply:ConCommand("noclip")
	ply:ChatPrint( "[CTF]: Welcome, spectator." )

end
concommand.Add( "ctf_spectate", ctf_spectate )
