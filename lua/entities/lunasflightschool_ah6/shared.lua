--DO NOT EDIT OR REUPLOAD THIS FILE

ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript_heli" )

ENT.PrintName = "AH-6 Littlebird"
ENT.Author = "Merydian"
ENT.Information = ""
ENT.Category = "[Merydian LFS]"

ENT.Spawnable		= true
ENT.AdminSpawnable	= false

ENT.MDL = "models/lfs_merydian/AH6_LB.mdl"
ENT.Cost = 1000


ENT.AITEAM = 2

ENT.Mass = 1500
ENT.Inertia = Vector(4000,4000,4000)
ENT.Drag = 0

ENT.SeatPos = Vector(26,13,-63)
ENT.SeatAng = Angle(0,-90,0)

ENT.MaxThrustHeli = 8
ENT.MaxTurnPitchHeli = 30
ENT.MaxTurnYawHeli = 50
ENT.MaxTurnRollHeli = 100

ENT.ThrustEfficiencyHeli = 0.9

ENT.RotorPos = Vector(0,0,0)
ENT.RotorAngle = Angle(0,0,0)
ENT.RotorRadius = 180	

ENT.MaxHealth = 950

ENT.MaxPrimaryAmmo = 5000
ENT.MaxSecondaryAmmo = 0

sound.Add( {
	name = "MINIGUN_LOOP",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 90,
	sound = "lfs_custom/ah6/mg_loop.wav"
} )

sound.Add( {
	name = "MINIGUN_LASTSHOT",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 90,
	sound = "lfs_custom/ah6/mg_stop.wav"
} )
