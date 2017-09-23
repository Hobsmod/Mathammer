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

hero_hash.each do |key, value|
	value.ApplyAuras
end


hero_hash.each do |key, value|
	hero_hash.each do |key2, value2|
		odds = Duel(sm_wep,value,value2,100)
		if key == key2
			puts "If #{key} charges #{key2}, the charging #{key} wins #{odds * 100}% of the time"
		else 
			puts "If #{key} charges #{key2}, #{key} wins #{odds * 100}% of the time"
		end
	end
end
