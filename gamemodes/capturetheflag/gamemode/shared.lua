GM.Name		= "CaptureTheFlag: Redux"
GM.Author	= "Nefusadi, TricycleRaptor"
GM.Email	= "arrinbevers@yahoo.com"
GM.Website  	= ""

DeriveGamemode( "sandbox" )
include( 'class_menu.lua' )

function GM:Initialize()
	team.SetUp( 1, "RedTeam", Color( 255, 100, 100, 255 ) ) //RedTeam
	team.SetUp( 2, "BlueTeam", Color( 100, 100, 255, 255 ) ) //BlueTeam
	team.SetUp( 3, "Spectator", Color( 125, 125, 125, 255 ) ) //Spectator
	team.SetUp( 4, "Joining", Color( 0, 0 , 0, 255 ) ) //Choosing Team
end

-------------------------------Prop Protection----------------------------

PropProtection = {}

-----------------------------Prop Protection End--------------------------
