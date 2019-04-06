BeginNoise = Sound("ambient/levels/streetwar/city_battle13.wav")

-- function buyEntity(ply, cmd, args)

	-- if(args[1] != nil) then
		-- local ent = ents.Create(args[1])
		-- local tr = ply:GetEyeTrace()
		
		-- if(ent:IsValid()) then
		
		
		
		-- end
	-- end

-- end

function setPlayerClass(ply, cmd, args)

	if(args[nil]) then
		return
	else
		ply:SetNWInt("playerClass", tonumber(args[1]))
		--ply:Kill()
	end
	
end
concommand.Add("ctf_setclass",setPlayerClass)