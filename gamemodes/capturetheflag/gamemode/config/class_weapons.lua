-- Rifleman Weapon Table --

local V = {

	Name = "ARC-C",
	Model = "models/weapons/w_acrc.mdl",
	Class = "tfa_ins2_acrc",
	Category = 2,
	Description = "The ARC-C offers high damage in bursts while suffering from high recoil and spread under sustained fire.",

}
list.Set( "weapons_rifleman_primary", "tfa_ins2_acrc", V )

local V = {

	Name = "SCAR-L",
	Model = "models/weapons/tfa_ins2/w_scarl.mdl",
	Class = "tfa_ins2_scarl",
	Category = 2,
	Description = "The SCAR-L offers great recoil control and low spread. Moderate damage at medium distance.",

}
list.Set( "weapons_rifleman_primary", "tfa_ins2_scarl", V )

-- Marksman Weapon Table --

local V = {

	Name = "MK. 14 EBR",
	Model = "models/weapons/tfa_ins2/w_m14ebr.mdl",
	Class = "tfa_ins2_mk14ebr",
	Category = 3,
	Description = "The MK.14 EBR offers both automatic and semi-automatic firing modes. Best used for offensive engagement.",

}
list.Set( "weapons_marksman_primary", "tfa_ins2_mk14ebr", V )

local V = {

	Name = "GOL Magnum",
	Model = "models/weapons/tfa_ins2/w_gol.mdl",
	Class = "tfa_ins2_gol",
	Category = 3,
	Description = "The GOL Magnum is a bolt-action rifle that offers extremely high damage. An effective sentry weapon.",

}
list.Set( "weapons_marksman_primary", "tfa_ins2_gol", V )

-- Gunner Weapon Table

local V = {

	Name = "RPK-74m",
	Model = "models/weapons/w_rpk_74m.mdl",
	Class = "tfa_ins2_rpk_74m",
	Category = 4,
	Description = "The RPK-74m offers moderate firerate and modest recoil control. Decent range, but poor suppression options.",

}
list.Set( "weapons_gunner_primary", "tfa_ins2_rpk_74m", V )

local V = {

	Name = "M60",
	Model = "models/weapons/w_nam_m60.mdl",
	Class = "tfa_nam_m60",
	Category = 4,
	Description = "The M-60 is a belt-fed machinegun offering high firerate with poor recoil control. Good for suppression.",

}
list.Set( "weapons_gunner_primary", "tfa_nam_m60", V )

-- Demolitionist Weapon Table

local V = {

	Name = "QBZ-97",
	Model = "models/weapons/smc/qbz97/w_warface_t97.mdl",
	Class = "tfa_ins2_norinco_qbz97",
	Category = 5,
	Description = "The QBZ-97 bullpup rifle sports a high capacity magazine and low recoil. Considerably heavy.",

}
list.Set( "weapons_demolitionist_primary", "tfa_ins2_mwr_p90", V)

local V = {

	Name = "H&K MP7",
	Model = "models/weapons/tfa_ins2/w_mp7.mdl",
	Class = "tfa_ins2_mp7",
	Category = 5,
	Description = "The MP7 is a lightweight SMG alternative to the QBZ-97. Moderate damage with high spread.",

}
list.Set( "weapons_demolitionist_primary", "tfa_ins2_mp7", V )

-- Support Weapon Table

local V = {

	Name = "SPAS-12",
	Model = "models/weapons/tfa_ins2/w_spas12_bri.mdl",
	Class = "tfa_ins2_spas12",
	Category = 6,
	Description = "The SPAS-12 holds nine shells with tight pellet spread. Effective at close and midrange.",

}
list.Set( "weapons_support_primary", "tfa_ins2_spas12", V )

local V = {

	Name = "M1014",
	Model = "models/weapons/tfa_ins2/w_m1014.mdl",
	Class = "tfa_ins2_m1014",
	Category = 6,
	Description = "The M1014 is a gas-chambered semi-auto shotgun. Best at close range. Holds seven shells.",

}
list.Set( "weapons_support_primary", "tfa_ins2_m1014", V )

-- Engineer Weaopon Table

local V = {

	Name = "Nova",
	Model = "models/weapons/tfa_ins2/w_nova.mdl",
	Class = "tfa_ins2_nova",
	Category = 7,
	Description = "The Nova shotgun offers eight shells with standard pellet count. Tighter spread, medium range.",

}
list.Set( "weapons_engineer_primary", "tfa_ins2_nova", V )

local V = {

	Name = "M590A1",
	Model = "models/weapons/tfa_ins2/w_m590_olli.mdl",
	Class = "tfa_ins2_m590o",
	Category = 7,
	Description = "The M590A1 combat shotgun offers nine shells with higher pellet count. Short range.",

}
list.Set( "weapons_engineer_primary", "tfa_ins2_m590o", V )

-- Scout Weapon Table

local V = {

	Name = "H&K MP5K",
	Model = "models/weapons/tfa_ins2/w_mp5k.mdl",
	Class = "tfa_ins2_mp5k",
	Category = 8,
	Description = "The MP5 is a lightweight SMG with medium damage and spread. Most effective as a run-and-gun option.",

}
list.Set( "weapons_scout_primary", "tfa_ins2_mp5k", V )

local V = {

	Name = "KRISS VECTOR",
	Model = "models/weapons/tfa_ins2/w_krissv.mdl",
	Class = "tfa_ins2_krissv",
	Category = 8,
	Description = "The KRISS-VECTTOR offers a large magazine and high damage at the cost of spread. Best for sustained fire.",

}
list.Set( "weapons_scout_primary", "tfa_ins2_krissv", V )

-- Medic Weapon Table

local V = {

	Name = "H&K MP5K",
	Model = "models/weapons/tfa_ins2/w_mp5k.mdl",
	Class = "tfa_ins2_mp5k",
	Category = 9,
	Description = "The MP5 is a lightweight SMG with moderate damage and spread. Good for sentry medics.",

}
list.Set( "weapons_medic_primary", "tfa_ins2_mp5k", V)

local V = {

	Name = "H&K MP7",
	Model = "models/weapons/tfa_ins2/w_mp7.mdl",
	Class = "tfa_ins2_mp7",
	Category = 9,
	Description = "The MP7 is a heavier SMG alternative to the MP5. Higher damage and spread. Best combat medic option.",

}
list.Set( "weapons_medic_primary", "tfa_ins2_mp7", V )

