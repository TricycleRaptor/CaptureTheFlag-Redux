local light_table = {
	L_HeadLampPos = Vector(118.8,30.5,41.8),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampPos = Vector(118.8,-35,41.8),
	R_HeadLampAng = Angle(15,0,0),
	
	Headlight_sprites = { 
		Vector(118.8,30.5,41.8),
		Vector(118.8,-35,41.8)
	},
	Headlamp_sprites = {
		Vector(118.8,30.5,41.8),
		Vector(118.8,-35,41.8)
	},
	
	Turnsignal_sprites = {
		Left = {
			Vector(116.88,36.33,53.57),
			Vector(115.4,37.9,53.59),
			Vector(113.67,39.87,53.72),
			Vector(-100.76,20.37,18.99),
			Vector(-100.71,18.55,18.97),
			Vector(-100.71,16.69,19.1),
		},
		Right = {
			Vector(114.88,-40.33,53.57),
			Vector(113.4,-41.9,53.59),
			Vector(111.67,-43.87,53.72),
			Vector(-100.76,-22.37,18.99),
			Vector(-100.71,-20.55,18.97),
			Vector(-100.71,-18.69,19.1),
		},
	}
}
list.Set( "simfphys_lights", "avia", light_table)


local light_table = {
	L_HeadLampPos = Vector(-36.87,87.86,47.32),
	L_HeadLampAng = Angle(15,90,0),
	R_HeadLampPos = Vector(36.33,87.27,46.67),
	R_HeadLampAng = Angle(15,90,0),
	
	L_RearLampPos = Vector(43.03,-194,25),
	L_RearLampAng = Angle(60,-90,0),
	R_RearLampPos = Vector(-43.03,-194,25),
	R_RearLampAng = Angle(60,-90,0),
	
	Headlight_sprites = { 
		{pos = Vector(-36.87,87.86,47.32),material = "sprites/light_ignorez",size = 64},
		{pos = Vector(-36.87,87.86,47.32),size = 75},
		
		{pos = Vector(36.33,87.27,46.67),material = "sprites/light_ignorez",size = 64},
		{pos = Vector(36.33,87.27,46.67),size = 75}
	},
	Headlamp_sprites = { 
		{pos = Vector(-36.87,87.86,47.32),size = 110},
		{pos = Vector(36.33,87.27,46.67),size = 110}
	},
	Rearlight_sprites = {
		Vector(43.04,-194,21.05),
		Vector(43.03,-194,22.49),
		Vector(43.23,-194,23.34),
		Vector(43.14,-194,24.32),
		
		Vector(-43.04,-194,21.05),
		Vector(-43.03,-194,22.49),
		Vector(-43.23,-194,23.34),
		Vector(-43.14,-194,24.32)
	},
	Brakelight_sprites = {
		Vector(43.04,-194,21.05),
		Vector(43.03,-194,22.49),
		Vector(43.23,-194,23.34),
		Vector(43.14,-194,24.32),
		
		Vector(-43.04,-194,21.05),
		Vector(-43.03,-194,22.49),
		Vector(-43.23,-194,23.34),
		Vector(-43.14,-194,24.32)
	},
	FrontMarker_sprites = {
		Vector(55.4,-156.48,56.9),
		Vector(56.74,-70.56,55.19),
		Vector(50,73.98,57.71),
		Vector(-53.4,-156.48,56.9),
		Vector(-54,-70.56,55.19),
		Vector(-50,73.98,57.71)
	},
	
	Turnsignal_sprites = {
		Left = {
			Vector(-38.2,87.81,58.93),
			Vector(-42.96,-193.67,28.29),
		},
		Right = {
			Vector(37.8,87.41,58.52),
			Vector(43.38,-194.54,28.99),
		},
	}
}
list.Set( "simfphys_lights", "gaz", light_table)


local light_table = {
	L_HeadLampPos = Vector(97.45,36.17,37.08),
	L_HeadLampAng = Angle(15,0,0),
	R_HeadLampPos = Vector(97.23,-36.19,37.03),
	R_HeadLampAng = Angle(15,0,0),
	
	L_RearLampPos = Vector(-117,-32.5,41),
	L_RearLampAng = Angle(45,180,0),
	R_RearLampPos = Vector(-117,32.5,41),
	R_RearLampAng = Angle(45,180,0),
	
	Headlight_sprites = { 
		Vector(97.41,33.55,37.05),Vector(97.45,36.17,37.08),Vector(97.61,38.86,37.14),
		Vector(97.25,-33.56,37.04),Vector(97.23,-36.19,37.03),Vector(97.13,-38.64,37.08)
	},
	Headlamp_sprites = { 
		Vector(97.45,36.17,37.08),
		Vector(97.23,-36.19,37.03)
	},
	Rearlight_sprites = {
		{pos = Vector(-117,-32.5,41),material = "sprites/light_ignorez",size = 35,color = Color( 255, 60, 0,  125)},
		{pos = Vector(-117,-32.5,41),size = 45,color = Color( 255, 0, 0,  250)},
		
		{pos = Vector(-117,32.5,41),material = "sprites/light_ignorez",size = 35,color = Color( 255, 60, 0,  125)},
		{pos = Vector(-117,32.5,41),size = 45,color = Color( 255, 0, 0,  250)},
	},
	Reverselight_sprites = {
		Vector(-117,-32.5,45),Vector(-117,-34.5,45),Vector(-117,-30.5,45),
		Vector(-117,32.5,45),Vector(-117,34.5,45),Vector(-117,30.5,45)
	},
	
	Turnsignal_sprites = {
		Left = {
			Vector(96.64,36.27,27.21),
			Vector(96.64,35,27.21),
		},
		Right = {
			Vector(96.64,-36.27,27.21),
			Vector(96.64,-35,27.21),
		},
		TurnBrakeLeft = {
			{pos = Vector(-117,32.5,41),material = "sprites/light_ignorez",size = 50},
			{pos = Vector(-117,32.5,41),size = 55},
		},
		TurnBrakeRight = {
			{pos = Vector(-117,-32.5,41),material = "sprites/light_ignorez",size = 50},
			{pos = Vector(-117,-32.5,41),size = 55},
		},
	},
}
list.Set( "simfphys_lights", "van", light_table)


local V = {
	Name = "HL2 Van",
	Model = "models/blu/van/pw_van.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "[CTF Certified] : Civilian",
	SpawnAngleOffset = 90,
	Cost = 100,
	
	Members = {
		Mass = 2500,
		
		EnginePos = Vector(89.98,0,51.3),
		
		LightsTable = "van",
		
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		
		CustomWheelModel = "models/salza/van/van_wheel.mdl",
		CustomWheelPosFL = Vector(45,44,20),
		CustomWheelPosFR = Vector(45,-44,20),
		CustomWheelPosRL = Vector(-72,44,20),
		CustomWheelPosRR = Vector(-72,-44,20),
		CustomWheelAngleOffset = Angle(0,-90,0),
		
		CustomMassCenter = Vector(0,0,15),
		
		CustomSteerAngle = 35,
		
		SeatOffset = Vector(36,-23,72),
		SeatPitch = 8,
		SeatYaw = 90,
		
		PassengerSeats = {
			{
				pos = Vector(45,-27,33),
				ang = Angle(0,-90,9)
			},
			{
				pos = Vector(45,0,33),
				ang = Angle(0,-90,9)
			},
			{
				pos = Vector(-38,-29,28),
				ang = Angle(0,0,0)
			}
		},
		
		FrontHeight = 12,
		FrontConstant = 45000,
		FrontDamping = 3500,
		FrontRelativeDamping = 3500,
		
		RearHeight = 12,
		RearConstant = 45000,
		RearDamping = 3500,
		RearRelativeDamping = 3500,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 350,
		
		TurnSpeed = 8,
		
		MaxGrip = 45,
		Efficiency = 1.8,
		GripOffset = -2,
		BrakePower = 55,
		
		IdleRPM = 750,
		LimitRPM = 6000,
		PeakTorque = 95,
		PowerbandStart = 1000,
		PowerbandEnd = 5500,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-93.45,46.02,42.24),
		FuelType = FUELTYPE_PETROL,
		FuelTankSize = 65,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 1,
		snd_idle = "simulated_vehicles/generic3/generic3_idle.wav",
		
		snd_low = "simulated_vehicles/generic3/generic3_low.wav",
		snd_low_revdown = "simulated_vehicles/generic3/generic3_revdown.wav",
		snd_low_pitch = 0.9,
		
		snd_mid = "simulated_vehicles/generic3/generic3_mid.wav",
		snd_mid_gearup = "simulated_vehicles/generic3/generic3_second.wav",
		snd_mid_pitch = 1,
		
		DifferentialGear = 0.52,
		Gears = {-0.1,0,0.1,0.2,0.3,0.4}
	}
}
list.Set( "simfphys_ctf_prewar", "sim_fphys_pwvan", V )


local V = {
	Name = "HL2 GAZ52",
	Model = "models/blu/gaz52/gaz52.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "[CTF Certified] : Civilian",
	Cost = 250,

	Members = {
		Mass = 3000,
		
		EnginePos = Vector(0,61.23,76.81),
		
		LightsTable = "gaz",
		
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		
		CustomWheelModel = "models/salza/gaz52/gaz52_wheel.mdl",
		CustomWheelPosFL = Vector(-40,55,25),
		CustomWheelPosFR = Vector(40,55,25),
		CustomWheelPosRL = Vector(-45,-120,25),
		CustomWheelPosRR = Vector(45,-120,25),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		CustomMassCenter = Vector(0,0,18),
		
		CustomSteerAngle = 35,
		
		SeatOffset = Vector(-20,-23,85),
		SeatPitch = 10,
		SeatYaw = 0,
		
		PassengerSeats = {
			{
				pos = Vector(23,-2,50),
				ang = Angle(0,0,5)
			}
		},
		
		FrontHeight = 8,
		FrontConstant = 38000,
		FrontDamping = 6000,
		FrontRelativeDamping = 6000,
		
		RearHeight = 12.5,
		RearConstant = 38000,
		RearDamping = 6000,
		RearRelativeDamping = 6000,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 600,
		
		TurnSpeed = 8,
		
		MaxGrip = 85,
		Efficiency = 1.2,
		GripOffset = -12,
		BrakePower = 80,
		
		IdleRPM = 500,
		LimitRPM = 5000,
		PeakTorque = 150,
		PowerbandStart = 650,
		PowerbandEnd = 4700,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(-25.29,-34.76,50),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 140,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 1,
		snd_idle = "vehicles/crane/crane_startengine1.wav",
		
		snd_low ="simulated_vehicles/alfaromeo/alfaromeo_low.wav",
		snd_low_pitch = 0.35,
		
		snd_mid = "simulated_vehicles/alfaromeo/alfaromeo_mid.wav",
		snd_mid_gearup = "simulated_vehicles/alfaromeo/alfaromeo_second.wav",
		snd_mid_pitch = 0.5,
		
		DifferentialGear = 0.25,
		Gears = {-0.1,0,0.1,0.19,0.29,0.37,0.44,0.5,0.57}
	}
}
list.Set( "simfphys_ctf_prewar", "sim_fphys_pwgaz52", V )


local V = {
	Name = "HL2 Avia",
	Model = "models/blu/avia/avia.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "[CTF Certified] Civilian",
	SpawnAngleOffset = 90,
	Cost = 250,

	Members = {
		Mass = 2500,
		
		EnginePos = Vector(49.37,-2.41,44.13),
		
		LightsTable = "avia",
		
		CustomWheels = true,
		CustomSuspensionTravel = 10,
		
		CustomWheelModel = "models/salza/avia/avia_wheel.mdl",
		CustomWheelPosFL = Vector(78,37,17),
		CustomWheelPosFR = Vector(78,-40,17),
		CustomWheelPosRL = Vector(-55,38.5,17),
		CustomWheelPosRR = Vector(-55,-37,17),
		CustomWheelAngleOffset = Angle(0,180,0),
		
		CustomMassCenter = Vector(0,0,5),
		
		CustomSteerAngle = 35,
		
		SeatOffset = Vector(55,-20,95),
		SeatPitch = 15,
		SeatYaw = 90,
		
		PassengerSeats = {
			{
				pos = Vector(79,-21,45),
				ang = Angle(0,-90,0)
			}
		},
		
		FrontHeight = 8,
		FrontConstant = 40000,
		FrontDamping = 3500,
		FrontRelativeDamping = 3500,
		
		RearHeight = 8,
		RearConstant = 40000,
		RearDamping = 3500,
		RearRelativeDamping = 3500,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 49,
		Efficiency = 1.1,
		GripOffset = -2,
		BrakePower = 45,	
		
		IdleRPM = 750,
		LimitRPM = 4200,
		PeakTorque = 160,
		PowerbandStart = 1500,
		PowerbandEnd = 3800,
		Turbocharged = false,
		Supercharged = false,
		
		FuelFillPos = Vector(9.79,35.14,30.77),
		FuelType = FUELTYPE_DIESEL,
		FuelTankSize = 100,
		
		PowerBias = 1,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 1,
		snd_idle = "simulated_vehicles/jeep/jeep_idle.wav",
		
		snd_low = "simulated_vehicles/jeep/jeep_low.wav",
		snd_low_revdown = "simulated_vehicles/jeep/jeep_revdown.wav",
		snd_low_pitch = 0.9,
		
		snd_mid = "simulated_vehicles/jeep/jeep_mid.wav",
		snd_mid_gearup = "simulated_vehicles/jeep/jeep_second.wav", 
		snd_mid_pitch = 1,
		
		DifferentialGear = 0.45,
		Gears = {-0.15,0,0.15,0.25,0.35,0.45,0.52}
	}
}
list.Set( "simfphys_ctf_prewar", "sim_fphys_pwavia", V )