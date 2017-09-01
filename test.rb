require_relative 'Methods\LoadFromCSV'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'

space_marine_codex = YAML.load(File.read('F:\Mathammer\Codices\SpaceMarineCodex.yml')) 
space_marine_weapons = LoadWeapons('F:\Mathammer\SMWeapons.csv')


#puts space_marine_codex['Tactical Marine'].inspect



tac_squad1 = Unit.new()
tac_squad1.addModels(space_marine_codex, space_marine_weapons, 'Tactical Marine', 3, [], [])
tac_squad1.addModels(space_marine_codex, space_marine_weapons, 'Tactical Marine', 1, ['Plasma Gun'], ['Boltgun'])
tac_squad1.addModels(space_marine_codex,space_marine_weapons, 'Tactical Marine Sergeant', 1, [], [])

var = 0
tac_squad1.getModels.each do |model|
	puts model.getID
	puts model.getGear
end

puts tac_squad1.getCost
File.write('TacSquad.yml', tac_squad1.to_yaml)