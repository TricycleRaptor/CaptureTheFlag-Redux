surface.CreateFont( "ScoreboardDefault", {
	font	= "Helvetica",
	size	= 22,
	weight	= 800
} )

surface.CreateFont( "ScoreboardDefaultTitle", {
	font	= "Helvetica",
	size	= 32,
	weight	= 800
} )

--
-- This defines a new panel type for the player row. The player row is given a player
-- and then from that point on it pretty much looks after itself. It updates player info
-- in the think function, and removes itself when the player leaves the server.
--
local PLAYER_LINE = {
	Init = function( self )

		self.AvatarButton = self:Add( "DButton" )
		self.AvatarButton:Dock( LEFT )
		self.AvatarButton:SetSize( 32, 32 )
		self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

		self.Avatar = vgui.Create( "AvatarImage", self.AvatarButton )
		self.Avatar:SetSize( 32, 32 )
		self.Avatar:SetMouseInputEnabled( false )

		self.Name = self:Add( "DLabel" )
		self.Name:Dock( FILL )
		self.Name:SetFont( "ScoreboardDefault" )
		self.Name:SetTextColor( Color( 93, 93, 93 ) )
		self.Name:DockMargin( 8, 0, 0, 0 )

		self.Mute = self:Add( "DImageButton" )
		self.Mute:SetSize( 32, 32 )
		self.Mute:Dock( RIGHT )

		self.Ping = self:Add( "DLabel" )
		self.Ping:Dock( RIGHT )
		self.Ping:SetWidth( 50 )
		self.Ping:SetFont( "ScoreboardDefault" )
		self.Ping:SetTextColor( Color( 93, 93, 93 ) )
		self.Ping:SetContentAlignment( 5 )

		self.Deaths = self:Add( "DLabel" )
		self.Deaths:Dock( RIGHT )
		self.Deaths:SetWidth( 50 )
		self.Deaths:SetFont( "ScoreboardDefault" )
		self.Deaths:SetTextColor( Color( 93, 93, 93 ) )
		self.Deaths:SetContentAlignment( 5 )

		self.Kills = self:Add( "DLabel" )
		self.Kills:Dock( RIGHT )
		self.Kills:SetWidth( 50 )
		self.Kills:SetFont( "ScoreboardDefault" )
		self.Kills:SetTextColor( Color( 93, 93, 93 ) )
		self.Kills:SetContentAlignment( 5 )

		self:Dock( TOP )
		self:DockPadding( 3, 3, 3, 3 )
		self:SetHeight( 32 + 3 * 2 )
		self:DockMargin( 2, 0, 2, 2 )

	end,

	Setup = function( self, pl )

		self.Player = pl

		self.Avatar:SetPlayer( pl )

		self:Think( self )

		--local friend = self.Player:GetFriendStatus()
		--MsgN( pl, " Friend: ", friend )

	end,

	Think = function( self )

		if ( !IsValid( self.Player ) or self.Team != self.Player:Team()) then
			self:SetZPos( 9999 ) -- Causes a rebuild
			self:Remove()
			return
		end

		if ( self.PName == nil || self.PName != self.Player:Nick() ) then
			self.PName = self.Player:Nick()
			self.Name:SetText( self.PName )
		end
		
		if ( self.NumKills == nil || self.NumKills != self.Player:Frags() ) then
			self.NumKills = self.Player:Frags()
			self.Kills:SetText( self.NumKills )
		end

		if ( self.NumDeaths == nil || self.NumDeaths != self.Player:Deaths() ) then
			self.NumDeaths = self.Player:Deaths()
			self.Deaths:SetText( self.NumDeaths )
		end

		if ( self.NumPing == nil || self.NumPing != self.Player:Ping() ) then
			self.NumPing = self.Player:Ping()
			self.Ping:SetText( self.NumPing )
		end

		--
		-- Change the icon of the mute button based on state
		--
		if ( self.Muted == nil || self.Muted != self.Player:IsMuted() ) then

			self.Muted = self.Player:IsMuted()
			if ( self.Muted ) then
				self.Mute:SetImage( "icon32/muted.png" )
			else
				self.Mute:SetImage( "icon32/unmuted.png" )
			end

			self.Mute.DoClick = function() self.Player:SetMuted( !self.Muted ) end

		end

		--
		-- Connecting players go at the very bottom
		--
		if ( self.Player:Team() == TEAM_CONNECTING ) then
			self:SetZPos( 2000 + self.Player:EntIndex() )
			return
		end

		--
		-- This is what sorts the list. The panels are docked in the z order,
		-- so if we set the z order according to kills they'll be ordered that way!
		-- Careful though, it's a signed short internally, so needs to range between -32,768k and +32,767
		--
		self:SetZPos( self.Player:EntIndex() )

	end,

	Paint = function( self, w, h )

		if ( !IsValid( self.Player ) ) then
			return
		end

		--
		-- We draw our background a different colour based on the status of the player
		--
		local baseColor = team.GetColor(self.Player:Team())

		if ( self.Player:Team() == TEAM_CONNECTING ) then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 200, 200, 200, 200 ) )
			return
		end

		if ( !self.Player:Alive() ) then
			local drawColor = baseColor
			drawColor.r = math.max(drawColor.r - 100, 0)
			drawColor.g = math.max(drawColor.r - 100, 0)
			drawColor.b = math.max(drawColor.r - 100, 0)
			draw.RoundedBox( 4, 0, 0, w, h, drawColor )
			return
		end

		if ( self.Player:IsAdmin() ) then
			draw.RoundedBox( 4, 0, 0, w, h, Color( 230, 255, 230, 255 ) )
			return
		end

		draw.RoundedBox( 4, 0, 0, w, h, baseColor )

	end
}

--
-- Convert it from a normal table into a Panel Table based on DPanel
--
PLAYER_LINE = vgui.RegisterTable( PLAYER_LINE, "DPanel" )

--
-- Here we define a new panel table for the scoreboard. It basically consists
-- of a header and a scrollpanel - into which the player lines are placed.
--
local SCORE_BOARD = {
	Init = function( self )

		self.Header = self:Add( "Panel" )
		self.Header:Dock( TOP )
		self.Header:SetHeight( 100 )

		self.Name = self.Header:Add( "DLabel" )
		self.Name:SetFont( "ScoreboardDefaultTitle" )
		self.Name:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Name:Dock( TOP )
		self.Name:SetHeight( 40 )
		self.Name:SetContentAlignment( 5 )
		self.Name:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		--self.NumPlayers = self.Header:Add( "DLabel" )
		--self.NumPlayers:SetFont( "ScoreboardDefault" )
		--self.NumPlayers:SetTextColor( Color( 255, 255, 255, 255 ) )
		--self.NumPlayers:SetPos( 0, 100 - 30 )
		--self.NumPlayers:SetSize( 300, 30 )
		--self.NumPlayers:SetContentAlignment( 4 )

		self.RedLabel = self:Add( "DLabel" )
		self.RedLabel:SetFont( "ScoreboardDefaultTitle" )
		self.RedLabel:SetTextColor( Color( 255, 150, 150, 255 ) )
		self.RedLabel:SetText("Red Team")
		self.RedLabel:Dock( TOP )
		self.RedLabel:SetHeight( 40 )
		self.RedLabel:SetContentAlignment( 7 )
		self.RedLabel:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		self.Scores = {}

		self.Scores[1] = self:Add( "DScrollPanel" )
		self.Scores[1]:SetHeight(ScrH() / 6)
		self.Scores[1]:Dock( TOP )

		self.BlueLabel = self:Add( "DLabel" )
		self.BlueLabel:SetFont( "ScoreboardDefaultTitle" )
		self.BlueLabel:SetTextColor( Color( 150, 150, 255, 255 ) )
		self.BlueLabel:SetText("Blue Team")
		self.BlueLabel:Dock( TOP )
		self.BlueLabel:SetHeight( 40 )
		self.BlueLabel:SetContentAlignment( 7 )
		self.BlueLabel:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		self.Scores[2] = self:Add( "DScrollPanel" )
		self.Scores[2]:SetHeight(ScrH() / 6)
		self.Scores[2]:Dock( TOP )

		self.SpecLabel = self:Add( "DLabel" )
		self.SpecLabel:SetFont( "ScoreboardDefaultTitle" )
		self.SpecLabel:SetTextColor( Color( 200, 200, 200, 255 ) )
		self.SpecLabel:SetText("Spectators")
		self.SpecLabel:Dock( TOP )
		self.SpecLabel:SetHeight( 40 )
		self.SpecLabel:SetContentAlignment( 7 )
		self.SpecLabel:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		self.Scores[3] = self:Add( "DScrollPanel" )
		self.Scores[3]:SetHeight(ScrH() / 6)
		self.Scores[3]:Dock( TOP )

		self.JoinLabel = self:Add( "DLabel" )
		self.JoinLabel:SetFont( "ScoreboardDefaultTitle" )
		self.JoinLabel:SetTextColor( Color( 150, 150, 150, 255 ) )
		self.JoinLabel:SetText("Joining")
		self.JoinLabel:Dock( TOP )
		self.JoinLabel:SetHeight( 40 )
		self.JoinLabel:SetContentAlignment( 7 )
		self.JoinLabel:SetExpensiveShadow( 2, Color( 0, 0, 0, 200 ) )

		self.Scores[0] = self:Add( "DScrollPanel" )
		self.Scores[0]:SetHeight(ScrH() / 6)
		self.Scores[0]:Dock( TOP )
	end,

	PerformLayout = function( self )

		self:SetSize( 700, ScrH() - 200 )
		self:SetPos( ScrW() / 2 - 350, 100 )

	end,

	Paint = function( self, w, h )

		--draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

	end,

	Think = function( self, w, h )

		self.Name:SetText( GetHostName() )

		--
		-- Loop through each player, and if one doesn't have a score entry - create it.
		--
		local plyrs = player.GetAll()
		for id, pl in pairs( plyrs ) do

			if ( IsValid( pl.ScoreEntry ) ) then
				continue
			end

			pl.ScoreEntry = vgui.CreateFromTable( PLAYER_LINE, pl.ScoreEntry )
			pl.ScoreEntry.Team = pl:Team()
			pl.ScoreEntry:Setup( pl )

			local plyTeam = pl:Team()
			if plyTeam < 0 or plyTeam > 3 then
				plyTeam = 0
			end

			self.Scores[plyTeam]:AddItem( pl.ScoreEntry )

		end

	end
}

SCORE_BOARD = vgui.RegisterTable( SCORE_BOARD, "EditablePanel" )

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardShow( )
	Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function ScoreboardShow()

	if ( !IsValid( g_Scoreboard ) ) then
		g_Scoreboard = vgui.CreateFromTable( SCORE_BOARD )
	end

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Show()
		g_Scoreboard:MakePopup()
		g_Scoreboard:SetKeyboardInputEnabled( false )
	end

end
hook.Add("ScoreboardShow", "CTF_ScoreboardShow", ScoreboardShow)
--[[---------------------------------------------------------
	Name: gamemode:ScoreboardHide( )
	Desc: Hides the scoreboard
-----------------------------------------------------------]]
function ScoreboardHide()

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Hide()
	end

end
hook.Add("ScoreboardHide", "CTF_ScoreboardHide", ScoreboardHide)
--[[---------------------------------------------------------
	Name: gamemode:HUDDrawScoreBoard( )
	Desc: If you prefer to draw your scoreboard the stupid way (without vgui)
-----------------------------------------------------------]]
function GM:HUDDrawScoreBoard()
end
