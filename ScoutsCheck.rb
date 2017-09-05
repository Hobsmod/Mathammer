require_relative 'Methods\LoadFromCSV'
require_relative 'Methods\ShootingAtTargetTroubleshoot'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'

space_marine_codex = YAML.load(File.read('F:\Mathammer\Codices\SpaceMarineCodex.yml')) 
sm_wep = LoadWeapons('F:\Mathammer\SMWeapons.csv')
targets = LoadTargets('targets.csv')
sarge_ranged = ['Boltgun', 'Combi-flamer','Combi-melta', 'Combi-plasma', 'Storm Bolter']
scout_options = ['Boltgun', 'Astartes Shotgun', 'Sniper Rifle']
scout_heavy = ['Boltgun', 'Heavy Bolter', 'Missile Launcher']

range = 11
units = Hash.new
combined = Hash.new{|hash, key| hash[key] = Hash.new}

scout_options.each do |opt|
	scout_heavy.each do |heavy|
		sarge_ranged.each do |sarge|
			string = "Scout-#{opt}-#{heavy}-#{sarge}"
			units[string] = Unit.new()
			units[string].addModels(space_marine_codex, sm_wep, 'Scouts', 3, [opt], ['Boltgun'])
			units[string].addModels(space_marine_codex, sm_wep, 'Scouts', 1, [heavy], ['Boltgun'])
			units[string].addModels(space_marine_codex, sm_wep, 'Scout Sergeant', 1, [sarge], ['Boltgun'])
			targets.each do |key, value|
				ex_wounds = ShootingAtTargetTroubleshoot(units[string], sm_wep, targets[key], range, FALSE)
				cost = units[string].getCost
				efficency = ex_wounds #(ex_wounds * 100) / cost
				combined[string][key] = efficency
			end
		end
	end
end

