require_relative 'Models_with_Weapon_Objects.rb'
require_relative 'CodexEntry.rb'
class Unit2
	def initialize()
		@cost = 0
		@models = Array.new
	end
	
	def addModels(codex, gear_hash, name, quantity, add_gear, remove_gear)
		
		@rules = codex[name].getRules
		@weapons = Array.new
		(1..quantity).each do |n|
			#initialize an empty gear array
			new_gear = Array.new
			#grab the default gear from the codex
			codex[name].getGear.each do |item|
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
				puts item
				gear_cost = gear_cost + gear_hash[item].getCost()
				#puts "#{item}, #{gear_cost}"
			end
		
			#create model, and give it an id, add it to the unit array
			id = @models.count
			new_model = ModelWithWeapons.new(id, codex, gear_hash, name, new_gear)
			@models.push(new_model)
			
			#find out how much model costs and add costs to the unit
			
			new_cost = codex[name].getCost
			@cost = @cost + new_cost + gear_cost
			#puts @cost			
		end	
	end
	
	def ApplyAuras
		all_rules = Array.new()
		aura_rules = Array.new()
		@models.each do |model|
			model.getRules.each do |rule|
				all_rules.push(rule)
			end
		end
		all_rules = all_rules.uniq
		all_rules.each do |rule|
			if rule =~ /Aura/
				aura_rules.push(rule)
			end
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
					#puts add_rule
					add_rule = add_rule[0..-4]
					#puts add_rule
					model.addRule(add_rule)
				end
			end
		end
		
		
		#### Have Auras that modify stats modify the stats here
		@models.each do |model|
			if model.hasRule('Strength - 1')
				model.addS(1)
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
		