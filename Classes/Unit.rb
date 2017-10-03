require_relative 'Model.rb'
require_relative 'CodexEntry.rb'
require_relative 'Weapon.rb'
class Unit2
	def initialize()
		@cost = 0
		@models = Array.new
	end
	
	def addModels(codex, gear_hash, name, quantity, add_gear, remove_gear)
		
		@rules = codex[name].rules
		@weapons = Array.new
		(1..quantity).each do |n|
			#initialize an empty gear array
			new_gear = Array.new
			#grab the default gear from the codex
			codex[name].gear.each do |item|
				new_gear.push(item)
			end
		
			#modify the default gear based on parameters given
			remove_gear.each do |item|
				new_gear.delete(item)
			end
			add_gear.each do |item|
				new_gear.push(item)
			end
			
			#find out how much the gear costs
			gear_cost = 0
			
			new_gear.each do |item|
				gear_cost = gear_cost + gear_hash[item].getCost
				#puts "#{item}, #{gear_cost}"
			end
		
			#create model, and give it an id, add it to the unit array
			id = @models.count
			new_model = ModelWithWeapons.new(id, codex, gear_hash, name, new_gear)
			@models.push(new_model)
			
			#find out how much model costs and add costs to the unit
			
			new_cost = codex[name].cost
			@cost = @cost + new_cost + gear_cost
			#puts @cost			
		end	
	end
	
	def ApplyAuras
		aura_rules = Array.new
		@models.each do |model|
			aura_rules = aura_rules + model.rules.grep(/Aura/)
		end
		aura_rules.each do |aura|
			aura_array = aura.split(' - ')
			#puts "#{aura_array}"
			@models.each do |model|
				if aura_array[1].to_i == 6
					add_rule = ''
					aura_array[2..-1].each do |part|
						add_rule = add_rule + part + ' - '
					end
				
					add_rule = add_rule[0..-4]
					
					model.addBaseRule(add_rule)
				else 
					if model.hasKeyword(aura_array[1]) == true
						add_rule = ''
						aura_array[2..-1].each do |part|
							add_rule = add_rule + part + ' - '
						end
					
					add_rule = add_rule[0..-4]
					
					model.addBaseRule(add_rule)
					end
				end
			end
		end
		
		aura_rules.each do |rule|
			@rules.delete(rule)
		end
		#### Have Auras that modify stats modify the stats here
		@models.each do |model|
			if model.hasRule?('Attacks - 1')
				model.modPermStat('A',1)
			end
			if model.hasRule?('Wounds - 1')
				model.modPermStat('W',1)
			end
		end
	end
							
			
	def getSize
		return @models.count
	end
	def getCost
		@cost
	end
	
	def getModels
		@models
	end
end
		