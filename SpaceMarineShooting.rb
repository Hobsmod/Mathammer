require_relative 'Methods\LoadFromCSV'
require_relative 'Methods\ShootingAtTarget'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'
require_relative 'Classes\CodexTargets.rb'
require 'time'
start_time = Time.now



space_marine_codex = YAML.load(File.read('F:\Mathammer\Codices\SpaceMarineCodex.yml')) 
sm_wep = LoadWeapons('F:\Mathammer\Weapons.csv')
targets = Hash.new

space_marine_codex.each do |key, value|
	targets[key] = CodexTarget.new(space_marine_codex, key)
end

uniq_targets = UniqueTargets(targets)




special_wep = ['Flamer','Grav-gun','Meltagun','Plasma Gun']
heavy_wep = ['Grav-cannon and Grav-amp', 'Heavy Bolter', 'Lascannon', 'Missile Launcher',
'Multi-melta', 'Plasma Cannon']
pistols = ['Bolt Pistol', 'Grav-Pistol', 'Plasma Pistol']
sarge_ranged = ['Boltgun', 'Combi-flamer','Combi-melta', 'Combi-plasma', 'Storm Bolter']
dreadnought_hvy_wep = ['Assault Cannon', 'Heavy Plasma Cannon', 'Multi-melta', 'Twin Lascannon']
combi_wep = ['Combi-flamer','Combi-melta', 'Combi-plasma', 'Combi-grav', 'Storm Bolter']
stern_combi_wep = ['Special Issue Boltgun', 'Combi-flamer','Combi-melta', 'Combi-plasma', 'Combi-grav', 'Storm Bolter']
range = 15
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
		end
	end
end

#aggresors
units['Agressors'] = Unit.new()
units['Agressors'].addModels(space_marine_codex, sm_wep, 'Aggressor', 2, [], [])
units['Agressors'].addModels(space_marine_codex, sm_wep, 'Aggressor Sergeant', 1, [], [])

units['Agressors-Flamestorm'] = Unit.new()
units['Agressors-Flamestorm'].addModels(space_marine_codex, sm_wep, 'Aggressor', 2, ['Flamestorm Gauntlets'],
 ['Auto Boltstorm Gauntlet','Fragstorm Grenade Launcher'])
units['Agressors-Flamestorm'].addModels(space_marine_codex, sm_wep, 'Aggressor Sergeant', 1, 
['Flamestorm Gauntlets'], ['Auto Boltstorm Gauntlet','Fragstorm Grenade Launcher'])


####Standard Terminators
terminator_options = ['Assault Cannon', 'Heavy Flamer']
terminator_options.each do |opt|
	string = "Terminators-#{opt}" 
	units[string] = Unit.new()
	units[string].addModels(space_marine_codex, sm_wep, 'Terminator', 3, [], [])
	units[string].addModels(space_marine_codex, sm_wep, 'Terminator', 1, [opt], ['Storm Bolter'])
	units[string].addModels(space_marine_codex, sm_wep, 'Terminator Sergeant', 1, [], [])
end
units['Terminators-Cyclone Missile Launcher'] = Unit.new()
units['Terminators-Cyclone Missile Launcher'].addModels(space_marine_codex, sm_wep, 'Terminator', 3, [], [])
units['Terminators-Cyclone Missile Launcher'].addModels(space_marine_codex, sm_wep, 'Terminator', 1, ['Cyclone Missile Launcher'], ['Storm Bolter'])
units['Terminators-Cyclone Missile Launcher'].addModels(space_marine_codex, sm_wep, 'Terminator Sergeant', 1, [], [])

####Cataphractii Terminators
cat_terminator_options = ['Combi-bolter','Heavy Flamer']
cat_terminator_options.each do |opt|
	string = "Cataphractii Terminators-#{opt}" 
	units[string] = Unit.new()
	units[string].addModels(space_marine_codex, sm_wep, 'Cataphractii Terminator', 3, [], [])
	units[string].addModels(space_marine_codex, sm_wep, 'Cataphractii Terminator', 1, [opt], ['Combi-bolter'])
	units[string].addModels(space_marine_codex, sm_wep, 'Cataphractii Terminator Sergeant', 1, [], [])
end

####Tartaros Terminators
tart_terminator_options = ['Reaper Autocannon','Heavy Flamer']
tart_sarge_options = ['Volkite Charger', 'Plasma Blaster']
grenade_opt = ['Grenade Harness', 'Combi-bolter']
tart_terminator_options.each do |opt|
	tart_sarge_options.each do |sarge|
		grenade_opt.each do |grenade|
			string = "Tartaros Terminators-#{opt}-#{sarge}-#{grenade}" 
			units[string] = Unit.new()
			units[string].addModels(space_marine_codex, sm_wep, 'Tartaros Terminator', 2, [], [])
			units[string].addModels(space_marine_codex, sm_wep, 'Tartaros Terminator', 1, [grenade], ['Combi-bolter'])
			units[string].addModels(space_marine_codex, sm_wep, 'Tartaros Terminator', 1, [opt], ['Combi-bolter'])
			units[string].addModels(space_marine_codex, sm_wep, 'Tartaros Terminator Sergeant', 1, [sarge], ['Combi-bolter'])
		end
	end
end

###Sternguard Squads
stern_options = ['Flamer','Grav-gun','Meltagun','Plasma Gun', 'Heavy Flamer']
stern_options.each do |opt|
	stern_combi_wep.each do |combi|
		sarge_ranged.each do |sarge|
			string = "Sternguard-#{opt}-#{combi}-#{sarge}"
			units[string] = Unit.new
			
			units[string].addModels(space_marine_codex, sm_wep, 'Sternguard Veterans', 2, [opt], ['Special Issue Boltgun'])
			
			units[string].addModels(space_marine_codex, sm_wep, 'Sternguard Veterans', 2, [combi], ['Special Issue Boltgun'])
			
			units[string].addModels(space_marine_codex, sm_wep, 'Sternguard Veteran Sergeant', 1, [sarge], ['Special Issue Boltgun'])
			#puts "With 1 more models each with #{sarge} the unit costs #{units[string].getCost}"
			cost = units[string].getCost
			#print "#{string},#{cost},"
		end
	end
end

dread_opt = ['Storm Bolter', 'Missile Launcher', 'Heavy Flamer']
dreadnought_hvy_wep.each do |hvy|
	dread_opt.each do |opt|
		string = "Dreadnought-#{hvy}-#{opt}"
		units[string] = Unit.new
		units[string].addModels(space_marine_codex, sm_wep, 'Dreadnought', 1, [hvy, opt ], ['Storm Bolter'])
	end
end

dreadnought_hvy_wep.each do |hvy|
	dread_opt.each do |opt|
		string = "Ven Dreadnought-#{hvy}-#{opt}"
		units[string] = Unit.new
		units[string].addModels(space_marine_codex, sm_wep, 'Venerable Dreadnought', 1, [hvy, opt ], ['Storm Bolter'])
	end
end

contempt_opt = ['Kheres Pattern Assault Cannon', 'Multi-melta']
contempt_opt.each do |opt|
	string = "Contemptor - #{opt}"
	units[string] = Unit.new
	units[string].addModels(space_marine_codex, sm_wep, 'Venerable Dreadnought', 1, [opt], ['Multi-melta'])
end


redem_opt_1 = ['Heavy Flamer', 'Onslaught Gatling Cannon']
redem_opt_2 = ['Heavy Onslaught Gatling Cannon', 'Macro Plasma Incinerator']
redem_opt_3 = ['Storm Bolter','Fragstorm Grenade Launcher']
redem_opt_1.each do |opt1|
	redem_opt_2.each do |opt2|
		redem_opt_3.each do |opt3|	
			string = "Redemptor - #{opt1}- #{opt2}-#{opt3}"
			units[string] = Unit.new
			units[string].addModels(space_marine_codex, sm_wep, 'Redemptor Dreadnought', 1, 
			[opt1, opt2, opt3, opt3], ['Heavy Flamger', 'Heavy Onslaught Gattling Cannon', 'Fragstorm Grenade Launcher', 
			'Fragstorm Grenade Launcher'])
		end
	end
end
		
###Centurion Devestators		
centurion_opt1 = ['Flamer', 'Meltagun']
centurion_opt2 = ['Hurricane Bolter', 'Centurion Assault Launcher']
centurion_opt1.each do |opt1|
	centurion_opt2.each do |opt2|
		string = "Assault Centurions-#{opt1}-#{opt2}"
		units[string] = Unit.new
		units[string].addModels(space_marine_codex, sm_wep, 'Assault Centurion',2,[opt1, opt1, opt2],
		['Flamer','Flamer','Centurion Assault Launcher'])
		units[string].addModels(space_marine_codex, sm_wep, 'Assault Centurion Sergeant',1,[opt1, opt1, opt2],
		['Flamer','Flamer','Centurion Assault Launcher'])
	end
end

###Bike Squad
special_wep.each do |special|
	sarge_ranged.each do |sarge|
		(0..3).each do |n|
			string = "Bikers-#{special}-#{sarge}"
			units[string] = Unit.new()
			units[string].addModels(space_marine_codex, sm_wep, 'Biker', n, [], [])
			units[string].addModels(space_marine_codex, sm_wep, 'Biker', 2, [special], ['Bolt Pistol'])
			units[string].addModels(space_marine_codex, sm_wep, 'Biker Sergeant', 1,
			[sarge], ['Bolt Pistol'])
		end
	end
end		

##Land Speeders
ls_opt1 = ['Heavy Bolter', 'Multi-melta']
ls_opt2 = ['Assault Cannon', 'Heavy Flamer', 'Typhoon Missile Launcher']
ls_opt1.each do |opt1|
	ls_opt2.each do |opt2|
		string = "Land Speeder-#{opt1}-#{opt2}"
		units[string] = Unit.new()
		units[string].addModels(space_marine_codex, sm_wep, 'Land Speeder', 1, [opt1, opt2], ['Heavy Bolter'])
	end
end
	
##Attack Bike Squads
atk_bike_opt = ['Heavy Bolter', 'Multi-melta']	
atk_bike_opt.each do |opt|
	string = "Attack Bike - #{opt}"
	units[string] = Unit.new()
	units[string].addModels(space_marine_codex, sm_wep, 'Attack Bike', 1, [opt], ['Heavy Bolter'])
end

##Scout Bikers
scout_bike_opt = ['Twin Boltgun', 'Astartes Grenade Launcher']
scout_bike_opt.each do |opt|
	sarge_ranged.each do |sarge|
		[2,3,6].each do |n|
			string = "Scout Bikes - #{opt} - #{n}"
			units[string] = Unit.new()
			if n  > 3 
				sub = 3
			else
				sub = 2
			end
			units[string].addModels(space_marine_codex, sm_wep, 'Scout Biker', sub, [opt], ['Twin Boltgun'])
			units[string].addModels(space_marine_codex, sm_wep, 'Scout Biker', n - sub, [],[] )
			units[string].addModels(space_marine_codex, sm_wep, 'Scout Biker Sergeant', 1, [],[] )		
		end
	end
end

### Interceptors
intercept_opt = ['Assault Bolter','Plasma Exterminator']
intercept_opt.each do |opt|
	string = "Interceptors - #{opt}"
	units[string] = Unit.new()
	units[string].addModels(space_marine_codex, sm_wep, 'Interceptor', 2, [opt, opt], ['Assault Bolter','Assault Bolter'])
	units[string].addModels(space_marine_codex, sm_wep, 'Interceptor Sergeant', 1, [opt, opt], ['Assault Bolter','Assault Bolter'])
end


###Devestators
heavy_wep.each do |opt|
	sarge_ranged.each do |sarge|
		string = "Devestators - #{opt} - #{sarge}"
		units[string] = Unit.new()
		units[string].addModels(space_marine_codex, sm_wep, 'Devestator', 4, [opt], ['Boltgun'])
		units[string].addModels(space_marine_codex, sm_wep, 'Devestator Sergeant', 1, [sarge], ['Boltgun'])
	end
end
	

### Centurion Devestators
cent_dev_opt1 = ['Hurricane Bolter', 'Centurion Missile Launcher']
cent_dev_opt2 = ['Heavy Bolter', 'Lascannon', 'Grav-cannon and Grav-amp']
cent_dev_opt1.each do |opt1|
	cent_dev_opt2.each do |opt2|
		string = "Centurion Devestators - #{opt1} - #{opt2}"
		units[string] = Unit.new()
		units[string].addModels(space_marine_codex, sm_wep, 'Centurion Devestator', 2, [opt1,opt2,opt2],
		['Hurricane Bolter','Heavy Bolter','Heavy Bolter'])
		units[string].addModels(space_marine_codex, sm_wep, 'Centurion Devestator Sergeant', 1, [opt1,opt2,opt2],
		['Hurricane Bolter','Heavy Bolter','Heavy Bolter'])
	end
end

###Hellblasters

hell_opt = ['Plasma Incinerator','Assault Plasma Incinerator', 'Heavy Plasma Incinerator']
hell_sarge_opt = ['Bolt Pistol', 'Plasma Pistol']
hell_opt.each do |opt|
	hell_sarge_opt.each do |sarge|
		string = "Hellblasters - #{opt} - #{sarge}"
		units[string] = Unit.new()
		units[string].addModels(space_marine_codex, sm_wep, 'Hellblaster', 4, [opt],['Plasma Incinerator'])
		units[string].addModels(space_marine_codex, sm_wep, 'Hellblaster Sergeant', 4, [opt,sarge],['Plasma Incinerator','Bolt Pistol'])
	end
end

###Thunderfire Cannon
units['Hellfire Cannon'] = Unit.new()
units['Hellfire Cannon'].addModels(space_marine_codex, sm_wep, 'Thunderfire Cannon', 1, [],[])
units['Hellfire Cannon'].addModels(space_marine_codex, sm_wep, 'Techmarine Gunner', 1, [],[])

## Hunters

print ",,"	
uniq_targets.each do |key, value|
	print "#{key},"
end
puts " "
## Calculate Offensive power
units.each do |string, unit|
	uniq_targets.each do |key, value|
		ex_wounds = ShootingAtTarget(unit, sm_wep, value, range, false)
		cost = unit.getCost
		efficency = (ex_wounds * 100) / cost
		combined[string][key] = efficency
	end
end
	
#put the string and then the efficency			
units.each do |string, eq|
	cost = units[string].getCost()
	print "#{string},#{cost},"
	targets.each do |k, v|
		print "#{combined[string][k]},"
	end
	if cost
		print "\n"
	end
end

	
	
#File.write('TacSquad.yml', tac_squad1.to_yaml)
end_time = Time.now
elapsed = end_time - start_time
puts "Calculation took #{elapsed} Seconds" 

