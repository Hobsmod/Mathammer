require_relative '..\Classes\CodexEntry.rb'
require 'yaml'


spacemarinecodex = Hash.new{}
faction = ['Imperium','Adeptus Astartes']
character = faction.push('Character')
infantry = faction.push('Infantry')
vehicle = faction.push('Vehicle')
dreadnought = vehicle.push('Dreadnought')
flier = vehicle.push('Fly')
tactical_rules = ['ATSKNF']

calgar_cost = 200
tigerius_cost = 130
cassius_cost = 98
sicarius_cost = 132
chronus_cost = 35
telion_cost = 75
lysander_cost = 150
emp_chmp_cost = 75
helbrecht_cost = 170
shrike_cost = 150
kantor_cost = 170
guillman_cost = 360
vulkan_cost = 154
grimaldus_cost = 120
khan_cost = 107

capt_cost = 74
capt_cata_cost = 126
capt_grav_cost = 102
capt_term_cost = 105
capt_bike_cost = 98
capt_jmp = 90
librarian_cost = 93
term_lib_cost = 143
jmp_lib_cost = 116
lt_cost = 60
jmp_lt = 78
chaplain_cost = 72
term_chap_cost = 115
jmp_chap_cost = 90
prim_capt_cost = 87
prim_chap_cost = 85
prim_lib_cost = 93
prim_lt_cost = 70
tech_cost = 45

##Marneus Calgar
calgar_stats = [5,2,2,4,4,7,5,9,2,4]
calgar_gear = ['Gauntlets of Ultramar','Relic Blade']
calgar_rules = ['Chapter Master','Character','Damage - Halved']

calgar_keywords = character.push('Infantry')
spacemarinecodex['Marneus Calgar'] = CodexEntry.new(calgar_stats, calgar_gear, calgar_rules, calgar_cost, character)

##Chief Librarian Tigerius
tigerius_stats = [6,3,3,4,4,4,3,9,3]
tigerius_gear = ['Rod of Tigerius','Bolt Pistol','Frag Grenade','Krak Grenade','Smite','Librarius Discipline']
tigerius_rules = ['Character','+1 Deny','Reroll Psyker','-1 Hit Buff','2 Powers']

spacemarinecodex['Chief Librarian Tigerius'] = CodexEntry.new(tigerius_stats, tigerius_gear, tigerius_rules, tigerius_cost, character)

##Chaplain Cassius
cassius_stats = [6,2,3,4,5,4,3,9,3,4]
cassius_gear = ['Infernus','Crozius Arcanum','Frag Grenade','Krak Grenade']
cassius_rules = ['Character','Reroll Fight Hits']

spacemarinecodex['Chaplain Cassius'] = CodexEntry.new(cassius_stats, cassius_gear, cassius_rules, cassius_cost, character)

sicarius_stats = [6,2,2,4,4,5,4,9,2]
sicarius_gear = ['Talassarian Tempest Blade','Plasma Pistol','Frag Grenade','Krak Grenade']
sicarius_rules = ['Invulnerable-4','Character','Aura - 6 - Reroll - All - Hits - 1','Aura - 6 - Always Strikes First']
spacemarinecodex['Captain Sicarius'] = CodexEntry.new(sicarius_stats, sicarius_gear, sicarius_rules, sicarius_cost, character)

chronus_stats = [6,3,2,4,4,4,2,8,3]
chronus_gear = ['Bolt Pistol','Servo-arm','Frag Grenade','Krak Grenade']
chronus_rules = ['ATSKNF']
spacemarinecodex['Sergeant Chronus'] = CodexEntry.new(chronus_stats, chronus_gear, chronus_rules, chronus_cost, character)

telion_stats = [7,3,2,4,4,4,2,8,4]
telion_gear = ['Quietus','Bolt Pistol','Frag Grenade','Krak Grenade']
telion_rules = ['ATSKNF','Cover - 2','Aura - Scouts - Hits - 1']
spacemarinecodex['Sergeant Telion'] = CodexEntry.new(telion_stats, telion_gear, telion_rules, telion_cost, character)

lysander_stats = [5,2,2,4,4,6,4,9,2]
lysander_gear = ['Fist of Dorn']
lysander_rules = ['Invulnerable-3','Aura - 6 - Reroll  - All- Hits - 1']
spacemarinecodex['Captain Lysander'] = CodexEntry.new(lysander_stats, lysander_gear, lysander_rules, lysander_cost, character)

kantor_stats = [6,2,2,4,4,6,4,9,2]
kantor_gear = ['Dorns Arrow','Power Fist','Frag Grenade','Krak Grenade']
kantor_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - All','Aura - 6 - Attacks - 1']
spacemarinecodex['Pedro Kantor'] = CodexEntry.new(kantor_stats, kantor_gear, kantor_rules, kantor_cost, character)

helbrecht_stats = [6,2,2,4,4,6,4,9,2]
helbrecht_gear = ['Sword of the High Marshals','Combi-melta','Frag Grenade','Krak Grenade']
helbrecht_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - All','Aura - 6 - Strength - 1']
spacemarinecodex['High Marshal Helbrecht'] = CodexEntry.new(helbrecht_stats, helbrecht_gear, helbrecht_rules, helbrecht_cost, character)

emp_chmp_stats = [6,2,3,4,4,4,4,8,2]
emp_chmp_gear = ['Black Sword','Bolt Pistol','Frag Grenade','Krak Grenade']
emp_chmp_rules = ['Invulnerable-4','Duelist - Reroll - Hits' ' Duelist - Attacks - 1','Duelist - Strength - 1']
spacemarinecodex['The Emperors Champion'] = CodexEntry.new(emp_chmp_stats, emp_chmp_gear, emp_chmp_rules, emp_chmp_cost, character)

grimaldus_stats = [6,2,3,4,4,4,3,8,3]
grimaldus_gear = ['Crozius Arcanum','Plasma Pistol','Frag Grenade','Krak Grenade']
grimaldus_rules = ['Invulnerable-4','Aura - 6 - Reroll - Fight - Hits - All','Aura - 6 - Rend - Extra Attack']
spacemarinecodex['Chaplain Grimaldus'] = CodexEntry.new(grimaldus_stats, grimaldus_gear, grimaldus_rules, grimaldus_cost, character)

khan_stats = [6,2,2,4,4,5,4,9,3]
khan_gear = ['Moonfang','Bolt Pistol','Frag Grenade','Krak Grenade']
khan_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - 1','Aura - 6 - Charge - Strength - 1']
spacemarinecodex['Korsarro Khan'] = CodexEntry.new(khan_stats, khan_gear, khan_rules, khan_cost, character)

vulkan_stats = [6,2,2,4,4,5,4,9,2]
vulkan_gear = ['Gauntlet of the Forge','Spear of Vulkan','Bolt Pistol','Frag Grenade','Krak Grenade']
vulkan_rules = ['Invulnerable-3','Aura - 6 - Reroll - All - Hits - 1','Forgefather']
spacemarinecodex['Vulkan Hestan'] = CodexEntry.new(vulkan_stats, vulkan_gear, vulkan_rules, vulkan_cost, character)

shrike_stats = [12,2,2,4,4,5,5,9,2]
shrike_gear = ['Ravens Talons','Frag Grenade','Krak Grenade']
shrike_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - All','Aura - 6 - Reroll - Charge']
spacemarinecodex['Kayavaan Shrike'] = CodexEntry.new(shrike_stats, shrike_gear, shrike_rules, shrike_cost, character)

capt_term_stats = [5,2,2,4,4,6,4,9,2]
capt_term_gear = ['Power Sword','Storm Bolter']
capt_term_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - 1']
spacemarinecodex['Captain in Terminator Armor'] = CodexEntry.new(capt_term_stats, capt_term_gear, capt_term_rules, capt_term_cost, character)

capt_cata_stats = [4,2,2,4,4,6,4,9,2]
capt_cata_gear = ['Power Sword','Combi-bolter']
capt_cata_rules = ['Invulnerable-3','Aura - 6 - Reroll - All - Hits - 1']
spacemarinecodex['Captain in Cataphracti Armor'] = CodexEntry.new(capt_cata_stats, capt_cata_gear, capt_cata_rules, capt_cata_cost, character)

capt_stats = [5,2,2,4,4,5,4,9,3]
capt_gear = ['Chainsword','Master-crafted Boltgun','Frag Grenade','Krak Grenade']
capt_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - 1']
spacemarinecodex['Captain'] = CodexEntry.new(capt_stats, capt_gear, capt_rules, capt_cost, character)

capt_bike_stats = [14,2,2,4,5,6,4,9,3]
capt_bike_gear = ['Chainsword','Master-crafted Boltgun','Frag Grenade','Krak Grenade','Twin Boltgun']
capt_bike_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - 1']
spacemarinecodex['Captain on Bike'] = CodexEntry.new(capt_bike_stats, capt_bike_gear, capt_bike_rules, capt_bike_cost, character)

prim_capt_stats = [6,2,2,4,4,6,5,9,3]
prim_capt_gear = ['Bolt-Pistol','Master-crafted Auto Bolt Rifle','Frag Grenade','Krak Grenade']
prim_capt_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - 1']
spacemarinecodex['Captain'] = CodexEntry.new(prim_capt_stats, prim_capt_gear, prim_capt_rules, prim_capt_cost, character)

capt_grav_stats = [6,2,2,4,5,6,5,9,3]
capt_grav_gear = ['Master-crafted Power Sword','Boltstorm Gauntlet']
capt_grav_rules = ['Invulnerable-4','Aura - 6 - Reroll - All - Hits - 1']
spacemarinecodex['Captain in Gravis Armor'] = CodexEntry.new(capt_grav_stats, capt_grav_gear, capt_grav_rules, capt_grav_cost, character)

librarian_stats = [6,3,3,4,4,4,3,9,3]
prim_lib_stats = [6,3,3,4,4,5,4,9,3]
term_lib_stats = [5,3,3,4,4,5,3,9,2]
librarian_gear = ['Force Stave','Bolt Pistol','Frag Grenade','Krak Grenade']
prim_lib_gear = ['Force Sword','Bolt Pistol','Frag Grenade','Krak Grenade']
term_lib_gear = ['Force Stave']
librarian_rules = ['Psyker - 2','Deny - 1']
term_lib_rules = ['Psyker - 2','Deny - 1','Invulnerable-5']
spacemarinecodex['Librarian'] = CodexEntry.new(librarian_stats, librarian_gear, librarian_rules, librarian_cost, character)
spacemarinecodex['Primaris Librarian'] = CodexEntry.new(prim_lib_stats, prim_lib_gear, librarian_rules, prim_lib_cost, character)
spacemarinecodex['Librarian in Terminator Armor'] = CodexEntry.new(term_lib_stats, term_lib_gear, term_lib_rules, term_lib_cost, character)


chaplain_stats = [6,2,3,4,4,4,3,9,3]
prim_chap_stats = [6,3,3,4,4,5,4,9,3]
term_chap_stats = [5,3,3,4,4,5,3,9,2]
chaplain_gear = ['Crozius Arcanum','Absolver Bolt Pistol','Frag Grenade','Krak Grenade']
prim_chap_gear = ['Crozius Arcanum','Absolver Bolt Pistol','Frag Grenade','Krak Grenade']
term_chap_gear = ['Crozius Arcanum','Storm Bolter']
chaplain_rules = ['Invulnerable-4','Aura - 6 - Reroll - Fight - Hits - 1']
spacemarinecodex['Chaplain'] = CodexEntry.new(chaplain_stats, chaplain_gear, chaplain_rules, chaplain_cost, character)
spacemarinecodex['Primaris Chaplain'] = CodexEntry.new(prim_chap_stats, prim_chap_gear, chaplain_rules, prim_chap_cost, character)
spacemarinecodex['Chaplain in Terminator Armor'] = CodexEntry.new(term_chap_stats, term_chap_gear, chaplain_rules, term_chap_cost, character)


tech_stats = [6,3,2,4,4,2,3,8,2]
tech_gear = ['Power Axe', 'Servo Arm', 'Bolt Pistol', 'Plasma Cutter', 'Flamer']
spacemarinecodex['Techmarine Gunner'] = CodexEntry.new(tech_stats, tech_gear, tactical_rules, tech_cost, character)

lt_stats = [6,2,3,4,4,4,3,8,3]
lt_gear = ['Chainsword', 'Master-crafted Boltgun', 'Bolt Pistol', 'Frag Grenade','Krak Grenade']
lt_rules = ['Aura -6 - Reroll - All - Wounds - 1']
spacemarinecodex['Lieutenant'] = CodexEntry.new(lt_stats, lt_gear, lt_rules, lt_cost, character)

prim_lt_stats = [6,2,3,4,4,4,3,8,3]
prim_lt_gear = ['Chainsword', 'Master-crafted Boltgun', 'Bolt Pistol', 'Frag Grenade','Krak Grenade']
prim_lt_rules = ['Aura -6 - Reroll - All - Wounds - 1']
spacemarinecodex['Primaris Lieutenant'] = CodexEntry.new(prim_lt_stats, prim_lt_gear, prim_lt_rules, prim_lt_cost, character)



### Tactical Marine
tactical_stats = [6, 3, 3, 4, 4, 1, 1, 7, 3]
tactical_gear = ['Boltgun', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
tactical_rules = ['ATSKNF']
tactical_cost = 13
spacemarinecodex['Tactical Marine'] = CodexEntry.new(tactical_stats, tactical_gear, tactical_rules, tactical_cost, infantry)

###Sergeant
sergeant_stats = [6, 3, 3, 4, 4, 1, 2, 8, 3]
spacemarinecodex['Tactical Marine Sergeant'] = CodexEntry.new(sergeant_stats, tactical_gear, tactical_rules, tactical_cost, infantry)

###Intercessors
intercessor_stats = [6, 3, 3, 4, 4, 2, 2, 7, 3]
intercessor_gear = ['Bolt Rifle', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
intercessor_rules = ['ATSKNF']
intercessor_cost = 20
spacemarinecodex['Intercessor'] = CodexEntry.new(intercessor_stats, intercessor_gear, intercessor_rules, intercessor_cost, infantry)

intercessor_sergeant_stats = [6, 3, 3, 4, 4, 2, 3, 8, 3]
spacemarinecodex['Intercessor Sergeant'] = CodexEntry.new(intercessor_sergeant_stats, intercessor_gear, intercessor_rules, intercessor_cost, infantry)

###Scouts
scouts_stats = [6, 3, 3, 4, 4, 1, 1, 7, 4]
scouts_sarge_stats = [6, 3, 3, 4, 4, 1, 2, 8, 4]
scouts_gear = ['Boltgun', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
scouts_rules = ['ATSKNF']
scouts_cost = 11
spacemarinecodex['Scouts'] = CodexEntry.new(scouts_stats, scouts_gear, scouts_rules, scouts_cost, infantry)
spacemarinecodex['Scout Sergeant'] = CodexEntry.new(scouts_sarge_stats, scouts_gear, scouts_rules, scouts_cost, infantry)
## Primaris Ancient
primaris_ancient_stats = [6, 3, 3, 4, 4, 5, 4, 8, 3]
primaris_ancient_rules = ['ATSKNF','4+ Fight Back']
primaris_ancient_cost = 69
spacemarinecodex['Primaris Ancient'] = CodexEntry.new(primaris_ancient_stats, intercessor_gear, primaris_ancient_rules, primaris_ancient_cost, infantry)

#Chapter Ancient
chapter_ancient_stats = [6, 3, 3, 4, 4, 4, 3, 9, 2]
chapter_ancient_gear = ['Power Sword', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
chapter_ancient_cost = 63
spacemarinecodex['Chapter Ancient'] = CodexEntry.new(chapter_ancient_stats, chapter_ancient_gear, primaris_ancient_rules, chapter_ancient_cost, infantry)

#Company Ancient
company_ancient_stats = [6, 3, 3, 4, 4, 4, 3, 9, 3]
company_ancient_gear = ['Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
company_ancient_cost = 63
spacemarinecodex['Company Ancient'] = CodexEntry.new(company_ancient_stats, company_ancient_gear, primaris_ancient_rules, company_ancient_cost, infantry)

#Chapter Champion
chapter_champion_stats = [6, 2, 3, 4, 4, 4, 4, 9, 2]
chapter_champion_gear = ['Champions Blade', 'Power Sword' 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
chapter_champion_rules = ['Character', 'ATSKNF', 'Duelist - Hits']
chapter_champion_cost = 63
spacemarinecodex['Chapter Champion'] = CodexEntry.new(chapter_champion_stats, chapter_champion_gear, chapter_champion_rules, chapter_champion_cost, infantry)

#Honor Guard
h_guard_stats = [6, 3, 3, 4, 4, 2, 2, 9, 2]
h_guard_gear = ['Boltgun', 'Power Axe' 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
h_guard_rules = ['ATSKNF', 'Honor Guard']
h_guard_cost = 63
spacemarinecodex['Honor Guard'] = CodexEntry.new(h_guard_stats, h_guard_gear, h_guard_rules, h_guard_cost, infantry)


#Chapter Champion
company_champion_stats = [6, 2, 3, 4, 4, 4, 3, 8, 3, 5]
company_champion_gear = [ 'Master-crafted Power Sword' 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade', 'Combat Shield']
company_champion_rules = ['Character', 'ATSKNF', 'Duelist - Hits']
company_champion_cost = 63
spacemarinecodex['Company Champion'] = CodexEntry.new(company_champion_stats, company_champion_gear, company_champion_rules, company_champion_cost, infantry)

#Company Veterans
veteran_sergeant_stats = [6, 3, 3, 4, 4, 1, 3, 9, 3]
company_veterans_gear = [ 'Chainsword' 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade', 'Combat Shield']
company_veterans_rules = ['ATSKNF']
spacemarinecodex['Company Veterans'] = CodexEntry.new(sergeant_stats, company_veterans_gear, company_veterans_rules, 16, infantry)

#Reviver Squad
reiver_gear = ['Bolt Carbine','Heavy Bolt Pistol','Frag Grenade','Krak Grenade']
reiver_rules = ['ATSKNF','-1 Ld']
reiver_cost = 18
spacemarinecodex['Reiver'] = CodexEntry.new(intercessor_stats, reiver_gear, reiver_rules, reiver_cost, infantry)
spacemarinecodex['Reiver Sergeant'] = CodexEntry.new(intercessor_sergeant_stats, reiver_gear, reiver_rules, reiver_cost, infantry)

#Aggressors
aggressor_stats = [5,3,3,4,5,2,2,7,3]
aggressor_sergeant_stats = [5,3,3,4,5,2,3,8,3]
aggressor_gear = ['Auto Boltstorm Gauntlet','Fragstorm Grenade Launcher']
aggressor_rules = ['ATSKNF','Fire Storm','Move and Fire']
spacemarinecodex['Aggressor'] = CodexEntry.new(aggressor_stats, aggressor_gear, aggressor_rules, 25, infantry)
spacemarinecodex['Aggressor Sergeant'] = CodexEntry.new(aggressor_sergeant_stats, aggressor_gear, aggressor_rules, 25, infantry)

#Terminators
terminator_stats = [5,3,3,4,4,2,2,8,2,5]
terminator_sergeant_stats = [5,3,3,4,4,2,3,9,2,5]
terminator_gear = ['Storm Bolter', 'Power Fist']
terminator_sergeant_gear = ['Storm Bolter', 'Power Sword']
terminator_rules = ['ATSKNF','Invulnerable-5','Deepstrike']
terminator_cost = 26
spacemarinecodex['Terminator'] = CodexEntry.new(terminator_stats, terminator_gear, terminator_rules, terminator_cost, infantry)
spacemarinecodex['Terminator Sergeant'] = CodexEntry.new(terminator_sergeant_stats, terminator_sergeant_gear, terminator_rules, terminator_cost, infantry)

#Assault Terminators
assault_terminator_gear = ['Two Storm Claws']
assault_terminator_cost = 31
spacemarinecodex['Assault Terminator'] = CodexEntry.new(terminator_stats, assault_terminator_gear, terminator_rules, 31, infantry)
spacemarinecodex['Assault Terminator Sergeant'] = CodexEntry.new(terminator_sergeant_stats, assault_terminator_gear, terminator_rules, 31, infantry)

#Cataphractii Terminators
cataphractii_stats = [4,3,3,4,4,2,2,8,2,4]
cataphractii_sergeant_stats = [4,3,3,4,4,2,3,9,2,4]
cataphractii_gear = ['Combi-bolter', 'Power Fist']
cataphractii_sergeant_gear = ['Combi-bolter', 'Power Sword']
cataphractii_rules = ['ATSKNF', 'Invulnerable-4', 'Deepstrike']
spacemarinecodex['Cataphractii Terminator'] = CodexEntry.new(cataphractii_stats, cataphractii_gear, terminator_rules, 30, infantry)
spacemarinecodex['Cataphractii Terminator Sergeant'] = CodexEntry.new(cataphractii_sergeant_stats, cataphractii_sergeant_gear, cataphractii_rules, 30, infantry)

#Tartaros Terminators
tartaros_stats = [6,3,3,4,4,2,2,8,2,5]
tartaros_sergeant_stats = [6,3,3,4,4,2,3,9,2,5]
spacemarinecodex['Tartaros Terminator'] = CodexEntry.new(tartaros_stats, cataphractii_gear, terminator_rules, 31, infantry)
spacemarinecodex['Tartaros Terminator Sergeant'] = CodexEntry.new(tartaros_sergeant_stats, cataphractii_sergeant_gear, terminator_rules, 31, infantry)

#Vanguard Veterans
vanguard_gear = ['Bolt Pistol', 'Chainsword', 'Frag Grenade', 'Krak Grenade']
spacemarinecodex['Vanguard Veterans'] = CodexEntry.new(sergeant_stats, vanguard_gear, tactical_rules, 16, infantry)
spacemarinecodex['Vanguard Veteran Sergeant'] = CodexEntry.new(veteran_sergeant_stats, vanguard_gear, tactical_rules, 16, infantry)

#Vanguard Veterans
sternguard_gear = ['Bolt Pistol', 'Special Issue Boltgun', 'Frag Grenade', 'Krak Grenade']
spacemarinecodex['Sternguard Veterans'] = CodexEntry.new(sergeant_stats, sternguard_gear, tactical_rules, 16, infantry)
spacemarinecodex['Sternguard Veteran Sergeant'] = CodexEntry.new(veteran_sergeant_stats, sternguard_gear, tactical_rules, 16, infantry)

dreadnought_stats = [6,3,3,6,7,8,4,8,3]
dreadnought_gear = ['Assault Cannon', 'Storm Bolter', 'Dreadnought Close Combat Weapon']
dreadnought_rules = ['Smoke Launchers']
spacemarinecodex['Dreadnought'] = CodexEntry.new(dreadnought_stats, dreadnought_gear, dreadnought_rules, 70, dreadnought)

ironclad_dreadnought_gear = ['Seismic Hammer', 'Meltagun', 'Storm Bolter', 'Dreadnought Close Combat Weapon - Ironclad']
ironclad_dreadnought_stats = [6,3,3,6,8,8,4,8,3]
spacemarinecodex['Ironclad Dreadnought'] = CodexEntry.new(ironclad_dreadnought_stats, ironclad_dreadnought_gear, dreadnought_rules, 80, dreadnought)

ven_dread_stats = [6,2,2,6,7,8,4,8,3]
ven_dread_rules = ['FNP - 6']
spacemarinecodex['Venerable Dreadnought'] = CodexEntry.new(ven_dread_stats, dreadnought_gear, ven_dread_rules, 90, dreadnought)

contempt_dread_stats = [9,2,2,7,7,10,4,8,3,5]
contempt_rules = ['Invulnerable-5']
contempt_gear = ['Multi-Melta', 'Combi-bolter', 'Dreadnought Close Combat Weapon']
spacemarinecodex['Contemptor Dreadnought'] = CodexEntry.new(contempt_dread_stats, contempt_gear, contempt_rules, 98, dreadnought)

redem_dread_stats = [8,3,3,7,7,13,4,8,3]
redem_dread_gear = ['Heavy Onslaught Gatling Cannon', 'Heavy Flamer', 'Icarus Rocket Pod', 'Fragstorm Grenade Launcher',
'Fragstorm Grenade Launcher', 'Redemptor Fist']
redem_dread_rules = []
spacemarinecodex['Redemptor Dreadnought'] = CodexEntry.new(redem_dread_stats, redem_dread_gear, redem_dread_rules, 140, dreadnought)

centurion_stats = [4,3,3,5,5,3,2,7,2]
centurion_sarge_stats = [4,3,3,5,5,3,3,8,2]
centurion_gear = ['Siege Drills', 'Flamer', 'Flamer', 'Centurion Assault Launcher']
centurion_rules = ['Ignores Cover']
spacemarinecodex['Assault Centurion'] = CodexEntry.new(centurion_stats, centurion_gear, centurion_rules, 53, dreadnought)
spacemarinecodex['Assault Centurion Sergeant'] = CodexEntry.new(centurion_sarge_stats, centurion_gear, centurion_rules, 53, dreadnought)

biker_stats = [14,3,3,4,5,2,1,7,3]
biker_sarge_stats = [14,3,3,4,5,2,2,8,3]
atk_bike_stats = [14,3,3,4,5,4,2,7,3]
atk_biker_gear = ['Heavy Bolter']
biker_gear = ['Twin Boltgun','Bolt Pistol','Frag Grenade','Krak Grenade']
biker_rules = ['Turbo Boost']
spacemarinecodex['Biker'] = CodexEntry.new(biker_stats, biker_gear, biker_rules, 25, infantry)
spacemarinecodex['Biker Sergeant'] = CodexEntry.new(biker_sarge_stats, biker_gear, biker_rules, 25 , infantry)
spacemarinecodex['Attack Bike'] = CodexEntry.new(atk_bike_stats, atk_biker_gear, biker_rules, 35 , infantry)

ass_marine_gear = ['Bolt Pistol', 'Chainsword','Frag Grenade','Krak Grenade']
spacemarinecodex['Assault Marine'] = CodexEntry.new(tactical_stats, ass_marine_gear, tactical_rules, 13, infantry)
spacemarinecodex['Assault Marine Sergeant'] = CodexEntry.new(sergeant_stats, ass_marine_gear, tactical_rules, 13, infantry)

land_speeder_stats = [16,3,3,4,5,6,2,7,3]
land_speeder_gear = ['Heavy Bolter']
ls_rules = ['Fly']
spacemarinecodex['Land Speeder'] = CodexEntry.new(land_speeder_stats, land_speeder_gear, ls_rules, 70, flier)


scout_bike = [16,3,3,4,5,2,1,7,4]
scout_bike_sarge = [16,3,3,4,5,2,2,8,4]
scout_bike_gear = ['Bolt Pistol', 'Astartes Shotgun', 'Combat Knife','Frag Grenade','Krak Grenade']
scout_bike_rules = ['Turbo-boost']
spacemarinecodex['Scout Biker'] = CodexEntry.new(scout_bike, scout_bike_gear, scout_bike_rules, 23, infantry)
spacemarinecodex['Scout Biker Sergeant'] = CodexEntry.new(scout_bike_sarge, scout_bike_gear, scout_bike_rules, 23, infantry)

interceptors = [10,3,3,4,5,2,2,7,3]
interceptors_sarge = [10,3,3,4,5,2,3,8,3]
intercept_gear = ['Assault Bolter', 'Assault Bolter']
spacemarinecodex['Interceptor'] = CodexEntry.new(interceptors, intercept_gear, redem_dread_rules, 30, infantry)
spacemarinecodex['Interceptor Sergeant'] = CodexEntry.new(interceptors_sarge, intercept_gear, redem_dread_rules, 30, infantry)

devestator_rules = ['Signum', 'ATSKNF']
spacemarinecodex['Devestator'] = CodexEntry.new(tactical_stats, tactical_gear, devestator_rules, 13, infantry)
spacemarinecodex['Devestator Sergeant'] = CodexEntry.new(sergeant_stats, tactical_gear, devestator_rules, tactical_cost, infantry)

centurion_dev_gear = ['Heavy Bolter', 'Heavy Bolter', 'Hurricane Bolter']
centurion_dev_rules = ['Move and Fire', 'ATSKNF', 'Ignores Cover']
spacemarinecodex['Centurion Devestator'] = CodexEntry.new(centurion_stats, centurion_dev_gear, centurion_dev_rules, 80, infantry)
spacemarinecodex['Centurion Devestator Sergeant'] = CodexEntry.new(centurion_sarge_stats, centurion_dev_gear, centurion_dev_rules, 80, infantry)

hellblaster_gear = ['Plasma Incinerator', 'Bolt Pistol','Frag Grenade','Krak Grenade']
spacemarinecodex['Hellblaster'] = CodexEntry.new(intercessor_stats, hellblaster_gear, tactical_rules, 18, infantry)
spacemarinecodex['Hellblaster Sergeant'] = CodexEntry.new(intercessor_sergeant_stats, hellblaster_gear, tactical_rules, 18, infantry)

thunderfire_cannon = [3,6,3,3,6,4,1,8,3]
tech_gunner = [6,3,2,4,4,2,3,8,2]
thunderfire_gear = ['Thunderfire Cannon']
tech_gunner_gear = ['Servo Arm', 'Servo Arm', 'Bolt Pistol', 'Plasma Cutter', 'Flamer']
spacemarinecodex['Thunderfire Cannon'] = CodexEntry.new(thunderfire_cannon, thunderfire_gear, tactical_rules, 55, vehicle)
spacemarinecodex['Techmarine Gunner'] = CodexEntry.new(tech_gunner, tech_gunner_gear, tactical_rules, 26, infantry)

hunter = [10,6,3,6,8,11,3,8,3]
hunter_gear = ['Skyspear Missile Launcher']
spacemarinecodex['Hunter'] = CodexEntry.new(hunter, hunter_gear, dreadnought_rules, 90, vehicle)



stalker_gear = ['Icarus Stormcannon', 'Icarus Stormcannon']
spacemarinecodex['Stalker'] = CodexEntry.new(hunter, stalker_gear, dreadnought_rules, 80, vehicle)

whirlwind_gear = ['Whirlwind Vengeance Launcher']
spacemarinecodex['Whirlwind'] = CodexEntry.new(hunter, whirlwind_gear, dreadnought_rules, 75, vehicle)

predator_gear = ['Predator Autocannon']
spacemarinecodex['Predator'] = CodexEntry.new(hunter, predator_gear, dreadnought_rules, 90, vehicle)

vindicator_gear = ['Demolisher Cannon']
spacemarinecodex['Vindicator'] = CodexEntry.new(hunter, vindicator_gear, dreadnought_rules, 135, vehicle)

land_raider = [10,6,3,8,8,16,6,9,2]
land_raider_gear = ['Twin Heavy Bolter', 'Twin Lascannon', 'Twin Lascannon']
land_raider_rules = ['Move and Fire']
spacemarinecodex['Land Raider'] = CodexEntry.new(land_raider, land_raider_gear, land_raider_rules, 239, vehicle)

lr_crusader_gear = ['Twin Assault Cannon', 'Hurricane Bolter', 'Hurricane Bolter']
lr_redeem_gear = ['Twin Assault Cannon', 'Flamestorm Cannon', 'Flamestorm Cannon']
spacemarinecodex['Land Raider Crusader'] = CodexEntry.new(land_raider, lr_crusader_gear, land_raider_rules, 244, vehicle)
spacemarinecodex['Land Raider Redeemer'] = CodexEntry.new(land_raider, lr_redeem_gear, land_raider_rules, 244, vehicle)

rhino = [12,6,3,6,7,10,3,8,3]

spacemarinecodex['Rhino'] = CodexEntry.new(rhino, ['Storm Bolter'], dreadnought_rules, 70, vehicle)
spacemarinecodex['Razorback'] = CodexEntry.new(rhino, ['Twin Heavy Bolter'], dreadnought_rules, 75, vehicle)

land_speeder_storm = [18,3,3,4,5,7,2,7,4]
ls_storm_gear = ['Heavy Bolter', 'Cerberus Launcher']
ls_rules = ['Fly']
spacemarinecodex['Land Speeder Storm'] = CodexEntry.new(land_speeder_storm, ls_storm_gear, ls_rules, 70, flier)

repulsor = [10,6,3,8,8,16,6,9,3]
repulsor_rules = ['Fly']
repulsor_gear = ['Heavy Onslaught Gatling Cannon', 'Twin Heavy Bolter', 'Ironhail Heavy Stubber',
'Icarus Ironhail Heavy Stubber', 'Krakstorm Grenade Launcher', 'Krakstorm Grenade Launcher', 'Storm Bolter',
'Storm Bolter']
spacemarinecodex['Repulsor'] = CodexEntry.new(repulsor, repulsor_gear, repulsor_rules, 210, flier)

stormhawk = [60,6,3,6,7,10,3,8,3]
stormhawk_gear = ['Assault Cannon', 'Assault Cannon', 'Heavy Bolter', 'Heavy Bolter', 'Icarus Stormcannon']
stormhawk_rules = ['Hard to Hit - 1', 'Reroll - Saves - 1', 'AA - 1', 'Fly']
spacemarinecodex['Stormhawk Interceptor'] = CodexEntry.new(stormhawk, stormhawk_gear, stormhawk_rules, 85, flier)

stormtalon = [60,6,3,6,6,10,3,8,3]
stormtalon_gear = ['Twin Assault Cannon', 'Heavy Bolter', 'Heavy Bolter']
stormtalon_rules = ['Hard to Hit', 'Anti-Ground', 'Fly']
spacemarinecodex['Stormtalon Gunship'] = CodexEntry.new(stormtalon, stormtalon_gear, stormtalon_rules, 110, flier)

stormraven = [45,6,3,8,7,14,3,9,3]
stormraven_gear = ['Twin Assault Cannon', 'Heavy Bolter', 'Heavy Bolter', 'Stormstrike Missile Launcher', 'Stormstrike Missile Launcher']
storm_raven_rules = ['Hard to Hit - 1', 'Move and Fire', 'Fly']
spacemarinecodex['Stormraven Gunship'] = CodexEntry.new(stormraven, stormraven_gear, storm_raven_rules, 172, flier)



File.write('SpaceMarineCodex.yml', spacemarinecodex.to_yaml)