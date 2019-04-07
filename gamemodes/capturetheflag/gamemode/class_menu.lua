net.Receive("ClassMenu",function()

	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "[CTF] Class Selection Menu" )
	Frame:SetSize( 300, 470 )
	Frame:Center()
	Frame:MakePopup()
	Frame:ShowCloseButton(true)
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		draw.RoundedBox( 0, 0, 0, w, h, Color( 60, 60,60, 250 ) ) -- Draw a red box instead of the frame
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
		
		ply:ChatPrint( "[CTF]: Rifleman class selected. Loadout will be applied on respawn." )
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
		
		ply:ChatPrint( "[CTF]: Marksman class selected. Loadout will be applied on respawn." )
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
		
		ply:ChatPrint( "[CTF]: Gunner class selected. Loadout will be applied on respawn." )
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
		
		ply:ChatPrint( "[CTF]: Demolitionist class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end
	
	local Button5 = vgui.Create( "DButton", Frame )
	Button5:SetText( "Arsonist" )
	Button5:SetTextColor( Color( 255, 255, 255 ) )
	Button5:SetPos( 100, 250 )
	Button5:SetSize( 100, 30 )
	Button5.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
	end
	
	Button5.DoClick = function()
		
		-- Call player table value for arsonist
		RunConsoleCommand( "ctf_setclass", "6" )
		
		ply:ChatPrint( "[CTF]: Arsonist class selected. Loadout will be applied on respawn." )
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
		
		ply:ChatPrint( "[CTF]: Engineer class selected. Loadout will be applied on respawn." )
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
		
		ply:ChatPrint( "[CTF]: Scout class selected. Loadout will be applied on respawn." )
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
		
		ply:ChatPrint( "[CTF]: Medic class selected. Loadout will be applied on respawn." )
		Frame:Close()
		
	end

end)
