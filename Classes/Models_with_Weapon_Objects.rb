class ModelWithWeapons
	def initialize(id, codex, gear_hash, name, gear)
		@id = id
		@statline = codex[name].getStats.clone
		@perm_statline = codex[name].getStats.clone
		@game_statline = codex[name].getStats.clone
		@rules = codex[name].getRules.clone
		@perm_rules = codex[name].getRules.clone
		@game_rules = codex[name].getRules.clone
		@name = name
		@keywords = codex[name].getKeywords
		### Add Weapon Objects to Model
		@gear = Array.new()
		gear.each do |item|
			@gear.push(gear_hash[item])
		end
	end
	
	def getID
		@id
	end
	
	def getName
		@name
	end
	def getRules
		@rules
	end
	
	def ApplyFactionKeywords(faction, keyword)
		@keywords.delete(keyword)
		@keywords.push(faction)
	end
	
	def getGear()
		return @gear
	end
	### Return individual stats
	def getM 
		@statline['M']
	end
	def getWS
		@statline['WS']
	end
	def getBS 
		@statline['BS']
	end
	def getS 
		@statline['S']
	end
	def addS(n)
		@statline['S'] = @statline['S'] + n
	end
	def getT 
		@statline['T']
	end
	def getW 
		@statline['W']
	end
	def getA
		@statline['A']
	end
	
	def addA(n)
		@statline['A'] = @statline['A'] + n
	end
	def getLd 
		@statline['Ld']
	end
	def getSv 
		@statline['Sv']
	end
	def hasRule(rule)
		if @rules.include? rule
			return true
		else
			return false
		end
	end
	def getInvuln()
		if @statline['Invuln'] 
			invul = @statline['Invuln'].to_i
		else
			invul = 7
		end
		if @rules.include?('Invulnerable - 3') && invul > 3
			return 3
		elsif @rules.include?('Invulnerable - 4') && invul > 4
			return 4
		elsif @rules.include?('Invulnerable - 5') && invul > 5
			return 5 
		elsif @rules.include?('Invulnerable - 6') && invul > 6
			return 6
		else
			return invul
		end
	end
	def getFNP()
		unless @fnp
			@fnp = Array.new
			@rules.each do |rule|
				if rule =~ /FNP/
					@fnp.push(rule[-1].to_f)
				end
			end
		end
		return @fnp
	end
			
	def hasKeyword(keyword)
		if @keywords.include? keyword
			return true
		else
			return false
		end
	end
	
	def getKeywords
		@keywords
	end

	
	def ApplyGear()
		### Take rules that are on wargear and add them to the model
		gear_rules = Array.new()
		@gear.each do |item|
			item.getFiretypes.each do |mode|
				gear_rules = gear_rules + item.getRules(mode).grep(/Gear/)
			end
		end
		gear_rules.each do |rule|

			if rule =~ /Invulnerable - \d/
				@statline['Invuln'] = rule[-1]
			end
					

			if rule =~ /Modify Stat/
				split_array = rule.split(' - ')
				@statline[split_array[2]] = split_array[3]
			end
			if rule =~ /Add Rule/
				split_array = rule.split(' - ')
				add_rule = ''
				split_array[2..-1].each do |part|
					add_rule = add_rule + part + ' - '
				end
				@rules.push(add_rule[0..-4])
			end
		end
	end
	
	def modStat(stat, mod)
		### If we call the stats full name and not it's abbreviation we still modify it
		replace_hash = Hash.new()
		replace_hash['Toughness'] = 'T'
		replace_hash['Strength'] = 'S'
		replace_hash['Attacks'] = 'A'
		
		replace_hash.each do |key, value|
			if stat == key
				stat = value
			end
		end
		
		@statline[stat] = @statline[stat].to_i + mod	
	end
	
	def ClearRoundModifiers
		#puts "#{@name} replaces mods stats: #{@statline} with the perm statline #{@perm_statline}"
		@rules = @game_rules.clone
		@statline = @game_statline.clone
	end
	
	def ClearGameModifiers
		@rules = @perm_rules.clone
		@game_rules = @perm_rules.clone
		@statline = @perm_statline.clone
		@game_statline = @perm_statline.clone
	end
	
	def modGameStat(stat, mod)
		### If we call the stats full name and not it's abbreviation we still modify it
		replace_hash = Hash.new()
		replace_hash['Toughness'] = 'T'
		replace_hash['Strength'] = 'S'
		replace_hash['Attacks'] = 'A'
		
		replace_hash.each do |key, value|
			if stat == key
				stat = value
			end
		end
		
		@statline[stat] = @statline[stat].to_i + mod
		@game_statline[stat] = @statline[stat].to_i + mod	
	end
	
	def modPermStat(stat, mod)
		### If we call the stats full name and not it's abbreviation we still modify it
		replace_hash = Hash.new()
		replace_hash['Toughness'] = 'T'
		replace_hash['Strength'] = 'S'
		replace_hash['Attacks'] = 'A'
		
		replace_hash.each do |key, value|
			if stat == key
				stat = value
			end
		end
		
		@statline[stat] = @statline[stat].to_i + mod	
		@game_statline[stat] = @statline[stat].to_i + mod	
		@perm_statline[stat] = @statline[stat].to_i + mod	
	end
	
	def addRule(rule)
		if rule.class == Array
			@rules = @rules + rule
		elsif rule.class == String
			@rules.push(rule)
		else
			puts "Could't add rule #{rule}"
		end
	end
	
	def addGameRule(rule)
		if rule.class == Array
			@rules = @rules + rule
			@game_rules = @game_rules + rule
		elsif rule.class == String
			@rules.push(rule)
			@game_rules.push(rule)
		else
			puts "Could't add rule #{rule}"
		end
	end
	
	def addPermRule(rule)
		if rule.class == Array
			@rules = @rules + rule
			@game_rules = @game_rules + rule
			@perm_rules = @game_rules + rule
		elsif rule.class == String
			@rules.push(rule)
			@game_rules.push(rule)
			@perm_rules.push(rule)
		else
			puts "Could't add rule #{rule}"
		end
	end
	
	def addGear(gear_hash, gear)
		if gear.is_a? String
			@gear.push(gear_hash[gear])
		elsif gear.is_a? Array
			gear.each do |item|
				@gear.push(gear_hash[item])
			end
		end
	end
	
	def getRangedWeapons
		ranged_wep = Array.new
		@gear.each do |item|
			item.getFiretypes.each do |mode|
				if item.getRange(mode) > 0
					ranged_wep.push(item)
				end
			end
		end
		return ranged_wep.uniq
	end
	
	def getPistols()
		pistols = Array.new
		@gear.each do |item|
			item.getFiretypes.each do |mode|
				if item.getType(mode) == 'Pistol'
					pistols.push(item)
				end
			end
		end
		return pistols.uniq
	end
	
	def getPowers()
		powers = Array.new()
		@gear.each do |item|
			item.getFiretypes.each do |mode|
				if item.getType(mode) =~ /Psychic/
					powers.push(item)
				end
			end
		end
		return powers
	end
	
end