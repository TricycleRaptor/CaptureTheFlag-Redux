include( 'cl_scoreboard.lua' )
include( 'shared.lua' )
include( 'ordnance_menu.lua' )

BeginNoise = Sound("ctf/intro.wav")
DeployNoise = Sound("ambient/levels/streetwar/city_battle13.wav")
BaseAppear = Sound("npc/scanner/scanner_nearmiss2.wav")
ScoreNoise = Sound("ctf/captured.wav")
PickupNoise = Sound("ctf/taken.wav")
DropNoise = Sound("ctf/dropped.wav")
ReturnNoise = Sound("ctf/recovered.wav")
//LoseNoise = Sound("")
//WinNoise = Sound("")

LocalPlayer().canbuild = 1
LocalPlayer().canbuy = 1

MatchHasBegun = false
BaseSet = {false, false}
FlagsDropped = {false, false}
FlagsCarried = {false, false}
Scores = {0,0}

FlagCarrier = {NULL, NULL}
Icon = {NULL, NULL}
IconDropped = {NULL, NULL}
IconCarried = {NULL, NULL}

TimeLeft = 0
ShowPP = false

IconTimer = {0,0}

WinTime = -5
DeathTime = -10
RespawnTime = 10

for i=1,2 do
	Icon[i] = vgui.Create( "DImage" )
	Icon[i]:SetImage( "icons/flag_icon.png" )
	Icon[i]:SetImageColor( Color(150,150,150,150) )
	--Icon[i]:Show()

	IconCarried[i] = vgui.Create( "DImage" )
	IconCarried[i]:SetImage( "icons/flag_icon_carried.png" )
	IconCarried[i]:Show() // Might not be necessary
	IconCarried[i]:SetVisible(false)

	IconDropped[i] = vgui.Create( "DImage" )
	IconDropped[i]:SetImage( "icons/flag_icon_dropped.png" )
	IconDropped[i]:Show()
	IconDropped[i]:SetVisible(false)
end

victoryLogo = vgui.Create( "DImage")
victoryText = vgui.Create( "DImage")

local function HandleUpdateAllValues(len, ply)

	MatchHasBegun = net.ReadBool()
	FlagCarrier[1] = net.ReadEntity()
	FlagCarrier[2] = net.ReadEntity()
	BaseSet[1] = net.ReadBool()
	BaseSet[2] = net.ReadBool()
	FlagsDropped[1] = net.ReadBool()
	FlagsDropped[2] = net.ReadBool()
	FlagsCarried[1] = net.ReadBool()
	FlagsCarried[2] = net.ReadBool()
	Scores[1] = net.ReadFloat()
	Scores[2] = net.ReadFloat()
	TimeLeft = net.ReadFloat()
	ShowPP = net.ReadBool()
	RespawnTime = net.ReadFloat()

	print("Data Received")

	for i=1,2 do
		local c = Color(255,75,75,255)
		if i == 2 then
			c = Color(75,75,255,255)
		end

		if BaseSet[i] then
			Icon[i]:SetImageColor( c )
		else
			Icon[i]:SetImageColor( Color(150,150,150,150) )
		end

		if FlagsDropped[i] then
			IconDropped[i]:SetVisible(true)
		else
			IconDropped[i]:SetVisible(false)
		end

		if FlagsCarried[i] then
			IconCarried[i]:SetVisible(true)
		else
			IconCarried[i]:SetVisible(false)
		end
	end
end
net.Receive("UpdateAllValues", HandleUpdateAllValues)

local function HandlePPUpdate()
	ShowPP = net.ReadBool()
end
net.Receive("UpdatePP", HandlePPUpdate)

local function HandleBaseSet(len, ply)
	local team = net.ReadFloat()
	LocalPlayer():EmitSound(BaseAppear)
	LocalPlayer().canbuild = 1
	BaseSet[team] = true

	local c = Color(255,75,75,255)
	if team == 2 then
		c = Color(75,75,255,255)
	end
	
	Icon[team]:SetImageColor(c)
	IconTimer[team] = CurTime()
end
net.Receive("BaseSet", HandleBaseSet)

local function HandleMatchBegin()

	MatchHasBegun = true
	LocalPlayer():EmitSound(BeginNoise)
	LocalPlayer():EmitSound(DeployNoise)
	
end
net.Receive("MatchBegin", HandleMatchBegin)

local function HandleFlagDropped(len, ply)
	local team = net.ReadFloat()
	FlagsDropped[team] = true
	FlagsCarried[team] = false
	FlagCarrier[team] = NULL
	LocalPlayer():EmitSound(DropNoise)
	IconDropped[team]:SetVisible(true)
	IconCarried[team]:SetVisible(false)
	IconTimer[team] = CurTime()
end
net.Receive("FlagDropped", HandleFlagDropped)

local function HandleFlagPickedUp(len, ply)
	local ply = net.ReadEntity()
	local team = 1
	if ply:Team() == 1 then
		team = 2
	end

	FlagsDropped[team] = false
	FlagsCarried[team] = true
	FlagCarrier[team] = ply

	IconCarried[team]:SetVisible(true)
	IconDropped[team]:SetVisible(false)
	IconTimer[team] = CurTime()

	LocalPlayer():EmitSound(PickupNoise)
end
net.Receive("FlagPickedUp", HandleFlagPickedUp)

local function HandleFlagReturned(len, ply)
	local team = net.ReadFloat()

	FlagsDropped[team] = false
	FlagsCarried[team] = false
	LocalPlayer():EmitSound(ReturnNoise)
	IconCarried[team]:SetVisible(false)
	IconDropped[team]:SetVisible(false)
	IconTimer[team] = CurTime()
	FlagCarrier[team] = NULL
end
net.Receive("FlagReturned", HandleFlagReturned)

local function HandleTeamScored(len, ply)
	local scoredTeam = net.ReadFloat()
	FlagsDropped = {false, false}
	FlagsCarried = {false, false}
	FlagCarrier = {NULL, NULL}
	local newScore = net.ReadFloat()
	Scores[scoredTeam] = newScore

	LocalPlayer():EmitSound(ScoreNoise)
	if scoredTeam != LocalPlayer():Team() && LocalPlayer():Team() <= 2 then
		//LocalPlayer():EmitSound(LoseNoise)
	elseif LocalPlayer():Team() <= 2 then
		//LocalPlayer():EmitSound(WinNoise)
	end

	for i=1,2 do
		IconCarried[i]:SetVisible(false)
		IconDropped[i]:SetVisible(false)
	end
end
net.Receive("TeamScored", HandleTeamScored)

local function HandleTimeUpdate(len, ply)
	TimeLeft = net.ReadFloat()
end
net.Receive("ctf_TimeUpdate", HandleTimeUpdate)

local function HandleGameEnded(len, ply)
	local winningTeam = net.ReadFloat()

	if winningTeam == 1 then
		victoryLogo:SetImage( "icons/red_win_logo.png" )
		victoryText:SetImage( "icons/red_win_text.png" )
	else
		victoryLogo:SetImage( "icons/blue_win_logo.png" )
		victoryText:SetImage( "icons/blue_win_text.png" )
	end

	victoryLogo:Show()
	victoryText:Show()

	WinTime = CurTime()
end
net.Receive("GameEnded", HandleGameEnded)

local function NotifyDeath()
	DeathTime = CurTime()
end
net.Receive("NotifyDeath", NotifyDeath)

local function UpdateRespawn()
	RespawnTime = net.ReadFloat()
end
net.Receive("UpdateRespawn", UpdateRespawn)

hook.Add( "PreDrawHalos", "CTF_OutlineHalos", function()

	-- Player halos
	if (LocalPlayer():GetEyeTrace()) then -- Determine entity player is looking at
		if(LocalPlayer():GetEyeTrace().Entity:IsPlayer()) then -- Determine if the entity is a player
			if(LocalPlayer():GetEyeTrace().Entity:Team() == 1) then -- Determine if the player is on red team
				halo.Add( {LocalPlayer():GetEyeTrace().Entity} , Color( 255, 71, 71 ), 3, 3, 1 ) -- Color red team
			elseif (LocalPlayer():GetEyeTrace().Entity:Team() == 2) then -- Determine if the player is on blue team
				halo.Add( {LocalPlayer():GetEyeTrace().Entity} , Color( 100, 100, 255 ), 3, 3, 1 ) -- Color blue team
			end
		end
	end 
	
	-- Vehicle halos
	if (LocalPlayer():GetEyeTrace()) then -- Determine entity player is looking at
		if(LocalPlayer():GetEyeTrace().Entity:IsVehicle()) then -- Determine if the entity is a vehicle
			if(LocalPlayer():GetEyeTrace().Entity:GetNWInt("OwningTeam") == 1) then -- Determine if the vehicle is owned by red team
				halo.Add( {LocalPlayer():GetEyeTrace().Entity} , Color( 255, 71, 71 ), 3, 3, 1 ) -- Color red team
			elseif (LocalPlayer():GetEyeTrace().Entity:GetNWInt("OwningTeam") == 2) then -- Determine if the vehicle is owned by blue team
				halo.Add( {LocalPlayer():GetEyeTrace().Entity} , Color( 100, 100, 255 ), 3, 3, 1 ) -- Color blue team
			end
		end
	end
	
	-- LFS Halos
	if (LocalPlayer():GetEyeTrace()) then -- Determine entity player is looking at
		if(LocalPlayer():GetEyeTrace().Entity:IsScripted() and LocalPlayer():GetEyeTrace().Entity:GetClass() ~= "ctf_spawnarea" and LocalPlayer():GetEyeTrace().Entity:GetClass() ~= "ctf_flag" and LocalPlayer():GetEyeTrace().Entity:GetClass() ~= "ctf_flagbase") then -- Determine if the entity is a vehicle and is not a flag
			if(LocalPlayer():GetEyeTrace().Entity:GetNWInt("OwningTeam") == 1) then -- Determine if the vehicle is owned by red team
				halo.Add( {LocalPlayer():GetEyeTrace().Entity} , Color( 255, 71, 71 ), 3, 3, 1 ) -- Color red team
			elseif (LocalPlayer():GetEyeTrace().Entity:GetNWInt("OwningTeam") == 2) then -- Determine if the player is owned by blue team
				halo.Add( {LocalPlayer():GetEyeTrace().Entity} , Color( 100, 100, 255 ), 3, 3, 1 ) -- Color blue team
			end
		end
	end
	
	-- No-Z Flag Halos
	-- local flagteam1 = {}
	-- local flagteam2 = {}

	-- for k, v in pairs(ents.FindByClass("ctf_flag")) do
		-- if v:GetNWInt("OwningTeam") == 1 then
			-- table.insert(flagteam1, v)
		-- elseif v:GetNWInt("OwningTeam") == 2 then
			-- table.insert(flagteam2, v)
		-- end
	-- endz
	
	-- for k, v in pairs(ents.FindByClass("ctf_flagbase")) do
		-- if v:GetNWInt("OwningTeam") == 1 then
			-- table.insert(flagteam1, v)
		-- elseif v:GetNWInt("OwningTeam") == 2 then
			-- table.insert(flagteam2, v)
		-- end
	-- end

	-- halo.Add(flagteam1, Color( 255, 71, 71 ), 2, 2, 1, true, true)
	-- halo.Add(flagteam2, Color( 100, 100, 255 ), 2, 2, 1, true, true)
	
end )

hook.Add("PreDrawEffects", "CTF_flagRender", function()

	local ang = LocalPlayer():EyeAngles()
	ang:RotateAroundAxis(ang:Forward(),90)
	ang:RotateAroundAxis(ang:Right(),90)

	local flagMat = Material( "icons/flag_icon.png" )
	
	local flag1vector = Vector(0,0,0)
	local flag2vector = Vector(0,0,0)

	for k, v in pairs(ents.FindByClass("ctf_flag")) do
		if v:GetNWInt("OwningTeam") == 1 then
		
			flag1vector = v:GetPos() 
			flag1vector = flag1vector + Vector(0,0,150)
			local flag1pos = flag1vector:ToScreen()
			
			cam.Start2D()
				surface.SetDrawColor( 255, 71, 71, 255 )
				surface.SetMaterial( flagMat )
				surface.DrawTexturedRect( flag1pos.x,flag1pos.y, 40,40)
			cam.End2D()
			
		elseif v:GetNWInt("OwningTeam") == 2 then
		
			flag2vector = v:GetPos()
			flag2vector = flag2vector + Vector(0,0,150)
			local flag2pos = flag2vector:ToScreen()
			
			cam.Start2D()
				surface.SetDrawColor( 100, 100, 255, 255 )
				surface.SetMaterial( flagMat )
				surface.DrawTexturedRect( flag2pos.x,flag2pos.y, 40,40)
			cam.End2D()
			
		end
	end
	
end)

surface.CreateFont( "MyScoreAndTime", {
	size = ScrH() / 8,
	weight = 550,
	font = "Arial"
} )

surface.CreateFont( "RaptorFont", {
	size = ScrH() / 50,
	weight = 550,
	font = "Arial"
} )

function SpawnMenuOpen()
	if LocalPlayer().canbuild == 1 and LocalPlayer():Alive() then
		return true
	end

	return false
end
hook.Add("SpawnMenuOpen", "CTFSpawnMenu", SpawnMenuOpen)

local function RestrictMenu()

	LocalPlayer().canbuild = 0

end
net.Receive("RestrictMenu", RestrictMenu)

local function UnrestrictMenu()

	LocalPlayer().canbuild = 1

end
net.Receive("UnrestrictMenu", UnrestrictMenu)

local function UnrestrictOrdnanceMenu()

	LocalPlayer().canbuy = 1

end
net.Receive("UnrestrictOrdnanceMenu", UnrestrictOrdnanceMenu)

local function RestrictOrdnanceMenu()

	LocalPlayer().canbuy = 0

end
net.Receive("RestrictOrdnanceMenu", RestrictOrdnanceMenu)


function set_team()

	local buttonSizeY = ScrH() / 8
	local buttonSizeX = buttonSizeY * 510 / 260
	local spacing = ScrW() / 16;
	local frameWidth = (buttonSizeX + spacing) * 3

	if PickTeam != nil then
		PickTeam:Remove()
	end

	PickTeam = vgui.Create( "DFrame" )
	PickTeam:SetPos( ScrW() / 2 - frameWidth / 2, ScrH() / 2 - ScrH() / 4 )
	PickTeam:SetSize( frameWidth, ScrH() / 2 )
	PickTeam:SetTitle( "Choose your team" )
	PickTeam:SetVisible( true )
	PickTeam:SetDraggable( false )
	PickTeam:ShowCloseButton( false )
	PickTeam:MakePopup()

	local Image = vgui.Create( "DImage", PickTeam )
	Image:SetSize( frameWidth - 10, (frameWidth - 10) * 256 / 1024 )
	Image:SetPos( 5, 15 )
	Image:SetImage( "buttons/welcome.png" )

	grid = vgui.Create( "DGrid", PickTeam )
	grid:SetPos( spacing / 2, ScrH() / 2 - buttonSizeY * 3 / 2 )
	grid:SetCols( 3 )
	grid:SetRowHeight( buttonSizeX )
	grid:SetColWide( buttonSizeX + spacing )

	PickTeamR = vgui.Create( "DImageButton" )
	PickTeamR:SetSize( buttonSizeX, buttonSizeY )
	PickTeamR:SetImage( "buttons/red_button.png" )
	PickTeamR.DoClick = function()
		RunConsoleCommand( "ctf_setteam", "1" )
		PickTeam:Remove()
		PickTeam = nil
	end
	grid:AddItem(PickTeamR)

	PickTeamB = vgui.Create( "DImageButton" )
	PickTeamB:SetSize( buttonSizeX, buttonSizeY )
	PickTeamB:SetImage( "buttons/blue_button.png" )
	PickTeamB.DoClick = function()
		RunConsoleCommand( "ctf_setteam", "2" )
		PickTeam:Remove()
		PickTeam = nil
	end
	grid:AddItem(PickTeamB)

	PickTeamS = vgui.Create( "DImageButton", PickTeam )
	PickTeamS:SetSize( buttonSizeX, buttonSizeY )
	PickTeamS:SetImage( "buttons/spectators_button.png" ) 
	PickTeamS.DoClick = function()
		RunConsoleCommand( "ctf_spectate" )
		PickTeam:Remove()
		PickTeam = nil
	end
	grid:AddItem(PickTeamS)
end
concommand.Add( "ctf_start", set_team )

function PropProtection.HUDPaint()
	if not IsValid(LocalPlayer()) or not ShowPP then
		return
	end
	local tr = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
	if tr.HitNonWorld then
		if IsValid(tr.Entity) and not tr.Entity:IsPlayer() and not LocalPlayer():InVehicle() then
			local PropOwner = "Owner: "
			local OwnerTeam = tr.Entity:GetNWInt("OwningTeam", 0)
			if OwnerTeam == 1 then
				PropOwner = PropOwner .. "Red Team"
			elseif OwnerTeam == 2 then
				PropOwner = PropOwner .. "Blue Team"
			elseif OwnerTeam == 0 then
				PropOwner = PropOwner .. "N/A"
			else
				PropOwner = PropOwner .. "World"
			end
			surface.SetFont("Default")
			local w, h = surface.GetTextSize(PropOwner)
			w = w + 25
			draw.RoundedBox(4, ScrW() - (w + 8), (ScrH() / 2 - 150) - (8), w + 8, h + 8, Color(0, 0, 0, 150))
			draw.SimpleText(PropOwner, "Default", ScrW() - (w / 2) - 7, ScrH() / 2 - 150, Color(255, 255, 255, 255), 1, 1)
		end
	end
end
hook.Add("HUDPaint", "PropProtection.HUDPaint", PropProtection.HUDPaint)

function GM:ScoreboardShow()

end

function GM:ScoreboardHide()

end

function ButtonThink()

	if PickTeam == nil or not PickTeam:IsVisible() then
		return
	end

	if PickTeamR != null then
		if PickTeamR:IsDown() then
			PickTeamR:SetImage("buttons/red_button_down.png")
		else
			PickTeamR:SetImage("buttons/red_button.png")
			if PickTeamR.Hovered then
				PickTeamR:SetColor(Color(200,200,200,255))
			else
				PickTeamR:SetColor(Color(255,255,255,255))
			end
		end
	end

	if PickTeamB != null then
		if PickTeamB:IsDown() then
			PickTeamB:SetImage("buttons/blue_button_down.png")
		else
			PickTeamB:SetImage("buttons/blue_button.png")
			if PickTeamB.Hovered then
				PickTeamB:SetColor(Color(200,200,200,255))
			else
				PickTeamB:SetColor(Color(255,255,255,255))
			end
		end
	end

	if PickTeamS != null then
		if PickTeamS:IsDown() then
			PickTeamS:SetImage("buttons/spectators_button_down.png")
		else
			PickTeamS:SetImage("buttons/spectators_button.png")
			if PickTeamS.Hovered then
				PickTeamS:SetColor(Color(200,200,200,255))
			else
				PickTeamS:SetColor(Color(255,255,255,255))
			end
		end
	end

end
hook.Add("Think", "ButtonThink", ButtonThink)

function AlertThink()

	local TimeA = 0
	local SText = ""
	local MText = ""
	local ScoreA = 0
	local seconds = math.floor(TimeLeft) % 60
	local minutes = math.floor(TimeLeft / 60) % 60
	local hours = math.floor(TimeLeft / (60 * 60))
	local deathText = math.Max(RespawnTime - math.floor(CurTime() - DeathTime), 0)
	local deathAtCenter = 0

	if LocalPlayer():GetObserverMode() == OBS_MODE_NONE then
		deathText = "Respawn in\n"..deathText
		if (CurTime() - DeathTime > RespawnTime) then
			deathText = "Click to respawn"
		end
	end

	if LocalPlayer():GetObserverMode() == OBS_MODE_NONE then
		deathAtCenter = 1
	end

	local showDeath = !LocalPlayer():Alive()

	local holdingFlag1 = 0
	local team = LocalPlayer():Team()
	local otherTeam = 1
	if (team == 1) then
		otherTeam = 2
	end

	if (LocalPlayer() == FlagCarrier[otherTeam] && otherTeam == 1) then
		holdingFlag1 = 1
	end

	local holdingFlag2 = 0
	if (LocalPlayer() == FlagCarrier[otherTeam] && otherTeam == 2) then
		holdingFlag2 = 1
	end

	if !MatchHasBegun then
		TimeA = 255
	end

	if seconds < 10 then
		SText = "0"
	else
		SText = ""
	end

	if minutes < 10 then
		MText = "0"
	else
		MText = ""
	end

	local TimeText = "Setup: " .. hours .. ":" .. MText .. minutes .. ":" .. SText .. seconds
	local RedScore = Scores[1]
	local BlueScore = Scores[2]

	if MatchHasBegun then
		ScoreA = 255
	end

	local function TeamDisplay()
		local Scale1 = 2 - (CurTime() - IconTimer[1]) * 2
		local Scale2 = 2 - (CurTime() - IconTimer[2]) * 2
		if Scale1 < 1 then Scale1 = 1 end
		if Scale2 < 1 then Scale2 = 1 end

		local AlertSize1 = (ScrH() / 10) * Scale1
		local AlertSize2 = (ScrH() / 10) * Scale2

		Icon[1]:SetSize(AlertSize1, AlertSize1)
		Icon[1]:SetPos(ScrW() / 2 - AlertSize1 * 5 / 4, ScrH() - AlertSize1)
		Icon[2]:SetSize(AlertSize2, AlertSize2)
		Icon[2]:SetPos(ScrW() / 2 + AlertSize2 / 4, ScrH() - AlertSize2)

		local flash1 = 255 * holdingFlag1 * math.Round((CurTime() % .25) * 4)
		local flash2 = 255 * holdingFlag2 * math.Round((CurTime() % .25) * 4)

		IconCarried[1]:SetSize(AlertSize1, AlertSize1)
		IconCarried[1]:SetPos(ScrW() / 2 - AlertSize1 * 5 / 4, ScrH() - AlertSize1)
		IconCarried[1]:SetImageColor(Color(255,255,flash1,255))
		IconCarried[2]:SetSize(AlertSize2, AlertSize2)
		IconCarried[2]:SetPos(ScrW() / 2 + AlertSize2 / 4, ScrH() - AlertSize2)
		IconCarried[2]:SetImageColor(Color(255,255,flash2,255))

		IconDropped[1]:SetSize(AlertSize1, AlertSize1)
		IconDropped[1]:SetPos(ScrW() / 2 - AlertSize1 * 5 / 4, ScrH() - AlertSize1)
		IconDropped[2]:SetSize(AlertSize2, AlertSize2)
		IconDropped[2]:SetPos(ScrW() / 2 + AlertSize2 / 4, ScrH() - AlertSize2)

		surface.SetFont( "MyScoreAndTime" )
		local colonWidth, colonwHeight = surface.GetTextSize(":")
		local deathWidth, deathHeight = surface.GetTextSize(deathText)
		
		--draw.RoundedBox( 5, (ScrW() / 29), (ScrH()/ 140), 165, 53, Color(90, 90, 90, 110))
		draw.DrawText(TimeText, "RaptorFont", (ScrW() / 2.35), (ScrH()/ 90), Color(255,255,255,TimeA), TEXT_ALIGN_LEFT) --TimeA
		draw.SimpleText("Balance: " .. LocalPlayer():GetNWInt("playerMoney").. "cR", "RaptorFont", (ScrW() / 1.95), (ScrH()/ 90), Color(255, 255, 255, 255), 0)
		draw.DrawText(Scores[1], "RaptorFont", (ScrW() / 2.16 + colonWidth / 50), (ScrH()/ 90), Color(255,71,71,ScoreA), TEXT_ALIGN_LEFT) --ScoreA
		draw.DrawText(Scores[2], "RaptorFont", (ScrW() / 2.08 + colonWidth / 50), (ScrH()/ 90), Color(100,100,255,ScoreA), TEXT_ALIGN_LEFT) --ScoreA
		draw.DrawText("Scores: " .. "     -","RaptorFont", (ScrW() / 2.35), (ScrH()/ 90), Color(255, 255, 255, ScoreA), TEXT_ALIGN_LEFT) --ScoreA

		if (showDeath) then
			surface.SetDrawColor(65, 65, 65, 65)
			surface.DrawRect(0, 0, ScrW(), ScrH())
			draw.DrawText(deathText, "MyScoreAndTime", ScrW() / 2, deathAtCenter * (ScrH() / 2 - deathHeight / 2) + (1 - deathAtCenter) * deathHeight, Color(255,255,255,255), TEXT_ALIGN_CENTER)
		end
	end
	hook.Add("HUDPaint", "TeamDisplay", TeamDisplay)
end
hook.Add("Think", "AlertThink", AlertThink)


playedThunk = true
function VictoryThink()
	if CurTime() - WinTime > 7 then
		victoryLogo:Hide()
		victoryText:Hide()
                playedThunk = false
	else
		local LogoSize = 2 - (CurTime() - WinTime)
		if LogoSize < 1 then
			LogoSize = 1
		end
		local LogoAlpha = 2 - LogoSize

		local TextSize = 3 - (CurTime() - WinTime)
		if TextSize < 1 then
			TextSize = 1
		end
		local TextAlpha = 2 - TextSize
		if TextAlpha < 0 then
			TextAlpha = 0
		end

		local time = CurTime() - WinTime
		if (time > 1 and time < 1.5 and not playedThunk) then
			playedThunk = true
		elseif time > 1.5 and time < 2 then
			playedThunk = false
		elseif time > 2 and not playedThunk then
			playedThunk = true
		end

		victoryLogo:SetSize(LogoSize * ScrH() / 2, LogoSize * ScrH() / 2)
		victoryText:SetSize(TextSize * ScrH() / 2, TextSize * ScrH() / 2)

		victoryLogo:SetPos(ScrW() / 2 - (LogoSize * ScrH() / 2) / 2, ScrH() / 2 - (LogoSize * ScrH() / 2) / 2)
		victoryText:SetPos(ScrW() / 2 - (TextSize * ScrH() / 2) / 2, ScrH() / 2 - (TextSize * ScrH() / 2) / 2)

		victoryLogo:SetImageColor(Color(255,255,255,255 * LogoAlpha))
		victoryText:SetImageColor(Color(255,255,255,255 * TextAlpha))
	end
end
hook.Add("Think", "VictoryThink", VictoryThink)

function classMenu()

	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "[CTF] Class Selection Menu" )
	Frame:SetSize( 300, 470 )
	Frame:Center()
	Frame:MakePopup()
	Frame:ShowCloseButton(true)
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60,60, 255 ) ) -- Draw a red box instead of the frame
	end

	local Button1 = vgui.Create( "DButton", Frame )
	Button1:SetText( "Rifleman" )
	Button1:SetTextColor( Color( 255, 255, 255 ) )
	Button1:SetPos( 100, 50 )
	Button1:SetSize( 100, 30 )
	Button1.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end

	Button1.DoClick = function()
		
		-- Call player table value for rifleman
		RunConsoleCommand( "ctf_setclass", "2" )
		
		LocalPlayer():ChatPrint( "[CTF]: Rifleman class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end
	
	local Button2 = vgui.Create( "DButton", Frame )
	Button2:SetText( "Marksman" )
	Button2:SetTextColor( Color( 255, 255, 255 ) )
	Button2:SetPos( 100, 100 )
	Button2:SetSize( 100, 30 )
	Button2.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end
	
	Button2.DoClick = function()
		
		-- Call player table value for marksman
		RunConsoleCommand( "ctf_setclass", "3" )
		
		LocalPlayer():ChatPrint( "[CTF]: Marksman class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end
	
	local Button3 = vgui.Create( "DButton", Frame )
	Button3:SetText( "Gunner" )
	Button3:SetTextColor( Color( 255, 255, 255 ) )
	Button3:SetPos( 100, 150 )
	Button3:SetSize( 100, 30 )
	Button3.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end
	
	Button3.DoClick = function()
		
		-- Call player table value for gunner
		RunConsoleCommand( "ctf_setclass", "4" )
		
		LocalPlayer():ChatPrint( "[CTF]: Gunner class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end
	
	local Button4 = vgui.Create( "DButton", Frame )
	Button4:SetText( "Demolitionist" )
	Button4:SetTextColor( Color( 255, 255, 255 ) )
	Button4:SetPos( 100, 200 )
	Button4:SetSize( 100, 30 )
	Button4.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end
	
	Button4.DoClick = function()
		
		-- Call player table value for demolitionist
		RunConsoleCommand( "ctf_setclass", "5" )
		
		LocalPlayer():ChatPrint( "[CTF]: Demolitionist class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end
	
	local Button5 = vgui.Create( "DButton", Frame )
	Button5:SetText( "Support" )
	Button5:SetTextColor( Color( 255, 255, 255 ) )
	Button5:SetPos( 100, 250 )
	Button5:SetSize( 100, 30 )
	Button5.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end
	
	Button5.DoClick = function()
		
		-- Call player table value for support
		RunConsoleCommand( "ctf_setclass", "6" )
		
		LocalPlayer():ChatPrint( "[CTF]: Support class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end
	
	local Button6 = vgui.Create( "DButton", Frame )
	Button6:SetText( "Engineer" )
	Button6:SetTextColor( Color( 255, 255, 255 ) )
	Button6:SetPos( 100, 300 )
	Button6:SetSize( 100, 30 )
	Button6.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end
	
	Button6.DoClick = function()
		
		-- Call player table value for engineer
		RunConsoleCommand( "ctf_setclass", "7" )
		
		LocalPlayer():ChatPrint( "[CTF]: Engineer class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end
	
	local Button7 = vgui.Create( "DButton", Frame )
	Button7:SetText( "Scout" )
	Button7:SetTextColor( Color( 255, 255, 255 ) )
	Button7:SetPos( 100, 350 )
	Button7:SetSize( 100, 30 )
	Button7.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end
	
	Button7.DoClick = function()
		
		-- Call player table value for scout
		RunConsoleCommand( "ctf_setclass", "8" )
		
		LocalPlayer():ChatPrint( "[CTF]: Scout class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end
	
	local Button8 = vgui.Create( "DButton", Frame )
	Button8:SetText( "Medic" )
	Button8:SetTextColor( Color( 255, 255, 255 ) )
	Button8:SetPos( 100, 400 )
	Button8:SetSize( 100, 30 )
	Button8.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end
	
	Button8.DoClick = function()
		
		-- Call player table value for medic
		RunConsoleCommand( "ctf_setclass", "9" )
		
		LocalPlayer():ChatPrint( "[CTF]: Medic class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end

end
concommand.Add( "ctf_open_classmenu", classMenu )
