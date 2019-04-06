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
		draw.DrawText("Entities","DermaDefaultBold",entitiesButton:GetWide()/2,17,Color(255,255,255,255),1)
		
	end

end