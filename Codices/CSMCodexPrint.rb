require_relative '..\Classes\CodexEntry.rb'
require 'yaml'


chaos_marine_codex = Hash.new{}
faction = ['Chaos','Heretic Astartes']
character = faction.push('Character')
infantry = faction.push('Infantry')
vehicle = faction.push('Vehicle')
dreadnought = vehicle.push('Dreadnought')
flier = vehicle.push('Fly')


abd_cost = 240
cyph_cost = 110
bile_cost = 109
huron_cost = 125
kharn_cost = 160
lucius_cost = 115

bld_let_cost = 7
deamette_cost = 7
blu_hor_cost = 5
brim_hor_cost = 3
pink_hor_cost = 8
plg_ber_cost = 7

biker_cost = 25
cult_cost = 4
lr_cost = 239
pred_cost = 90
rhino_cost = 70
csm_cost = 13
spawn_cost = 33
terminator_cost = 31
vind_cost = 135
chos_cost = 16
dem_prnc_cost = 146
defiler_cost = 152
fallen_cost = 14
forgefiend_cost = 119
havoc_cost = 13
hellbrute_cost = 72
heldrake_cost = 138
brz_cost = 16
maulerfiend_cost = 140
mutil_cost = 50
nos_mrn_cost = 15
oblit_cost = 65
plg_cost = 19
posd_cost = 22
raptor_cost = 17
rub_cost = 18
warp_tal_cost = 15

##Abaddon
abd_stats = [6,2,2,4,5,7,6,10,2]
abd_gear = ['Drach’nyen','Talon of Horus']
abd_rules = ['DTFE','Command Points - 2', 'Invulnerable-4', 'Damage is Halved', 'Aura - 6 - Reroll Hits',
				'Aura - 12 - Pass Morale', 'Deepstrike']
chaos_marine_codex['Abaddon The Despoiler'] = CodexEntry.new(abd_stats, abd_gear, abd_rules, abd_cost, character)

bile = [6,2,3,5,4,5,6,9,3]
bile_gear = ['Xyclos Needler', 'Rod of Torment', 'Frag Grenade', 'Krak Grenade']
bile_rules = ['DTFE']
chaos_marine_codex['Fabius Bile'] = CodexEntry.new(bile, bile_gear, bile_rules, bile_cost, character)

kharn = [6,2,2,5,4,5,6,9,3]
kharn_gear = ['Gorechild','Kharns Plasma Pistol','Frag Grenade', 'Krak Grenade']
kharn_rules = ['Invulnerable-4', 'Fight Twice', 'Aura - 1 - Reroll Hits']
chaos_marine_codex['Kharn the Betrayer'] = CodexEntry.new(kharn, kharn_gear, kharn_rules, kharn_cost, character)

lucius_stats = [6,2,2,4,4,5,5,9,3]
lucius_gear = ['Lash of Torment', 'Master-crafted Power Sword', 'Doom Siren', 'Frag Grenade', 'Krak Grenade']
lucius_rules = ['Invulnerable-4', 'Aura - 6 - Reroll Hits']
chaos_marine_codex['Lucius The Eternal'] = CodexEntry.new(lucius_stats, lucius_gear, lucius_rules, lucius_cost, character)


cyph_stats = [7,2,2,4,4,5,4,9,3]
cyph_gear = ['Cyphers Bolt Pistol', 'Cyphers Plasma Pistol', 'Frag Grenade', 'Krak Grenade']
chaos_marine_codex['Cypher'] = CodexEntry.new(cyph_stats, cyph_gear, lucius_rules, cyph_cost, character)

huron_gear = ['Tyrants Claw', 'Power Axe', 'Frag Grenade', 'Krak Grenade']
huron_rules = ['Invulnerable-4', 'Psyker - 2', 'Command Points - 1', 'Aura - 6 - Reroll Hits']
chaos_marine_codex['Huron Blackheart'] = CodexEntry.new(lucius_stats,huron_gear, huron_rules, huron_cost, character)

dem_prnc_stats = [8,2,2,7,6,8,4,10,3]
dem_prnc_gear = ['Malefic Talons', 'Malefic Talons']
dem_prnc_rules = ['DTFE', 'Invulnerable-5' 'Aura - 6 - Reroll Hits - 1']
chaos_marine_codex['Daemon Prince'] = CodexEntry.new(dem_prnc_stats,dem_prnc_gear, dem_prnc_rules, dem_prnc_cost, character)





fallen_stats = [6, 3, 3, 4, 4, 1, 2, 8, 3]
fallen_chmp_stats = [6, 3, 3, 4, 4, 1, 3, 9, 3]
fallen_gear = ['Boltgun', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
fallen_rules = ['DTFE', 'Stationary - Reroll 1']
chaos_marine_codex['Fallen'] = CodexEntry.new(fallen_stats, fallen_gear, fallen_rules, fallen_cost, infantry)
chaos_marine_codex['Fallen Champion'] = CodexEntry.new(fallen_chmp_stats, fallen_gear, fallen_rules, fallen_cost, infantry)

### Chaos Marine
csm_stats = [6, 3, 3, 4, 4, 1, 1, 7, 3]
csm_gear = ['Boltgun', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
csm_rules = ['DTFE']
csm_cost = 13
chaos_marine_codex['Chaos Space Marine'] = CodexEntry.new(csm_stats, csm_gear, csm_rules, csm_cost, infantry)

###Sergeant
sergeant_stats = [6, 3, 3, 4, 4, 1, 2, 8, 3]
chaos_marine_codex['Aspiring Champion'] = CodexEntry.new(sergeant_stats, csm_gear, csm_rules, csm_cost, infantry)

### Cultists
cult_stats = [6,4,4,3,3,1,1,5,6]
cult_chmp_stats = [6,4,4,3,3,1,2,6,6]
cult_gear = ['Autogun']
cult_rules = []
chaos_marine_codex['Chaos Cultist'] = CodexEntry.new(cult_stats, cult_gear, cult_rules, cult_cost, infantry)
chaos_marine_codex['Cultist Champion'] = CodexEntry.new(cult_chmp_stats, cult_gear, cult_rules, cult_cost, infantry)


##Bloodletters
bld_let_gear = ['Hellblade']
bld_let_stats = [6,3,3,4,3,1,1,7,6]
bld_rep_stats = [6,3,3,4,3,1,2,7,6]
bld_let_rules = ['Invulnerable-5', 'Furious Charge']
chaos_marine_codex['Bloodletter'] = CodexEntry.new(bld_let_stats, bld_let_gear, bld_let_rules, bld_let_cost, infantry)
chaos_marine_codex['Bloodreaper'] = CodexEntry.new(bld_rep_stats, bld_let_gear, bld_let_rules, bld_let_cost, infantry)

##Horors
pink_hor_stats = [6,4,4,3,3,1,1,7,6]
blu_hor_stats = [6,5,7,2,3,1,1,7,6]
brim_hor_stats = [6,5,7,1,3,1,2,7,6]
pink_gear = ['Coruscating Flame']
hor_rules = ['Invulnerable-5', 'Psyker - 1', 'Minor Smite']
chaos_marine_codex['Pink Horror'] = CodexEntry.new(pink_hor_stats, pink_gear, hor_rules, pink_hor_cost, infantry)
chaos_marine_codex['Brimstone Horrors'] = CodexEntry.new(brim_hor_stats, [], hor_rules, brim_hor_cost, infantry)
chaos_marine_codex['Blue Horrors'] = CodexEntry.new(blu_hor_stats, [], hor_rules, blu_hor_cost, infantry)


##Plaguebearers
plg_ber_stats = [5,4,4,4,4,1,1,7,6]
plg_rid_stats = [5,4,4,4,4,1,3,7,6]
plg_ber_gear = ['Plaguesword']
plg_ber_rules = ['Invulnerable-5', 'FNP - 5']
chaos_marine_codex['Plaguebearer'] = CodexEntry.new(plg_ber_stats, plg_ber_gear, plg_ber_rules, plg_ber_cost, infantry)
chaos_marine_codex['Plagueridden'] = CodexEntry.new(plg_rid_stats, plg_ber_gear, plg_ber_rules, plg_ber_cost, infantry)

##Deamonettes
deamette_stats = [7,3,3,3,3,1,2,7,6]
alluress_stats = [7,3,3,3,3,1,3,7,6]
deamette_gear = ['Piercing Claws']
deamette_rules = ['Invulnerable-5', 'Always Strikes First']
chaos_marine_codex['Deamonette'] = CodexEntry.new(deamette_stats, deamette_gear, deamette_rules, deamette_cost, infantry)
chaos_marine_codex['Alluress'] = CodexEntry.new(alluress_stats, deamette_gear, deamette_rules, deamette_cost, infantry)

khorn_brz_stats = [6,3,3,5,4,1,2,7,3]
brz_chmp_stats = [6,3,3,5,4,1,3,8,3]
brz_gear = ['Bolt Pistol', 'Chainsword','Frag Grenade','Krak Grenade']
brz_rules = ['DTFE','Fights Twice']
chaos_marine_codex['Khorne Berzerker'] = CodexEntry.new(khorn_brz_stats, brz_gear, brz_rules, brz_cost, infantry)
chaos_marine_codex['Berzerker Champion'] = CodexEntry.new(brz_chmp_stats, brz_gear, brz_rules, brz_cost, infantry)

rub_stats = [5,3,3,4,4,1,1,7,3]
asp_sorc_stats = [6,3,3,4,4,1,2,8,3]
rub_gear = ['Inferno Boltgun']
asp_sorc_gear = ['Force Stave', 'Inferno Bolt Pistol']
rub_rules = ['Invulnerable-5', 'DTFE', 'Move and Fire', 'All is Dust']
asp_sorc_rules = ['Invulnerable-5', 'DTFE', 'Move and Fire', 'All is Dust', 'Psyker - 1', 'Minor Smite']
chaos_marine_codex['Rubric Marine'] = CodexEntry.new(rub_stats, rub_gear, rub_rules, rub_cost, infantry)
chaos_marine_codex['Aspiring Sorcerer'] = CodexEntry.new(asp_sorc_stats, asp_sorc_gear, asp_sorc_rules, rub_cost, infantry)


plg_mrn = [5,3,3,4,5,1,1,7,3]
plg_chmp = [5,3,3,4,5,1,2,8,3]
plg_gear = ['Plague Knige', 'Boltgun', 'Blight Grenade', 'Krak Grenade']
plg_mrn_rules = ['DTFE', 'FNP - 5']
chaos_marine_codex['Plague Marine'] = CodexEntry.new(plg_mrn, plg_gear, plg_mrn_rules, plg_cost, infantry)
chaos_marine_codex['Plague Champion'] = CodexEntry.new(plg_chmp, plg_gear, plg_mrn_rules, plg_cost, infantry)

nos_mrn = [6,3,3,4,4,1,2,7]
nos_chmp = [6,3,3,4,4,1,3,8,3]
nos_mrn_rules = ['DTFE' 'Shoot Back - Auto']
chaos_marine_codex['Noise Marine'] = CodexEntry.new(nos_mrn, csm_gear, nos_mrn_rules, nos_mrn_cost, infantry)
chaos_marine_codex['Plague Champion'] = CodexEntry.new(nos_chmp, csm_gear, nos_mrn_rules, nos_mrn_cost, infantry)

chos_rules = ['DTFE']
chaos_marine_codex['Chosen'] = CodexEntry.new(fallen_stats, csm_gear, chos_rules, chos_cost, infantry)
chaos_marine_codex['Chosen Champion'] = CodexEntry.new(fallen_chmp_stats, csm_gear, chos_rules, chos_cost, infantry)

mutil_stats = [4,3,3,5,4,3,3,8,2]
mutil_gear = ['Fleshmetal Weapons']
mutil_rules = ['Invulnerable-5', 'DTFE', 'Deepstrike']
chaos_marine_codex['Mutilator'] = CodexEntry.new(mutil_stats, mutil_gear, mutil_rules, mutil_cost, infantry)


#Terminators
terminator_stats = [5,3,3,4,4,2,2,8,2]
terminator_sergeant_stats = [5,3,3,4,4,2,3,9,2]
terminator_gear = ['Combi-bolter', 'Power Axe']
terminator_rules = ['DTFE','Invulnerable-5','Deepstrike']
chaos_marine_codex['Chaos Terminator'] = CodexEntry.new(terminator_stats, terminator_gear, terminator_rules, terminator_cost, infantry)
chaos_marine_codex['Terminator Champion'] = CodexEntry.new(terminator_sergeant_stats, terminator_gear, terminator_rules, terminator_cost, infantry)

##Posessed
posd_stats = [7,3,3,5,4,2,0,8,3]
posd_rules = ['Invulnerable-5', 'DTFE', 'Attacks - D3']
posd_gear = ['Horrifying Mutations']
chaos_marine_codex['Possesed'] = CodexEntry.new(posd_stats, posd_gear, posd_rules, posd_cost, infantry)

hellbrute_stats = [8,3,3,6,7,8,4,8,3]
hellbrute_gear = ['Multi-Melta', 'Hellbrute Fist','Hellbrute Fist']
hellbrute_rules = ['Crazed', 'Attacks - Two CCW - 1']
chaos_marine_codex['Hellbrutes'] = CodexEntry.new(hellbrute_stats, hellbrute_gear, hellbrute_rules, hellbrute_cost, infantry)

biker_stats = [14,3,3,4,5,2,1,7,3]
biker_sarge_stats = [14,3,3,4,5,2,2,8,3]
biker_gear = ['Combi-bolter','Bolt Pistol','Frag Grenade','Krak Grenade']
biker_rules = ['DTFE','Turbo Boost']
chaos_marine_codex['Chaos Biker'] = CodexEntry.new(biker_stats, biker_gear, biker_rules, biker_cost, infantry)
chaos_marine_codex['Chaos Biker Champion'] = CodexEntry.new(biker_sarge_stats, biker_gear, biker_rules, biker_cost, infantry)

spawn = [7,4,4,5,5,4,'D6',9,5]
spawn_gear = ['Hideous Mutations']
spawn_rules = ['Fear - 1']
chaos_marine_codex['Chaos Spawn'] = CodexEntry.new(spawn, spawn_gear, spawn_rules, spawn_cost, infantry)

ass_marine_gear = ['Bolt Pistol', 'Chainsword','Frag Grenade','Krak Grenade']
raptor_rules = ['DTFE', 'Fear - 1', 'Deepstrike']
chaos_marine_codex['Raptor'] = CodexEntry.new(csm_stats, ass_marine_gear, raptor_rules, raptor_cost, infantry)
chaos_marine_codex['Raptor Champion'] = CodexEntry.new(sergeant_stats, ass_marine_gear, raptor_rules, raptor_cost, infantry)

warp_tal = [12,3,3,4,4,1,1,8,3]
warp_tal_chmp = [12,3,3,4,4,1,1,2,3]
warp_tal_gear = ['Two Lightning Claws']
warp_tal_rules = ['Invulnerable-5', 'DTFE', 'Deepstrike']
chaos_marine_codex['Warp Talon'] = CodexEntry.new(warp_tal, warp_tal_gear, warp_tal_rules, warp_tal_cost, infantry)
chaos_marine_codex['Warp Talon Champion'] = CodexEntry.new(warp_tal_chmp, warp_tal_gear, warp_tal_rules, warp_tal_cost, infantry)

chaos_marine_codex['Havoc'] = CodexEntry.new(csm_stats, csm_gear, csm_rules, havoc_cost, infantry)

oblit_stats = [4,3,3,5,4,3,3,8,2]
oblit_gear = ['Fleshmetal Guns']
oblit_rules = ['Invulnerable-5', 'Deepstrike', 'DTFE']
chaos_marine_codex['Obliterator'] = CodexEntry.new(oblit_stats, oblit_gear, oblit_rules, oblit_cost, infantry)


land_raider = [10,6,3,8,8,16,6,9,2]
land_raider_gear = ['Twin Heavy Bolter', 'Twin Lascannon', 'Twin Lascannon']
land_raider_rules = ['Move and Fire']
chaos_marine_codex['Chaos Land Raider'] = CodexEntry.new(land_raider, land_raider_gear, land_raider_rules, lr_cost, vehicle)

defiler_stats = [8,4,4,8,7,14,4,8,3]
defiler_gear = ['Battle Cannon', 'Reaper Autocannon', 'Twin Heavy Flamer', 'Defiler Claws']
defiler_rules = ['Invulnerable-5', 'Regeneration - 1']
chaos_marine_codex['Defiler'] = CodexEntry.new(defiler_stats , defiler_gear, defiler_rules, defiler_cost, dreadnought)


fiend_stats = [8,4,4,6,7,12,4,8,3]
forgefiend_gear = ['Hades Autocannon','Hades Autocannon','Daemon Jaws']
maulerfiend_gear = ['Maulerfiend Fists','Magma Cutter','Magma Cutter']
chaos_marine_codex['Forgefiend'] = CodexEntry.new(fiend_stats , forgefiend_gear, defiler_rules, forgefiend_cost, dreadnought)
chaos_marine_codex['Maulerfiend'] = CodexEntry.new(fiend_stats , maulerfiend_gear, defiler_rules, maulerfiend_cost, dreadnought)

pred = [12,6,3,6,7,11,3,8,3]
vehicle_rules = ['Smoke Launcher']
predator_gear = ['Predator Autocannon']
chaos_marine_codex['Chaos Predator'] = CodexEntry.new(pred, predator_gear, vehicle_rules, pred_cost, vehicle)

vindicator_gear = ['Demolisher Cannon']
chaos_marine_codex['Chaos Vindicator'] = CodexEntry.new(pred, vindicator_gear, vehicle_rules, vind_cost, vehicle)


rhino = [12,6,3,6,7,10,3,8,3]
chaos_marine_codex['Chaos Rhino'] = CodexEntry.new(rhino, ['Storm Bolter'], vehicle_rules, rhino_cost, vehicle)

heldrake_stats = [30,3,4,7,7,12,4,8,3]
heldrake_gear = ['Hades Autocannon','Heldrake Claws']
heldrake_rules = ['Invulnerable-5', 'Regeneration - 1', 'Fly']
chaos_marine_codex['Heldrake'] = CodexEntry.new(heldrake_stats, heldrake_gear, heldrake_rules, heldrake_cost, flier)



File.write('ChaosSpaceMarineCodex.yml', chaos_marine_codex.to_yaml)