ButtonNoise = Sound("buttons/lightswitch2.wav")
DenyNoise = Sound("buttons/button2.wav")
OpenNoise = Sound("npc/scanner/scanner_scan1.wav")
CloseNoise = Sound("npc/scanner/scanner_scan2.wav")

local Menu

function ordnanceMenu()

	if(Menu == nil) then
	
		if(LocalPlayer():GetNWBool("canBuy") == false) then 
			LocalPlayer():EmitSound(DenyNoise)
		return end
		
		LocalPlayer():EmitSound(OpenNoise)
		Menu = vgui.Create("DFrame")
		Menu:SetSize(750,500)
		Menu:SetPos(ScrW()/2 - 325, ScrH()/2 - 250)
		Menu:SetTitle("[CTF]: Ordnance Selection Menu")
		Menu:SetDraggable(true)
		Menu:ShowCloseButton(false)
		Menu:SetDeleteOnClose(false)
		Menu.Paint = function()
			surface.SetDrawColor(60,60,60,255)
			surface.DrawRect(0,0,Menu:GetWide(),Menu:GetTall())
			surface.SetDrawColor(40,40,40,255)
			surface.DrawRect(0,24,Menu:GetWide(),1)
		end
		
		addButtons(Menu)
		gui.EnableScreenClicker(true)
		
		net.Start("sendMenu")
		net.WriteBool(true)
		net.SendToServer()
		
	else
	
		if(Menu:IsVisible() or LocalPlayer():GetNWBool("canBuy") == false) then
		
			if (LocalPlayer():GetNWBool("canBuy") == false) then
				Menu:SetVisible(false)
				gui.EnableScreenClicker(false)
				LocalPlayer():EmitSound(DenyNoise)
			return end
			
			Menu:SetVisible(false)
			gui.EnableScreenClicker(false)
			LocalPlayer():EmitSound(CloseNoise)
			net.Start("sendMenu")
			net.WriteBool(false)
			net.SendToServer()
			
		else
		
			Menu:SetVisible(true)
			gui.EnableScreenClicker(true)
			LocalPlayer():EmitSound(OpenNoise)
			
			net.Start("sendMenu")
			net.WriteBool(true)
			net.SendToServer()
			
		end
		
	end
	
end
concommand.Add( "ctf_open_ordnancemenu", ordnanceMenu )

function addButtons(Menu)

	-- Ammo Button --

	local ammoButton = vgui.Create("DButton")
	ammoButton:SetParent(Menu)
	ammoButton:SetText("")
	ammoButton:SetSize(100,50)
	ammoButton:SetPos(0,25)
	ammoButton.Paint = function()
		-- Color of entire button
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0,ammoButton:GetWide(),ammoButton:GetTall())
		
		-- Draw bottom and right borders
		surface.SetDrawColor(40,40,40,255)
		surface.DrawRect(0,49,ammoButton:GetWide(),1)
		surface.DrawRect(99,0,1,ammoButton:GetTall()) -- Width of 100 minus 1
		
		-- Draw text
		draw.DrawText("Ammo","DermaDefaultBold",ammoButton:GetWide()/2,17,Color(255,255,255,255),1)
		
	end
	
	ammoButton.DoClick = function(ammoButton)
		LocalPlayer():EmitSound(ButtonNoise)
		local ammoPanel = Menu:Add("AmmoPanel")
		
		--- General Ammo Start ---
		
		local generalAmmoCategory = vgui.Create("DCollapsibleCategory", ammoPanel)
		generalAmmoCategory:SetPos(0,0)
		generalAmmoCategory:SetSize(ammoPanel:GetWide(),100)
		generalAmmoCategory:SetLabel("[TFA] Ammo Kits:")
		
		local generalAmmoList = vgui.Create("DIconLayout", generalAmmoCategory)
		
		generalAmmoList:SetPos(10,25)
		generalAmmoList:SetSize(ammoPanel:GetWide(), ammoPanel:GetTall())
		generalAmmoList:SetSpaceY(10)
		generalAmmoList:SetSpaceX(10)
		
		local generalAmmoArray = {}
		generalAmmoArray[1] = scripted_ents.Get("tfa_ammo_pistol")
		generalAmmoArray[2] = scripted_ents.Get("tfa_ammo_smg")
		generalAmmoArray[3] = scripted_ents.Get("tfa_ammo_ar2")
		generalAmmoArray[4] = scripted_ents.Get("tfa_ammo_buckshot")
		generalAmmoArray[5] = scripted_ents.Get("tfa_ammo_357")
		generalAmmoArray[6] = scripted_ents.Get("tfa_ammo_sniper_rounds")
		
		for k, v in pairs(generalAmmoArray) do
			local icon = vgui.Create("SpawnIcon", generalAmmoList)
			icon:SetModel(v["MyModel"])
			icon:SetToolTip(v["PrintName"].."\nCost: "..v["Cost"].."cR")
			generalAmmoList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyentity "..v["ClassName"])
			end
		end
		
		--- HL2 Ammo Start ---
	
		local hl2AmmoCategory = vgui.Create("DCollapsibleCategory", ammoPanel)
		hl2AmmoCategory:SetPos(0,100)
		hl2AmmoCategory:SetSize(ammoPanel:GetWide(),100)
		hl2AmmoCategory:SetLabel("[HL2] Additional Munitions:")
		
		local hl2AmmoList = vgui.Create("DIconLayout", hl2AmmoCategory)
		
		hl2AmmoList:SetPos(10,25)
		hl2AmmoList:SetSize(ammoPanel:GetWide(), ammoPanel:GetTall())
		hl2AmmoList:SetSpaceY(10)
		hl2AmmoList:SetSpaceX(10)
		
		local hl2AmmoArray = {}
		hl2AmmoArray[1] = scripted_ents.Get("hl2_ammo_crate_rpg")
		hl2AmmoArray[2] = scripted_ents.Get("hl2_ammo_crate_ar2")
		hl2AmmoArray[3] = scripted_ents.Get("hl2_ammo_crate_smg")
		
		for k, v in pairs(hl2AmmoArray) do
			local icon = vgui.Create("SpawnIcon", hl2AmmoList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["PrintName"].."\nCost: "..v["Cost"].."cR")
			hl2AmmoList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyentity "..v["ClassName"])
			end
		end
		
	end

	-- Entities Button ---
	
	local entitiesButton = vgui.Create("DButton")
	entitiesButton:SetParent(Menu)
	entitiesButton:SetText("")
	entitiesButton:SetSize(100,50)
	entitiesButton:SetPos(0,75)
	entitiesButton.Paint = function()
		-- Color of entire button
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0,entitiesButton:GetWide(),entitiesButton:GetTall())
		
		-- Draw bottom and right borders
		surface.SetDrawColor(40,40,40,255)
		surface.DrawRect(0,49,entitiesButton:GetWide(),1)
		surface.DrawRect(99,0,1,entitiesButton:GetTall()) -- Width of 100 minus 1
		
		-- Draw text
		draw.DrawText("Equipment","DermaDefaultBold",entitiesButton:GetWide()/2,17,Color(255,255,255,255),1)
		
	end
	
	entitiesButton.DoClick = function(entitiesButton)
		LocalPlayer():EmitSound(ButtonNoise)
		local entitiesPanel = Menu:Add("EntitiesPanel")
		
		--- Vest Category ---
		
		local vestCategory = vgui.Create("DCollapsibleCategory", entitiesPanel)
		vestCategory:SetPos(0,0)
		vestCategory:SetSize(entitiesPanel:GetWide(),100)
		vestCategory:SetLabel("[Ballistic Vests] Personal Protection:")
		
		local vestList = vgui.Create("DIconLayout", vestCategory)
		
		vestList:SetPos(10,25)
		vestList:SetSize(entitiesPanel:GetWide(), entitiesPanel:GetTall())
		vestList:SetSpaceY(10)
		vestList:SetSpaceX(10)
		
		local vestArray = {}
		vestArray[1] = scripted_ents.Get("danguvestsmall")
		vestArray[2] = scripted_ents.Get("danguvestnormal")
		vestArray[3] = scripted_ents.Get("danguvestheavy")
		vestArray[4] = scripted_ents.Get("danguvesthelmet")
		
		
		for k, v in pairs(vestArray) do
			local icon = vgui.Create("SpawnIcon", vestList)
			icon:SetModel(v["MdlRef"])
			icon:SetToolTip(v["PrintName"].."\nCost: "..v["Cost"].."cR")
			vestList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyentity "..v["ClassName"])
			end
		end
		
		--- Emplacements Category ---
		
		local turretCategory = vgui.Create("DCollapsibleCategory", entitiesPanel)
		turretCategory:SetPos(0,100)
		turretCategory:SetSize(entitiesPanel:GetWide(),100)
		turretCategory:SetLabel("[Emplacements] Mounted Weapons:")
		
		local turretList = vgui.Create("DIconLayout", turretCategory)
		
		turretList:SetPos(10,25)
		turretList:SetSize(entitiesPanel:GetWide(), entitiesPanel:GetTall())
		turretList:SetSpaceY(10)
		turretList:SetSpaceX(10)
		
		local turretArray = {}
		turretArray[1] = scripted_ents.Get("turret_bullets2")
		turretArray[2] = scripted_ents.Get("turret_bullets")
		turretArray[3] = scripted_ents.Get("turret_grenade")
		turretArray[4] = scripted_ents.Get("turret_rail")
		
		
		for k, v in pairs(turretArray) do
			local icon = vgui.Create("SpawnIcon", turretList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["PrintName"].."\nCost: "..v["Cost"].."cR")
			turretList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyentity "..v["ClassName"])
			end
		end
		
	end
	
	--- Vehicles Button ---
	
	local vehiclesButton = vgui.Create("DButton")
	vehiclesButton:SetParent(Menu)
	vehiclesButton:SetText("")
	vehiclesButton:SetSize(100,50)
	vehiclesButton:SetPos(0,125)
	vehiclesButton.Paint = function()
		-- Color of entire button
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0,vehiclesButton:GetWide(),vehiclesButton:GetTall())
		
		-- Draw bottom and right borders
		surface.SetDrawColor(40,40,40,255)
		surface.DrawRect(0,49,vehiclesButton:GetWide(),1)
		surface.DrawRect(99,0,1,vehiclesButton:GetTall()) -- Width of 100 minus 1
		
		-- Draw text
		draw.DrawText("Vehicles","DermaDefaultBold",vehiclesButton:GetWide()/2,17,Color(255,255,255,255),1)
		
	end
	
	vehiclesButton.DoClick = function(vehiclesButton)
		LocalPlayer():EmitSound(ButtonNoise)
		local vehiclesPanel = Menu:Add("VehiclesPanel")
		
		local airCategory = vgui.Create("DCollapsibleCategory", vehiclesPanel)
		airCategory:SetPos(0,300) -- Set the second value by the number determined below (100)
		airCategory:SetSize(vehiclesPanel:GetWide(),100) --Change 100 for more than one line
		airCategory:SetLabel("[LFS] Helicopters:")
		
		--- Air Vehicles Start ---
		
		local airList = vgui.Create("DIconLayout", airCategory)
		airList:SetPos(10,25)
		airList:SetSize(vehiclesPanel:GetWide(), vehiclesPanel:GetTall())
		airList:SetSpaceY(10)
		airList:SetSpaceX(10)
		
		local airArray = {}
		airArray[1] = scripted_ents.Get("lunasflightschool_combineheli")
		airArray[2] = scripted_ents.Get("lunasflightschool_ah6")
		
		for k, v in pairs(airArray) do
			local icon = vgui.Create("SpawnIcon", airList)
			icon:SetModel(v["MDL"])
			icon:SetToolTip(v["PrintName"].."\nCost: "..v["Cost"].."cR")
			airList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_LFS_buyvehicle "..v["ClassName"])
			end
		end
		
		--- Prewar Start --
		
		local simfphysPrewarCategory = vgui.Create("DCollapsibleCategory", vehiclesPanel)
		simfphysPrewarCategory:SetPos(0,0) -- Set the second value by the number determined below (100)
		simfphysPrewarCategory:SetSize(vehiclesPanel:GetWide(),100) --Change 100 for more than one line
		simfphysPrewarCategory:SetLabel("[Simfphys] Civilian:")
		
		local simfphysPrewarList = vgui.Create("DIconLayout", simfphysPrewarCategory)
		
		simfphysPrewarList:SetPos(10,25)
		simfphysPrewarList:SetSize(vehiclesPanel:GetWide(), vehiclesPanel:GetTall())
		simfphysPrewarList:SetSpaceY(10)
		simfphysPrewarList:SetSpaceX(10)
		
		local vehiclePrewarList = list.Get( "simfphys_ctf_prewar" ) -- Call modified list
		local vehiclePrewar = vehiclePrewarList[ vname ]
		
		for k, v in pairs(vehiclePrewarList) do
			local icon = vgui.Create("SpawnIcon", simfphysPrewarList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["Name"].."\nCost: "..v["Cost"].."cR")
			simfphysPrewarList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_simfphys_buyprewar "..k)
			end
		end
		
		--- Recon Start ---
		
		local simfphysReconCategory = vgui.Create("DCollapsibleCategory", vehiclesPanel)
		simfphysReconCategory:SetPos(0,100) -- Set the second value by the number determined below (100)
		simfphysReconCategory:SetSize(vehiclesPanel:GetWide(),100) --Change 100 for more than one line
		simfphysReconCategory:SetLabel("[Simfphys] Recon:")
		
		local simfphysReconList = vgui.Create("DIconLayout", simfphysReconCategory)
		
		simfphysReconList:SetPos(10,25)
		simfphysReconList:SetSize(vehiclesPanel:GetWide(), vehiclesPanel:GetTall())
		simfphysReconList:SetSpaceY(10)
		simfphysReconList:SetSpaceX(10)
		
		local vehicleReconList = list.Get( "simfphys_ctf_recon" ) -- Call modified list
		local vehicleRecon = vehicleReconList[ vname ]
		
		for k, v in pairs(vehicleReconList) do
			local icon = vgui.Create("SpawnIcon", simfphysReconList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["Name"].."\nCost: "..v["Cost"].."cR")
			simfphysReconList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_simfphys_buyrecon "..k)
			end
		end
		
		--- Tanks Start ---
		
		local simfphysTanksCategory = vgui.Create("DCollapsibleCategory", vehiclesPanel)
		simfphysTanksCategory:SetPos(0,200) -- Set the second value by the number determined below (100)
		simfphysTanksCategory:SetSize(vehiclesPanel:GetWide(),100) --Change 100 for more than one line
		simfphysTanksCategory:SetLabel("[Simfphys] Tanks:")
		
		local simfphysTankList = vgui.Create("DIconLayout", simfphysTanksCategory)
		
		simfphysTankList:SetPos(10,25)
		simfphysTankList:SetSize(vehiclesPanel:GetWide(), vehiclesPanel:GetTall())
		simfphysTankList:SetSpaceY(10)
		simfphysTankList:SetSpaceX(10)
		
		local vehicleTankList = list.Get( "simfphys_ctf_tanks" ) -- Call modified list
		local vehicleTank = vehicleTankList[ vname ]
		
		for k, v in pairs(vehicleTankList) do
			local icon = vgui.Create("SpawnIcon", simfphysTankList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["Name"].."\nCost: "..v["Cost"].."cR")
			simfphysTankList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_simfphys_buytank "..k)
			end
		end
		
	end
end

-- Ammo Panel

PANEL = {}

function PANEL:Init()
	self:SetSize(650,475)
	self:SetPos(100,25)
end

function PANEL:Paint(w,h)
	draw.RoundedBox(0,0,0,w,h, Color(70,70,70,255))
end

vgui.Register("AmmoPanel",PANEL, "Panel")

-- Entities Panel

PANEL = {}

function PANEL:Init()
	self:SetSize(650,475)
	self:SetPos(100,25)
end

function PANEL:Paint(w,h)
	draw.RoundedBox(0,0,0,w,h, Color(70,70,70,255))
end

vgui.Register("EntitiesPanel",PANEL, "Panel")

-- Vehicles Panel

PANEL = {}

function PANEL:Init()
	self:SetSize(650,475)
	self:SetPos(100,25)
end

function PANEL:Paint(w,h)
	draw.RoundedBox(0,0,0,w,h, Color(70,70,70,255))
end

vgui.Register("VehiclesPanel",PANEL, "Panel")
