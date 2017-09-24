require_relative 'Methods\DuelEngine.rb'
require_relative 'Methods\LoadFromCSV'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit2.rb'
require_relative 'Classes\CodexEntry.rb'
require_relative 'Classes\CodexTargets.rb'
require 'time'
start_time = Time.now

space_marine_codex = YAML.load(File.read('Codices\SpaceMarineCodex.yml')) 
sm_wep = LoadWeapons('Codices\SMWeapons.csv')

hero_hash = Hash.new()

hero_hash['Captain Lysander'] = Unit2.new()
hero_hash['Captain Lysander'].addModels(space_marine_codex, sm_wep, 'Captain Lysander', 1,[] , [] )
hero_hash['High Marshal Helbrecht'] = Unit2.new()
hero_hash['High Marshal Helbrecht'].addModels(space_marine_codex, sm_wep, 'High Marshal Helbrecht', 1, [],[] )
hero_hash['Marneus Calgar'] = Unit2.new()
hero_hash['Marneus Calgar'].addModels(space_marine_codex, sm_wep, 'Marneus Calgar', 1, [],[] )
hero_hash['Chief Librarian Tigerius'] = Unit2.new()
hero_hash['Chief Librarian Tigerius'].addModels(space_marine_codex, sm_wep, 'Chief Librarian Tigerius', 1, [],[] )
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
hero_hash['Vulkan Hestan'] = Unit2.new()
hero_hash['Vulkan Hestan'].addModels(space_marine_codex, sm_wep, 'Vulkan Hestan', 1, [],[] )
hero_hash['Kayvaan Shrike'] = Unit2.new()
hero_hash['Kayvaan Shrike'].addModels(space_marine_codex, sm_wep, 'Kayvaan Shrike', 1, [],[] )



#shrike_gear = hero_hash['Kayvaan Shrike'].getModels[0].getGear
#puts "#{shrike_gear}"

term_cap_wep = ['Power Sword','Relic Blade', 'Chainfist','Lightning Claw','Power Fist','Thunder Hammer']
term_cap_shield = ['Storm Shield']







hero_hash.each do |key, value|
	value.ApplyAuras
end
calcs_run = 0

total_calc = hero_hash.length * hero_hash.length
hero_hash.each do |key, value|
	hero_hash.each do |key2, value2|
		calc_time = Time.now
		odds = Duel(sm_wep,value,value2,1)
		if key == key2
			puts "If #{key} charges #{key2}, the charging #{key} wins #{odds * 100}% of the time"
		else 
			puts "If #{key} charges #{key2}, #{key} wins #{odds * 100}% of the time"
		end
		calcs_run = calcs_run + 1
		time_remaining = (Time.now - calc_time) * (total_calc - calcs_run)
		puts "Estimated #{time_remaining} seconds to complete #{(total_calc - calcs_run)} remaining Duels"
	end
end
