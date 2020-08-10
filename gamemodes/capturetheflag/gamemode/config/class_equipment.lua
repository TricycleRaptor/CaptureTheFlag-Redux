-- Grenades --

local V = {

	Name = "Frag Grenade",
	Model = "models/Items/grenadeAmmo.mdl",
	Class = "weapon_frag",
	Category = "Grenades",
	Description = "Standard fare HL2 frag grenade, simple to throw with high damage. Easy for everyone to see and hear.",

}
list.Set( "grenades_list", "weapon_frag", V )

local V = {

	Name = "ST5 Stun Grenade",
	Model = "models/items/tfa_st5/st5_ammo.mdl",
	Class = "tfa_misc_st5stunner",
	Category = "Grenades",
	Description = "The ST5 Stun Grenade can incapacitate and disorient enemies for up to six seconds. Must be timed well.",

}
list.Set( "grenades_list", "tfa_misc_st5stunner", V )

-- Binoculars --

local V = {

	Name = "Standard Binoculars",
	Model = "models/weapons/w_binocularsbp.mdl",
	Class = "weapon_rpw_binoculars",
	Category = "Binoculars",
	Description = "Standard binoculars model that provides a rangefinder and zoom level of up to 8x.",

}
list.Set( "binoculars_list", "weapon_rpw_binoculars", V )

local V = {

	Name = "Explorer Binoculars",
	Model = "models/weapons/w_binoculars_uk.mdl",
	Class = "weapon_rpw_binoculars_explorer",
	Category = "Binoculars",
	Description = "High-range binoculars with a fixed distance and vector coordinates.",

}
list.Set( "binoculars_list", "weapon_rpw_binoculars_explorer", V )

local V = {

	Name = "Nightvision Binoculars",
	Model = "models/weapons/w_nvbinoculars.mdl",
	Class = "weapon_rpw_binoculars_nvg",
	Category = "Binoculars",
	Description = "Binoculars that offer up to 6x zoom with a rangefinder and passive night vision.",

}
list.Set( "binoculars_list", "weapon_rpw_binoculars_nvg", V )

local V = {

	Name = "Scout Binoculars",
	Model = "models/weapons/w_binoculars_usa.mdl",
	Class = "weapon_rpw_binoculars_scout",
	Category = "Binoculars",
	Description = "Binoculars that offer up to 5x zoom with a passive target identifier.",

}
list.Set( "binoculars_list", "weapon_rpw_binoculars_scout", V )

local V = {

	Name = "Vintage Binoculars",
	Model = "models/weapons/w_binoculars_ger.mdl",
	Class = "weapon_rpw_binoculars_vintage",
	Category = "Binoculars",
	Description = "Aged binoculars that offer 4x zoom and vector coordinates.",

}
list.Set( "binoculars_list", "weapon_rpw_binoculars_vintage", V )

-- Support Equipment --

local V = {

	Name = "Rifle Ammo Supply",
	Model = "models/Items/BoxMRounds.mdl",
	Class = "tfa_fml_hl2_ammo_drop_ar2",
	Category = "Throwable Ammo",
	Description = "Deployable rifle ammo compatible with most assault weapons.",

}
list.Set( "supplies_list", "tfa_fml_hl2_ammo_drop_ar2", V )

local V = {

	Name = "Shotgun Ammo Supply",
	Model = "models/Items/BoxBuckshot.mdl",
	Class = "tfa_fml_hl2_ammo_drop_shotgun",
	Category = "Throwable Ammo",
	Description = "Deployable buckshot ammo for all shotguns.",

}
list.Set( "supplies_list", "tfa_fml_hl2_ammo_drop_shotgun", V )

local V = {

	Name = "Pistol Ammo Supply",
	Model = "models/Items/BoxSRounds.mdl",
	Class = "tfa_fml_hl2_ammo_drop_pistol",
	Category = "Throwable Ammo",
	Description = "Deployable pistol ammo for all non-revolver pistols.",

}
list.Set( "supplies_list", "tfa_fml_hl2_ammo_drop_pistol", V )

local V = {

	Name = "SMG Ammo Supply",
	Model = "models/Items/BoxMRounds.mdl",
	Class = "tfa_fml_hl2_ammo_drop_smg1",
	Category = "Throwable Ammo",
	Description = "Deployable SMG ammo for all non-revolver pistols.",

}
list.Set( "supplies_list", "tfa_fml_hl2_ammo_drop_smg1", V )

local V = {

	Name = "Sniper Ammo Supply",
	Model = "models/Items/sniper_round_box.mdl",
	Class = "tfa_fml_hl2_ammo_drop_sniper",
	Category = "Throwable Ammo",
	Description = "Deployable high-caliber ammo for all sniper rifles.",

}
list.Set( "supplies_list", "tfa_fml_hl2_ammo_drop_sniper", V )

local V = {

	Name = "Rocket Ammo Supply",
	Model = "models/weapons/w_missile_closed.mdl",
	Class = "tfa_fml_hl2_ammo_drop_missile",
	Category = "Throwable Ammo",
	Description = "Extra rockets for the Demolitionist's RPG.",

}
list.Set( "supplies_list", "tfa_fml_hl2_ammo_drop_missile", V )

local V = {

	Name = "SLAM/Mine Supply",
	Model = "models/weapons/w_slam.mdl",
	Class = "tfa_fml_hl2_ammo_drop_slam",
	Category = "Throwable Ammo",
	Description = "Extra charges for the Demolitionist's SLAM and vehicle mines.",

}
list.Set( "supplies_list", "tfa_fml_hl2_ammo_drop_slam", V )

-- Engineer equipment --

local V = {

	Name = "Vehicle Repair Tool",
	Model = "models/weapons/w_physics.mdl",
	Class = "weapon_ctf_repair",
	Category = "Toolkit",
	Description = "A handheld tool that repairs and restocks ammunition for both land and ground vehicles.",

}
list.Set( "engineers_list", "weapon_ctf_repair", V )

local V = {

	Name = "Fortification Tablet",
	Model = "models/nirrti/tablet/tablet_sfm.mdl",
	Class = "alydus_fortificationbuildertablet",
	Category = "Toolkit",
	Description = "A tablet that provides access to fortification setups. Can be used to make field barricades and checkpoints.",

}
list.Set( "engineers_list", "alydus_fortificationbuildertablet", V )

-- Demolitionist Equipment --

local V = {

	Name = "RPG Platform",
	Model = "models/weapons/w_rocket_launcher.mdl",
	Class = "weapon_lfsmissilelauncher",
	Category = "Demolitions",
	Description = "A radar-assisted rocket propulsion system. Can home onto aircraft from a certain distance.",

}
list.Set( "demolitionists_list", "weapon_rpg", V )

local V = {

	Name = "SLAMS/Mines",
	Model = "models/weapons/w_slam.mdl",
	Class = "weapon_slam",
	Category = "Demolitions",
	Description = "Provides anti-personnel and anti-vehicle mines. Best for traps and taking down armored vehicles.",

}
list.Set( "demolitionists_list", "weapon_simmines", V )
