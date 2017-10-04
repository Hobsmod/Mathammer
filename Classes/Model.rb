class ModelWithWeapons
	attr_accessor :id, :stats, :base_stats, :gear, :rules, :base_rules, :name, :keywords, :stat_modifiers, :rule_modifiers
	
	def initialize(id, codex, gear_hash, name, gear)
		self.id = id
		self.base_stats = codex[name].stats.clone
		self.stats = codex[name].stats
		self.base_rules = codex[name].rules.clone
		self.rules = codex[name].rules
		self.name = name
		self.keywords = codex[name].keywords
		self.stat_modifiers = Array.new{|v| v = Hash.new}
		self.rule_modifiers = Array.new()
		### Add Weapon Objects to Model
		self.gear = Array.new()
		gear.each do |item|
			@gear.push(gear_hash[item])
		end
	end
	
	
	def ApplyFactionKeywords(faction, keyword)
		@keywords.delete(keyword)
		@keywords.push(faction)
	end
	
	
	def hasRule?(rule)
		rules.include? rule
	end
	
	
	def getInvuln
		### The way codex entries are written invuln can either be written as a rule, or as the 9th entry in 
		### in the stats
		
		if @stats['Invuln'] 
			invul = @stats['Invuln'].to_i
		else
			invul = 7
		end
		
		if @rules.include?('Invulnerable - 3') && invul > 3
			invul = 3
		elsif @rules.include?('Invulnerable - 4') && invul > 4
			invul = 4
		elsif @rules.include?('Invulnerable - 5') && invul > 5
			invul = 5 
		elsif @rules.include?('Invulnerable - 6') && invul > 6
			invul = 6
		end
			
		return invul
	end
	
	
	def getFNP
		
		@fnp = rules.select{ |rule| rule =~ /FNP/ }.map!{|x| x[-1].to_i}
		return @fnp
	
	end
			
	def hasKeyword(keyword)
		keywords.include? keyword
	end
	
	def hasKeyword?(keyword)
		keywords.include? keyword
	end
	
	def ApplyGear()
		### Take rules that are on wargear and add them to the model
		gear_rules = Array.new()
		@gear.each do |item|
			item.getFiretypes.each do |mode|
				gear_rules = gear_rules + item.rules[mode].grep(/Gear/)
			end
		end
		gear_rules.each do |rule|

			if rule =~ /Invulnerable - \d/
				@stats['Invuln'] = rule[-1]
			end
					

			if rule =~ /Modify Stat/
				split_array = rule.split(' - ')
				@stats[split_array[2]] = split_array[3]
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
	
	
	### Add ,odifier and rules to the base stats and rules, which cannot be reset
	def modBaseStat(stat, mod)
		### If we call the stats full name and not it's abbreviation we still modify it
		stat = stat[1]
		@base_stats[stat] = @base_stats[stat].to_i + mod	
	end
	
	
	
	def addBaseRule(rule)
		if rule.class == Array
			@base_rules = @rules + rule
		elsif rule.class == String
			@base_rules.push(rule)
		else
			puts "Could't add rule #{rule}"
		end
	end
	
	### add temporary modifiers
	def addStatModifier(duration, stat, modifier)
		### Take only the first letter of the stat for building the hash so you better CAPITALIZE!
		stat = stat[0]
		dur = duration.to_i - 1
		
		unless stat_modifiers[dur]
			stat_modifiers.insert(dur, { stat=> modifier})
			return
		end
		
		if stat_modifiers[dur][stat]
			stat_modifiers[dur][stat] = stat_modifiers[dur][stat] + modifier.to_i
		elsif stat_modifiers[dur]
			stat_modifiers[dur][stat] = modifier.to_i
		end
		
		#puts "#{stat_modifiers}"
	end	
	
	def addRuleModifier(duration, rule)
		### Check if the stat is typed out instead of abbreviated and replace with abbreviation
		unless rule_modifiers[duration.to_i]
			rule_modifiers[duration.to_i] = [rule]
		else
			rule_modifiers[duration.to_i].push(rule)
		end	
	end	
	
	def IncrementModifiers
		@stat_modifiers.shift
		@rule_modifiers.shift
		@stats = base_stats.clone
		@rules = base_rules.clone
	end
	
	def ApplyModifiers
		@stats = @base_stats.clone
		@rules = @base_rules.clone
		
		rule_modifiers.each do |rule_arr|
			unless rule_arr == nil
				rule_arr.each do |rule|
					@rules.push(rule)
				end
			end
		end
		
		stat_modifiers.each do |hash|
			unless hash == nil
				#puts hash
				hash.each do |key, value|
					@stats[key] = base_stats[key] + value
				end
			end
		end
		
	end
	
	
	def ClearModifiers
		self.stat_modifiers = Array.new{|v| v = Hash.new}
		self.rule_modifiers = Array.new()
		self.stats = base_stats.clone
		self.rules = base_rules.clone
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
				if item.getType(mode) == 'Heavy' or item.getType(mode) == 'Rapid Fire' or item.getType(mode) == 'Assault' or item.getType(mode) == 'Pistol' or item.getType(mode) == 'Grenade'
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