ButtonNoise = Sound("buttons/lightswitch2.wav")

local Menu

net.Receive("OrdnanceMenu",function()

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
	end
	
	addButtons(Menu)
	
	
	if(net.ReadBit() == 0) then
		Menu:Hide()
		gui.EnableScreenClicker(false)
	else
		Menu:Show()
		gui.EnableScreenClicker(true)
	end
end)

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
		local iconList = vgui.Create("DIconLayout", ammoPanel)
		
		iconList:SetPos(10,5)
		iconList:SetSize(ammoPanel:GetWide(), ammoPanel:GetTall())
		iconList:SetSpaceY(10)
		iconList:SetSpaceX(10)
		
		local entityArray = {}
		entityArray[1] = scripted_ents.Get("cw_ammo_kit_small")
		entityArray[2] = scripted_ents.Get("cw_ammo_kit_regular")
		entityArray[3] = scripted_ents.Get("cw_ammo_40mm")
		entityArray[4] = scripted_ents.Get("cw_ammo_crate_small")
		
		
		for k, v in pairs(entityArray) do
			local icon = vgui.Create("SpawnIcon", iconList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["PrintName"])
			iconList:Add(icon)
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
		local iconList = vgui.Create("DIconLayout", entitiesPanel)
		
		iconList:SetPos(10,5)
		iconList:SetSize(entitiesPanel:GetWide(), entitiesPanel:GetTall())
		iconList:SetSpaceY(10)
		iconList:SetSpaceX(10)
		
		local entityArray = {}
		entityArray[1] = scripted_ents.Get("danguvestsmall")
		entityArray[2] = scripted_ents.Get("danguvestnormal")
		entityArray[3] = scripted_ents.Get("danguvestheavy")
		entityArray[4] = scripted_ents.Get("danguvesthelmet")
		
		
		for k, v in pairs(entityArray) do
			local icon = vgui.Create("SpawnIcon", iconList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["PrintName"])
			iconList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyentity "..v["ClassName"])
			end
		end
		
	end
	
	-- Vehicles Button ---
	
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
		local iconList = vgui.Create("DIconLayout", vehiclesPanel)
		
		iconList:SetPos(10,5)
		iconList:SetSize(vehiclesPanel:GetWide(), vehiclesPanel:GetTall())
		iconList:SetSpaceY(10)
		iconList:SetSpaceX(10)
		
		local entityArray = {}
		entityArray[1] = scripted_ents.Get("lunasflightschool_combineheli") -- Test
		
		for k, v in pairs(entityArray) do
			local icon = vgui.Create("SpawnIcon", iconList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["PrintName"])
			iconList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("ctf_buyentity "..v["ClassName"])
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
