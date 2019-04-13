ButtonNoise = Sound("buttons/lightswitch2.wav")

local Menu

function ordnanceMenu()

	if(Menu == nil) then
	
		Menu = vgui.Create("DFrame")
		Menu:SetSize(750,500)
		Menu:SetPos(ScrW()/2 - 325, ScrH()/2 - 250)
		Menu:SetTitle("[CTF] Ordnance Selection Menu")
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
		
	else
	
		if(Menu:IsVisible()) then
			Menu:SetVisible(false)
			gui.EnableScreenClicker(false)
		else
			Menu:SetVisible(true)
			gui.EnableScreenClicker(true)
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
		generalAmmoCategory:SetLabel("[CW 2.0] General Ammo Kits:")
		
		local generalAmmoList = vgui.Create("DIconLayout", generalAmmoCategory)
		
		generalAmmoList:SetPos(10,25)
		generalAmmoList:SetSize(ammoPanel:GetWide(), ammoPanel:GetTall())
		generalAmmoList:SetSpaceY(10)
		generalAmmoList:SetSpaceX(10)
		
		local generalAmmoArray = {}
		generalAmmoArray[1] = scripted_ents.Get("cw_ammo_kit_small")
		generalAmmoArray[2] = scripted_ents.Get("cw_ammo_kit_regular")
		generalAmmoArray[3] = scripted_ents.Get("cw_ammo_crate_small")
		
		for k, v in pairs(generalAmmoArray) do
			local icon = vgui.Create("SpawnIcon", generalAmmoList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["PrintName"].."\nCost: "..v["Cost"].."cR")
			generalAmmoList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyentity "..v["ClassName"])
			end
		end
		
		
		--- Special Ammo Start ---
		
		local specialAmmoCategory = vgui.Create("DCollapsibleCategory", ammoPanel)
		specialAmmoCategory:SetPos(0,100)
		specialAmmoCategory:SetSize(ammoPanel:GetWide(),100)
		specialAmmoCategory:SetLabel("[CW 2.0] Special Ammo Kits:")
		
		local specialAmmoList = vgui.Create("DIconLayout", specialAmmoCategory)
		
		specialAmmoList:SetPos(10,25)
		specialAmmoList:SetSize(ammoPanel:GetWide(), ammoPanel:GetTall())
		specialAmmoList:SetSpaceY(10)
		specialAmmoList:SetSpaceX(10)
		
		local specialAmmoArray = {}
		specialAmmoArray[1] = scripted_ents.Get("cw_ammo_40mm")
		specialAmmoArray[2] = scripted_ents.Get("cw_ammo_fraggrenades")
		--specialAmmoArray[3] = scripted_ents.Get("item_rpg_round")
		
		for k, v in pairs(specialAmmoArray) do
			local icon = vgui.Create("SpawnIcon", specialAmmoList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["PrintName"].."\nCost: "..v["Cost"].."cR")
			specialAmmoList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyentity "..v["ClassName"])
			end
		end	
		
		--- HL2 Ammo Start ---
	
		local hl2AmmoCategory = vgui.Create("DCollapsibleCategory", ammoPanel)
		hl2AmmoCategory:SetPos(0,200)
		hl2AmmoCategory:SetSize(ammoPanel:GetWide(),100)
		hl2AmmoCategory:SetLabel("[HL2] Additional Munitions:")
		
		local hl2AmmoList = vgui.Create("DIconLayout", hl2AmmoCategory)
		
		hl2AmmoList:SetPos(10,25)
		hl2AmmoList:SetSize(ammoPanel:GetWide(), ammoPanel:GetTall())
		hl2AmmoList:SetSpaceY(10)
		hl2AmmoList:SetSpaceX(10)
		
		local hl2AmmoArray = {}
		hl2AmmoArray[1] = scripted_ents.Get("hl2_ammo_crate_rpg")
		
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

	-- Entities Button --
	
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
		airCategory:SetPos(0,0) -- Set the second value by the number determined below (100)
		airCategory:SetSize(vehiclesPanel:GetWide(),100) --Change 100 for more than one line
		airCategory:SetLabel("[LFS] Air Vehicles:")
		
		--- Air Vehicles Start ---
		
		local airList = vgui.Create("DIconLayout", airCategory)
		airList:SetPos(10,25)
		airList:SetSize(vehiclesPanel:GetWide(), vehiclesPanel:GetTall())
		airList:SetSpaceY(10)
		airList:SetSpaceX(10)
		
		local airArray = {}
		airArray[1] = scripted_ents.Get("lunasflightschool_spitfire")
		airArray[2] = scripted_ents.Get("lunasflightschool_combineheli")
		airArray[3] = scripted_ents.Get("lfs_crysis_vtol")
		
		for k, v in pairs(airArray) do
			local icon = vgui.Create("SpawnIcon", airList)
			icon:SetModel(v["MDL"])
			icon:SetToolTip(v["PrintName"].."\nCost: "..v["Cost"].."cR")
			airList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyLFSVehicle "..v["ClassName"])
			end
		end
		
		--- Simfphys Start --
		
		local simfphysCategory = vgui.Create("DCollapsibleCategory", vehiclesPanel)
		simfphysCategory:SetPos(0,100) -- Set the second value by the number determined below (100)
		simfphysCategory:SetSize(vehiclesPanel:GetWide(),100) --Change 100 for more than one line
		simfphysCategory:SetLabel("[Simfphys] Vehicles:")
		
		local simfphysList = vgui.Create("DIconLayout", simfphysCategory)
		
		simfphysList:SetPos(10,25)
		simfphysList:SetSize(vehiclesPanel:GetWide(), vehiclesPanel:GetTall())
		simfphysList:SetSpaceY(10)
		simfphysList:SetSpaceX(10)
		
		local vehicleList = list.Get( "simfphys_vehicles" ) -- Call modified list
		local vehicle = vehicleList[ vname ]
		
		for k, v in pairs(vehicleList) do
			local icon = vgui.Create("SpawnIcon", simfphysList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["Name"].."\nCost: "..v["Cost"].."cR")
			simfphysList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_simfphys_buyvehicle "..k)
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
