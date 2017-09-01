require_relative '..\Classes\CodexEntry.rb'
require 'yaml'


spacemarinecodex = Hash.new{}



### Tactical Marine
tactical_stats = [6, 3, 3, 4, 4, 1, 1, 7, 3]
tactical_gear = ['Boltgun', 'Bolt Pistol', 'Frag Grenade', 'Krak Grenade']
tactical_rules = ['ATSKNF']
tactical_cost = 13
spacemarinecodex['Tactical Marine'] = CodexEntry.new(tactical_stats, tactical_gear, tactical_rules, tactical_cost)

###Sergeant
sergeant_stats = [6, 3, 3, 4, 4, 1, 2, 8, 3]
spacemarinecodex['Tactical Marine Sergeant'] = CodexEntry.new(sergeant_stats, tactical_gear, tactical_rules, tactical_cost)


puts spacemarinecodex.inspect
File.write('SpaceMarineCodex.yml', spacemarinecodex.to_yaml)