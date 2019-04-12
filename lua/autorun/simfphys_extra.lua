local light_table = {
	L_HeadLampPos = Vector(-26,106,30.3),
	L_HeadLampAng = Angle(15,90,0),
	R_HeadLampPos = Vector(26,106,30.3),
	R_HeadLampAng = Angle(15,90,0),
	
	L_RearLampPos = Vector(-28.5,-109.63,49.5),
	L_RearLampAng = Angle(40,-90,0),
	R_RearLampPos = Vector(28.5,-109.63,49.5),
	R_RearLampAng = Angle(40,-90,0),
	
	Headlight_sprites = { 
		{pos = Vector(-23,106,30.23),size = 60, color = Color( 220,220,220,50)},
		{pos = Vector(-30,106,30.36),size = 60, color = Color( 220,220,220,50)},
		{pos = Vector(23,106,30.23),size = 60, color = Color( 220,220,220,50)},
		{pos = Vector(30,106,30.36),size = 60, color = Color( 220,220,220,50)},
	},
	
	Headlamp_sprites = { 
		{pos = Vector(-26,106,30.23),material = "sprites/light_ignorez",size = 80, color = Color( 220,220,220,120)},
		{pos = Vector(26,106,30.23),material = "sprites/light_ignorez",size = 80, color = Color( 220,220,220,120)},
	},
	
	Rearlight_sprites = {
		{pos = Vector(-35.5,-109.63,40.75),material = "sprites/light_ignorez",size = 30,color = Color( 255, 0, 0,  50)},
		{pos = Vector(-35.5,-109.63,38),material = "sprites/light_ignorez",size = 30,color = Color( 255, 0, 0,  50)},
		
		{pos = Vector(-24.5,-109.63,40.75),material = "sprites/light_ignorez",size = 30,color = Color( 255, 0, 0,  50)},
		{pos = Vector(-24.5,-109.63,38),material = "sprites/light_ignorez",size = 30,color = Color( 255, 0, 0,  50)},
		
		
		{pos = Vector(35.5,-109.63,40.75),material = "sprites/light_ignorez",size = 30,color = Color( 255, 0, 0,  50)},
		{pos = Vector(35.5,-109.63,38),material = "sprites/light_ignorez",size = 30,color = Color( 255, 0, 0,  50)},
		
		{pos = Vector(24.5,-109.63,40.75),material = "sprites/light_ignorez",size = 30,color = Color( 255, 0, 0,  50)},
		{pos = Vector(24.5,-109.63,38),material = "sprites/light_ignorez",size = 30,color = Color( 255, 0, 0,  50)},
	},
	Brakelight_sprites = {
		{pos = Vector(-35.5,-109.63,40.75),material = "sprites/light_ignorez",size = 33,color = Color( 255, 0, 0,  50)},
		{pos = Vector(-35.5,-109.63,38),material = "sprites/light_ignorez",size = 33,color = Color( 255, 0, 0,  50)},
		
		{pos = Vector(-24.5,-109.63,40.75),material = "sprites/light_ignorez",size = 33,color = Color( 255, 0, 0,  50)},
		{pos = Vector(-24.5,-109.63,38),material = "sprites/light_ignorez",size = 33,color = Color( 255, 0, 0,  50)},
		
		
		{pos = Vector(35.5,-109.63,40.75),material = "sprites/light_ignorez",size = 33,color = Color( 255, 0, 0,  50)},
		{pos = Vector(35.5,-109.63,38),material = "sprites/light_ignorez",size = 33,color = Color( 255, 0, 0,  50)},
		
		{pos = Vector(24.5,-109.63,40.75),material = "sprites/light_ignorez",size = 33,color = Color( 255, 0, 0,  50)},
		{pos = Vector(24.5,-109.63,38),material = "sprites/light_ignorez",size = 33,color = Color( 255, 0, 0,  50)},
	},
	RearMarker_sprites = {
		Vector(-42.87,-101.7,35.71),
		Vector(42.87,-101.7,35.71)
	},
	--[[
	FogLight_sprites = {
		{pos = Vector(-26.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(-27.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(-28.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(-29.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(-30.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(-31.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(-32.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		
		{pos = Vector(26.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(27.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(28.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(29.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(30.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(31.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
		{pos = Vector(32.06,109.39,15.74),material = "sprites/light_ignorez",size = 12, color = Color( 220,220,220,100)},
	},
	]]--
	
	Turnsignal_sprites = {
		Left = {
			Vector(-30,-109.16,40.87),
			Vector(-30,-109.31,38.06),
			
			{pos = Vector(-26.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(-27.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(-28.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(-29.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(-30.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(-31.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(-32.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
		},
		Right = {
			Vector(29.5,-109.16,40.87),
			Vector(29.5,-109.31,38.06),
			
			{pos = Vector(26.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(27.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(28.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(29.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(30.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(31.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
			{pos = Vector(32.06,109.39,15.74),material = "sprites/light_ignorez",size = 20},
		},
	},

	
	ems_sounds = {"simulated_vehicles/police/siren_madmax.wav","common/null.wav"},
	ems_sprites = {
		{
			pos = Vector(15.89,20.46,55.79),
			material = "sprites/light_glow02_add_noz",
			size = 60,
			Colors = {Color(0,0,250,250),Color(0,0,255,255),Color(0,0,250,250),Color(0,0,200,200),Color(0,0,150,150),Color(0,0,100,100),Color(0,0,50,50),Color(0,0,0,0)}, -- the script will go from color to color
			Speed = 0.05,
		}
	},
	
	SubMaterials = {
		off = {
			Base = {
				[1] = "",
				[3] = ""
			},
			Brake = {
				[1] = "models/madmax/lights/brake_1",
				[3] = ""
			},
		},
		on_lowbeam = {
			Base = {
				[1] = "models/madmax/lights/brake_1",
				[3] = "models/madmax/lights/lowbeam"
			},
			Brake = {
				[1] = "models/madmax/lights/brake_2",
				[3] = "models/madmax/lights/lowbeam"
			},
		},
		on_highbeam = {
			Base = {
				[1] = "models/madmax/lights/brake_1",
				[3] = "models/madmax/lights/highbeam"
			},
			Brake = {
				[1] = "models/madmax/lights/brake_2",
				[3] = "models/madmax/lights/highbeam"
			},
		},
	}
}
list.Set( "simfphys_lights", "madmax", light_table)

local light_table = {
	L_HeadLampPos = Vector( 115, 20, 0 ),
	L_HeadLampAng = Angle(10,5,0),
	R_HeadLampPos = Vector( 115, -20, 0 ),
	R_HeadLampAng = Angle(10,-5,0),
	
	L_RearLampPos = Vector(-115,20,5),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-115,-20,5),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = {
		{pos = Vector(102,27.5,-1),material = "sprites/light_ignorez",size = 20, color = Color( 220,205,160,120)},
		{pos = Vector(102,-27.5,-1),material = "sprites/light_ignorez",size = 20, color = Color( 220,205,160,120)},
		{pos = Vector(102,21,-1),material = "sprites/light_ignorez",size = 20, color = Color( 220,205,160,120)},
		{pos = Vector(102,-21,-1),material = "sprites/light_ignorez",size = 20, color = Color( 220,205,160,120)},
		
		{pos = Vector(102,27.5,-1),size = 60, color = Color( 220,205,160,50)},
		{pos = Vector(102,-27.5,-1),size = 60, color = Color( 220,205,160,50)},
		{pos = Vector(102,21,-1),size = 60, color = Color( 220,205,160,50)},
		{pos = Vector(102,-21,-1),size = 60, color = Color( 220,205,160,50)},
	},
	Headlamp_sprites = {
		{pos = Vector(102,27.5,-1),material = "sprites/light_ignorez",size = 80, color = Color( 220,205,160,70)},
		{pos = Vector(102,-27.5,-1),material = "sprites/light_ignorez",size = 80, color = Color( 220,205,160,70)},
		{pos = Vector(102,21,-1),material = "sprites/light_ignorez",size = 80, color = Color( 220,205,160,70)},
		{pos = Vector(102,-21,-1),material = "sprites/light_ignorez",size = 80, color = Color( 220,205,160,70)},
	},
	Rearlight_sprites = {
		{pos = Vector(-121,25.5,5),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(-121,-25.5,5),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
	},
	Brakelight_sprites = {
		{pos = Vector(-121,13.5,5),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
		{pos = Vector(-121,-13.5,5),material = "sprites/light_ignorez",size = 45,color = Color( 255, 0, 0,  150)},
	},
	Reverselight_sprites = {
		{pos = Vector(-121,19.5,5),material = "sprites/light_ignorez",size = 25,color = Color( 255, 255, 255, 100)},
		{pos = Vector(-121,-19.5,5),material = "sprites/light_ignorez",size = 25,color = Color( 255, 255, 255, 100)},
	},
	
	DelayOn = 0.5,
	DelayOff = 0.25,
	BodyGroups = {
		On = {8,0},
		Off = {8,1}
	},
	
	Turnsignal_sprites = {
		Left = {
			Vector(103.28,27,-9.54),
			Vector(103.28,28.5,-9.54),
			{pos = Vector(-121,25.5,5),material = "sprites/light_ignorez",size = 55,color = Color( 255, 0, 0,  165)},
		},
		Right = {
			Vector(103.28,-27,-9.54),
			Vector(103.28,-28.5,-9.54),
			{pos = Vector(-121,-25.5,5),material = "sprites/light_ignorez",size = 55,color = Color( 255, 0, 0,  165)},
		},
	},
	
	SubMaterials = {
		off = {
			Base = {
				[10] = ""
			},
			Brake = {
				[10] = "models/gtav/dukes/lights/brake"
			},
			Reverse = {
				[10] = "models/gtav/dukes/lights/reverse"
			},
			Brake_Reverse = {
				[10] = "models/gtav/dukes/lights/brake_reverse"
			},
		},
		on_lowbeam = {
			Base = {
				[10] = "models/gtav/dukes/lights/lowbeam"
			},
			Brake = {
				[10] = "models/gtav/dukes/lights/lowbeam_brake"
			},
			Reverse = {
				[10] = "models/gtav/dukes/lights/lowbeam_reverse"
			},
			Brake_Reverse = {
				[10] = "models/gtav/dukes/lights/lowbeam_brake_reverse"
			},
		},
		on_highbeam = {
			Base = {
				[10] = "models/gtav/dukes/lights/highbeam"
			},
			Brake = {
				[10] = "models/gtav/dukes/lights/highbeam_brake"
			},
			Reverse = {
				[10] = "models/gtav/dukes/lights/highbeam_reverse"
			},
			Brake_Reverse = {
				[10] = "models/gtav/dukes/lights/highbeam_brake_reverse"
			},
		},
	}
}
list.Set( "simfphys_lights", "dukes", light_table)

local light_table = {
	L_HeadLampPos = Vector( 28.5, 122, 31.5 ),
	L_HeadLampAng = Angle(15,90,0),
	R_HeadLampPos = Vector( -28.5, 120, 31.5 ),
	R_HeadLampAng = Angle(15,90,0),
	
	L_RearLampPos = Vector(23,-120,36),
	L_RearLampAng = Angle(25,-90,0),
	R_RearLampPos = Vector(-23,-120,36),
	R_RearLampAng = Angle(25,-90,0),

	Headlight_sprites = { 
		{pos = Vector(-33,121.5,31.5),material = "sprites/light_ignorez",size = 28, color = Color( 220,205,160,255)},
		{pos = Vector(-33,121.5,31.5),size = 64, color = Color( 220,205,160,100)},
		
		{pos = Vector(33,121.5,31.5),material = "sprites/light_ignorez",size = 28, color = Color( 220,205,160,255)},
		{pos = Vector(33,121.5,31.5),size = 64, color = Color( 220,205,160,100)},
	},
	Headlamp_sprites = { 
		{pos = Vector(-24,121.5,31.5),material = "sprites/light_ignorez",size = 28, color = Color( 220,205,160,255)},
		{pos = Vector(-24,121.5,31.5),size = 64, color = Color( 220,205,160,100)},
		
		{pos = Vector(24,121.5,31.5),material = "sprites/light_ignorez",size = 28, color = Color( 220,205,160,255)},
		{pos = Vector(24,121.5,31.5),size = 64, color = Color( 220,205,160,100)},
	},
	Rearlight_sprites = {
		Vector(33.5,-120,36),Vector(31.9,-120,36),Vector(30.3,-120,36),Vector(28.7,-120,36),Vector(27.1,-120,36),Vector(25.5,-120,36),Vector(23.9,-120,36),Vector(22.3,-120,36),Vector(20.7,-120,36),Vector(19.1,-120,36),Vector(17.5,-120,36),Vector(15.9,-120,36),Vector(14.3,-120,36),Vector(12.7,-120,36),Vector(11.1,-120,36),Vector(9.5,-120,36),Vector(7.9,-120,36),
		Vector(-33.5,-120,36),Vector(-31.9,-120,36),Vector(-30.3,-120,36),Vector(-28.7,-120,36),Vector(-27.1,-120,36),Vector(-25.5,-120,36),Vector(-23.9,-120,36),Vector(-22.3,-120,36),Vector(-20.7,-120,36),Vector(-19.1,-120,36),Vector(-17.5,-120,36),Vector(-15.9,-120,36),Vector(-14.3,-120,36),Vector(-12.7,-120,36),Vector(-11.1,-120,36),Vector(-9.5,-120,36),Vector(-7.9,-120,36)
	},
	Reverselight_sprites = {
		Vector(-17.6,-121.1,23.1),
		Vector(17.6,-121.1,23.1)
	},
	FrontMarker_sprites = {
		Vector(-30,120.5,18),
		Vector(30,120.5,18),
		Vector(-42.5,110.3,24.4),
		Vector(42.5,110.3,24.4)
	},
	RearMarker_sprites = {
		Vector(-41.5,-113,28),
		Vector(41.5,-113,28)
	},
	
	Turnsignal_sprites = {
		Left = {
			Vector(-30,120.5,18),
			Vector(-42.5,110.3,24.4),
		},
		Right = {
			Vector(30,120.5,18),
			Vector(42.5,110.3,24.4)
		},
		
		TurnBrakeLeft = {
			Vector(-33.5,-120,36),Vector(-31.9,-120,36),Vector(-30.3,-120,36),Vector(-28.7,-120,36),Vector(-27.1,-120,36),Vector(-25.5,-120,36),Vector(-23.9,-120,36),Vector(-22.3,-120,36),Vector(-20.7,-120,36),Vector(-19.1,-120,36),Vector(-17.5,-120,36),Vector(-15.9,-120,36),
		},
		
		TurnBrakeRight = {
			Vector(33.5,-120,36),Vector(31.9,-120,36),Vector(30.3,-120,36),Vector(28.7,-120,36),Vector(27.1,-120,36),Vector(25.5,-120,36),Vector(23.9,-120,36),Vector(22.3,-120,36),Vector(20.7,-120,36),Vector(19.1,-120,36),Vector(17.5,-120,36),Vector(15.9,-120,36),
		},
	},
	
	DelayOn = 2.1,
	DelayOff = 2.1,
	Animation = {
		On = "lightcoveropenreal",
		Off = "lightcoverclosereal"
	}
}
list.Set( "simfphys_lights", "charger", light_table)


local light_table = {
	ModernLights = true,
	
	L_HeadLampPos = Vector(87.8,24.1,22.7),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampPos = Vector(87.8,-24.1,22.7),
	R_HeadLampAng = Angle(15,0,0),
	
	L_RearLampPos = Vector(-88,24.5,31.2),
	L_RearLampAng = Angle(25,180,0),
	R_RearLampPos = Vector(-88,-24.5,31.2),
	R_RearLampAng = Angle(25,180,0),
	
	Headlight_sprites = { 
		{pos = Vector(84.2,29.4,22.3),material = "sprites/light_ignorez",size = 18, color = Color(215,240,255,255)},
		{pos = Vector(84.2,29.4,22.3),size = 64, color = Color( 215,240,255,50)},
		
		{pos = Vector(84.2,-29.4,22.3),material = "sprites/light_ignorez",size = 18, color = Color(215,240,255,255)},
		{pos = Vector(84.2,-29.4,22.3),size = 64, color = Color( 215,240,255,50)},
		
		{pos = Vector(87.8,24.1,22.3),material = "sprites/light_ignorez",size = 18, color = Color(215,240,255,255)},
		{pos = Vector(87.8,24.1,22.3),size = 64, color = Color( 215,240,255,50)},
		
		{pos = Vector(87.8,-24.1,22.3),material = "sprites/light_ignorez",size = 18, color = Color(215,240,255,255)},
		{pos = Vector(87.8,-24.1,22.3),size = 64, color = Color( 215,240,255,50)},

	},
	Headlamp_sprites = { 
		{pos = Vector(90,-19,21.9),material = "sprites/light_ignorez",size = 18, color = Color(215,240,255,255)},
		{pos = Vector(90,-19,21.9),size = 64, color = Color( 215,240,255,50)},
		
		{pos = Vector(90,19,21.9),material = "sprites/light_ignorez",size = 18, color = Color(215,240,255,255)},
		{pos = Vector(90,19,21.9),size = 64, color = Color( 215,240,255,50)},
	},
	Rearlight_sprites = {
		Vector(-88,22.2,31.2),Vector(-86.2,26.9,30.9),
		Vector(-88,-22.2,31.2),Vector(-86.2,-26.9,30.9)
	},
	Brakelight_sprites = {
		Vector(-88,22.2,31.2),Vector(-86.2,26.9,30.9),
		Vector(-88,-22.2,31.2),Vector(-86.2,-26.9,30.9),
		
		Vector(-70,5.9,49.8),Vector(-70,4.425,49.85),Vector(-70,2.95,49.9),Vector(-70,1.475,49.95),Vector(-70,0,50),Vector(-70,-5.9,49.8),Vector(-70,-4.425,49.85),Vector(-70,-2.95,49.9),Vector(-70,-1.475,49.95),
	},
	Reverselight_sprites = {
		Vector(-90,16.6,30.9),
		Vector(-90,-16.6,30.9)
	},
	FogLight_sprites = {
		{pos = Vector(87.79,26.65,9.62),material = "sprites/light_ignorez",size = 16, color = Color(215,240,255,255)},
		{pos = Vector(87.79,26.65,9.62),size = 32, color = Color( 215,240,255,50)},
		
		{pos = Vector(87.79,-26.65,9.62),material = "sprites/light_ignorez",size = 16, color = Color(215,240,255,255)},
		{pos = Vector(87.79,-26.65,9.62),size = 32, color = Color( 215,240,255,50)},
	}
}
list.Set( "simfphys_lights", "alfons", light_table)

local light_table = {
	L_HeadLampPos = Vector(0,66.3,21.84),
	L_HeadLampAng = Angle(20,90,0),
	
	R_HeadLampPos = Vector(0,-58.01,70.71),
	R_HeadLampAng = Angle(0,90,0),

	L_RearLampPos = Vector(-14.9,-99.9,39.13),
	L_RearLampAng = Angle(40,-90,0),
	
	Headlight_sprites = { 
		Vector(-12.25,67.23,22.33),
		Vector(-3.91,67.03,22.14),
		Vector(4.63,66.33,21.96),
		Vector(13.4,66.72,22.16)
	},
	Headlamp_sprites = { 
		Vector(14.3,-59.87,70.12),
		Vector(7.34,-58.62,70.32),
		Vector(-7.79,-58.55,70.09),
		Vector(-14.97,-60.01,69.99)
	},
	Rearlight_sprites = {
		Vector(-14.9,-99.9,39.13)
	},
	Brakelight_sprites = {
		Vector(-14.9,-99.9,39.1)
	},
}
list.Set( "simfphys_lights", "elitejeep", light_table)