include( 'config/class_weapons.lua' )
include( 'config/secondary_weapons.lua' )
include( 'config/class_equipment.lua' )

ButtonNoise = Sound("buttons/lightswitch2.wav")
ChooseNoise = Sound("items/ammo_pickup.wav")
OpenNoise2 = Sound("npc/scanner/scanner_scan4.wav")
ConfirmNoise = Sound("buttons/button14.wav")
DenyNoise = Sound("buttons/button8.wav")

local selectedPrimary
local selectedSecondary
local selectedEquipment

function classMenu()

	local Frame = vgui.Create( "DFrame" )
		Frame:SetTitle( "[CTF]: Class Selection Menu" )
		Frame:SetSize( 800, 460 )
		Frame:Center()
		Frame:MakePopup()
		--Frame:ShowCloseButton(false)
		Frame:SetDraggable(true)

			if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
				Frame:ShowCloseButton(false)
			else
				Frame:ShowCloseButton(true)
			end

		LocalPlayer():EmitSound(OpenNoise2)

		Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 6, 0, 0, w, h, Color( 60, 60,60, 255 ) )
		end

		-- Rifleman button

		local Button1 = vgui.Create( "DButton", Frame )
			Button1:SetText( "Rifleman" )
			Button1:SetTextColor( Color( 255, 255, 255 ) )
			Button1:SetPos( 25, 50 )
			Button1:SetSize( 100, 30 )
			Button1.Paint = function( self, w, h )
				draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
		end

		Button1.DoClick = function()

		-- Begin Panels ---

			selectedPrimary = nil
			selectedSecondary = nil
			selectedEquipment = nil

			LocalPlayer():EmitSound(ButtonNoise)
			local broadPanel = Frame:Add("SelectionPanel")

			local classTitle = vgui.Create("DLabel",broadPanel)

			local classDescPanel = vgui.Create("DPanel", broadPanel)
				classDescPanel:SetPos(25,45)
				classDescPanel:SetSize(600,60)
				classDescPanel:SetBackgroundColor(Color(84,84,84))
				classDescPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(84,84,84) )
			end

			classTitle:SetSize(600,250)
			classTitle:SetPos(200,-100)
			classTitle:SetFont("DermaLarge")
			classTitle:SetText("[ Rifleman's Arsenal ]")

			local primaryDescription = vgui.Create("DLabel",classDescPanel)
			primaryDescription:SetSize(600,15)
			primaryDescription:SetText("PRIMARY: ...")
			primaryDescription:SetPos(10,10)

			local secondaryDescription = vgui.Create("DLabel",classDescPanel)
			secondaryDescription:SetSize(600,15)
			secondaryDescription:SetText("SECONDARY: ...")
			secondaryDescription:SetPos(10,25)

			local equipmentDescription = vgui.Create("DLabel",classDescPanel)
			equipmentDescription:SetSize(600,15)
			equipmentDescription:SetText("EQUIPMENT: ...")
			equipmentDescription:SetPos(10,40)

			local weaponIconPanel = vgui.Create("DPanel", broadPanel)
				weaponIconPanel:SetPos(25,125)
				weaponIconPanel:SetSize(600,175)
				weaponIconPanel:SetBackgroundColor(Color(84,84,84))
				weaponIconPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(65,65,65) )
			end

			local ConfirmButton = vgui.Create( "DButton", broadPanel )
				ConfirmButton:SetText( "CONFIRM" )
				ConfirmButton:SetTextColor( Color( 255, 255, 255 ) )
				ConfirmButton:SetPos( 270, 375 )
				ConfirmButton:SetSize( 120, 30 )
				ConfirmButton.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) )
			end

			ConfirmButton.DoClick = function()

				if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
					LocalPlayer():EmitSound(DenyNoise)
				else

					net.Start("receiveClassRequest")
						net.WriteInt(2, 5)
					net.SendToServer()

					net.Receive("receiveUpdatedClassData", function(len, ply)

						local confirmed = net.ReadBool()

						if(confirmed == true) then

							RunConsoleCommand("ctf_setclass", 2)

							net.Start("receivePrimaryWeapon")
								net.WriteTable(selectedPrimary)
							net.SendToServer()

							net.Start("receiveSecondaryWeapon")
								net.WriteTable(selectedSecondary)
							net.SendToServer()

							net.Start("receiveEquipment")
								net.WriteTable(selectedEquipment)
							net.SendToServer()

							LocalPlayer():EmitSound(ConfirmNoise)
							LocalPlayer():ChatPrint( "[CTF]: Rifleman class selected. Loadout will be applied on respawn." )
							Frame:Close()

						else

							LocalPlayer():EmitSound(DenyNoise)
							LocalPlayer():ChatPrint( "[CTF]: The class you are attempting to switch to is full." )

						end

					end)

				end

			end
			
			-- End Panels ---

			--- Begin Primary Weapon ---

			local riflemanPrimaryList = list.Get("weapons_rifleman_primary")

			local riflemanPrimary = vgui.Create( "DComboBox", broadPanel )
				riflemanPrimary:SetPos( 70, 310 )
				riflemanPrimary:SetSize( 150, 20 )
				riflemanPrimary:SetValue("Select Primary Weapon")

				local primaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				primaryIcon:SetSize( 400, 400)
				primaryIcon:SetPos(-60,-255)
				primaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0))
				function primaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(riflemanPrimaryList) do

					riflemanPrimary:AddChoice(v["Name"], v)

				end

				riflemanPrimary.OnSelect = function( self, index, value )

					selectedPrimary = riflemanPrimary:GetOptionData(index)
					primaryDescription:SetText("PRIMARY: " .. selectedPrimary.Description)
					
					selectedModel = selectedPrimary.Model

					primaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			--- End Primary Weapon ---

			--- Begin Secondary Weapon ---

			local riflemanSecondaryList = list.Get("ctf_sidearms")
			
			local riflemanSecondary = vgui.Create( "DComboBox", broadPanel )
				riflemanSecondary:SetPos( 255, 310 )
				riflemanSecondary:SetSize( 150, 20 )
				riflemanSecondary:SetValue("Select Secondary Weapon")

				local secondaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				secondaryIcon:SetSize( 600, 600)
				secondaryIcon:SetPos(0,-425)
				secondaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function secondaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(riflemanSecondaryList) do

					riflemanSecondary:AddChoice(v["Name"], v)

				end

				riflemanSecondary.OnSelect = function( self, index, value )

					selectedSecondary = riflemanSecondary:GetOptionData(index)
					secondaryDescription:SetText("SECONDARY: " .. selectedSecondary.Description)

					selectedModel = selectedSecondary.Model

					secondaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- Begin Equipment --

			local riflemanEquipmentList = list.Get("grenades_list")
			
			local riflemanEquipment = vgui.Create( "DComboBox", broadPanel )
				riflemanEquipment:SetPos( 440, 310 )
				riflemanEquipment:SetSize( 150, 20 )
				riflemanEquipment:SetValue("Select Equipment")

				local equipmentIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				equipmentIcon:SetSize( 600, 600)
				equipmentIcon:SetPos(165,-425)
				equipmentIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function equipmentIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(riflemanEquipmentList) do

					riflemanEquipment:AddChoice(v["Name"], v)

				end

				riflemanEquipment.OnSelect = function( self, index, value )

					selectedEquipment = riflemanEquipment:GetOptionData(index)
					equipmentDescription:SetText("EQUIPMENT: " .. selectedEquipment.Description)

					selectedModel = selectedEquipment.Model

					equipmentIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- End Equipment
		
		end

		-- Marksman button
	
		local Button2 = vgui.Create( "DButton", Frame )
			Button2:SetText( "Marksman" )
			Button2:SetTextColor( Color( 255, 255, 255 ) )
			Button2:SetPos( 25, 100 )
			Button2:SetSize( 100, 30 )
			Button2.Paint = function( self, w, h )
				draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
		end
	
		Button2.DoClick = function()

			selectedPrimary = nil
			selectedSecondary = nil
			selectedEquipment = nil
		
			LocalPlayer():EmitSound(ButtonNoise)
			local broadPanel = Frame:Add("SelectionPanel")

			local classTitle = vgui.Create("DLabel",broadPanel)

			local classDescPanel = vgui.Create("DPanel", broadPanel)
				classDescPanel:SetPos(25,45)
				classDescPanel:SetSize(600,60)
				classDescPanel:SetBackgroundColor(Color(84,84,84))
				classDescPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(84,84,84) )
			end

			classTitle:SetSize(600,250)
			classTitle:SetPos(200,-100)
			classTitle:SetFont("DermaLarge")
			classTitle:SetText("[ Marksman's Arsenal ]")

			local primaryDescription = vgui.Create("DLabel",classDescPanel)
			primaryDescription:SetSize(600,15)
			primaryDescription:SetText("PRIMARY: ...")
			primaryDescription:SetPos(10,10)

			local secondaryDescription = vgui.Create("DLabel",classDescPanel)
			secondaryDescription:SetSize(600,15)
			secondaryDescription:SetText("SECONDARY: ...")
			secondaryDescription:SetPos(10,25)

			local equipmentDescription = vgui.Create("DLabel",classDescPanel)
			equipmentDescription:SetSize(600,15)
			equipmentDescription:SetText("EQUIPMENT: ...")
			equipmentDescription:SetPos(10,40)

			local weaponIconPanel = vgui.Create("DPanel", broadPanel)
				weaponIconPanel:SetPos(25,125)
				weaponIconPanel:SetSize(600,175)
				weaponIconPanel:SetBackgroundColor(Color(84,84,84))
				weaponIconPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(65,65,65) )
			end

			local ConfirmButton = vgui.Create( "DButton", broadPanel )
				ConfirmButton:SetText( "CONFIRM" )
				ConfirmButton:SetTextColor( Color( 255, 255, 255 ) )
				ConfirmButton:SetPos( 270, 375 )
				ConfirmButton:SetSize( 120, 30 )
				ConfirmButton.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) )
			end

			ConfirmButton.DoClick = function()

				if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
					LocalPlayer():EmitSound(DenyNoise)
				else

					net.Start("receiveClassRequest")
						net.WriteInt(3, 5)
					net.SendToServer()

					net.Receive("receiveUpdatedClassData", function(len, ply)

						local confirmed = net.ReadBool()

						if(confirmed == true) then

							RunConsoleCommand("ctf_setclass", 3)

							net.Start("receivePrimaryWeapon")
								net.WriteTable(selectedPrimary)
							net.SendToServer()

							net.Start("receiveSecondaryWeapon")
								net.WriteTable(selectedSecondary)
							net.SendToServer()

							net.Start("receiveEquipment")
								net.WriteTable(selectedEquipment)
							net.SendToServer()

							LocalPlayer():EmitSound(ConfirmNoise)
							LocalPlayer():ChatPrint( "[CTF]: Marksman class selected. Loadout will be applied on respawn." )
							Frame:Close()

						else

							LocalPlayer():EmitSound(DenyNoise)
							LocalPlayer():ChatPrint( "[CTF]: The class you are attempting to switch to is full." )

						end

					end)

				end

			end

			--- Begin Primary Weapon ---

			local marksmanPrimaryList = list.Get("weapons_marksman_primary")

			local marksmanPrimary = vgui.Create( "DComboBox", broadPanel )
				marksmanPrimary:SetPos( 70, 310 )
				marksmanPrimary:SetSize( 150, 20 )
				marksmanPrimary:SetValue("Select Primary Weapon")

				local primaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				primaryIcon:SetSize( 400, 400)
				primaryIcon:SetPos(-60,-255)
				primaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0))
				function primaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(marksmanPrimaryList) do

					marksmanPrimary:AddChoice(v["Name"], v)

				end

				marksmanPrimary.OnSelect = function( self, index, value )

					selectedPrimary = marksmanPrimary:GetOptionData(index)
					primaryDescription:SetText("PRIMARY: " .. selectedPrimary.Description)
					
					selectedModel = selectedPrimary.Model

					primaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			--- End Primary Weapon ---

			--- Begin Secondary Weapon ---

			local marksmanSecondaryList = list.Get("ctf_sidearms")
			
			local marksmanSecondary = vgui.Create( "DComboBox", broadPanel )
				marksmanSecondary:SetPos( 255, 310 )
				marksmanSecondary:SetSize( 150, 20 )
				marksmanSecondary:SetValue("Select Secondary Weapon")

				local secondaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				secondaryIcon:SetSize( 600, 600)
				secondaryIcon:SetPos(0,-425)
				secondaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function secondaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(marksmanSecondaryList) do

					marksmanSecondary:AddChoice(v["Name"], v)

				end

				marksmanSecondary.OnSelect = function( self, index, value )

					selectedSecondary = marksmanSecondary:GetOptionData(index)
					secondaryDescription:SetText("SECONDARY: " .. selectedSecondary.Description)

					selectedModel = selectedSecondary.Model

					secondaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- Begin Equipment --

			local marksmanEquipmentList = list.Get("binoculars_list")
			
			local marksmanEquipment = vgui.Create( "DComboBox", broadPanel )
				marksmanEquipment:SetPos( 440, 310 )
				marksmanEquipment:SetSize( 150, 20 )
				marksmanEquipment:SetValue("Select Equipment")

				local equipmentIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				equipmentIcon:SetSize( 600, 600)
				equipmentIcon:SetPos(165,-425)
				equipmentIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function equipmentIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(marksmanEquipmentList) do

					marksmanEquipment:AddChoice(v["Name"], v)

				end

				marksmanEquipment.OnSelect = function( self, index, value )

					selectedEquipment = marksmanEquipment:GetOptionData(index)
					equipmentDescription:SetText("EQUIPMENT: " .. selectedEquipment.Description)

					selectedModel = selectedEquipment.Model

					equipmentIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- End Equipment
		
		end
	
		-- Gunner button

		local Button3 = vgui.Create( "DButton", Frame )
			Button3:SetText( "Gunner" )
			Button3:SetTextColor( Color( 255, 255, 255 ) )
			Button3:SetPos( 25, 150 )
			Button3:SetSize( 100, 30 )
			Button3.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
		end
	
		Button3.DoClick = function()
		
			LocalPlayer():EmitSound(ButtonNoise)

			-- Begin Panels ---

			selectedPrimary = nil
			selectedSecondary = nil
			selectedEquipment = nil

			LocalPlayer():EmitSound(ButtonNoise)
			local broadPanel = Frame:Add("SelectionPanel")

			local classTitle = vgui.Create("DLabel",broadPanel)

			local classDescPanel = vgui.Create("DPanel", broadPanel)
				classDescPanel:SetPos(25,45)
				classDescPanel:SetSize(600,60)
				classDescPanel:SetBackgroundColor(Color(84,84,84))
				classDescPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(84,84,84) )
			end

			classTitle:SetSize(600,250)
			classTitle:SetPos(200,-100)
			classTitle:SetFont("DermaLarge")
			classTitle:SetText("[ Gunner's Arsenal ]")

			local primaryDescription = vgui.Create("DLabel",classDescPanel)
			primaryDescription:SetSize(600,15)
			primaryDescription:SetText("PRIMARY: ...")
			primaryDescription:SetPos(10,10)

			local secondaryDescription = vgui.Create("DLabel",classDescPanel)
			secondaryDescription:SetSize(600,15)
			secondaryDescription:SetText("SECONDARY: ...")
			secondaryDescription:SetPos(10,25)

			local equipmentDescription = vgui.Create("DLabel",classDescPanel)
			equipmentDescription:SetSize(600,15)
			equipmentDescription:SetText("EQUIPMENT: ...")
			equipmentDescription:SetPos(10,40)

			local weaponIconPanel = vgui.Create("DPanel", broadPanel)
				weaponIconPanel:SetPos(25,125)
				weaponIconPanel:SetSize(600,175)
				weaponIconPanel:SetBackgroundColor(Color(84,84,84))
				weaponIconPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(65,65,65) )
			end

			local ConfirmButton = vgui.Create( "DButton", broadPanel )
				ConfirmButton:SetText( "CONFIRM" )
				ConfirmButton:SetTextColor( Color( 255, 255, 255 ) )
				ConfirmButton:SetPos( 270, 375 )
				ConfirmButton:SetSize( 120, 30 )
				ConfirmButton.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) )
			end

			ConfirmButton.DoClick = function()

				if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
					LocalPlayer():EmitSound(DenyNoise)
				else

					net.Start("receiveClassRequest")
						net.WriteInt(4, 5)
					net.SendToServer()

					net.Receive("receiveUpdatedClassData", function(len, ply)

						local confirmed = net.ReadBool()

						if(confirmed == true) then

							RunConsoleCommand("ctf_setclass", 4)

							net.Start("receivePrimaryWeapon")
								net.WriteTable(selectedPrimary)
							net.SendToServer()

							net.Start("receiveSecondaryWeapon")
								net.WriteTable(selectedSecondary)
							net.SendToServer()

							net.Start("receiveEquipment")
								net.WriteTable(selectedEquipment)
							net.SendToServer()

							LocalPlayer():EmitSound(ConfirmNoise)
							LocalPlayer():ChatPrint( "[CTF]: Gunner class selected. Loadout will be applied on respawn." )
							Frame:Close()

						else

							LocalPlayer():EmitSound(DenyNoise)
							LocalPlayer():ChatPrint( "[CTF]: The class you are attempting to switch to is full." )

						end

					end)

				end

			end
			
			-- End Panels ---

			--- Begin Primary Weapon ---

			local gunnerPrimaryList = list.Get("weapons_gunner_primary")

			local gunnerPrimary = vgui.Create( "DComboBox", broadPanel )
				gunnerPrimary:SetPos( 70, 310 )
				gunnerPrimary:SetSize( 150, 20 )
				gunnerPrimary:SetValue("Select Primary Weapon")

				local primaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				primaryIcon:SetSize( 400, 400)
				primaryIcon:SetPos(-60,-255)
				primaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0))
				function primaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(gunnerPrimaryList) do

					gunnerPrimary:AddChoice(v["Name"], v)

				end

				gunnerPrimary.OnSelect = function( self, index, value )

					selectedPrimary = gunnerPrimary:GetOptionData(index)
					primaryDescription:SetText("PRIMARY: " .. selectedPrimary.Description)
					
					selectedModel = selectedPrimary.Model

					primaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			--- End Primary Weapon ---

			--- Begin Secondary Weapon ---

			local gunnerSecondaryList = list.Get("ctf_sidearms")
			
			local gunnerSecondary = vgui.Create( "DComboBox", broadPanel )
				gunnerSecondary:SetPos( 255, 310 )
				gunnerSecondary:SetSize( 150, 20 )
				gunnerSecondary:SetValue("Select Secondary Weapon")

				local secondaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				secondaryIcon:SetSize( 600, 600)
				secondaryIcon:SetPos(0,-425)
				secondaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function secondaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(gunnerSecondaryList) do

					gunnerSecondary:AddChoice(v["Name"], v)

				end

				gunnerSecondary.OnSelect = function( self, index, value )

					selectedSecondary = gunnerSecondary:GetOptionData(index)
					secondaryDescription:SetText("SECONDARY: " .. selectedSecondary.Description)

					selectedModel = selectedSecondary.Model

					secondaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- Begin Equipment --

			local gunnerEquipmentList = list.Get("grenades_list")
			
			local gunnerEquipment = vgui.Create( "DComboBox", broadPanel )
				gunnerEquipment:SetPos( 440, 310 )
				gunnerEquipment:SetSize( 150, 20 )
				gunnerEquipment:SetValue("Select Equipment")

				local equipmentIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				equipmentIcon:SetSize( 600, 600)
				equipmentIcon:SetPos(165,-425)
				equipmentIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function equipmentIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(gunnerEquipmentList) do

					gunnerEquipment:AddChoice(v["Name"], v)

				end

				gunnerEquipment.OnSelect = function( self, index, value )

					selectedEquipment = gunnerEquipment:GetOptionData(index)
					equipmentDescription:SetText("EQUIPMENT: " .. selectedEquipment.Description)

					selectedModel = selectedEquipment.Model

					equipmentIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- End Equipment
		
		end
	
		-- Demolitionist button

		local Button4 = vgui.Create( "DButton", Frame )
			Button4:SetText( "Demolitionist" )
			Button4:SetTextColor( Color( 255, 255, 255 ) )
			Button4:SetPos( 25, 200 )
			Button4:SetSize( 100, 30 )
			Button4.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
		end
	
		Button4.DoClick = function()
		
			-- Begin Panels ---

			selectedPrimary = nil
			selectedSecondary = nil
			selectedEquipment = nil

			LocalPlayer():EmitSound(ButtonNoise)
			local broadPanel = Frame:Add("SelectionPanel")

			local classTitle = vgui.Create("DLabel",broadPanel)

			local classDescPanel = vgui.Create("DPanel", broadPanel)
				classDescPanel:SetPos(25,45)
				classDescPanel:SetSize(600,60)
				classDescPanel:SetBackgroundColor(Color(84,84,84))
				classDescPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(84,84,84) )
			end

			classTitle:SetSize(600,250)
			classTitle:SetPos(200,-100)
			classTitle:SetFont("DermaLarge")
			classTitle:SetText("[ Demolitionist's Arsenal ]")

			local primaryDescription = vgui.Create("DLabel",classDescPanel)
			primaryDescription:SetSize(600,15)
			primaryDescription:SetText("PRIMARY: ...")
			primaryDescription:SetPos(10,10)

			local secondaryDescription = vgui.Create("DLabel",classDescPanel)
			secondaryDescription:SetSize(600,15)
			secondaryDescription:SetText("SECONDARY: ...")
			secondaryDescription:SetPos(10,25)

			local equipmentDescription = vgui.Create("DLabel",classDescPanel)
			equipmentDescription:SetSize(600,15)
			equipmentDescription:SetText("EQUIPMENT: ...")
			equipmentDescription:SetPos(10,40)

			local weaponIconPanel = vgui.Create("DPanel", broadPanel)
				weaponIconPanel:SetPos(25,125)
				weaponIconPanel:SetSize(600,175)
				weaponIconPanel:SetBackgroundColor(Color(84,84,84))
				weaponIconPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(65,65,65) )
			end

			local ConfirmButton = vgui.Create( "DButton", broadPanel )
				ConfirmButton:SetText( "CONFIRM" )
				ConfirmButton:SetTextColor( Color( 255, 255, 255 ) )
				ConfirmButton:SetPos( 270, 375 )
				ConfirmButton:SetSize( 120, 30 )
				ConfirmButton.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) )
			end

			ConfirmButton.DoClick = function()

				if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
					LocalPlayer():EmitSound(DenyNoise)
				else
					net.Start("receiveClassRequest")
						net.WriteInt(5, 5)
					net.SendToServer()

					net.Receive("receiveUpdatedClassData", function(len, ply)

						local confirmed = net.ReadBool()

						if(confirmed == true) then

							RunConsoleCommand("ctf_setclass", 5)

							net.Start("receivePrimaryWeapon")
								net.WriteTable(selectedPrimary)
							net.SendToServer()

							net.Start("receiveSecondaryWeapon")
								net.WriteTable(selectedSecondary)
							net.SendToServer()

							net.Start("receiveEquipment")
								net.WriteTable(selectedEquipment)
							net.SendToServer()

							LocalPlayer():EmitSound(ConfirmNoise)
							LocalPlayer():ChatPrint( "[CTF]: Demolitionist class selected. Loadout will be applied on respawn." )
							Frame:Close()

						else

							LocalPlayer():EmitSound(DenyNoise)
							LocalPlayer():ChatPrint( "[CTF]: The class you are attempting to switch to is full." )

						end

					end)

				end

			end
			
			-- End Panels ---

			--- Begin Primary Weapon ---

			local demolitionistPrimaryList = list.Get("weapons_demolitionist_primary")

			local demolitionistPrimary = vgui.Create( "DComboBox", broadPanel )
				demolitionistPrimary:SetPos( 70, 310 )
				demolitionistPrimary:SetSize( 150, 20 )
				demolitionistPrimary:SetValue("Select Primary Weapon")

				local primaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				primaryIcon:SetSize( 400, 400)
				primaryIcon:SetPos(-70,-255)
				primaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0))
				function primaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(demolitionistPrimaryList) do

					demolitionistPrimary:AddChoice(v["Name"], v)

				end

				demolitionistPrimary.OnSelect = function( self, index, value )

					selectedPrimary = demolitionistPrimary:GetOptionData(index)
					primaryDescription:SetText("PRIMARY: " .. selectedPrimary.Description)
					selectedModel = selectedPrimary.Model
					
					if(value == "QBZ-97") then
						primaryIcon:SetSize( 420, 420)
						primaryIcon:SetPos(-70,-270)
					elseif (value == "H&K MP7") then
						primaryIcon:SetSize( 460, 460)
						primaryIcon:SetPos(-110,-300)
					end

					primaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			--- End Primary Weapon ---

			--- Begin Secondary Weapon ---

			local demolitionistSecondaryList = list.Get("ctf_sidearms")
			
			local demolitionistSecondary = vgui.Create( "DComboBox", broadPanel )
				demolitionistSecondary:SetPos( 255, 310 )
				demolitionistSecondary:SetSize( 150, 20 )
				demolitionistSecondary:SetValue("Select Secondary Weapon")

				local secondaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				secondaryIcon:SetSize( 600, 600)
				secondaryIcon:SetPos(0,-425)
				secondaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function secondaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(demolitionistSecondaryList) do

					demolitionistSecondary:AddChoice(v["Name"], v)

				end

				demolitionistSecondary.OnSelect = function( self, index, value )

					selectedSecondary = demolitionistSecondary:GetOptionData(index)
					secondaryDescription:SetText("SECONDARY: " .. selectedSecondary.Description)

					selectedModel = selectedSecondary.Model

					secondaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- Begin Equipment --

			local demolitionistEquipmentList = list.Get("demolitionists_list")
			
			local demolitionistEquipment = vgui.Create( "DComboBox", broadPanel )
				demolitionistEquipment:SetPos( 440, 310 )
				demolitionistEquipment:SetSize( 150, 20 )
				demolitionistEquipment:SetValue("Select Equipment")

				local equipmentIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				equipmentIcon:SetSize( 600, 600)
				equipmentIcon:SetPos(165,-425)
				equipmentIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function equipmentIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(demolitionistEquipmentList) do

					demolitionistEquipment:AddChoice(v["Name"], v)

				end

				demolitionistEquipment.OnSelect = function( self, index, value )

					selectedEquipment = demolitionistEquipment:GetOptionData(index)
					equipmentDescription:SetText("EQUIPMENT: " .. selectedEquipment.Description)
					
					selectedModel = selectedEquipment.Model

					if(value == "RPG Platform") then
						equipmentIcon:SetSize( 200, 200)
						equipmentIcon:SetPos(420,-80)
					elseif (value == "SLAMS/Mines") then
						equipmentIcon:SetSize( 600, 600)
						equipmentIcon:SetPos(165,-425)
					end

					equipmentIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- End Equipment
		
		end
		
		-- Support button
	
		local Button5 = vgui.Create( "DButton", Frame )
			Button5:SetText( "Support" )
			Button5:SetTextColor( Color( 255, 255, 255 ) )
			Button5:SetPos( 25, 250 )
			Button5:SetSize( 100, 30 )
			Button5.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
		end
	
		Button5.DoClick = function()
		
			-- Begin Panels ---

			selectedPrimary = nil
			selectedSecondary = nil
			selectedEquipment = nil

			LocalPlayer():EmitSound(ButtonNoise)
			local broadPanel = Frame:Add("SelectionPanel")

			local classTitle = vgui.Create("DLabel",broadPanel)

			local classDescPanel = vgui.Create("DPanel", broadPanel)
				classDescPanel:SetPos(25,45)
				classDescPanel:SetSize(600,60)
				classDescPanel:SetBackgroundColor(Color(84,84,84))
				classDescPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(84,84,84) )
			end

			classTitle:SetSize(600,250)
			classTitle:SetPos(200,-100)
			classTitle:SetFont("DermaLarge")
			classTitle:SetText("[ Support's Arsenal ]")

			local primaryDescription = vgui.Create("DLabel",classDescPanel)
			primaryDescription:SetSize(600,15)
			primaryDescription:SetText("PRIMARY: ...")
			primaryDescription:SetPos(10,10)

			local secondaryDescription = vgui.Create("DLabel",classDescPanel)
			secondaryDescription:SetSize(600,15)
			secondaryDescription:SetText("SECONDARY: ...")
			secondaryDescription:SetPos(10,25)

			local equipmentDescription = vgui.Create("DLabel",classDescPanel)
			equipmentDescription:SetSize(600,15)
			equipmentDescription:SetText("EQUIPMENT: ...")
			equipmentDescription:SetPos(10,40)

			local weaponIconPanel = vgui.Create("DPanel", broadPanel)
				weaponIconPanel:SetPos(25,125)
				weaponIconPanel:SetSize(600,175)
				weaponIconPanel:SetBackgroundColor(Color(84,84,84))
				weaponIconPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(65,65,65) )
			end

			local ConfirmButton = vgui.Create( "DButton", broadPanel )
				ConfirmButton:SetText( "CONFIRM" )
				ConfirmButton:SetTextColor( Color( 255, 255, 255 ) )
				ConfirmButton:SetPos( 270, 375 )
				ConfirmButton:SetSize( 120, 30 )
				ConfirmButton.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) )
			end

			ConfirmButton.DoClick = function()

				if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
					LocalPlayer():EmitSound(DenyNoise)
				else
					net.Start("receiveClassRequest")
						net.WriteInt(6, 5)
					net.SendToServer()

					net.Receive("receiveUpdatedClassData", function(len, ply)

						local confirmed = net.ReadBool()

						if(confirmed == true) then

							RunConsoleCommand("ctf_setclass", 6)

							net.Start("receivePrimaryWeapon")
								net.WriteTable(selectedPrimary)
							net.SendToServer()

							net.Start("receiveSecondaryWeapon")
								net.WriteTable(selectedSecondary)
							net.SendToServer()

							net.Start("receiveEquipment")
								net.WriteTable(selectedEquipment)
							net.SendToServer()

							LocalPlayer():EmitSound(ConfirmNoise)
							LocalPlayer():ChatPrint( "[CTF]: Support class selected. Loadout will be applied on respawn." )
							Frame:Close()

						else

							LocalPlayer():EmitSound(DenyNoise)
							LocalPlayer():ChatPrint( "[CTF]: The class you are attempting to switch to is full." )

						end

					end)

				end

			end
			
			-- End Panels ---

			--- Begin Primary Weapon ---

			local supportPrimaryList = list.Get("weapons_support_primary")

			local supportPrimary = vgui.Create( "DComboBox", broadPanel )
				supportPrimary:SetPos( 70, 310 )
				supportPrimary:SetSize( 150, 20 )
				supportPrimary:SetValue("Select Primary Weapon")

				local primaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				primaryIcon:SetSize( 400, 400)
				primaryIcon:SetPos(-60,-255)
				primaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0))
				function primaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(supportPrimaryList) do

					supportPrimary:AddChoice(v["Name"], v)

				end

				supportPrimary.OnSelect = function( self, index, value )

					selectedPrimary = supportPrimary:GetOptionData(index)
					primaryDescription:SetText("PRIMARY: " .. selectedPrimary.Description)
					
					selectedModel = selectedPrimary.Model

					primaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			--- End Primary Weapon ---

			--- Begin Secondary Weapon ---

			local supportSecondaryList = list.Get("ctf_sidearms")
			
			local supportSecondary = vgui.Create( "DComboBox", broadPanel )
				supportSecondary:SetPos( 255, 310 )
				supportSecondary:SetSize( 150, 20 )
				supportSecondary:SetValue("Select Secondary Weapon")

				local secondaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				secondaryIcon:SetSize( 600, 600)
				secondaryIcon:SetPos(0,-425)
				secondaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function secondaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(supportSecondaryList) do

					supportSecondary:AddChoice(v["Name"], v)

				end

				supportSecondary.OnSelect = function( self, index, value )

					selectedSecondary = supportSecondary:GetOptionData(index)
					secondaryDescription:SetText("SECONDARY: " .. selectedSecondary.Description)

					selectedModel = selectedSecondary.Model

					secondaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- Begin Equipment --

			local supportEquipmentList = list.Get("supplies_list")
			
			local supportEquipment = vgui.Create( "DComboBox", broadPanel )
				supportEquipment:SetPos( 440, 310 )
				supportEquipment:SetSize( 150, 20 )
				supportEquipment:SetValue("Select Equipment")

				local equipmentIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				equipmentIcon:SetSize( 550, 550)
				equipmentIcon:SetPos(195,-375)
				equipmentIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function equipmentIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(supportEquipmentList) do

					supportEquipment:AddChoice(v["Name"], v)

				end

				supportEquipment.OnSelect = function( self, index, value )

					selectedEquipment = supportEquipment:GetOptionData(index)
					equipmentDescription:SetText("EQUIPMENT: " .. selectedEquipment.Description)

					selectedModel = selectedEquipment.Model

					equipmentIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- End Equipment
		
		end

		-- Engineer button
	
		local Button6 = vgui.Create( "DButton", Frame )
			Button6:SetText( "Engineer" )
			Button6:SetTextColor( Color( 255, 255, 255 ) )
			Button6:SetPos( 25, 300 )
			Button6:SetSize( 100, 30 )
			Button6.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
		end
	
		Button6.DoClick = function()
		
			-- Begin Panels ---

			selectedPrimary = nil
			selectedSecondary = nil
			selectedEquipment = nil

			LocalPlayer():EmitSound(ButtonNoise)
			local broadPanel = Frame:Add("SelectionPanel")

			local classTitle = vgui.Create("DLabel",broadPanel)

			local classDescPanel = vgui.Create("DPanel", broadPanel)
				classDescPanel:SetPos(25,45)
				classDescPanel:SetSize(600,60)
				classDescPanel:SetBackgroundColor(Color(84,84,84))
				classDescPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(84,84,84) )
			end

			classTitle:SetSize(600,250)
			classTitle:SetPos(200,-100)
			classTitle:SetFont("DermaLarge")
			classTitle:SetText("[ Engineer's Arsenal ]")

			local primaryDescription = vgui.Create("DLabel",classDescPanel)
			primaryDescription:SetSize(600,15)
			primaryDescription:SetText("PRIMARY: ...")
			primaryDescription:SetPos(10,10)

			local secondaryDescription = vgui.Create("DLabel",classDescPanel)
			secondaryDescription:SetSize(600,15)
			secondaryDescription:SetText("SECONDARY: ...")
			secondaryDescription:SetPos(10,25)

			local equipmentDescription = vgui.Create("DLabel",classDescPanel)
			equipmentDescription:SetSize(600,15)
			equipmentDescription:SetText("EQUIPMENT: ...")
			equipmentDescription:SetPos(10,40)

			local weaponIconPanel = vgui.Create("DPanel", broadPanel)
				weaponIconPanel:SetPos(25,125)
				weaponIconPanel:SetSize(600,175)
				weaponIconPanel:SetBackgroundColor(Color(84,84,84))
				weaponIconPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(65,65,65) )
			end

			local ConfirmButton = vgui.Create( "DButton", broadPanel )
				ConfirmButton:SetText( "CONFIRM" )
				ConfirmButton:SetTextColor( Color( 255, 255, 255 ) )
				ConfirmButton:SetPos( 270, 375 )
				ConfirmButton:SetSize( 120, 30 )
				ConfirmButton.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) )
			end

			ConfirmButton.DoClick = function()

				if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
					LocalPlayer():EmitSound(DenyNoise)
				else
					net.Start("receiveClassRequest")
						net.WriteInt(7, 5)
					net.SendToServer()

					net.Receive("receiveUpdatedClassData", function(len, ply)

						local confirmed = net.ReadBool()

						if(confirmed == true) then

							RunConsoleCommand("ctf_setclass", 7)

							net.Start("receivePrimaryWeapon")
								net.WriteTable(selectedPrimary)
							net.SendToServer()

							net.Start("receiveSecondaryWeapon")
								net.WriteTable(selectedSecondary)
							net.SendToServer()

							net.Start("receiveEquipment")
								net.WriteTable(selectedEquipment)
							net.SendToServer()

							LocalPlayer():EmitSound(ConfirmNoise)
							LocalPlayer():ChatPrint( "[CTF]: Engineer class selected. Loadout will be applied on respawn." )
							Frame:Close()

						else

							LocalPlayer():EmitSound(DenyNoise)
							LocalPlayer():ChatPrint( "[CTF]: The class you are attempting to switch to is full." )

						end

					end)

				end

			end
			
			-- End Panels ---

			--- Begin Primary Weapon ---

			local engineerPrimaryList = list.Get("weapons_engineer_primary")

			local engineerPrimary = vgui.Create( "DComboBox", broadPanel )
				engineerPrimary:SetPos( 70, 310 )
				engineerPrimary:SetSize( 150, 20 )
				engineerPrimary:SetValue("Select Primary Weapon")

				local primaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				primaryIcon:SetSize( 400, 400)
				primaryIcon:SetPos(-60,-255)
				primaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0))
				function primaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(engineerPrimaryList) do

					engineerPrimary:AddChoice(v["Name"], v)

				end

				engineerPrimary.OnSelect = function( self, index, value )

					selectedPrimary = engineerPrimary:GetOptionData(index)
					primaryDescription:SetText("PRIMARY: " .. selectedPrimary.Description)
					
					selectedModel = selectedPrimary.Model

					primaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			--- End Primary Weapon ---

			--- Begin Secondary Weapon ---

			local engineerSecondaryList = list.Get("ctf_sidearms")
			
			local engineerSecondary = vgui.Create( "DComboBox", broadPanel )
				engineerSecondary:SetPos( 255, 310 )
				engineerSecondary:SetSize( 150, 20 )
				engineerSecondary:SetValue("Select Secondary Weapon")

				local secondaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				secondaryIcon:SetSize( 600, 600)
				secondaryIcon:SetPos(0,-425)
				secondaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function secondaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(engineerSecondaryList) do

					engineerSecondary:AddChoice(v["Name"], v)

				end

				engineerSecondary.OnSelect = function( self, index, value )

					selectedSecondary = engineerSecondary:GetOptionData(index)
					secondaryDescription:SetText("SECONDARY: " .. selectedSecondary.Description)

					selectedModel = selectedSecondary.Model

					secondaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- Begin Equipment --

			local engineerEquipmentList = list.Get("engineers_list")
			
			local engineerEquipment = vgui.Create( "DComboBox", broadPanel )
				engineerEquipment:SetPos( 440, 310 )
				engineerEquipment:SetSize( 150, 20 )
				engineerEquipment:SetValue("Select Equipment")

				local equipmentIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				equipmentIcon:SetSize( 600, 600)
				equipmentIcon:SetPos(165,-425)
				equipmentIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function equipmentIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(engineerEquipmentList) do

					engineerEquipment:AddChoice(v["Name"], v)

				end

				engineerEquipment.OnSelect = function( self, index, value )

					selectedEquipment = engineerEquipment:GetOptionData(index)
					equipmentDescription:SetText("EQUIPMENT: " .. selectedEquipment.Description)
					
					selectedModel = selectedEquipment.Model

					if(value == "Vehicle Repair Tool") then
						equipmentIcon:SetSize( 450, 450)
						equipmentIcon:SetPos(285,-315)
					elseif (value == "Fortification Tablet") then
						equipmentIcon:SetSize( 600, 600)
						equipmentIcon:SetPos(165,-425)
					end

					equipmentIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- End Equipment
		
		end

		-- Scout button
	
		local Button7 = vgui.Create( "DButton", Frame )
			Button7:SetText( "Scout" )
			Button7:SetTextColor( Color( 255, 255, 255 ) )
			Button7:SetPos( 25, 350 )
			Button7:SetSize( 100, 30 )
			Button7.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
		end
	
		Button7.DoClick = function()
		
			-- Begin Panels ---

			selectedPrimary = nil
			selectedSecondary = nil
			selectedEquipment = nil

			LocalPlayer():EmitSound(ButtonNoise)
			local broadPanel = Frame:Add("SelectionPanel")

			local classTitle = vgui.Create("DLabel",broadPanel)

			local classDescPanel = vgui.Create("DPanel", broadPanel)
				classDescPanel:SetPos(25,45)
				classDescPanel:SetSize(600,60)
				classDescPanel:SetBackgroundColor(Color(84,84,84))
				classDescPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(84,84,84) )
			end

			classTitle:SetSize(600,250)
			classTitle:SetPos(200,-100)
			classTitle:SetFont("DermaLarge")
			classTitle:SetText("[ Scout's Arsenal ]")

			local primaryDescription = vgui.Create("DLabel",classDescPanel)
			primaryDescription:SetSize(600,15)
			primaryDescription:SetText("PRIMARY: ...")
			primaryDescription:SetPos(10,10)

			local secondaryDescription = vgui.Create("DLabel",classDescPanel)
			secondaryDescription:SetSize(600,15)
			secondaryDescription:SetText("SECONDARY: ...")
			secondaryDescription:SetPos(10,25)

			local equipmentDescription = vgui.Create("DLabel",classDescPanel)
			equipmentDescription:SetSize(600,15)
			equipmentDescription:SetText("EQUIPMENT: ...")
			equipmentDescription:SetPos(10,40)

			local weaponIconPanel = vgui.Create("DPanel", broadPanel)
				weaponIconPanel:SetPos(25,125)
				weaponIconPanel:SetSize(600,175)
				weaponIconPanel:SetBackgroundColor(Color(84,84,84))
				weaponIconPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(65,65,65) )
			end

			local ConfirmButton = vgui.Create( "DButton", broadPanel )
				ConfirmButton:SetText( "CONFIRM" )
				ConfirmButton:SetTextColor( Color( 255, 255, 255 ) )
				ConfirmButton:SetPos( 270, 375 )
				ConfirmButton:SetSize( 120, 30 )
				ConfirmButton.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) )
			end

			ConfirmButton.DoClick = function()

				if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
					LocalPlayer():EmitSound(DenyNoise)
				else
					net.Start("receiveClassRequest")
						net.WriteInt(8, 5)
					net.SendToServer()

					net.Receive("receiveUpdatedClassData", function(len, ply)

						local confirmed = net.ReadBool()

						if(confirmed == true) then

							RunConsoleCommand("ctf_setclass", 8)

							net.Start("receivePrimaryWeapon")
								net.WriteTable(selectedPrimary)
							net.SendToServer()

							net.Start("receiveSecondaryWeapon")
								net.WriteTable(selectedSecondary)
							net.SendToServer()

							net.Start("receiveEquipment")
								net.WriteTable(selectedEquipment)
							net.SendToServer()

							LocalPlayer():EmitSound(ConfirmNoise)
							LocalPlayer():ChatPrint( "[CTF]: Scout class selected. Loadout will be applied on respawn." )
							Frame:Close()

						else

							LocalPlayer():EmitSound(DenyNoise)
							LocalPlayer():ChatPrint( "[CTF]: The class you are attempting to switch to is full." )

						end

					end)

				end

			end
			
			-- End Panels ---

			--- Begin Primary Weapon ---

			local scoutPrimaryList = list.Get("weapons_scout_primary")

			local scoutPrimary = vgui.Create( "DComboBox", broadPanel )
				scoutPrimary:SetPos( 70, 310 )
				scoutPrimary:SetSize( 150, 20 )
				scoutPrimary:SetValue("Select Primary Weapon")

				local primaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				primaryIcon:SetSize( 400, 400)
				primaryIcon:SetPos(-70,-255)
				primaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0))
				function primaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(scoutPrimaryList) do

					scoutPrimary:AddChoice(v["Name"], v)

				end

				scoutPrimary.OnSelect = function( self, index, value )

					selectedPrimary = scoutPrimary:GetOptionData(index)
					primaryDescription:SetText("PRIMARY: " .. selectedPrimary.Description)
					
					selectedModel = selectedPrimary.Model
					
					if(value == "H&K MP5K") then
						primaryIcon:SetSize( 420, 420)
						primaryIcon:SetPos(-95,-260)
					elseif (value == "KRISS VECTOR") then
						primaryIcon:SetSize( 400, 400)
						primaryIcon:SetPos(-70,-255)
					end

					primaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			--- End Primary Weapon ---

			--- Begin Secondary Weapon ---

			local scoutSecondaryList = list.Get("ctf_sidearms")
			
			local scoutSecondary = vgui.Create( "DComboBox", broadPanel )
				scoutSecondary:SetPos( 255, 310 )
				scoutSecondary:SetSize( 150, 20 )
				scoutSecondary:SetValue("Select Secondary Weapon")

				local secondaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				secondaryIcon:SetSize( 600, 600)
				secondaryIcon:SetPos(0,-425)
				secondaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function secondaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(scoutSecondaryList) do

					scoutSecondary:AddChoice(v["Name"], v)

				end

				scoutSecondary.OnSelect = function( self, index, value )

					selectedSecondary = scoutSecondary:GetOptionData(index)
					secondaryDescription:SetText("SECONDARY: " .. selectedSecondary.Description)

					selectedModel = selectedSecondary.Model

					secondaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- Begin Equipment --

			local scoutEquipmentList = list.Get("binoculars_list")
			
			local scoutEquipment = vgui.Create( "DComboBox", broadPanel )
				scoutEquipment:SetPos( 440, 310 )
				scoutEquipment:SetSize( 150, 20 )
				scoutEquipment:SetValue("Select Equipment")

				local equipmentIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				equipmentIcon:SetSize( 600, 600)
				equipmentIcon:SetPos(165,-425)
				equipmentIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function equipmentIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(scoutEquipmentList) do

					scoutEquipment:AddChoice(v["Name"], v)

				end

				scoutEquipment.OnSelect = function( self, index, value )

					selectedEquipment = scoutEquipment:GetOptionData(index)
					equipmentDescription:SetText("EQUIPMENT: " .. selectedEquipment.Description)

					selectedModel = selectedEquipment.Model

					equipmentIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- End Equipment

		end

		-- Medic button
	
		local Button8 = vgui.Create( "DButton", Frame )
			Button8:SetText( "Medic" )
			Button8:SetTextColor( Color( 255, 255, 255 ) )
			Button8:SetPos( 25, 400 )
			Button8:SetSize( 100, 30 )
			Button8.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) ) -- Draw a button
		end
	
		Button8.DoClick = function()
		
			-- Begin Panels ---

			selectedPrimary = nil
			selectedSecondary = nil
			selectedEquipment = nil

			LocalPlayer():EmitSound(ButtonNoise)
			local broadPanel = Frame:Add("SelectionPanel")

			local classTitle = vgui.Create("DLabel",broadPanel)

			local classDescPanel = vgui.Create("DPanel", broadPanel)
				classDescPanel:SetPos(25,45)
				classDescPanel:SetSize(600,60)
				classDescPanel:SetBackgroundColor(Color(84,84,84))
				classDescPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(84,84,84) )
			end

			classTitle:SetSize(600,250)
			classTitle:SetPos(200,-100)
			classTitle:SetFont("DermaLarge")
			classTitle:SetText("[ Medic's Arsenal ]")

			local primaryDescription = vgui.Create("DLabel",classDescPanel)
			primaryDescription:SetSize(600,15)
			primaryDescription:SetText("PRIMARY: ...")
			primaryDescription:SetPos(10,10)

			local secondaryDescription = vgui.Create("DLabel",classDescPanel)
			secondaryDescription:SetSize(600,15)
			secondaryDescription:SetText("SECONDARY: ...")
			secondaryDescription:SetPos(10,25)

			local equipmentDescription = vgui.Create("DLabel",classDescPanel)
			equipmentDescription:SetSize(600,15)
			equipmentDescription:SetText("EQUIPMENT: ...")
			equipmentDescription:SetPos(10,40)

			local weaponIconPanel = vgui.Create("DPanel", broadPanel)
				weaponIconPanel:SetPos(25,125)
				weaponIconPanel:SetSize(600,175)
				weaponIconPanel:SetBackgroundColor(Color(84,84,84))
				weaponIconPanel.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color(65,65,65) )
			end

			local ConfirmButton = vgui.Create( "DButton", broadPanel )
				ConfirmButton:SetText( "CONFIRM" )
				ConfirmButton:SetTextColor( Color( 255, 255, 255 ) )
				ConfirmButton:SetPos( 270, 375 )
				ConfirmButton:SetSize( 120, 30 )
				ConfirmButton.Paint = function( self, w, h )
					draw.RoundedBox( 6, 0, 0, w, h, Color( 40, 40, 40, 250 ) )
			end

			ConfirmButton.DoClick = function()

				if(selectedPrimary == nil or selectedSecondary == nil or selectedEquipment == nil) then
					LocalPlayer():EmitSound(DenyNoise)
				else
					net.Start("receiveClassRequest")
						net.WriteInt(9, 5)
					net.SendToServer()

					net.Receive("receiveUpdatedClassData", function(len, ply)

						local confirmed = net.ReadBool()

						if(confirmed == true) then

							RunConsoleCommand("ctf_setclass", 9)

							net.Start("receivePrimaryWeapon")
								net.WriteTable(selectedPrimary)
							net.SendToServer()

							net.Start("receiveSecondaryWeapon")
								net.WriteTable(selectedSecondary)
							net.SendToServer()

							net.Start("receiveEquipment")
								net.WriteTable(selectedEquipment)
							net.SendToServer()

							LocalPlayer():EmitSound(ConfirmNoise)
							LocalPlayer():ChatPrint( "[CTF]: Medic class selected. Loadout will be applied on respawn." )
							Frame:Close()

						else

							LocalPlayer():EmitSound(DenyNoise)
							LocalPlayer():ChatPrint( "[CTF]: The class you are attempting to switch to is full." )

						end

					end)

				end

			end
			
			-- End Panels ---

			--- Begin Primary Weapon ---

			local medicPrimaryList = list.Get("weapons_medic_primary")

			local medicPrimary = vgui.Create( "DComboBox", broadPanel )
				medicPrimary:SetPos( 70, 310 )
				medicPrimary:SetSize( 150, 20 )
				medicPrimary:SetValue("Select Primary Weapon")

				local primaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				primaryIcon:SetSize( 400, 400)
				primaryIcon:SetPos(-70,-255)
				primaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0))
				function primaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(medicPrimaryList) do

					medicPrimary:AddChoice(v["Name"], v)

				end

				medicPrimary.OnSelect = function( self, index, value )

					selectedPrimary = medicPrimary:GetOptionData(index)
					primaryDescription:SetText("PRIMARY: " .. selectedPrimary.Description)
					
					selectedModel = selectedPrimary.Model

					primaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			--- End Primary Weapon ---

			--- Begin Secondary Weapon ---

			local medicSecondaryList = list.Get("ctf_sidearms")
			
			local medicSecondary = vgui.Create( "DComboBox", broadPanel )
				medicSecondary:SetPos( 255, 310 )
				medicSecondary:SetSize( 150, 20 )
				medicSecondary:SetValue("Select Secondary Weapon")

				local secondaryIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				secondaryIcon:SetSize( 600, 600)
				secondaryIcon:SetPos(0,-425)
				secondaryIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function secondaryIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(medicSecondaryList) do

					medicSecondary:AddChoice(v["Name"], v)

				end

				medicSecondary.OnSelect = function( self, index, value )

					selectedSecondary = medicSecondary:GetOptionData(index)
					secondaryDescription:SetText("SECONDARY: " .. selectedSecondary.Description)

					selectedModel = selectedSecondary.Model

					secondaryIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- Begin Equipment --

			local medicEquipmentList = list.Get("grenades_list")
			
			local medicEquipment = vgui.Create( "DComboBox", broadPanel )
				medicEquipment:SetPos( 440, 310 )
				medicEquipment:SetSize( 150, 20 )
				medicEquipment:SetValue("Select Equipment")

				local equipmentIcon = vgui.Create( "DModelPanel", weaponIconPanel )
				equipmentIcon:SetSize( 600, 600)
				equipmentIcon:SetPos(165,-425)
				equipmentIcon:SetDirectionalLight(BOX_FRONT, Color(0,0,0) )
				function equipmentIcon:LayoutEntity( Entity ) return end

				for k, v in pairs(medicEquipmentList) do

					medicEquipment:AddChoice(v["Name"], v)

				end

				medicEquipment.OnSelect = function( self, index, value )

					selectedEquipment = medicEquipment:GetOptionData(index)
					equipmentDescription:SetText("EQUIPMENT: " .. selectedEquipment.Description)
					
					selectedModel = selectedEquipment.Model
					
					equipmentIcon:SetModel(selectedModel)
					LocalPlayer():EmitSound(ChooseNoise)
				
				end

			-- End Equipment
		
		end

		-- Entities Panel

		PANEL = {}

		function PANEL:Init()
			self:SetSize(650,435)
			self:SetPos(150,25)
		end

		function PANEL:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h, Color(70,70,70,255))
		end
		vgui.Register("SelectionPanel",PANEL, "Panel")

end
concommand.Add( "ctf_open_classmenu", classMenu )
