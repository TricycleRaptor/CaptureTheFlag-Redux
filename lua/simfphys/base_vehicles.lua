local V = {
	Name = "HL2 Jeep",
	Model = "models/buggy.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Half Life 2 / Synergy",
	Cost = 150,
	
	Members = {
		Mass = 1700,
		
		--OnTick = function(ent) print("hi") end,
		--OnSpawn = function(ent) print("i spawned") end,
		--OnDelete = function(ent) print("im removed :(") end,
		--OnDestroyed = function(ent) print("im destroyed :((((") end,
		
		LightsTable = "jeep",
		
		FrontWheelRadius = 18,
		RearWheelRadius = 20,
		
		CustomMassCenter = Vector(0,0,0),
		
		SeatOffset = Vector(0,0,-2),
		SeatPitch = 0,
		
		SpeedoMax = 120,

		StrengthenSuspension = false,
		
		FrontHeight = 13.5,
		FrontConstant = 27000,
		FrontDamping = 2800,
		FrontRelativeDamping = 2800,
		
		RearHeight = 13.5,
		RearConstant = 32000,
		RearDamping = 2900,
		RearRelativeDamping = 2900,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 535,
		
		TurnSpeed = 8,
		
		MaxGrip = 44,
		Efficiency = 1.337,
		GripOffset = 0,
		BrakePower = 40,
		
		IdleRPM = 750,
		LimitRPM = 6500,

		PeakTorque = 100,
		PowerbandStart = 2200,
		PowerbandEnd = 6300,
		
		FuelFillPos = Vector(17.64,-14.55,30.06),
		
		PowerBias = 0.5,
		
		EngineSoundPreset = -1,
		
		snd_pitch = 1,
		snd_idle = "simulated_vehicles/jeep/jeep_idle.wav",
		
		snd_low = "simulated_vehicles/jeep/jeep_low.wav",
		snd_low_revdown = "simulated_vehicles/jeep/jeep_revdown.wav",
		snd_low_pitch = 0.9,
		
		snd_mid = "simulated_vehicles/jeep/jeep_mid.wav",
		snd_mid_gearup = "simulated_vehicles/jeep/jeep_second.wav",

		snd_mid_pitch = 1,

		Sound_Idle = "simulated_vehicles/misc/nanjing_loop.wav",
		Sound_IdlePitch = 1,
		
		Sound_Mid = "simulated_vehicles/misc/m50.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 58,
		Sound_MidFadeOutRate = 0.476,
		
		Sound_High = "simulated_vehicles/misc/v8high2.wav",
		Sound_HighPitch = 1,
		Sound_HighVolume = 0.75,
		Sound_HighFadeInRPMpercent = 58,
		Sound_HighFadeInRate = 0.19,
		
		Sound_Throttle = "",
		Sound_ThrottlePitch = 0,
		Sound_ThrottleVolume = 0,
		
		snd_horn = "simulated_vehicles/horn_1.wav", 
		
		DifferentialGear = 0.3,
		Gears = {-0.15,0,0.15,0.25,0.35,0.45}
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_jeep", V )