require_relative '..\Classes\CodexEntry.rb'
require 'yaml'
faction = ['Imperium','Adeptus Astartes']
character = faction + ['Character']
infantry = faction + ['Infantry']
vehicle = faction + ['Vehicle']
dreadnought = vehicle + ['Dreadnought']
flier = vehicle + ['Fly']
tactical_rules = ['ATSKNF']

imp_index_1 = Hash.new{}

###Blood Angels
baal_cost = 107
cmp_anc_jmp_cost = 72
cmp_chmp_jmp_cost = 70
vet_jmp_cost = 19
death_cmp_cost = 17
furioso_dred_cost = 122
lib_dred_cost = 150
sang_grd_cost = 22
sang_grd_anc_cost = 84
sang_nov_jmp_cost = 60
sang_priest_cost = 69
sang_priest_bike_cost = 91
term_anc_cost = 108
death_cmp_dred_cost = 128


astorath_cost = 143
corbulo_cost = 94
tycho_cost = 95
mephiston_cost = 145
seth_cost = 135
lemartes_cost = 129
sanguinor_cost = 170
tycho_lost_cost = 70
dante_cost = 215


## Dark Angels
deathwing_anc_cost = 103
deathwing_apoth_cost = 75
deathwing_chmp_cost = 118
knight_cost = 45
deathwing_cost = 26
int_chap_cost = 90
int_chap_term_cost = 128
int_chap_bike_cost = 117
int_chap_jmp_cost = 101
nephilim_cost = 123
ravenwing_anc_cost = 117
ravenwing_apoth_cost = 97
raven_atk_bike_cost = 45
ravenwing_cost = 32
blk_knight_cost = 50
ravenwing_chmp_cost = 106
drk_talon_cost = 180
darkshroud_cost = 128
ls_veng_cost = 122
ls_cost = 85

asmodai_cost = 145
azrael_cost = 180
belial_cost = 150
ezekiel_cost = 145
sammael_corv_cost = 216
sammael_sable_cost = 183

##space wolves
bjorn_cost = 210
bloodclaw_cost = 13
wolfguard_sarge_term_cost = 31
cyberwolf_cost = 15
fenris_wolf_cost = 9
grey_hunter_cost = 14
iron_priest_cost = 58
iron_priest_bike_cost = 65
iron_priest_wolf_cost = 80
lonewolf_cost = 75
lonewolf_term_cost = 115
long_fang_cost = 15
rune_priest_cost = 68
rune_priest_term_cost = 120
rune_priest_bike_cost = 109
rune_priest_jmp_cost = 91
skyclaw_cost = 16
storm_fang_cost = 155
storm_wolf_cost = 165
swiftclaw_cost = 31
swiftclaw_atk_bike_cost = 45
thunderwolf_cost = 45
wolfguard_cost = 16
wolf_guard_leader_cost = 60
wolf_guard_leader_term_cost = 92
wolf_guard_leader_bike_cost = 85
thunderwolf_guard_leader_cost = 97
wolf_guard_leader_jmp_cost = 63
wolf_guard_term_cost = 31
wolf_guard_bike_cost = 34
wolf_guard_jmp_cost = 21
thunderwolf_lord_cost = 128
wolf_priest_cost = 90
wolf_priest_term_cost = 144
wolf_priest_bike_cost = 135
wolf_priest_jmp_cost = 112
scouts_cost = 11
wulfen_cost = 37

arjac_cost = 140
canis_cost = 150
harald_cost = 188
krom_cost = 119
grimnar_cost = 190
grimnar_storm_cost = 230
lukas_cost = 118
murderfang_cost = 200
njal_cost = 138
njal_term_cost = 167
blackmane_cost = 141
ulrik_cost = 133

##deathwatch
blackstar_cost = 160
watch_bike_cost = 34
watch_term_cost = 32
watch_vanguard_cost = 21
blk_shield_cost = 19
watch_cost = 19
watch_veteran_cost = 19
watch_master_cost = 130
artemis_cost = 130




dante_stats = [12,3,3,4,4,6,6,9,2]
dante_gear = ['Axe Mortalis','Inferno Pistol','Frag Grenade','Krak Grenade']
dante_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - All','Fear - 1', 'Deepstrike']
imp_index_1['Commander Dante'] = CodexEntry.new(dante_stats, dante_gear, dante_rules, dante_cost, character)

tycho_stats = [6,2,2,4,4,5,4,9,2]
tycho_gear = ['Blood Song','Bolt Pistol','Frag Grenade','Krak Grenade']
tycho_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1']
imp_index_1['Captain Tycho'] = CodexEntry.new(tycho_stats, tycho_gear, tycho_rules, tycho_cost, character)

tycho_lost_stats = [6,2,2,4,4,5,4,9,2]
tycho_lost_gear = ['Blood Song','Bolt Pistol','Frag Grenade','Krak Grenade']
tycho_lost_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1','FNP - 6','Charge - Attack - 1']
imp_index_1['Tycho the Lost'] = CodexEntry.new(tycho_lost_stats, tycho_lost_gear, tycho_lost_rules, tycho_lost_cost, character)

lib_dred_stats = [6,2,3,6,7,8,3,9,3]
lib_dred_gear = ['Furioso Force Halberd', 'Furioso Fist', 'Storm Bolter']
lib_dred_rules = ['Psyker - 2', 'Deny - 1' 'Smoke Launchers']
imp_index_1['Librarian Dreadnought'] = CodexEntry.new(lib_dred_stats, lib_dred_gear, lib_dred_rules, lib_dred_cost, character)

mephiston_stats = [7,2,2,5,5,5,4,9,2]
mephiston_gear = ['Plasma Pistol', 'Sanguine Sword','Frag Grenade','Krak Grenade']
mephiston_rules = ['Psyker - 2', 'Deny - 2', 'Deny - Bonus - 1', 'FNP - 5']
imp_index_1['Chief Librarian Mephiston'] = CodexEntry.new(mephiston_stats, mephiston_gear, mephiston_rules, mephiston_cost, character)

sanguinor_stats = [12,2,2,4,4,5,5,9,2]
sanguinor_gear = ['Encarmine Broadsword','Frag Grenade','Krak Grenade']
sanguinor_rules = ['Invulnerable - 4','Aura - 6 - Attacks - 1','Fear - 1', 'Deepstrike']
imp_index_1['The Sanguinor'] = CodexEntry.new(sanguinor_stats, sanguinor_gear, sanguinor_rules, sanguinor_cost, character)

astorath_stats = [12,2,2,4,4,5,4,9,2]
astorath_gear = ['Excecutioners Axe','Bolt Pistol','Frag Grenade','Krak Grenade']
astorath_rules = ['Invulnerable - 4','Aura - 6 - Reroll - Fight - Hits - All', 'Deepstrike','FNP - 6', 'Charge - Attacks - 1']
imp_index_1['Astorath'] = CodexEntry.new(astorath_stats, astorath_gear, astorath_rules, astorath_cost, character)

sang_priest_stats = [6,2,3,4,4,4,3,9,3]
sang_priest_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade']
sang_priest_rules = ['Aura - 6 - Strength - 1','Narthecium']
imp_index_1['Sanguinary Priest'] = CodexEntry.new(sang_priest_stats, sang_priest_gear, sang_priest_rules, sang_priest_cost, character)

sang_priest_bike_stats = [14,2,3,4,5,5,3,9,3]
sang_priest_bike_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade']
sang_priest_bike_rules = ['Aura - 6 - Strength - 1','Narthecium']
imp_index_1['Sanguinary Priest on Bike'] = CodexEntry.new(sang_priest_bike_stats, sang_priest_bike_gear, sang_priest_bike_rules, sang_priest_bike_cost, character)

corbulo_stats = [6,2,2,4,4,5,4,9,3]
corbulo_gear = ['Heavens Teeth','Bolt Pistol','Frag Grenade','Krak Grenade']
corbulo_rules = ['Aura - 6 - Strength - 1','Healing - D3','Aura - 6 - Rend - Fight - Extra Attack','Reroll - Saves - All - Single']
imp_index_1['Brother Corbulo'] = CodexEntry.new(corbulo_stats, corbulo_gear, corbulo_rules, corbulo_cost, character)

sang_grd_anc_stats = [12,3,3,4,4,4,3,9,2]
sang_grd_anc_gear = ['Encarmine Sword','Angelus Boltgun','Frag Grenade','Krak Grenade']
sang_grd_anc_rules = ['Fear - 1','Aura - 6 - Reroll - Fight - Wound - 1']
imp_index_1['Sanguinary Guard Ancient'] = CodexEntry.new(sang_grd_anc_stats, sang_grd_anc_gear, sang_grd_anc_rules, sang_grd_anc_cost, infantry)


term_anc_stats = [5,3,3,4,4,5,3,8,2]
term_anc_gear = ['Lightning Claw','Frag Grenade','Krak Grenade']
term_anc_rules = ['Invulnerable - 5','Aura - 6 - Reroll - Fight - Hits - All']
imp_index_1['Terminator Ancient'] = CodexEntry.new(term_anc_stats, term_anc_gear, term_anc_rules, term_anc_cost, infantry)

death_cmp_stats = [6,3,3,4,4,1,2,7,3]
death_cmp_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade']
death_cmp_rules = ['FNP - 6', 'Charge - Attack - 1']
imp_index_1['Death Company'] = CodexEntry.new(death_cmp_stats, death_cmp_gear, death_cmp_rules, death_cmp_cost, infantry)

lemartes_stats = [12,2,3,4,4,4,5,9,3]
lemartes_gear = ['Blood Crozius','Bolt Pistol','Frag Grenade','Krak Grenade']
lemartes_rules = ['Invulnerable - 4','FNP - 6', 'Charge - Attack - 1', 'Aura - 6 - Reroll - Fight - Hits - All','Deepstrike']
imp_index_1['Lemartes'] = CodexEntry.new(lemartes_stats, lemartes_gear, lemartes_rules, lemartes_cost, character)

sang_grd_stats = [12,3,3,4,4,2,2,8,2]
sang_grd_gear = ['Encarmine Sword','Angelus Boltgun','Frag Grenade','Krak Grenade']
sang_grd_rules = ['Deepstrike']
imp_index_1['Sanguinary Guard'] = CodexEntry.new(sang_grd_stats, sang_grd_gear, sang_grd_rules, sang_grd_cost, infantry)

death_cmp_dred_stats = [8,3,3,6,7,8,4,7,3]
death_cmp_dred_gear = ['Furioso Fist', 'Furioso Fist', 'Storm Bolter','Meltagun']
death_cmp_dred_rules = ['FNP - 6', 'Charge - Attack - 1', 'Smoke Launchers']
imp_index_1['Death Company Dreadnought'] = CodexEntry.new(death_cmp_dred_stats, death_cmp_dred_gear, death_cmp_dred_rules, death_cmp_dred_cost, dreadnought)

furioso_dred_stats = [8,3,3,6,7,8,4,8,3]
furioso_dred_gear = ['Furioso Fist', 'Furioso Fist', 'Storm Bolter','Meltagun']
furioso_dred_rules = ['Smoke Launchers']
imp_index_1['Furioso Dreadnought'] = CodexEntry.new(furioso_dred_stats, furioso_dred_gear, furioso_dred_rules, furioso_dred_cost, dreadnought)

baal_stats = [12,6,3,6,7,11,3,8,3]
baal_gear = ['Twin Assault Cannon']
imp_index_1['Baal Predator'] = CodexEntry.new(baal_stats, baal_gear, furioso_dred_rules, baal_cost, vehicle)

seth_stats = [6,2,2,4,4,6,4,9,3]
seth_gear = ['Blood Reaver','Bolt Pistol','Frag Grenade','Krak Grenade']
seth_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - All','Aura - 6 - Fight Twice - 6']
imp_index_1['Gabriel Seth'] = CodexEntry.new(seth_stats, seth_gear, seth_rules, seth_cost, character)

azrael_stats = [6,2,2,4,4,6,5,9,2]
azrael_gear = ['Sword of Secrets', 'Lions Wrath','Bolt Pistol','Frag Grenade','Krak Grenade']
azrael_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - All','Aura - 6 - Invulnerable - 4','Command Point - 1']
imp_index_1['Azrael'] = CodexEntry.new(azrael_stats, azrael_gear, azrael_rules, azrael_cost, character)

belial_stats = [5,2,2,4,4,6,4,9,2]
belial_gear = ['Sword of Silence','Storm Bolter']
belial_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1','Aura - Deathwing - Reroll - All - Hits - All']
imp_index_1['Belial'] = CodexEntry.new(belial_stats, belial_gear, belial_rules, belial_cost, character)

sammael_corv_stats = [14,2,2,4,6,6,5,9,2]
sammael_corv_gear = ['Raven Sword','Bolt Pistol','Frag Grenade','Krak Grenade','Plasma Cannon','Twin Storm Bolter']
sammael_corv_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1','Aura - Ravenwing - Reroll - All - Hits - All','Jink']
imp_index_1['Sammael on Corvex'] = CodexEntry.new(sammael_corv_stats, sammael_corv_gear, sammael_corv_rules, sammael_corv_cost, character)

sammael_sable_stats = [16,2,2,4,6,7,5,9,3]
sammael_sable_gear = ['Raven Sword','Bolt Pistol','Frag Grenade','Krak Grenade','Twin Assault Cannon','Twin Heavy Bolter']
sammael_sable_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1','Aura - Ravenwing - Reroll - All - Hits - All','Jink']
imp_index_1['Sammael on Sableclaw'] = CodexEntry.new(sammael_sable_stats, sammael_sable_gear, sammael_sable_rules, sammael_sable_cost, character)

int_chap_term_stats = [6,2,3,4,4,6,3,9,2]
int_chap_term_gear = ['Crozius Arcanum','Storm Bolter']
int_chap_term_rules = ['Invulnerable - 4','Aura - 6 - Reroll - Fight - Hits - All','Deepstrike','Fear - 1']
imp_index_1['Interrogator-Chaplain in Terminator Armor'] = CodexEntry.new(int_chap_term_stats, int_chap_term_gear, int_chap_term_rules, int_chap_term_cost, character)

int_chap_stats = [6,2,3,4,4,5,3,9,3]
int_chap_gear = ['Crozius Arcanum','Bolt Pistol','Frag Grenade','Krak Grenade']
int_chap_rules = ['Invulnerable - 4','Aura - 6 - Reroll - Fight - Hits - All','Fear - 1']
imp_index_1['Interrogator-Chaplain in Terminator Armor'] = CodexEntry.new(int_chap_stats, int_chap_gear, int_chap_rules, int_chap_cost, character)

int_chap_bike_stats = [14,2,3,4,5,6,3,9,3]
int_chap_bike_gear = ['Crozius Arcanum','Storm Bolter','Frag Grenade','Krak Grenade']
int_chap_bike_rules = ['Invulnerable - 4','Aura - 6 - Reroll - Fight - Hits - All','Fear - 1']
imp_index_1['Interrogator-Chaplain on Bike'] = CodexEntry.new(int_chap_bike_stats, int_chap_bike_gear, int_chap_bike_rules, int_chap_bike_cost, character)


asmodai_stats = [6,2,3,4,4,5,3,9,3]
asmodai_gear = ['Blades of Reason','Crozius Arcanum','Bolt Pistol','Frag Grenade','Krak Grenade']
asmodai_rules = ['Invulnerable - 4','Aura - 6 - Reroll - Fight - Hits - All','Aura - 6 - Attacks - 1','Fear - 1']
imp_index_1['Asmodai'] = CodexEntry.new(asmodai_stats, asmodai_gear, asmodai_rules, asmodai_cost, character)

ezekiel_stats = [6,2,2,4,4,5,3,9,2]
ezekiel_gear = ['Traitors Bane','The Deliverer','Frag Grenade','Krak Grenade']
ezekiel_rules = ['Invulnerable - 4','Aura - 6 - Fight Back - 0','Psyker - 2','Deny - Bonus - 1','Deny - 2']
imp_index_1['Ezekiel'] = CodexEntry.new(ezekiel_stats, ezekiel_gear, ezekiel_rules, ezekiel_cost, character)

deathwing_apoth_stats = [5,3,3,4,4,5,2,8,2]
deathwing_apoth_gear = ['Storm Bolter']
deathwing_apoth_rules = ['Invulnerable - 5','Deepstrike','Narthecium']
imp_index_1['Deathwing Apothecary'] = CodexEntry.new(deathwing_apoth_stats, deathwing_apoth_gear, deathwing_apoth_rules, deathwing_apoth_cost, character)

deathwing_anc_stats = [5,3,3,4,4,5,3,8,2]
deathwing_anc_gear = ['Storm Bolter','Power Fist']
deathwing_anc_rules = ['Invulnerable - 5','Aura - Deathwing - Attack - 1','Deepstrike']
imp_index_1['Deathwing Ancient'] = CodexEntry.new(deathwing_anc_stats, deathwing_anc_gear, deathwing_anc_rules, deathwing_anc_cost, character)

deathwing_chmp_stats = [5,2,3,4,4,5,3,8,2]
deathwing_chmp_gear = ['Halberd of Caliban']
deathwing_chmp_rules = ['Invulnerable - 5','Duelist - Hits','Deepstrike']
imp_index_1['Deathwing Champion'] = CodexEntry.new(deathwing_chmp_stats, deathwing_chmp_gear, deathwing_chmp_rules, deathwing_chmp_cost, character)

deathwing_stats = [5,3,3,4,4,2,2,8,2]
deathwing_sarge_stats = [5,3,3,4,4,2,2,8,2]
deathwing_sarge_gear = ['Power Sword','Storm Bolter']
deathwing_rules = ['Invulnerable - 5','Deepstrike']
imp_index_1['Deathwing Terminator'] = CodexEntry.new(deathwing_stats, deathwing_anc_gear, deathwing_rules, deathwing_cost, infantry)
imp_index_1['Deathwing Sergeant'] = CodexEntry.new(deathwing_sarge_stats, deathwing_sarge_gear, deathwing_rules, deathwing_cost, infantry)


knight_master = [5,3,3,4,4,2,3,9,2]
knight_rules = ['Invulnerable - 3','Deepstrike']
knight_gear = ['Mace of Absolution','Storm Shield']
knight_master_gear = ['Flail of the Unforgiven','Storm Shield']
imp_index_1['Knight Master'] = CodexEntry.new(knight_master, knight_master_gear, knight_rules, knight_cost, infantry)
imp_index_1['Deathwing Knight'] = CodexEntry.new(deathwing_sarge_stats, knight_gear, knight_rules, knight_cost, infantry)

ravenwing_apoth_stats = [14,3,3,4,5,5,3,8,3]
ravenwing_apoth_gear = ['Corvus Hammer','Bolt Pistol','Frag Grenade','Krak Grenade','Plamsa Talon']
ravenwing_apoth_rules = ['Turbo-Boost','Jink','Narthecium']
imp_index_1['Ravenwing Apothecary'] = CodexEntry.new(ravenwing_apoth_stats, ravenwing_apoth_gear, ravenwing_apoth_rules, ravenwing_apoth_cost, character)

ravenwing_anc_stats = [14,3,3,4,5,5,3,8,3]
ravenwing_anc_gear = ['Corvus Hammer','Bolt Pistol','Frag Grenade','Krak Grenade','Plamsa Talon']
ravenwing_anc_rules = ['Turbo-Boost','Jink','Aura - Ravenwing - Attacks - 1']
imp_index_1['Ravenwing Ancient'] = CodexEntry.new(ravenwing_anc_stats, ravenwing_anc_gear, ravenwing_anc_rules, ravenwing_anc_cost, character)

ravenwing_chmp_stats = [14,2,3,4,5,5,3,8,3]
ravenwing_chmp_gear = ['Blade of Caliban','Bolt Pistol','Frag Grenade','Krak Grenade','Plamsa Talon']
ravenwing_chmp_rules = ['Turbo-Boost','Jink','Duelist - Hits']
imp_index_1['Ravenwing Champion'] = CodexEntry.new(ravenwing_chmp_stats, ravenwing_chmp_gear, ravenwing_chmp_rules, ravenwing_chmp_cost, character)


ravenwing_stats = [14,3,3,4,5,2,1,7,3]
ravenwing_sarge_stats = [14,3,3,4,5,2,2,8,3]
ravenwing_gear = ['Twin Boltgun','Bolt Pistol','Frag Grenade','Krak Grenade']
ravenwing_rules = ['Turbo-Boost','Jink']
imp_index_1['Ravenwing Bike'] = CodexEntry.new(ravenwing_stats, ravenwing_gear, ravenwing_rules, ravenwing_cost, infantry)
imp_index_1['Ravenwing Sergeant'] = CodexEntry.new(ravenwing_sarge_stats, ravenwing_gear, ravenwing_rules, ravenwing_cost, infantry)


atk_bike_stats = [14,3,3,4,5,4,2,7,3]
atk_biker_gear = ['Heavy Bolter', 'Twin Boltgun','Bolt Pistol']
biker_rules = ['Turbo Boost','Jink']
imp_index_1['Ravenwing Attack Bike'] = CodexEntry.new(atk_bike_stats, atk_biker_gear, biker_rules, raven_atk_bike_cost, infantry)


land_speeder_stats = [16,3,3,4,5,6,2,7,3]
land_speeder_gear = ['Heavy Bolter']
ls_rules = ['Fly','Jink']
imp_index_1['Ravenwing Land Speeder'] = CodexEntry.new(land_speeder_stats, land_speeder_gear, ls_rules, ls_cost, flier)


darkshroud = [12,3,3,4,6,9,3,8,3]
darkshroud_gear = ['Heavy Bolter']
darkshroud_rules = ['Jink','Aura - 6 - Hard to Hit']
imp_index_1['Ravenwing Darkshroud'] = CodexEntry.new(darkshroud, darkshroud_gear, darkshroud_rules, darkshroud_cost, flier)

nephilim = [50,6,3,6,6,10,3,8,3]
nephilim_gear = ['Avenger Mega Bolter', 'Twin Heavy Bolter', 'Blacksword Missile Launcher','Blacksword Missile Launcher']
nephilim_rules = ['Jink','Hard to Hit','Airborne','Anti-Ground']
imp_index_1['Nephilim Jetfighter'] = CodexEntry.new( nephilim,  nephilim_gear,  nephilim_rules,  nephilim_cost, flier)

drk_talon = [40,6,3,6,6,10,3,8,3]
drk_talon_gear = ['Hurricane Bolter','Hurricane Bolter','Rift Cannon']
drk_talon_rules = ['Jink','Hard to Hit','Airborne','Anti-Ground']
imp_index_1['Ravenwing Dark Talon'] = CodexEntry.new(drk_talon, drk_talon_gear, drk_talon_rules, drk_talon_cost, flier)


blk_knight_stats = [14,3,3,4,5,2,2,8,3]
blk_knight_sarge_stats = [14,3,3,4,5,2,3,8,3]
blk_knight_gear = ['Corvus Hammer','Bolt Pistol','Frag Grenade','Krak Grenade','Plamsa Talon']
blk_knight_rules = ['Turbo-Boost','Jink']
imp_index_1['Ravenwing Black Knight'] = CodexEntry.new(blk_knight_stats, blk_knight_gear, blk_knight_rules, blk_knight_cost, infantry)
imp_index_1['Ravenwing Huntsmaster'] = CodexEntry.new(blk_knight_sarge_stats, blk_knight_gear, blk_knight_rules, blk_knight_cost, infantry)

ls_veng_stats = [12,3,3,4,6,9,3,8,3]
ls_veng_gear = ['Heavy Bolter','Plamsa Storm Bolter']
ls_rules = ['Fly','Jink']
imp_index_1['Ravenwing Land Speeder Vengance'] = CodexEntry.new(ls_veng_stats, ls_veng_gear, ls_rules, ls_veng_cost, flier)

grimnar_stats = [5,2,2,4,4,7,5,9,2]
grimnar_gear = ['Axe of Morkai','Storm Bolter']
grimnar_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - All','Deepstrike']
imp_index_1['Logan Grimnar'] = CodexEntry.new(grimnar_stats, grimnar_gear, grimnar_rules, grimnar_cost, character)

grimnar_storm_stats = [10,2,2,4,6,12,5,9,3]
grimnar_storm_gear = ['Axe of Morkai','Storm Bolter','Tynak and Fenrir']
grimnar_storm_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - All','Deepstrike','Reroll - Charge']
imp_index_1['Logan Grimnar on Stormrider'] = CodexEntry.new(grimnar_storm_stats, grimnar_storm_gear, grimnar_storm_rules, grimnar_storm_cost, character)


thunderwolf_lord_stats = [10,2,2,4,5,7,4,9,3]
thunderwolf_lord_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade','Storm Bolter','Thunderwolf']
thunderwolf_lord_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1']
imp_index_1['Wolf Lord on Thunderwolf'] = CodexEntry.new(thunderwolf_lord_stats, thunderwolf_lord_gear, thunderwolf_lord_rules, thunderwolf_lord_cost, character)

blackmane_stats = [6,2,2,4,4,5,5,9,3]
svangir = [12,3,7,4,4,1,3,4]
svan_gear = ['Teeth and Claws']
blackmane_gear = ['Frostfang','Bolt Pistol','Frag Grenade','Krak Grenade','Storm Bolter']
blackmane_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1','Aura - 6 - Reroll - Charge']
imp_index_1['Ragnar Blackmane'] = CodexEntry.new(blackmane_stats, blackmane_gear, blackmane_rules, blackmane_cost, character)
imp_index_1['Svangir'] = CodexEntry.new(svangir, svan_gear, [], blackmane_cost, character)


krom_stats = [6,2,2,4,4,5,5,9,3]
krom_gear = ['Wyrmclaw','Bolt Pistol','Frag Grenade','Krak Grenade','Storm Bolter']
krom_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1','Fear - 1']
imp_index_1['Krom Dragongraze'] = CodexEntry.new(krom_stats, krom_gear, krom_rules, krom_cost, character)


arjac_stats = [6,2,2,4,4,5,5,9,3]
arjac_gear = ['Foehammer']
arjac_rules = ['Invulnerable - 3','Aura - 6 - Reroll - All - Wounds - 1','Duelist - Reroll - Fight - Hits - All', 'Aura - Wolf Guard - Attacks - 1','Damage - Reduced - All - 1']
imp_index_1['Arjac Rockfist'] = CodexEntry.new(arjac_stats, arjac_gear, arjac_rules, arjac_cost, character + ['Wolf Guard'])

harald_stats = [10,2,2,4,5,7,4,9,3]
harald_gear = ['Glacius','Bolt Pistol','Frag Grenade','Krak Grenade','Storm Bolter','Crushing Teeth and Claws']
harald_rules = ['Invulnerable - 3','Aura - 6 - Reroll - All - Hits - 1', 'Saves - Shooting - 1']
imp_index_1['Harald Deathwolf'] = CodexEntry.new(harald_stats, harald_gear, harald_rules, harald_cost, character)

canis_stats = [10,2,5,4,5,6,4,8,3]
canis_gear = ['Two Wolf Claws','Bolt Pistol','Frag Grenade','Krak Grenade','Storm Bolter','Crushing Teeth and Claws']
canis_rules = ['Aura - Wolves - Attacks - 1','Reroll - Charges','Aura - 6 - Reroll - All - Wound - 1']
imp_index_1['Canis Wolfborn'] = CodexEntry.new(canis_stats, canis_gear, canis_rules, canis_cost, character)


rune_priest_stats = [6,2,3,4,4,4,3,9,3]
rune_priest_gear = ['Runic Axe','Bolt Pistol','Frag Grenade','Krak Grenade']
rune_priest_rules = ['Deny - 1', 'Psyker - 2']
imp_index_1['Rune Priest'] = CodexEntry.new(rune_priest_stats, rune_priest_gear, rune_priest_rules, rune_priest_cost, character)

rune_priest_term_stats = [6,2,3,4,4,5,3,9,2]
rune_priest_term_gear = ['Runic Axe','Storm Bolter']
rune_priest_term_rules = ['Invulnerable - 5', 'Deny - 1', 'Psyker - 2']
imp_index_1['Rune Priest in Terminator Armor'] = CodexEntry.new(rune_priest_term_stats, rune_priest_term_gear, rune_priest_term_rules, rune_priest_term_cost, character)


rune_priest_bike_stats = [14,2,3,4,5,5,3,9,3]
rune_priest_bike_gear = ['Runic Axe','Storm Bolter']
rune_priest_bike_rules = ['Deny - 1', 'Psyker - 2']
imp_index_1['Rune Priest on Bike'] = CodexEntry.new(rune_priest_bike_stats, rune_priest_bike_gear, rune_priest_bike_rules, rune_priest_bike_cost, character)


njal_stats = [6,2,2,4,4,5,3,9,2]
njal_gear = ['Staff of the Stormcaller', 'Nightwing','Bolt Pistol','Frag Grenade','Krak Grenade']
njal_rules = ['Deny - 1', 'Psyker - 2','Psychic Test - 1', 'Invulnerable - 5', 'Reroll - Deny - 1']
imp_index_1['Njal Stormcaller'] = CodexEntry.new(njal_stats, njal_gear, njal_rules, njal_cost, character)

njal_term_stats = [5,2,2,4,4,6,3,9,2]
imp_index_1['Njal Stormcaller in Runic Terminator Armor'] = CodexEntry.new(njal_term_stats, njal_gear, njal_rules, njal_term_cost, character)


wolf_priest_stats = [6,2,3,4,4,4,3,9,3]
wolf_priest_gear = ['Crozius Arcanum','Bolt Pistol','Frag Grenade','Krak Grenade']
wolf_priest_rules = ['Aura - 6 - Reroll - Fight - Hits - All','Invulnerable - 4','Healing Balms']
imp_index_1['Wolf Priest'] = CodexEntry.new(wolf_priest_stats, wolf_priest_gear, wolf_priest_rules, wolf_priest_cost, character)

wolf_priest_term_stats = [5,2,3,4,4,5,3,9,2]
wolf_priest_term_gear = ['Crozius Arcanum','Storm Bolter']
wolf_priest_term_rules = ['Aura - 6 - Reroll - Fight - Hits - All','Invulnerable - 4','Healing Balms']
imp_index_1['Wolf Priest in Terminator Armor'] = CodexEntry.new(wolf_priest_term_stats, wolf_priest_term_gear, wolf_priest_term_rules, wolf_priest_term_cost, character)

wolf_priest_bike_stats = [14,2,3,4,5,5,3,9,3]
wolf_priest_bike_gear = ['Crozius Arcanum','Bolt Pistol','Frag Grenade','Krak Grenade','Twin Boltgun']
wolf_priest_bike_rules = ['Aura - 6 - Reroll - Fight - Hits - All','Invulnerable - 4','Healing Balms','Turbo-Boost']
imp_index_1['Wolf Priest on Bike'] = CodexEntry.new(wolf_priest_bike_stats, wolf_priest_bike_gear, wolf_priest_bike_rules, wolf_priest_bike_cost, character)


ulrik_stats = [6,2,2,4,4,5,4,9,3]
ulrik_gear = ['Crozius Arcanum','Plasma Pistol','Frag Grenade','Krak Grenade']
ulrik_rules = ['Aura - 6 - Reroll - Fight - Hits - All','Invulnerable - 4','Healing - D3']
imp_index_1['Ulrik the Slayer'] = CodexEntry.new(ulrik_stats, ulrik_gear, ulrik_rules, ulrik_cost, character)

wolf_guard_leader_stats = [6,2,3,4,4,4,4,8,3]
wolf_guard_leader_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade']
wolf_guard_leader_rules = ['Aura - 6 - Reroll - All - Wound - 1']
imp_index_1['Wolf Guard Battle Leader'] = CodexEntry.new(wolf_guard_leader_stats, wolf_guard_leader_gear, wolf_guard_leader_rules, wolf_guard_leader_cost, character)

wolf_guard_leader_term_stats = [5,2,3,4,4,5,4,8,2]
wolf_guard_leader_term_gear = ['Power Sword','Storm Bolter']
wolf_guard_leader_term_rules = ['Aura - 6 - Reroll - All - Wound - 1','Invulnerable - 5','Deepstrike']
imp_index_1['Wolf Guard Battle Leader in Terminator Armor'] = CodexEntry.new(wolf_guard_leader_term_stats, wolf_guard_leader_term_gear, wolf_guard_leader_term_rules, wolf_guard_leader_term_cost, character)

wolf_guard_leader_bike_stats = [14,2,3,4,5,5,4,8,3]
wolf_guard_leader_bike_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade','Twin Boltgun']
wolf_guard_leader_bike_rules = ['Aura - 6 - Reroll - All - Wound - 1']
imp_index_1['Wolf Guard Battle Leader on Bike'] = CodexEntry.new(wolf_guard_leader_bike_stats, wolf_guard_leader_bike_gear, wolf_guard_leader_bike_rules, wolf_guard_leader_bike_cost, character)

thunderwolf_guard_leader_stats = [10,2,3,4,5,6,4,8,3]
thunderwolf_guard_leader_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade','Crushing Teeth and Claws']
thunderwolf_guard_leader_rules = ['Aura - 6 - Reroll - All - Wound - 1']
imp_index_1['Wolf Guard Battle Leader on Thunderwolf'] = CodexEntry.new(thunderwolf_guard_leader_stats, thunderwolf_guard_leader_gear, thunderwolf_guard_leader_rules, thunderwolf_guard_leader_cost, character)

bjorn_stats = [8,2,2,7,8,8,5,9,3]
bjorn_gear = ['Trueclaw','Assault Cannon','Heavy Flamer']
bjorn_rules = ['Smoke Launchers','Aura - 6 - Reroll - All - Hit - 1','FNP - 5','Command Point - 1']
imp_index_1['Bjorn the Fell-handed'] = CodexEntry.new(bjorn_stats, bjorn_gear, bjorn_rules, bjorn_cost, dreadnought)

bloodclaw = [6,3,4,4,4,1,1,7,3]
skyclaw = [12,3,4,4,4,1,1,7,3]
bloodclaw_sarge = [6,3,4,4,4,1,2,7,3]
wolfguard_sarge = [6,3,3,4,4,1,2,8,3]
wolfguard_sarge_term = [5,3,3,4,4,2,2,8,2]
bloodclaw_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade']
bloodclaw_rules = ['ATSKNF','Charge - Attack - 1']
wolfguard_sarge_term_rules = ['ATSKNF','Charge - Attack - 1','Invulnerable - 5']
imp_index_1['Blood Claw'] = CodexEntry.new(bloodclaw, bloodclaw_gear, bloodclaw_rules, bloodclaw_cost, infantry)
imp_index_1['Skyclaw'] = CodexEntry.new(skyclaw, bloodclaw_gear, bloodclaw_rules, bloodclaw_cost, infantry)
imp_index_1['Blood Claw Pack Leader'] = CodexEntry.new(bloodclaw_sarge, bloodclaw_gear, bloodclaw_rules, bloodclaw_cost, infantry)
imp_index_1['Wolf Guard Pack Leader'] = CodexEntry.new(wolfguard_sarge, bloodclaw_gear, bloodclaw_rules, wolfguard_cost, infantry)
imp_index_1['Wolf Guard Pack Leader in Terminator Armor'] = CodexEntry.new(wolfguard_sarge_term, wolf_guard_leader_term_gear, wolfguard_sarge_term_rules, wolfguard_sarge_term_cost, infantry)


lukas_stats = [6,2,3,4,4,4,4,8,3]
lukas_gear = ['Claw of the Jackalwolf','Plasma Pistol','Frag Grenade','Krak Grenade']
lukas_rules = ['Aura - Blood Claw - Add - All - Hits - 1','Hard to Hit - Fight - 1','Fear - 1']
imp_index_1['Lukas the Trickster'] = CodexEntry.new(lukas_stats, lukas_gear, lukas_rules, lukas_cost, character + ['Blood Claw'])


grey_hunter = [6,3,3,4,4,1,1,7,3]
grey_hunter_sarge = [6,3,4,4,4,1,2,7,3]
grey_hunter_rules = ['ATSKNF']
long_fang_rules = ['ATSKNF','Reroll - Shooting - 1']
grey_hunter_gear = ['Boltgun','Bolt Pistol','Frag Grenade','Krak Grenade']
imp_index_1['Grey Hunter'] = CodexEntry.new(grey_hunter, grey_hunter_gear, grey_hunter_rules, grey_hunter_cost, infantry)
imp_index_1['Grey Hunter Pack Leader'] = CodexEntry.new(grey_hunter_sarge, grey_hunter_gear, grey_hunter_rules, grey_hunter_cost, infantry)
imp_index_1['Wolf Guard'] = CodexEntry.new(wolfguard_sarge, grey_hunter_gear, grey_hunter_rules, wolfguard_cost, infantry)
imp_index_1['Long Fang'] = CodexEntry.new(grey_hunter, grey_hunter_gear, long_fang_rules, long_fang_cost, infantry)
imp_index_1['Long Fang Pack Leader'] = CodexEntry.new(grey_hunter, grey_hunter_gear, long_fang_rules, long_fang_cost, infantry)

iron_priest_stats = [6,2,3,4,4,4,3,8,2]
iron_priest_gear = ['Thunder Hammer','Boltgun', 'Servo-arm','Plasma Pistol','Frag Grenade','Krak Grenade']
iron_priest_rules = ['Heal - Vehicle - D3']
imp_index_1['Iron Priest'] = CodexEntry.new(iron_priest_stats, iron_priest_gear, iron_priest_rules, iron_priest_cost, character)

iron_priest_bike_stats = [14,2,3,4,5,5,3,8,2]
iron_priest_bike_gear = ['Thunder Hammer','Boltgun', 'Servo-arm','Plasma Pistol','Frag Grenade','Krak Grenade','Twin Boltgun']
iron_priest_bike_rules = ['Heal - Vehicle - D3']
imp_index_1['Iron Priest on Bike'] = CodexEntry.new(iron_priest_bike_stats, iron_priest_bike_gear, iron_priest_bike_rules, iron_priest_bike_cost, character)

iron_priest_wolf_stats = [10,2,3,4,5,6,3,8,2]
iron_priest_wolf_gear = ['Thunder Hammer','Boltgun','Frag Grenade','Krak Grenade','Servo-arm','Crushing Teeth and Claws']
imp_index_1['Iron Priest on Thunderwolf'] = CodexEntry.new(iron_priest_wolf_stats, iron_priest_wolf_gear, iron_priest_rules, iron_priest_wolf_cost, character)



cyberwolf_stats = [10,3,7,4,4,2,3,4,4]
fenris_wolf_stats = [10,3,7,4,4,1,2,4,6]
cyberwolf_gear = ['Teeth and Claws']
cyberwolf_rules = ['Reroll - Charges'] 
imp_index_1['Cyberwolf'] = CodexEntry.new(cyberwolf_stats, cyberwolf_gear, iron_priest_rules, cyberwolf_cost, infantry)
imp_index_1['Fenrisian Wolf'] = CodexEntry.new(fenris_wolf_stats, cyberwolf_gear, iron_priest_rules, fenris_wolf_cost, infantry)


scouts_stats = [6, 3, 3, 4, 4, 1, 1, 7, 4]
scouts_sarge_stats = [6, 3, 3, 4, 4, 1, 2, 8, 4]
scouts_gear = ['Boltgun', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
scouts_rules = ['ATSKNF']
imp_index_1['Wolf Scout'] = CodexEntry.new(scouts_stats, scouts_gear, scouts_rules, scouts_cost, infantry)
imp_index_1['Wolf Scout Pack Leader'] = CodexEntry.new(scouts_sarge_stats, scouts_gear, scouts_rules, scouts_cost, infantry)


wulfen_stats = [7,3,5,5,4,2,3,7,4]
wulfen_sarge_stats = [7,3,5,5,4,2,4,7,4]
wulfen_gear = ['Wulfen Claws']
wulfen_sarge_gear = ['Frost Claws']
wulfen_rules = ['Reroll - Charges','Fleet','FNP - 5','Death Throes - 0','Aura - 6 - Reroll - Charges','Aura - 6 - Attacks - 1'] 
imp_index_1['Wulfen'] = CodexEntry.new(wulfen_stats, wulfen_gear, wulfen_rules, wulfen_cost, character)
imp_index_1['Wulfen Pack Leader'] = CodexEntry.new(wulfen_sarge_stats, wulfen_sarge_gear, wulfen_rules, wulfen_cost, character)


lonewolf_stats = [6,2,3,4,4,3,3,8,3]
lonewolf_rules = ['Death Throws - 4','Duelist - Wounds'] 
imp_index_1['Lone Wolf'] = CodexEntry.new(lonewolf_stats, bloodclaw_gear, lonewolf_rules, lonewolf_cost, character)

lonewolf_term_stats = [6,2,3,4,4,3,3,8,3]
lonewolf_term_rules = ['Death Throws - 4','Duelist - Wounds','Invulnerable - 5'] 
imp_index_1['Lone Wolf in Terminator Armor'] = CodexEntry.new(lonewolf_term_stats, wolf_guard_leader_term_gear, lonewolf_rules, lonewolf_term_cost, character)


murderfang_stats = [8,2,3,6,7,8,5,8,3]
murderfang_gear = ['Murderclaws','Storm Bolter','Heavy Flamer']
murderfang_rules = ['Reroll Charges']
imp_index_1['Murderfang'] = CodexEntry.new(murderfang_stats, murderfang_gear, murderfang_rules, murderfang_cost, dreadnought)

wolf_guard_bike_stats = [14,3,3,4,5,2,2,8,3]
wolf_guard_bike_sarge_stats = [14,3,3,4,5,2,3,8,3]
wolf_guard_bike_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade','Twin Boltgun']
wolf_guard_bike_rules = ['Turbo-Boost']
imp_index_1['Wolf Guard on Bike'] = CodexEntry.new(wolf_guard_bike_stats, wolf_guard_bike_gear, wolf_guard_bike_rules, wolf_guard_bike_cost, infantry)
imp_index_1['Wolf Guard Pack Leader on Bike'] = CodexEntry.new(wolf_guard_bike_sarge_stats, wolf_guard_bike_gear, wolf_guard_bike_rules, wolf_guard_bike_cost, infantry)

wolf_guard_term_stats = [5,3,3,4,4,2,2,8,2]
wolf_guard_term_sarge_stats = [5,3,3,4,4,2,3,8,2]
wolf_guard_term_gear = ['Power Fist','Storm Bolter']
wolf_guard_term_sarge_gear = ['Power Sword','Storm Bolter']
wolf_guard_term_rules = ['Invulnerable - 5','Deepstrike']
imp_index_1['Wolf Guard in Terminator Armor'] = CodexEntry.new(wolf_guard_term_stats, wolf_guard_term_gear, wolf_guard_term_rules, wolf_guard_term_cost, infantry)
imp_index_1['Wolf Guard Pack Leader in Terminator Armor'] = CodexEntry.new(wolf_guard_term_sarge_stats, wolf_guard_term_sarge_gear, wolf_guard_term_rules, wolf_guard_term_cost, infantry)

swiftclaw = [14,3,4,4,5,2,1,7,3]
swiftclaw_sarge = [13,3,4,4,5,2,2,7,3]
swiftclaw_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade','Twin Boltgun']
swiftclaw_rules = ['ATSKNF','Charge - Attack - 1','Turbo-Boost']
imp_index_1['Swift Claw'] = CodexEntry.new(swiftclaw, swiftclaw_gear, swiftclaw_rules, swiftclaw_cost, infantry)
imp_index_1['Swift Claw Pack Leader'] = CodexEntry.new(swiftclaw_sarge, swiftclaw_gear, swiftclaw_rules, swiftclaw_cost, infantry)



swift_atk_bike_stats = [14,3,4,4,5,4,2,7,3]
imp_index_1['Swiftclaw Attack Bike'] = CodexEntry.new(swift_atk_bike_stats, atk_biker_gear, swiftclaw_rules, swiftclaw_atk_bike_cost, infantry)

stormwolf = [50,6,3,8,7,14,3,8,3]
stormwolf_gear = ['Lascannon','Lascannon','Twin Heavy Bolter','Twin Heavy Bolter','Twin Helfrost Cannon']
storm_fang_gear = ['Helfrost Destructor','Twin Heavy Bolter','Twin Heavy Bolter','Stormstrike Missile Launcher''Stormstrike Missile Launcher']
blackstar_gear = ['Twin Assault Cannon','Stormstrike Missile Launcher''Stormstrike Missile Launcher']
storm_wolf_rules = ['Hard to Hit - 1', 'Move and Fire', 'Fly']
imp_index_1['Stormwolf Gunship'] = CodexEntry.new(stormwolf, stormwolf_gear, storm_wolf_rules, storm_wolf_cost,flier)
imp_index_1['Stormfang Gunship'] = CodexEntry.new(stormwolf, storm_fang_gear, storm_wolf_rules, storm_fang_cost,flier)
imp_index_1['Corvus Blackstar'] = CodexEntry.new(stormwolf, blackstar_gear, storm_wolf_rules, blackstar_cost,flier)


thunderwolf_stats = [10,3,3,4,5,3,2,8,3]
thunderwolf_gear = ['Chainsword','Bolt Pistol','Frag Grenade','Krak Grenade','Crushing Teeth and Claws']
imp_index_1['Thunderwolf Cavalry'] = CodexEntry.new(thunderwolf_stats, thunderwolf_gear, grey_hunter_rules, thunderwolf_cost,infantry)


watch_master_stats = [6,2,2,4,4,6,5,9,2]
watch_master_gear = ['Guardian Spear','Frag Grenade','Krak Grenade']
watch_master_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - All']
imp_index_1['Watch Master'] = CodexEntry.new(watch_master_stats, watch_master_gear, watch_master_rules, watch_master_cost, character)

artemis_stats = [6,2,2,4,4,5,4,9,3]
artemis_gear = ['Power Sword','Hellfire Extremis','Stasis Bomb','Frag Grenade','Krak Grenade']
artemis_rules = ['Invulnerable - 4','Aura - 6 - Reroll - All - Hits - 1','FNP - 6']
imp_index_1['Watch Captain Artemis'] = CodexEntry.new(artemis_stats, artemis_gear, artemis_rules, artemis_cost, character)

watch_veteran = [6,3,3,4,4,1,2,8,3]
watch_sarge = [6,3,3,4,4,1,3,9,3]
blk_shield = [6,3,3,4,4,1,3,8,3]
watch_term = [5,3,3,4,4,2,2,8,2]
watch_term_sarge = [5,3,3,4,4,2,3,9,2]
watch_biker = [14,3,3,4,5,2,2,8,3]
watch_biker_sarge = [14,3,3,4,5,2,3,9,3]
watch_vanguard = [12,3,3,4,4,1,2,8,3]
watch_vanguard_sarge = [12,3,3,4,4,1,3,9,3]
watch_gear = ['Boltgun - Deathwatch','Frag Grenades','Krak Grenades']
watch_term_gear = ['Storm Bolter','Power Fist']
watch_term_sarge_gear = ['Storm Bolter','Power Sword']
watch_term_rules = ['Invulnerable - 5','Autopass Morale']
blk_shield_rules = ['Heroic Intervention']
watch_bike_gear = ['Frag Grenade','Krak Grenade','Twin Boltgun - Deathwatch']
watch_vanguard_gear = ['Frag Grenade','Krak Grenade','Bolt Pistol - Deathwatch','Chainsword']
watch_bike_rules = ['Fall Back - Assault','ATSKNF']
watch_vanguard_rules = ['Fall Back - Shoot','ATSKNF','Deepstrike']
imp_index_1['Deathwatch Veteran'] = CodexEntry.new(watch_veteran, watch_gear, grey_hunter_rules, watch_veteran_cost, infantry)
imp_index_1['Deathwatch Sergeant'] = CodexEntry.new(watch_sarge, watch_gear, grey_hunter_rules, watch_cost, infantry)
imp_index_1['Black Shield'] = CodexEntry.new(blk_shield, watch_gear, blk_shield_rules, blk_shield_cost, infantry)
imp_index_1['Deathwatch Terminator'] = CodexEntry.new(watch_term, watch_term_gear, watch_term_rules, watch_term_cost, infantry)
imp_index_1['Deathwatch Terminator Sergeant'] = CodexEntry.new(watch_term_sarge, watch_term_sarge_gear, watch_term_rules, watch_term_cost, infantry)
imp_index_1['Deathwatch Biker'] = CodexEntry.new(watch_biker, watch_bike_gear, watch_bike_rules, watch_bike_cost, infantry)
imp_index_1['Deathwatch Biker Sergeant'] = CodexEntry.new(watch_biker_sarge, watch_bike_gear, watch_bike_rules, watch_bike_cost, infantry)
imp_index_1['Deathwatch Vanguard Veteran'] = CodexEntry.new(watch_vanguard, watch_vanguard_gear, watch_vanguard_rules, watch_vanguard_cost, infantry)
imp_index_1['Deathwatch Vanguard Sergeant'] = CodexEntry.new(watch_vanguard_sarge, watch_vanguard_gear, watch_vanguard_rules, watch_vanguard_cost, infantry)





File.write('ImperialIndex1.yml', imp_index_1.to_yaml)












