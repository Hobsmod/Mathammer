require_relative '..\Classes\CodexEntry.rb'
require 'yaml'


spacemarinecodex = Hash.new{}

##Marneus Calgar
calgar_stats = [5,2,2,4,4,7,5,9,2,4]
calgar_gear = ['Gauntlets of Ultramar','Relic Blade']
calgar_rules = ['Chapter Master','Character']
calgar_cost = 200
spacemarinecodex['Marneus Calgar'] = CodexEntry.new(calgar_stats, calgar_gear, calgar_rules, calgar_cost)

##Chief Librarian Tigerius
tigerius_stats = [6,3,3,4,4,4,3,9,3]
tigerius_gear = ['Rod of Tigerius','Bolt Pistol','Frag Grenade','Krak Grenade','Smite','Librarius Discipline']
tigerius_rules = ['Character','+1 Deny','Reroll Psyker','-1 Hit Buff','2 Powers']
tigerius_cost = 130
spacemarinecodex['Chief Librarian Tigerius'] = CodexEntry.new(tigerius_stats, tigerius_gear, tigerius_rules, tigerius_cost)

##Chaplain Cassius
cassius_stats = [6,2,3,4,5,4,3,9,3,4]
cassius_gear = ['Infernus','Crozius Arcanum','Frag Grenade','Krak Grenade']
cassius_rules = ['Character','Reroll Fight Hits']
cassius_cost = 98
spacemarinecodex['Chaplain Cassius'] = CodexEntry.new(cassius_stats, cassius_gear, cassius_rules, cassius_cost)




### Tactical Marine
tactical_stats = [6, 3, 3, 4, 4, 1, 1, 7, 3]
tactical_gear = ['Boltgun', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
tactical_rules = ['ATSKNF']
tactical_cost = 13
spacemarinecodex['Tactical Marine'] = CodexEntry.new(tactical_stats, tactical_gear, tactical_rules, tactical_cost)

###Sergeant
sergeant_stats = [6, 3, 3, 4, 4, 1, 2, 8, 3]
spacemarinecodex['Tactical Marine Sergeant'] = CodexEntry.new(sergeant_stats, tactical_gear, tactical_rules, tactical_cost)

###Intercessors
intercessor_stats = [6, 3, 3, 4, 4, 2, 2, 7, 3]
intercessor_gear = ['Bolt Rifle', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
intercessor_rules = ['ATSKNF']
intercessor_cost = 20
spacemarinecodex['Intercessor'] = CodexEntry.new(intercessor_stats, intercessor_gear, intercessor_rules, intercessor_cost)

intercessor_sergeant_stats = [6, 3, 3, 4, 4, 2, 3, 8, 3]
spacemarinecodex['Intercessor Sergeant'] = CodexEntry.new(intercessor_sergeant_stats, intercessor_gear, intercessor_rules, intercessor_cost)

###Scouts
scouts_stats = [6, 3, 3, 4, 4, 1, 1, 7, 4]
scouts_sarge_stats = [6, 3, 3, 4, 4, 1, 2, 8, 4]
scouts_gear = ['Boltgun', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
scouts_rules = ['ATSKNF']
scouts_cost = 11
spacemarinecodex['Scouts'] = CodexEntry.new(scouts_stats, scouts_gear, scouts_rules, scouts_cost)
spacemarinecodex['Scout Sergeant'] = CodexEntry.new(scouts_sarge_stats, scouts_gear, scouts_rules, scouts_cost)
## Primaris Ancient
primaris_ancient_stats = [6, 3, 3, 4, 4, 5, 4, 8, 3]
primaris_ancient_rules = ['ATSKNF','4+ Fight Back']
primaris_ancient_cost = 69
spacemarinecodex['Primaris Ancient'] = CodexEntry.new(primaris_ancient_stats, intercessor_gear, primaris_ancient_rules, primaris_ancient_cost)

#Chapter Ancient
chapter_ancient_stats = [6, 3, 3, 4, 4, 4, 3, 9, 2]
chapter_ancient_gear = ['Power Sword', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
chapter_ancient_cost = 63
spacemarinecodex['Chapter Ancient'] = CodexEntry.new(chapter_ancient_stats, chapter_ancient_gear, primaris_ancient_rules, chapter_ancient_cost)

#Company Ancient
company_ancient_stats = [6, 3, 3, 4, 4, 4, 3, 9, 3]
company_ancient_gear = ['Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
company_ancient_cost = 
spacemarinecodex['Company Ancient'] = CodexEntry.new(company_ancient_stats, company_ancient_gear, primaris_ancient_rules, company_ancient_cost)

#Chapter Champion
chapter_champion_stats = [6, 2, 3, 4, 4, 4, 4, 9, 2]
chapter_champion_gear = ['Champions Blade', 'Power Sword' 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
chapter_champion_rules = ['Character', 'ATSKNF', 'Duelist - Hits']
chapter_champion_cost = 63
spacemarinecodex['Chapter Champion'] = CodexEntry.new(chapter_champion_stats, chapter_champion_gear, chapter_champion_rules, chapter_champion_cost)

#Honor Guard
h_guard_stats = [6, 3, 3, 4, 4, 2, 2, 9, 2]
h_guard_gear = ['Boltgun', 'Power Axe' 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
h_guard_rules = ['ATSKNF', 'Honor Guard']
h_guard_cost = 63
spacemarinecodex['Honor Guard'] = CodexEntry.new(h_guard_stats, h_guard_gear, h_guard_rules, h_guard_cost)


#Chapter Champion
company_champion_stats = [6, 2, 3, 4, 4, 4, 3, 8, 3, 5]
company_champion_gear = [ 'Master-crafted Power Sword' 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade', 'Combat Shield']
company_champion_rules = ['Character', 'ATSKNF', 'Duelist - Hits']
company_champion_cost = 63
spacemarinecodex['Company Champion'] = CodexEntry.new(company_champion_stats, company_champion_gear, company_champion_rules, company_champion_cost)

#Company Veterans
veteran_sergeant_stats = [6, 3, 3, 4, 4, 1, 3, 9, 3]
company_veterans_gear = [ 'Chainsword' 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade', 'Combat Shield']
company_veterans_rules = ['ATSKNF']
spacemarinecodex['Company Veterans'] = CodexEntry.new(sergeant_stats, company_veterans_gear, company_veterans_rules, 16)

#Reviver Squad
reiver_gear = ['Bolt Carbine','Heavy Bolt Pistol','Frag Grenade','Krak Grenade']
reiver_rules = ['ATSKNF','-1 Ld']
reiver_cost = 18
spacemarinecodex['Reiver'] = CodexEntry.new(intercessor_stats, reiver_gear, reiver_rules, reiver_cost)
spacemarinecodex['Reiver Sergeant'] = CodexEntry.new(intercessor_sergeant_stats, reiver_gear, reiver_rules, reiver_cost)

#Aggressors
aggressor_stats = [5,3,3,4,5,2,2,7,3]
aggressor_sergeant_stats = [5,3,3,4,5,2,3,8,3]
aggressor_gear = ['Auto Boltstorm Gauntlet','Fragstorm Grenade Launcher']
aggressor_rules = ['ATSKNF','Fire Storm','Move and Fire']
spacemarinecodex['Aggressor'] = CodexEntry.new(aggressor_stats, aggressor_gear, aggressor_rules, 25)
spacemarinecodex['Aggressor Sergeant'] = CodexEntry.new(aggressor_sergeant_stats, aggressor_gear, aggressor_rules, 25)

#Terminators
terminator_stats = [5,3,3,4,4,2,2,8,2,5]
terminator_sergeant_stats = [5,3,3,4,4,2,3,9,2,5]
terminator_gear = ['Storm Bolter', 'Power Fist']
terminator_sergeant_gear = ['Storm Bolter', 'Power Sword']
terminator_rules = ['ATSKNF','Invulnerable-5','Deepstrike']
terminator_cost = 26
spacemarinecodex['Terminator'] = CodexEntry.new(terminator_stats, terminator_gear, terminator_rules, terminator_cost)
spacemarinecodex['Terminator Sergeant'] = CodexEntry.new(terminator_sergeant_stats, terminator_sergeant_gear, terminator_rules, terminator_cost)

#Assault Terminators
assault_terminator_gear = ['Two Storm Claws']
assault_terminator_cost = 31
spacemarinecodex['Assault Terminator'] = CodexEntry.new(terminator_stats, assault_terminator_gear, terminator_rules, 31)
spacemarinecodex['Assault Terminator Sergeant'] = CodexEntry.new(terminator_sergeant_stats, assault_terminator_gear, terminator_rules, 31)

#Cataphractii Terminators
cataphractii_stats = [4,3,3,4,4,2,2,8,2,4]
cataphractii_sergeant_stats = [4,3,3,4,4,2,3,9,2,4]
cataphractii_gear = ['Combi-bolter', 'Power Fist']
cataphractii_sergeant_gear = ['Combi-bolter', 'Power Sword']
cataphractii_rules = ['ATSKNF', 'Invulnerable-4', 'Deepstrike']
spacemarinecodex['Cataphractii Terminator'] = CodexEntry.new(cataphractii_stats, cataphractii_gear, terminator_rules, 30)
spacemarinecodex['Cataphractii Terminator Sergeant'] = CodexEntry.new(cataphractii_sergeant_stats, cataphractii_sergeant_gear, cataphractii_rules, 30)

#Tartaros Terminators
tartaros_stats = [6,3,3,4,4,2,2,8,2,5]
tartaros_sergeant_stats = [6,3,3,4,4,2,3,9,2,5]
spacemarinecodex['Tartaros Terminator'] = CodexEntry.new(tartaros_stats, cataphractii_gear, terminator_rules, 31)
spacemarinecodex['Tartaros Terminator Sergeant'] = CodexEntry.new(tartaros_sergeant_stats, cataphractii_sergeant_gear, terminator_rules, 31)

#Vanguard Veterans
vanguard_gear = ['Bolt Pistol', 'Chainsword', 'Frag Grenade', 'Krak Grenade']
spacemarinecodex['Vanguard Veterans'] = CodexEntry.new(sergeant_stats, vanguard_gear, tactical_rules, 16)
spacemarinecodex['Vanguard Veteran Sergeant'] = CodexEntry.new(veteran_sergeant_stats, vanguard_gear, tactical_rules, 16)

#Vanguard Veterans
sternguard_gear = ['Bolt Pistol', 'Special Issue Boltgun', 'Frag Grenade', 'Krak Grenade']
spacemarinecodex['Sternguard Veterans'] = CodexEntry.new(sergeant_stats, sternguard_gear, tactical_rules, 16)
spacemarinecodex['Sternguard Veteran Sergeant'] = CodexEntry.new(veteran_sergeant_stats, sternguard_gear, tactical_rules, 16)

dreadnought_stats = [6,3,3,6,7,8,4,8,3]
dreadnought_gear = ['Assault Cannon', 'Storm Bolter', 'Dreadnought Close Combat Weapon']
dreadnought_rules = ['Smoke Launchers']
spacemarinecodex['Dreadnought'] = CodexEntry.new(dreadnought_stats, dreadnought_gear, dreadnought_rules, 70)

ironclad_dreadnought_gear = ['Seismic Hammer', 'Meltagun', 'Storm Bolter', 'Dreadnought Close Combat Weapon']
ironclad_dreadnought_stats = [6,3,3,6,8,8,4,8,3]
spacemarinecodex['Ironclad Dreadnought'] = CodexEntry.new(ironclad_dreadnought_stats, ironclad_dreadnought_gear, dreadnought_rules, 80)

ven_dread_stats = [6,2,2,6,7,8,4,8,3]
ven_dread_rules = ['FNP - 6']
spacemarinecodex['Venerable Dreadnought'] = CodexEntry.new(ven_dread_stats, dreadnought_gear, ven_dread_rules, 90)

contempt_dread_stats = [9,2,2,7,7,10,4,8,3,5]
contempt_rules = ['Invulnerable-5']
contempt_gear = ['Multi-Melta', 'Combi-bolter', 'Dreadnought Close Combat Weapon']
spacemarinecodex['Contemptor Dreadnought'] = CodexEntry.new(contempt_dread_stats, contempt_gear, contempt_rules, 98)

redem_dread_stats = [8,3,3,7,7,13,4,8,3]
redem_dread_gear = ['Heavy Onslaught Gattling Cannon', 'Heavy Flamer', 'Icarus Rocket Pod', 'Fragstorm Grenade Launcher',
'Fragstorm Grenade Launcher', 'Redemptor Fist']
redem_dread_rules = []
spacemarinecodex['Redemptor Dreadnought'] = CodexEntry.new(redem_dread_stats, redem_dread_gear, redem_dread_rules, 140)

centurion_stats = [4,3,3,5,5,3,2,7,2]
centurion_sarge_stats = [4,3,3,5,5,3,3,8,2]
centurion_gear = ['Siege Drills', 'Flamer', 'Flamer', 'Centurion Assault Launcher']
centurion_rules = ['Ignores Cover']
spacemarinecodex['Assault Centurion'] = CodexEntry.new(centurion_stats, centurion_gear, centurion_rules, 53)
spacemarinecodex['Assault Centurion Sergeant'] = CodexEntry.new(centurion_sarge_stats, centurion_gear, centurion_rules, 53)

biker_stats = [14,3,3,4,5,2,1,7,3]
biker_sarge_stats = [14,3,3,4,5,2,2,8,3]
atk_bike_stats = [14,3,3,4,5,4,2,7,3]
atk_biker_gear = ['Heavy Bolter']
biker_gear = ['Twin Boltgun','Bolt Pistol','Frag Grenade','Krak Grenade']
biker_rules = ['Turbo Boost']
spacemarinecodex['Biker'] = CodexEntry.new(biker_stats, biker_gear, biker_rules, 25)
spacemarinecodex['Biker Sergeant'] = CodexEntry.new(biker_sarge_stats, biker_gear, biker_rules, 25)
spacemarinecodex['Attack Bike'] = CodexEntry.new(atk_bike_stats, atk_biker_gear, biker_rules, 35)

ass_marine_gear = ['Bolt Pistol', 'Chainsword','Frag Grenade','Krak Grenade']
spacemarinecodex['Assault Marine'] = CodexEntry.new(tactical_stats, ass_marine_gear, tactical_rules, 13)
spacemarinecodex['Assault Marine Sergeant'] = CodexEntry.new(sergeant_stats, ass_marine_gear, tactical_rules, 13)

land_speeder_stats = [16,3,3,4,5,6,2,7,3]
land_speeder_gear = ['Heavy Bolter']
ls_rules = ['Fly']
spacemarinecodex['Land Speeder'] = CodexEntry.new(land_speeder_stats, land_speeder_gear, ls_rules, 70)

scout_bike = [16,3,3,4,5,2,1,7,4]
scout_bike_sarge = [16,3,3,4,5,2,2,8,4]
scout_bike_gear = ['Bolt Pistol', 'Astartes Shotgun', 'Combat Knife','Frag Grenade','Krak Grenade']
scout_bike_rules = ['Turbo-boost']
spacemarinecodex['Scout Biker'] = CodexEntry.new(scout_bike, scout_bike_gear, scout_bike_rules, 23)
spacemarinecodex['Scout Biker Sergeant'] = CodexEntry.new(scout_bike_sarge, scout_bike_gear, scout_bike_rules, 23)

interceptors = [10,3,3,4,5,2,2,7,3]
interceptors_sarge = [10,3,3,4,5,2,3,8,3]
intercept_gear = ['Assault Bolter', 'Assault Bolter']
spacemarinecodex['Interceptor'] = CodexEntry.new(interceptors, intercept_gear, redem_dread_rules, 30)
spacemarinecodex['Interceptor Sergeant'] = CodexEntry.new(interceptors_sarge, intercept_gear, redem_dread_rules, 30)

devestator_rules = ['Signum', 'ATSKNF']
spacemarinecodex['Devestator'] = CodexEntry.new(tactical_stats, tactical_gear, devestator_rules, 13)
spacemarinecodex['Devestator Sergeant'] = CodexEntry.new(sergeant_stats, tactical_gear, devestator_rules, tactical_cost)

centurion_dev_gear = ['Heavy Bolter', 'Heavy Bolter', 'Hurricane Bolter']
centurion_dev_rules = ['Move and Fire', 'ATSKNF', 'Ignores Cover']
spacemarinecodex['Centurion Devestator'] = CodexEntry.new(centurion_stats, centurion_dev_gear, centurion_dev_rules, 80)
spacemarinecodex['Centurion Devestator Sergeant'] = CodexEntry.new(centurion_sarge_stats, centurion_dev_gear, centurion_dev_rules, 80)

hellblaster_gear = ['Plasma Incinerator', 'Bolt Pistol','Frag Grenade','Krak Grenade']
spacemarinecodex['Hellblaster'] = CodexEntry.new(intercessor_stats, hellblaster_gear, tactical_rules, 18)
spacemarinecodex['Hellblaster Sergeant'] = CodexEntry.new(intercessor_sergeant_stats, hellblaster_gear, tactical_rules, 18)

thunderfire_cannon = [3,6,3,3,6,4,1,8,3]
tech_gunner = [6,3,2,4,4,2,3,8,2]
thunderfire_gear = ['Thunderfire Cannon']
tech_gunner_gear = ['Servo Arm', 'Servo Arm', 'Bolt Pistol', 'Plasma Cutter', 'Flamer']
spacemarinecodex['Thunderfire Cannon'] = CodexEntry.new(thunderfire_cannon, thunderfire_gear, tactical_rules, 55)
spacemarinecodex['Techmarine Gunner'] = CodexEntry.new(tech_gunner, tech_gunner_gear, tactical_rules, 26)

hunter = [10,6,3,6,8,11,3,8,3]
hunter_gear = ['Skyspear Missile Launcher']
spacemarinecodex['Hunter'] = CodexEntry.new(hunter, hunter_gear, dreadnought_rules, 90)



stalker_gear = ['Icarus Stormcannon', 'Icarus Stormcannon']
spacemarinecodex['Stalker'] = CodexEntry.new(hunter, stalker_gear, dreadnought_rules, 80)

whirlwind_gear = ['Whirlwind Vengeance Launcher']
spacemarinecodex['Whirlwind'] = CodexEntry.new(hunter, whirlwind_gear, dreadnought_rules, 75)

predator_gear = ['Predator Autocannon']
spacemarinecodex['Predator'] = CodexEntry.new(hunter, predator_gear, dreadnought_rules, 90)

vindicator_gear = ['Demolisher Cannon']
spacemarinecodex['Vindicator'] = CodexEntry.new(hunter, vindicator_gear, dreadnought_rules, 135)

land_raider = [10,6,3,8,8,16,6,9,2]
land_raider_gear = ['Twin Heavy Bolter', 'Twin Lascannon', 'Twin Lascannon']
land_raider_rules = ['Move and Fire']
spacemarinecodex['Land Raider'] = CodexEntry.new(land_raider, land_raider_gear, land_raider_rules, 239)

lr_crusader_gear = ['Twin Assault Cannon', 'Hurricane Bolter', 'Hurricane Bolter']
lr_redeem_gear = ['Twin Assault Cannon', 'Flamestorm Cannon', 'Flamestorm Cannon']
spacemarinecodex['Land Raider Crusader'] = CodexEntry.new(land_raider, lr_crusader_gear, land_raider_rules, 244)
spacemarinecodex['Land Raider Redeemer'] = CodexEntry.new(land_raider, lr_redeem_gear, land_raider_rules, 244)

rhino = [12,6,3,6,7,10,3,8,3]

spacemarinecodex['Rhino'] = CodexEntry.new(rhino, ['Storm Bolter'], dreadnought_rules, 70)
spacemarinecodex['Razorback'] = CodexEntry.new(rhino, ['Twin Heavy Bolter'], dreadnought_rules, 75)

land_speeder_storm = [18,3,3,4,5,7,2,7,4]
ls_storm_gear = ['Heavy Bolter', 'Cerberus Launcher']
ls_rules = ['Fly']
spacemarinecodex['Land Speeder Storm'] = CodexEntry.new(land_speeder_storm, ls_storm_gear, ls_rules, 70)

repulsor = [10,6,3,8,8,16,6,9,3]
repulsor_rules = ['Fly']
repulsor_gear = ['Heavy Onslaught Gattling Cannon', 'Twin Heavy Bolter', 'Ironhail Heavy Stubber',
'Icarus Ironhail Heavy Stubber', 'Krakstorm Grenade Launcher', 'Krakstorm Grenade Launcher', 'Storm Bolter',
'Storm Bolter']
spacemarinecodex['Repulsor'] = CodexEntry.new(repulsor, repulsor_gear, repulsor_rules, 210)

stormhawk = [60,6,3,6,7,10,3,8,3]
stormhawk_gear = ['Assault Cannon' 'Assault Cannon', 'Heavy Bolter', 'Heavy Bolter', 'Icarus Stormcannon']
stormhawk_rules = ['Hard to Hit - 1', 'Reroll - Saves - 1', 'AA - 1', 'Fly']
spacemarinecodex['Stormhawk Interceptor'] = CodexEntry.new(stormhawk, stormhawk_gear, stormhawk_rules, 85)

stormtalon = [60,6,3,6,6,10,3,8,3]
stormtalon_gear = ['Twin Assault Cannon', 'Heavy Bolter', 'Heavy Bolter', 'Fly']
stormtalon_rules = ['Hard to Hit', 'Anti-Ground']
spacemarinecodex['Stormtalon Gunship'] = CodexEntry.new(stormtalon, stormtalon_gear, stormtalon_rules, 110)

stormraven = [45,6,3,8,7,14,3,9,3]
stormraven_gear = ['Twin Assault Cannon', 'Heavy Bolter', 'Heavy Bolter', 'StormStrike Missile Launcher' 'StormStrike Missile Launcher']
storm_raven_rules = ['Hard to Hit - 1', 'Move and Fire', 'Fly']
spacemarinecodex['Stormraven Gunship'] = CodexEntry.new(stormraven, stormraven_gear, storm_raven_rules, 172)



File.write('SpaceMarineCodex.yml', spacemarinecodex.to_yaml)