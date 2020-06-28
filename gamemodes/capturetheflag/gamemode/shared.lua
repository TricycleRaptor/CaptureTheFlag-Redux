GM.Name		= "CaptureTheFlag: Redux"
GM.Author	= "Nefusadi, TricycleRaptor"
GM.Email	= "arrinbevers@yahoo.com"
GM.Website  	= ""

DeriveGamemode( "sandbox" )

function GM:Initialize()
	team.SetUp( 1, "RedTeam", Color( 255, 100, 100, 255 ) ) //RedTeam
	team.SetUp( 2, "BlueTeam", Color( 100, 100, 255, 255 ) ) //BlueTeam
	team.SetUp( 3, "Spectator", Color( 125, 125, 125, 255 ) ) //Spectator
	team.SetUp( 4, "Joining", Color( 0, 0 , 0, 255 ) ) //Choosing Team
end

-------------------------------Prop Protection----------------------------

PropProtection = {}

-----------------------------Prop Protection End--------------------------

----------------------------------MoveMent--------------------------------
hook.Add("OnPlayerHitGround", "CTF.Land", function(ply, inWater, onFloater, speed)
	local pingTime = ply:Ping() * 0.001
	local lockTime = math.max(0.1 - pingTime, 0.01) -- account for player ping weirdness
	ply._landingTime = CurTime() + lockTime
end)

hook.Add("StartCommand", "CTF.LandMovement", function(ply, cmd)
	if ply._landingTime then
		if CurTime() <= ply._landingTime then
			cmd:ClearMovement()
			cmd:RemoveKey(IN_JUMP)
		else
			ply._landingTime = nil
		end
	end
end)
--------------------------------MoveMent End------------------------------
