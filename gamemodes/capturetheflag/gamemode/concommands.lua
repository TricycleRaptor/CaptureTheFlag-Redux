function buyEntity(ply, cmd, args)

	if(args[1] != nil) then
		local ent = ents.Create(args[1])
		local tr = ply:GetEyeTrace()
		
		if(ent:IsValid()) then
			local ClassName = ent:GetClass()
		
			if(!tr.Hit) then return end
		
			local entCount = ply:GetNWInt(ClassName .. "count")
			local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80
			
			ent.Owner = ply
			ent:SetPos(SpawnPos)
			ent:Spawn()
			ent:Activate()
			
			ply:SetNWInt(ClassName .. "count", entCount + 1)
		
		end
	end
end
concommand.Add("ctf_buyentity", buyEntity)

function setPlayerClass(ply, cmd, args)
	
	if(args[1] != nil) then
		ply:SetNWInt("playerClass", tonumber(args[1]))
	end
	
end
concommand.Add("ctf_setclass",setPlayerClass)

function setPlayerMoney(ply, cmd, args)
	
	if(args[1] != nil) then
		ply:SetNWInt("playerMoney", tonumber(args[1]))
	end
	
end
concommand.Add("ctf_setmoney",setPlayerClass)
