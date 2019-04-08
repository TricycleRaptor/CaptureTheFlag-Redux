function buyEntity(ply, cmd, args)

	if(args[1] != nil) then
		local ent = ents.Create(args[1])
		local tr = ply:GetEyeTrace()
		
		if(ent:IsValid()) then
			local ClassName = ent:GetClass()
		
			if(!tr.Hit) then return end
		
			local entCount = ply:GetNWInt(ClassName .. "count")
			
			-- TO DO: 
			-- Add team entity count check
			-- Write separate function for buying vehicles to give the SetPos vector additional room on the X and Y coordinates so spawning a vehicle doesn't kill
			-- Troubleshoot Y coordinate in SetPos vector so vehicles do not get stuck in the ground on spawn
			
			ent.Owner = ply
			ent:SetPos(Vector((ply:GetShootPos() + ply:GetForward() * 200), 500, 500))
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

-- TO DO:
-- Add set money console command for testing purchases easily from the ordnance menu in the future

