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















hero_hash.each do |key, value|
	value.ApplyAuras
end



hero_hash.each do |key, value|
	hero_hash.each do |key2, value2|
		odds = Duel(sm_wep,value,value2,1000)
		if key == key2
			puts "If #{key} charges #{key2}, the charging #{key} wins #{odds * 100}% of the time"
		else 
			puts "If #{key} charges #{key2}, #{key} wins #{odds * 100}% of the time"
		end
		puts Time.now - start_time
	end
end
