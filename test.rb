require_relative 'Methods\LoadFromCSV'
require_relative 'Methods\ShootingAtTarget'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'

space_marine_codex = YAML.load(File.read('F:\Mathammer\Codices\SpaceMarineCodex.yml')) 
sm_wep = LoadWeapons('F:\Mathammer\SMWeapons.csv')
targets = LoadTargets('targets.csv')

special_wep = ['Flamer','Grav-gun','Meltagun','Plasma Gun']
heavy_wep = ['Grav-cannon and Grav-amp', 'Heavy Bolter', 'Lascannon', 'Missile Launcher',
'Multi-melta', 'Plasma Cannon']
pistols = ['Bolt Pistol', 'Grav-Pistol', 'Plasma Pistol']
sarge_ranged = ['Boltgun', 'Combi-flamer','Combi-melta', 'Combi-plasma', 'Storm Bolter']
dreadnought_hvy_wep = ['Assault Cannon', 'Heavy Plasma Cannon', 'Multi-melta', 'Twin Lascannon']

range = 11
units = Hash.new
combined = Hash.new{|hash, key| hash[key] = Hash.new}

#Iterate over all combinations
#Tactical Squads
special_wep.each do |special|
	heavy_wep.each do |heavy|
		sarge_ranged.each do |sarge|
			string = "Tactical-#{special}-#{heavy}-#{sarge}"
			#puts string
			units[string] = Unit.new()
			units[string].addModels(space_marine_codex, sm_wep, 'Tactical Marine', 7, [], [])
			units[string].addModels(space_marine_codex, sm_wep, 'Tactical Marine', 1, [special], ['Boltgun'])
			units[string].addModels(space_marine_codex, sm_wep, 'Tactical Marine', 1, [heavy], ['Boltgun'])
			units[string].addModels(space_marine_codex, sm_wep, 'Tactical Marine Sergeant', 1, [sarge], ['Boltgun', 'Bolt Pistol'])
			targets.each do |key, value|
				ex_wounds = ShootingAtTarget(units[string], sm_wep, targets[key], range, false)
				cost = units[string].getCost
				efficency = (ex_wounds * 100) / cost
				combined[string][key] = efficency
			end
		end
	end
end
##Intercessors
intercessor_options = ['Bolt Rifle','Auto Bolt Rifle', 'Stalker Bolt Rifle']
intercessor_options.each do |opt|
	(0..1).each do |n|
		aux = ''
		if n == 1
			aux = 'Auxiliary Grenade Launcher'
		end
		string = "Intercessor-#{opt}-#{aux}"
		#puts string
		units[string] = Unit.new()
		units[string].addModels(space_marine_codex, sm_wep, 'Intercessor', 3, [opt], ['Bolt Rifle'])
		if n == 1
			units[string].addModels(space_marine_codex, sm_wep, 'Intercessor', 1, ['Auxiliary Grenade Launcher',
			opt], ['Bolt Rifle'])
		else
			units[string].addModels(space_marine_codex, sm_wep, 'Intercessor', 1, [opt], ['Bolt Rifle'])
		end
		units[string].addModels(space_marine_codex, sm_wep, 'Intercessor Sergeant', 1, [opt], ['Bolt Rifle'])
		
		targets.each do |key, value|
				ex_wounds = ShootingAtTarget(units[string], sm_wep, targets[key], range, false)
				cost = units[string].getCost
				efficency = (ex_wounds * 100) / cost
				combined[string][key] = efficency
		end
	end
end


### Scout Options
scout_options = ['Boltgun', 'Astartes Shotgun', 'Sniper Rifle']
scout_heavy = ['Boltgun', 'Heavy Bolter', 'Missile Launcher']

scout_options.each do |opt|
	scout_heavy.each do |heavy|
		sarge_ranged.each do |sarge|
			string = "Scout-#{opt}-#{heavy}-#{sarge}"
			units[string] = Unit.new()
			units[string].addModels(space_marine_codex, sm_wep, 'Scouts', 3, [opt], ['Boltgun'])
			units[string].addModels(space_marine_codex, sm_wep, 'Scouts', 1, [heavy], ['Boltgun'])
			units[string].addModels(space_marine_codex, sm_wep, 'Scout Sergeant', 1, [sarge], ['Boltgun'])
			string = "Scout-#{opt}-#{heavy}-#{sarge}"
			targets.each do |key, value|
				ex_wounds = ShootingAtTarget(units[string], sm_wep, targets[key], range, false)
				cost = units[string].getCost
				efficency = (ex_wounds * 100) / cost
				combined[string][key] = efficency
			end
		end
	end
end

#aggresors
units['Agressors'] = Unit.new()
units['Agressors'].addModels(space_marine_codex, sm_wep, 'Aggressor', 2, [], [])
units['Agressors'].addModels(space_marine_codex, sm_wep, 'Aggressor Sergeant', 1, [], [])
targets.each do |key, value|
	ex_wounds = ShootingAtTarget(units['Agressors'], sm_wep, targets[key], range, false)
	cost = units['Agressors'].getCost
	efficency = (ex_wounds * 100) / cost
	combined['Agressors'][key] = efficency
end

units['Agressors-Flamestorm'] = Unit.new()
units['Agressors-Flamestorm'].addModels(space_marine_codex, sm_wep, 'Aggressor', 2, ['Flamestorm Gauntlets'],
 ['Auto Boltstorm Gauntlet','Fragstorm Grenade Launcher'])
units['Agressors-Flamestorm'].addModels(space_marine_codex, sm_wep, 'Aggressor Sergeant', 1, 
['Flamestorm Gauntlets'], ['Auto Boltstorm Gauntlet','Fragstorm Grenade Launcher'])
targets.each do |key, value|
	ex_wounds = ShootingAtTarget(units['Agressors-Flamestorm'], sm_wep, targets[key], range, false)
	cost = units['Agressors-Flamestorm'].getCost
	efficency = (ex_wounds * 100) / cost
	combined['Agressors-Flamestorm'][key] = efficency
end

terminator_options = ['Assault Cannon','Heavy Flamer']
terminator_options.each do |opt|
	string = "Terminators-#{opt}" 
	units[string].addModels(space_marine_codex, sm_wep, 'Terminator', 3, [], [])
	units[string].addModels(space_marine_codex, sm_wep, 'Terminators', 1, ['opt'], ['Storm Bolter'])
	units[string].addModels(space_marine_codex, sm_wep, 'Terminators Sergeant', 1, [], [])
	targets.each do |key, value|
		ex_wounds = ShootingAtTarget(units['Agressors'], sm_wep, targets[key], range, false)
		cost = units[string].getCost
		efficency = (ex_wounds * 100) / cost
		combined[string][key] = efficency
	end
end

# put the string and then the efficency			
combined.each do |string, eq|
	cost = units[string].getCost()
	print "#{string},#{cost},"
	eq.each do |k, v|
		print "#{v},"
	end
	print "\n"
end
	
	
#File.write('TacSquad.yml', tac_squad1.to_yaml)