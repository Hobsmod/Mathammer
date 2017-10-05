require_relative 'Methods\LoggedDuelEngine.rb'
require_relative 'Methods\LoadFromCSV.rb'
require_relative 'Methods\LoggedPsykerMethods.rb'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'
require_relative 'Classes\CodexTargets.rb'
require 'time'
start_time = Time.now
log_file = File.open('Logs\DuelLog.txt', 'w')
out_file = File.open('LoggedDuelResults.csv', 'w')
space_marine_codex = YAML.load(File.read('Codices\SpaceMarineCodex.yml')) 
sm_wep = LoadWeapons('Codices\SMWeapons.csv')
imp_ind_1 = YAML.load(File.read('Codices\ImperialIndex1.yml')) 
imp_ind_wep = LoadWeapons('Codices\ImpInd1Weapons.csv')
gk_codex = YAML.load(File.read('Codices\GreyKnightsCodex.yml'))
gk_wep = LoadWeapons('Codices\GK+SMWeapons.csv')
hero_hash = Hash.new()
hero_hash['Captain Lysander'] = Unit2.new()
hero_hash['Captain Lysander'].addModels(space_marine_codex, sm_wep, 'Captain Lysander', 1,[] , [] )
hero_hash['High Marshal Helbrecht'] = Unit2.new()
hero_hash['High Marshal Helbrecht'].addModels(space_marine_codex, sm_wep, 'High Marshal Helbrecht', 1, [],[] )
hero_hash['Marneus Calgar'] = Unit2.new()
hero_hash['Marneus Calgar'].addModels(space_marine_codex, sm_wep, 'Marneus Calgar', 1, [],[] )


librarius = ['Smite','Might of Heroes','Psychic Scourge','Null Zone','Veil of Time']
librarius.combination(2).each do |combo|
	string = "Tigerius - #{combo[0]} - #{combo[1]}"
	hero_hash[string] = Unit2.new()
	hero_hash[string].addModels(space_marine_codex, sm_wep, 'Chief Librarian Tigerius', 1, [],[] )
	hero_hash[string].getModels[0].addGear(sm_wep, combo)
end




hero_hash['Chaplain Cassius'] = Unit2.new()
hero_hash['Chaplain Cassius'].addModels(space_marine_codex, sm_wep, 'Chaplain Cassius', 1, [],[] )
hero_hash['Captain Sicarius'] = Unit2.new()
hero_hash['Captain Sicarius'].addModels(space_marine_codex, sm_wep, 'Captain Sicarius', 1, [],[] )
hero_hash['Sergeant Telion'] = Unit2.new()
hero_hash['Sergeant Telion'].addModels(space_marine_codex, sm_wep, 'Sergeant Telion', 1, [],[] )
hero_hash['Pedro Kantor'] = Unit2.new()
hero_hash['Pedro Kantor'].addModels(space_marine_codex, sm_wep, 'Pedro Kantor', 1, [],[] )
hero_hash['The Emperors Champion'] = Unit2.new()
hero_hash['The Emperors Champion'].addModels(space_marine_codex, sm_wep, 'The Emperors Champion', 1, [],[] )
hero_hash['Chaplain Grimaldus'] = Unit2.new()
hero_hash['Chaplain Grimaldus'].addModels(space_marine_codex, sm_wep, 'Chaplain Grimaldus', 1, [],[] )
hero_hash['Korsarro Khan'] = Unit2.new()
hero_hash['Korsarro Khan'].addModels(space_marine_codex, sm_wep, 'Korsarro Khan', 1, [],[] )
#hero_hash['Korsarro Khan'].getModels[0].addRule('Impact - Mortal Wounds - 1 - 4')
hero_hash['Vulkan Hestan'] = Unit2.new()
hero_hash['Vulkan Hestan'].addModels(space_marine_codex, sm_wep, 'Vulkan Hestan', 1, [],[] )
#hero_hash['Vulkan Hestan'].getModels[0].addRule(['Reroll - All - All - Single','Strength - 1'])
hero_hash['Kayvaan Shrike'] = Unit2.new()
hero_hash['Kayvaan Shrike'].addModels(space_marine_codex, sm_wep, 'Kayvaan Shrike', 1, [],[] )

sanguinary = ['Smite','Blood Boil','Shield of Sanguinius','Unleash Rage']
## Blood Angels
hero_hash['Commander Dante'] = Unit2.new()
hero_hash['Commander Dante'].addModels(imp_ind_1, imp_ind_wep, 'Commander Dante', 1, [],[] )
hero_hash['Captain Tycho'] = Unit2.new()
hero_hash['Captain Tycho'].addModels(imp_ind_1, imp_ind_wep, 'Captain Tycho', 1, [],[] )
hero_hash['Tycho the Lost'] = Unit2.new()
hero_hash['Tycho the Lost'].addModels(imp_ind_1, imp_ind_wep, 'Tycho the Lost', 1, [],[] )
sanguinary.combination(2).each do |combo|
	string = "Mephiston - #{combo[0]} - #{combo[1]}"
	hero_hash[string] = Unit2.new()
	hero_hash[string].addModels(imp_ind_1, imp_ind_wep, 'Chief Librarian Mephiston', 1, [],[] )
	hero_hash[string].getModels[0].addGear(imp_ind_wep, combo)
end

hero_hash['The Sanguinor'] = Unit2.new()
hero_hash['The Sanguinor'].addModels(imp_ind_1, imp_ind_wep, 'The Sanguinor', 1, [],[] )
hero_hash['Astorath'] = Unit2.new()
hero_hash['Astorath'].addModels(imp_ind_1, imp_ind_wep, 'Astorath', 1, [],[] )
hero_hash['Astorath'] = Unit2.new()
hero_hash['Astorath'].addModels(imp_ind_1, imp_ind_wep, 'Astorath', 1, [],[] )
hero_hash['Brother Corbulo'] = Unit2.new()
hero_hash['Brother Corbulo'].addModels(imp_ind_1, imp_ind_wep, 'Brother Corbulo', 1, [],[] )
hero_hash['Lemartes'] = Unit2.new()
hero_hash['Lemartes'].addModels(imp_ind_1, imp_ind_wep, 'Lemartes', 1, [],[] )
hero_hash['Gabriel Seth'] = Unit2.new()
hero_hash['Gabriel Seth'].addModels(imp_ind_1, imp_ind_wep, 'Gabriel Seth', 1, [],[] )
hero_hash['Azrael'] = Unit2.new()
hero_hash['Azrael'].addModels(imp_ind_1, imp_ind_wep, 'Azrael', 1, [],[] )
hero_hash['Belial'] = Unit2.new()
hero_hash['Belial'].addModels(imp_ind_1, imp_ind_wep, 'Belial', 1, [],[] )
hero_hash['Belial - TH - SS'] = Unit2.new()
hero_hash['Belial - TH - SS'].addModels(imp_ind_1, imp_ind_wep, 'Belial', 1, ['Thunder Hammer','Storm Shield'],
['Sword of Silence','Storm Bolter'] )
 hero_hash['Belial - LC'] = Unit2.new()
hero_hash['Belial - LC'].addModels(imp_ind_1, imp_ind_wep, 'Belial', 1, ['Two Lightning Claws'],
 ['Sword of Silence','Storm Bolter'] )
hero_hash['Sammael on Corvex'] = Unit2.new()
hero_hash['Sammael on Corvex'].addModels(imp_ind_1, imp_ind_wep, 'Sammael on Corvex', 1, [],[] )
hero_hash['Sammael on Sableclaw'] = Unit2.new()
hero_hash['Sammael on Sableclaw'].addModels(imp_ind_1, imp_ind_wep, 'Sammael on Sableclaw', 1, [],[] )
hero_hash['Asmodai'] = Unit2.new()
hero_hash['Asmodai'].addModels(imp_ind_1, imp_ind_wep, 'Asmodai', 1, [],[] )

interromancy = ['Smite','Mind Worm','Aversion']
interromancy.combination(2).each do |combo|
	string = "Ezekiel - #{combo[0]} - #{combo[1]}"
	hero_hash[string] = Unit2.new()
	hero_hash[string].addModels(imp_ind_1, imp_ind_wep, 'Ezekiel', 1, [],[] )
	hero_hash[string].getModels[0].addGear(imp_ind_wep, combo)
end

tempestas = ['Smite','Tempests Wrath','Jaws of the World Wolf']
hero_hash['Logan Grimnar'] = Unit2.new()
hero_hash['Logan Grimnar'].addModels(imp_ind_1, imp_ind_wep, 'Logan Grimnar', 1, [],[] )
hero_hash['Ragnar Blackmane'] = Unit2.new()
hero_hash['Ragnar Blackmane'].addModels(imp_ind_1, imp_ind_wep, 'Ragnar Blackmane', 1, [],[] )
hero_hash['Krom Dragongraze'] = Unit2.new()
hero_hash['Krom Dragongraze'].addModels(imp_ind_1, imp_ind_wep, 'Krom Dragongraze', 1, [],[] )
hero_hash['Harald Deathwolf'] = Unit2.new()
hero_hash['Harald Deathwolf'].addModels(imp_ind_1, imp_ind_wep, 'Harald Deathwolf', 1, [],[] )
hero_hash['Ulrik the Slayer'] = Unit2.new()
hero_hash['Ulrik the Slayer'].addModels(imp_ind_1, imp_ind_wep, 'Ulrik the Slayer', 1, [],[] )
hero_hash['Lukas the Trickster'] = Unit2.new()
hero_hash['Lukas the Trickster'].addModels(imp_ind_1, imp_ind_wep, 'Lukas the Trickster', 1, [],[] )
hero_hash['Arjac Rockfist'] = Unit2.new()
hero_hash['Arjac Rockfist'].addModels(imp_ind_1, imp_ind_wep, 'Arjac Rockfist', 1, [],[] )
hero_hash['Watch Captain Artemis'] = Unit2.new()
hero_hash['Watch Captain Artemis'].addModels(imp_ind_1, imp_ind_wep, 'Watch Captain Artemis', 1, [],[] )
hero_hash['Roboute Guilliman'] = Unit2.new()
hero_hash['Roboute Guilliman'].addModels(space_marine_codex, sm_wep, 'Roboute Guilliman', 1, [],[] )

tempestas.combination(2).each do |combo|
	string = "Njal Stormcaller - #{combo[0]} - #{combo[1]}"
	hero_hash[string] = Unit2.new()
	hero_hash[string].addModels(imp_ind_1, imp_ind_wep, 'Njal Stormcaller', 1, [],[] )
	hero_hash[string].getModels[0].addGear(imp_ind_wep, combo)
end


sanctic = ['Rites of Banishment','Hammerhand','Sanctuary','Vortex of Doom']

sanctic.combination(2).each do |combo|
	string = "Kaldor Draigo - #{combo[0]} - #{combo[1]}"
	hero_hash[string] = Unit2.new()
	hero_hash[string].addModels(gk_codex, gk_wep, 'Lord Kaldor Draigo', 1, [],[] )
	hero_hash[string].getModels[0].addGear(gk_wep, combo)
end

sanctic.combination(3).each do |combo|
	string = "Voldus - #{combo[0]} - #{combo[1]}"
	hero_hash[string] = Unit2.new()
	hero_hash[string].addModels(gk_codex, gk_wep, 'Grand Master Voldus', 1, [],[] )
	hero_hash[string].getModels[0].addGear(gk_wep, combo)
end


sanctic_crowe = ['Hammerhand','Sanctuary','Vortex of Doom']
sanctic_crowe.combination(2).each do |combo|
	string = "Crowe - #{combo[0]} - #{combo[1]}"
	hero_hash[string] = Unit2.new()
	hero_hash[string].addModels(gk_codex, gk_wep, 'Castellan Crowe', 1, [],[] )
	hero_hash[string].getModels[0].addGear(gk_wep, combo.push('Purifying Flames'))
end


sanctic_crowe.push('Zone of Banishment').combination(2).each do |combo|
	string = "Stern - #{combo[0]} - #{combo[1]}"
	hero_hash[string] = Unit2.new()
	hero_hash[string].addModels(gk_codex, gk_wep, 'Brother-Captain Stern', 1, [],[] )
	hero_hash[string].getModels[0].addGear(gk_wep, combo)
end


out_file.print "Attacker,"
## Apply Auras and gear to update each model
hero_hash.each do |key, value|
	value.ApplyAuras
	value.getModels[0].ApplyGear
	out_file.print "#{key},"
end




out_file.print "\n"
rows = Hash.new {|h,k| h[k] = Array.new }
calcs_run = 0
headers = Array.new()
total_calc = hero_hash.length
hero_hash.each do |key, value|
	row = Array.new()
	row.push(key)
	calc_time = Time.now
	hero_hash.each do |key2, value2|
		if key == key2
			next
		end
		odds = Duel(sm_wep,value,value2,4,log_file)
		if key == key2
			#puts "If #{key} charges #{key2}, the charging #{key} wins #{odds * 100}% of the time"
		else 
			#puts "If #{key} charges #{key2}, #{key} wins #{odds * 100}% of the time"
		end
		row.push(odds)
		
		
	end
	calcs_run = calcs_run + 1
	time_remaining = (total_calc - calcs_run) * ((Time.now - start_time) / calcs_run)
	puts "Estimated #{(time_remaining) / 60} minutes to complete #{(total_calc - calcs_run)} remaining Characters"
	
	row.each do |n|
		out_file.print "#{n},"
	end
	out_file.print "\n"
end

puts "Actual runtime was #{(Time.now - start_time) / 60} minutes"