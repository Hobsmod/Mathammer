require_relative 'Methods\DuelEngine.rb'
require_relative 'Methods\LoadFromCSV'
require_relative 'Classes\Targets.rb'
require 'yaml'
require_relative 'Classes\Unit2.rb'
require_relative 'Classes\CodexEntry.rb'
require_relative 'Classes\CodexTargets.rb'
require 'time'
start_time = Time.now
log_file = File.open('Logs\DuelLog.txt', 'w')
out_file = File.open('DuelResults.csv', 'w')
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

wep_relics = ['Teeth of Terra','The Burning Blade']
def_relics = ['The Shield Eternal','The Armor Indomitus']
melee_wep = ['Chainsword','Lightning Claw','Power Axe','Power Fist','Power Lance','Power Maul','Power Sword','Thunder Hammer']
term_cap_wep = ['Power Sword','Relic Blade', 'Chainfist','Lightning Claw','Power Fist','Thunder Hammer - Character']
shields = ['Blank','Storm Shield']

### Only adding Chapter Tactics relevant for duels
chapter_tactics = Hash.new()
chapter_tactics['Salamanders'] = ['Reroll - All - All - Single']
chapter_tactics['Iron Hands'] = ['FNP - 6']

chapter_warlord_traits = Hash.new()
chapter_warlord_traits['White Scars'] = ['Impact - Mortal Wounds - 1 - 4']
chapter_warlord_traits['Salamanders'] = ['Strength - 1']
chapter_warlord_traits['Iron Hands'] = ['Rend - Fight - Extra Attack']


relics = Hash.new{|hash, key| hash[key] = Hash.new}


chapters = ['Chapter w/out CC Traits/Tactics','White Scars','Salamanders','Iron Hands']



chapters.each do |chapter|
	traits = Hash.new()
	traits['Sword of the Imperium'] = ['Attacks - 1']
	traits['Iron Resolve'] = ['Wounds - 1','FNP - 6']
	traits['Champion of Humanity'] = ['Duelist - Add - All - 1']
	traits['Not Warlord'] = []
	chap_def_relics = def_relics
	chap_wep_relics = wep_relics
	if chapter == 'White Scars'
		traits['Deadly Hunter'] = ['Impact - 1 -  Mortal Wound - 4+']
	end
	if chapter == 'Salamanders'
		traits['Anvil of Strength'] = ['Strength - 1']
		chap_def_relics.push('The Salamanders Mantle')
	end
	if chapter == 'Iron Hands'
		traits['Merciless Logic'] = ['Rend - Fight - Extra Attack']
		chap_wep_relics.push('The Axe of Medusa')
	end
	if chapter == 'Chapter w/out CC Traits/Tactics'
		chap_wep_relics.push('The Fist of Vengance')
	end
	traits.each do |trait, effect|
	
		### Terminator Captain
		term_cap_wep = term_cap_wep + chap_wep_relics
		term_cap_wep.each do |wep1|
			term_cap_def = shields
			unless chap_wep_relics.any? {|relic| wep1 == relic}
				term_cap_def = shields + def_relics
				#puts "There already is a relic"
			end
			term_cap_def.each do |term_cap_def|
				string = "#{chapter} - #{trait} Captain in Terminator Armor - #{wep1} - #{term_cap_def}"
				puts string
				hero_hash[string] = Unit2.new()
				hero_hash[string].addModels(space_marine_codex, sm_wep, 'Captain in Terminator Armor', 1, [wep1, term_cap_def],['Power Sword'] )
			end
		end
		
		
		
		
		
		
		
		
	end
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
		
		odds = Duel(sm_wep,value,value2,3,log_file)
		if key == key2
			#puts "If #{key} charges #{key2}, the charging #{key} wins #{odds * 100}% of the time"
		else 
			#puts "If #{key} charges #{key2}, #{key} wins #{odds * 100}% of the time"
		end
		row.push(odds)
		
		
	end
	calcs_run = calcs_run + 1
	time_remaining = (total_calc - calcs_run) * ((Time.now - start_time) / calcs_run)
	puts "Estimated #{(time_remaining) / 60} minutes to complete #{(total_calc - calcs_run)} remaining Duels"
	
	row.each do |n|
		out_file.print "#{n},"
	end
	out_file.print "\n"
end

puts "Actual runtimes was #{Time.now - start_time}"