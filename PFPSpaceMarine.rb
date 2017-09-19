require_relative 'Methods\LoadFromCSV'
require_relative 'Methods\ShootingAtTarget'
require_relative 'Methods\ShootingAtDist'
require_relative 'Methods\DefensivePfP'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'
require_relative 'Classes\CodexTargets.rb'
require 'time'
start_time = Time.now

print_file = File.open('pfp.csv', 'w')


space_marine_codex = YAML.load(File.read('F:\Mathammer\Codices\SpaceMarineCodex.yml')) 
sm_wep = LoadWeapons('F:\Mathammer\SMWeapons.csv')
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
range = 36
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
			[opt1, opt2, opt3, opt3], ['Heavy Flamger', 'Heavy Onslaught Gatling Cannon', 'Fragstorm Grenade Launcher', 
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

## Hunters & Stalkers
units['Hunter'] = Unit.new()
units['Hunter'].addModels(space_marine_codex, sm_wep, 'Hunter', 1, [],[])

units['Stalker'] = Unit.new()
units['Stalker'].addModels(space_marine_codex, sm_wep, 'Stalker', 1, [],[])

##Whirlwinds
whirl_opt = ['Whirlwind Castellan Launcher', 'Whirlwind Vengeance Launcher']
whirl_opt.each do |opt|
	string = "Whirlwind - #{opt}"
	units[string] = Unit.new
	units[string].addModels(space_marine_codex, sm_wep, 'Whirlwind', 1, [opt],['Whirlwind Castellan Launcher'])
end
### Predators
pred_turret = ['Predator Autocannon', 'Twin Lascannon']
pred_spon = ['Heavy Bolter', 'Lascannon']
pred_turret.each do |turret|
	pred_spon.each do |spon|
		string = "Predator - #{turret} - #{spon}"
		units[string] = Unit.new
		units[string].addModels(space_marine_codex, sm_wep, 'Predator', 1, [turret,spon,spon],['Predator Autocannon'])
	end
end

#vindicator
units['Vindicator'] = Unit.new
units['Vindicator'].addModels(space_marine_codex, sm_wep, 'Vindicator', 1, [],[])

lr_opt = ['Multi-melta','Storm Bolter']
lr_types = ['Land Raider', 'Land Raider Crusader','Land Raider Redeemer']
lr_types.each do |type|
	lr_opt.each do |opt|
		string = "#{type} - #{opt}"
		units[string] = Unit.new
		units[string].addModels(space_marine_codex, sm_wep, type, 1, [opt],[])
	end
end
		
razorback_opt = ['Twin Heavy Bolter', 'Twin Lascannon', 'Twin Assault Cannon']
razorback_opt.each do |opt|
	string = "Razorback - #{opt}"
	units[string] = Unit.new
	units[string].addModels(space_marine_codex, sm_wep, 'Razorback', 1, [opt],['Twin Heavy Bolter'])
end

units['Land Speeder Storm'] = Unit.new
units['Land Speeder Storm'].addModels(space_marine_codex, sm_wep, 'Land Speeder Storm', 1, [],[])
	
repulsor_opt1 = ['Twin Heavy Bolter', 'Twin Lascannon']
repulsor_opt2 = ['Heavy Onslaught Gatling Cannon', 'Las-talon']
repulsor_opt3 = ['Ironhail Heavy Stubber', 'Onslaught Gatling Cannon']
repulsor_opt4 = ['Storm Bolter', 'Fragstorm Grenade Launcher']
repulsor_opt5 = ['Icarus Ironhail Heavy Stubber', 'Icarus Rocket Pod', 'Storm Bolter', 'Fragstorm Grenade Launcher']
repulsor_opt6 = ['Auto Launcher', 'Fragstorm Grenade Launcher']
repulsor_opt7 = ['Blank', 'Ironhail Heavy Stubber']

repulsor_opt1.each do |opt1|
	repulsor_opt2.each do |opt2|
		repulsor_opt3.each do |opt3|
			repulsor_opt4.each do |opt4|
				repulsor_opt5.each do |opt5|
					repulsor_opt6.each do |opt6|
						repulsor_opt7.each do |opt7|
							string = "Repulsor-#{opt1}-#{opt2}-#{opt3}-2#{opt4}-#{opt5}-#{opt6}-#{opt7}"
							units[string] = Unit.new
							units[string].addModels(space_marine_codex, sm_wep, 'Repulsor', 1,
							[opt1, opt2, opt3, opt4, opt4, opt5, opt6, opt7],
							['Twin Heavy Bolter','Heavy Onslaught Gatling Cannon','Icarus Ironhail Heavy Stubber',
							'Storm Bolter','Storm Bolter','Auto Launcher'])
						end
					end
				end
			end
		end
	end
end

hawk_opt1 = ['Heavy Bolter','Skyhammer Missile Launcher','Typhoon Missile Launcher']
hawk_opt2 = ['Icarus Stormcannon', 'Las-talon']
hawk_opt1.each do |opt1|
	hawk_opt2.each do |opt2|
		string = "Stormhawk Interceptor - #{opt1} - #{opt2}"
		units[string] = Unit.new
		if opt1 == 'Heavy Bolter'
			units[string].addModels(space_marine_codex, sm_wep, 'Stormhawk Interceptor', 1, [opt1, opt1, opt2],
			[hawk_opt1[0], hawk_opt1[0], hawk_opt2[0]])
		else
			units[string].addModels(space_marine_codex, sm_wep, 'Stormhawk Interceptor', 1, [opt1, opt2],
			[hawk_opt1[0], hawk_opt1[0], hawk_opt2[0]])
		end
	end
end
		
raven_opt = ['Twin Assault Cannon', 'Twin Lascannon', 'Twin Heavy Plasma Cannon']
raven_opt2 = ['Twin Heavy Bolter','Twin Multi-melta','Typhoon Missile Launcher']
raven_opt3 = ['Blank','Hurricane Bolter']

raven_opt.each do |opt1|
	raven_opt2.each do |opt2|
		raven_opt3.each do |opt3|
			string = "Stormraven Gunship-#{opt1}-#{opt2}-#{opt3}"
			units[string] = Unit.new
			units[string].addModels(space_marine_codex, sm_wep, 'Stormraven Gunship', 1, [opt1, opt2,opt3],
			[raven_opt[0], raven_opt2[0], raven_opt3[0]])
		end
	end
end

talon_opt = ['Heavy Bolter', 'Lascannon', 'Skyhammer Missile Launcher', 'Typhoon Missile Launcher']
talon_opt.each do |opt|
	string = "Stormtalon Gunship-#{opt}"
	units[string] = Unit.new
	if opt == 'Lascannon'
		units[string].addModels(space_marine_codex, sm_wep, 'Stormtalon Gunship', 1, [opt, opt], [talon_opt[0],talon_opt[0]])
	else
		units[string].addModels(space_marine_codex, sm_wep, 'Stormtalon Gunship', 1, [opt], [talon_opt[0]])
	end
end

distances = [12,24,36,48]

distances.each do |dist|
			print_file.write "#{dist},"
end
print_file.write "\n"
## Calculate Offensive power
units.each do |def_string, defender|
	pfp_avg_hash = DefensivePfP(space_marine_codex, sm_wep, defender, units, distances)
	puts Time.now - start_time
	puts def_string
	print_file.write "#{def_string},"
	distances.each do |dist|
		print_file.write "#{pfp_avg_hash[dist]},"
	end
	print_file.write "\n"
end
	

end_time = Time.now
elapsed = end_time - start_time
puts "Calculation took #{elapsed} Seconds" 

