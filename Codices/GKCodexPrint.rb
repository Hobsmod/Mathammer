require_relative '..\Classes\CodexEntry.rb'
require 'yaml'

spacemarinecodex = Hash.new{}
faction = ['Imperium','Adeptus Astartes','Grey Knights']
character = faction + ['Character']
infantry = faction + ['Infantry']
vehicle = faction + ['Vehicle']
dreadnought = vehicle + ['Dreadnought']
flier = vehicle + ['Fly']
tactical_rules = ['ATSKNF']


gkcodex = Hash.new{}

draigo_stats = [5,2,2,4,4,7,5,9,2]
draigo_gear = ['The Titansword','Storm Bolter','Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
draigo_cost = 240
draigo_rules = ['Invulnerable - 3', 'Aura - 6 - Reroll - All - Hits - All', 'Deepstrike', 'Psyker - 2', 'Deny - 2',]
gkcodex['Lord Kaldor Draigo'] = CodexEntry.new(draigo_stats, draigo_gear, draigo_rules, draigo_cost, character)

valdus_stats = [5,2,2,4,4,6,5,9,2]
valdus_gear = ['Maleus Argyrum','Storm Bolter','Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
valdus_cost = 190
valdus_rules = ['Invulnerable - 4', 'Psyker - 3', 'Deny - 3', 'Aura - 6 - Reroll - All - Hits - 1']
gkcodex['Grand Master Voldus'] = CodexEntry.new(valdus_stats, valdus_gear, valdus_rules, valdus_cost, character)

gm_stats = [5,2,2,4,4,6,5,9,2]
gm_gear = ['Nemesis Force Halberd', 'Storm Bolter','Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
gm_rules = ['Invulnerable - 4', 'Rites of Battle', 'Psyker - 2', 'Smite', 'Deep Strike']
gm_cost = 160
gkcodex['Grand Master'] = CodexEntry.new(gm_stats, gm_gear, gm_rules, gm_cost, character)


gm_dread_stats = [8, 2, 2, 6, 6, 12, 5, 9, 2,]
gm_dread_gear = ['Dreadfist','Dreadfist']
gm_dread_cost = 190
gkcodex['Grand Master in Dreadknight'] = CodexEntry.new(gm_dread_stats, gm_dread_gear, gm_rules, gm_dread_cost, vehicle)


crowe_stats = [6, 2, 2, 4, 4, 5, 5, 8, 2,]
crowe_gear = ['Black Blade of Antwyr', 'Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
crowe_rules = ['Invulnerable - 4', 'Psyker - 2', 'Deny - 1', 'Deep Strike', 'Reroll - Fight - All - All']
crowe_cost = 125
gkcodex['Castellan Crowe'] = CodexEntry.new(crowe_stats, crowe_gear, crowe_rules, crowe_cost, character)


stern_stats = [5,2,2,4,4,6,4,9,2]
stern_gear = ['Nemesis Force Sword','Storm Bolter','Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
stern_rules = ['Invulnerable - 4', 'Psyker - 2', 'Deny - 1']
stern_cost = 157
gkcodex['Brother-Captain Stern'] = CodexEntry.new(stern_stats, stern_gear, stern_rules, stern_cost, character)

bro_cpt_rules = ['Invulnerable - 4', 'Minor Smite','Psychic Locus','Psyker - 1']
bro_cpt_cost = 150
gkcodex['Brother-Captain'] = CodexEntry.new(gm_stats, gm_gear, bro_cpt_rules, bro_cpt_cost, character)

lib_stats = [5,2,2,4,4,5,3,9,2]
lib_rules = ['Psyker - 2', 'Invulnerable - 5', 'Minor Smite', 'Deny - 1']
lib_gear = ['Nemesis Warding Stave','Frag Grenade', 'Krak Grenade', 'Psykout Grenade', 'Psyker - 1']
lib_cost = 157
gkcodex['Librarian'] = CodexEntry.new(lib_stats, lib_gear, lib_rules, lib_cost, character)

tech_stats = [6,3,2,4,4,4,3,8,2]
tech_gear = ['Power Axe','Servo Arm', 'Servo Arm', 'Boltgun', 'Plasma Cutter', 'Flamer',
'Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
tech_rules = ['Minor Smite', 'Psyker - 1']
tech_cost = 91
gkcodex['Techmarine'] = CodexEntry.new(tech_stats, tech_gear, tech_rules, tech_cost, character)

chap_stats = [5,2,2,4,4,5,3,9,2]
chap_gear = ['Crozius Arcanum', 'Storm Bolter','Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
chap_rules = ['Invulnerable - 4', 'Minor Smite', 'Psyker - 1']
chap_cost = 144
gkcodex['Chaplain'] = CodexEntry.new(chap_stats, chap_gear, chap_rules, chap_cost, character)

bro_champ_stats = [6,2,2,4,4,4,4,8,2]
bro_champ_rules = ['Invulnerable - 4', 'Heroic Sacrifice', 'Minor Smite','Psyker - 1']
bro_champ_cost = 113
gkcodex['Brotherhood Champion'] = CodexEntry.new(bro_champ_stats, stern_gear, bro_champ_rules, bro_champ_cost, character)

terminator_stats = [5,3,3,4,4,2,2,7,2]
terminator_sergeant_stats = [5,3,3,4,4,2,3,8,2]
terminator_rules = ['ATSKNF','Invulnerable-5','Deepstrike','Minor Smite','Psyker - 1']
terminator_cost = 46
gkcodex['Grey Knight Terminator'] = CodexEntry.new(terminator_stats, stern_gear, 
terminator_rules, terminator_cost, infantry)
gkcodex['Terminator Justicar'] = CodexEntry.new(terminator_sergeant_stats, stern_gear,
 terminator_rules, terminator_cost, infantry)
 
strike_stats = [6, 3, 3, 4, 4, 1, 1, 7, 3]
strike_rules = ['ATSKNF','Minor Smite','Psyker - 1']
strike_cost = 19
sergeant_stats = [6, 3, 3, 4, 4, 1, 2, 8, 3]
gkcodex['Grey Knight'] = CodexEntry.new(strike_stats, stern_gear, strike_rules, strike_cost, infantry)
gkcodex['Justicar'] = CodexEntry.new(sergeant_stats, stern_gear, strike_rules, strike_cost, infantry)

apoth_stats = [5,2,3,4,4,5,4,8,2]
apoth_gear = ['Nemesis Force Sword','Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
apoth_rules = ['ATSKNF','Invulnerable-5','Minor Smite','Psyker - 1','Nathecium']
apoth_cost = 90
gkcodex['Apothecary'] = CodexEntry.new(apoth_stats, apoth_gear, apoth_rules, apoth_cost, character)

bro_anc_gear = ['Storm Bolter','Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
bro_anc_rules = ['ATSKNF','Invulnerable-5','Minor Smite','Psyker - 1','Aura - Attack - 1']
bro_anc_cost = 128
bro_anc_stats = [5,3,3,4,4,5,3,8,2]
gkcodex['Brotherhood Ancient'] = CodexEntry.new(bro_anc_stats, bro_anc_gear, bro_anc_rules, bro_anc_cost, character)

pal_stats = [5,3,3,4,4,3,3,8,2]
par_stats = [5,3,3,4,4,3,3,9,2]
pal_cost = 53
gkcodex['Paladin'] = CodexEntry.new(pal_stats, stern_gear, terminator_rules, pal_cost, infantry)
gkcodex['Paragon'] = CodexEntry.new(par_stats, stern_gear, terminator_rules, pal_cost, infantry)

pal_anc_gear = ['Storm Bolter','Frag Grenade', 'Krak Grenade', 'Psykout Grenade']
pal_anc_rules = ['ATSKNF','Invulnerable-5','Minor Smite','Psyker - 1','Aura - Attack - 1']
pal_anc_cost = 128
pal_anc_stats = [5,3,3,4,4,5,3,8,2]
gkcodex['Paladin Ancient'] = CodexEntry.new(pal_anc_stats, pal_anc_gear, pal_anc_rules, pal_anc_cost, infantry)

pure_rules = ['ATSKNF','Purifying Flame','Psyker - 1']
pure_cost = 26
gkcodex['Purifier'] = CodexEntry.new(strike_stats, stern_gear, pure_rules, strike_cost, infantry)
gkcodex['Knight of Flame'] = CodexEntry.new(sergeant_stats, stern_gear, pure_rules, strike_cost, infantry)

dreadnought_stats = [6,3,3,6,7,8,4,8,3]
dreadnought_gear = ['Assault Cannon', 'Storm Bolter', 'Dreadnought Close Combat Weapon']
dreadnought_rules = ['Smoke Launchers','Psyker - 1', 'Minor Smite']
gkcodex['Dreadnought'] = CodexEntry.new(dreadnought_stats, dreadnought_gear, dreadnought_rules, 87, vehicle)

ven_dread_stats = [6,2,2,6,7,8,4,8,3]
ven_dread_rules = ['FNP - 6','Psyker - 1', 'Minor Smite']
gkcodex['Venerable Dreadnought'] = CodexEntry.new(ven_dread_stats, dreadnought_gear, ven_dread_rules, 110, vehicle)

inter_stats = [12, 3, 3, 4, 4, 1, 1, 7, 3]
inter_just_stats = [12, 3, 3, 4, 4, 1, 1, 7, 3]
gkcodex['Interceptor'] = CodexEntry.new(inter_stats, stern_gear, strike_rules, 23, infantry)
gkcodex['Interceptor Justicar'] = CodexEntry.new(inter_just_stats, stern_gear, strike_rules, 23, infantry)

gkcodex['Purgator'] = CodexEntry.new(strike_stats, stern_gear, strike_rules, strike_cost, infantry)
gkcodex['Purgator Justicar'] = CodexEntry.new(sergeant_stats, stern_gear, strike_rules, strike_cost, infantry)

nem_dread_stats = [8,3,3,6,6,12,4,8,2]
new_dread_gear = ['Dreadfist','Dreadfist']
new_dread_rules = ['Invulnerable-5','Minor Smite','Psyker - 1','Deep Strike']
gkcodex['Nemesis Dreadknight'] = CodexEntry.new(nem_dread_stats, new_dread_gear, new_dread_rules, 130, vehicle)

land_raider = [10,6,3,8,8,16,6,9,2]
land_raider_gear = ['Twin Heavy Bolter', 'Twin Lascannon', 'Twin Lascannon']
land_raider_rules = ['Move and Fire']
gkcodex['Land Raider'] = CodexEntry.new(land_raider, land_raider_gear, land_raider_rules, 239, vehicle)

lr_crusader_gear = ['Twin Assault Cannon', 'Hurricane Bolter', 'Hurricane Bolter']
lr_redeem_gear = ['Twin Assault Cannon', 'Flamestorm Cannon', 'Flamestorm Cannon']
gkcodex['Land Raider Crusader'] = CodexEntry.new(land_raider, lr_crusader_gear, land_raider_rules, 244, vehicle)
gkcodex['Land Raider Redeemer'] = CodexEntry.new(land_raider, lr_redeem_gear, land_raider_rules, 244, vehicle)

rhino = [12,6,3,6,7,10,3,8,3]
dreadnought_rules = ['Smoke Launchers']
gkcodex['Rhino'] = CodexEntry.new(rhino, ['Storm Bolter'], dreadnought_rules, 70, vehicle)
gkcodex['Razorback'] = CodexEntry.new(rhino, ['Twin Heavy Bolter'], dreadnought_rules, 75, vehicle)

stormhawk = [60,6,3,6,7,10,3,8,3]
stormhawk_gear = ['Assault Cannon', 'Assault Cannon', 'Heavy Bolter', 'Heavy Bolter', 'Icarus Stormcannon']
stormhawk_rules = ['Hard to Hit - 1', 'Reroll - Saves - 1', 'AA - 1', 'Fly']
gkcodex['Stormhawk Interceptor'] = CodexEntry.new(stormhawk, stormhawk_gear, stormhawk_rules, 85, flier)

stormtalon = [60,6,3,6,6,10,3,8,3]
stormtalon_gear = ['Twin Assault Cannon', 'Heavy Bolter', 'Heavy Bolter']
stormtalon_rules = ['Hard to Hit', 'Anti-Ground', 'Fly']
gkcodex['Stormtalon Gunship'] = CodexEntry.new(stormtalon, stormtalon_gear, stormtalon_rules, 110, flier)

stormraven = [45,6,3,8,7,14,3,9,3]
stormraven_gear = ['Twin Assault Cannon', 'Heavy Bolter', 'Heavy Bolter', 'Stormstrike Missile Launcher', 'Stormstrike Missile Launcher']
storm_raven_rules = ['Hard to Hit - 1', 'Move and Fire', 'Fly']
gkcodex['Stormraven Gunship'] = CodexEntry.new(stormraven, stormraven_gear, storm_raven_rules, 172, flier)


File.write('GreyKnightsCodex.yml', gkcodex.to_yaml)