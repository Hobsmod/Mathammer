require_relative 'Model.rb'
require_relative 'CodexEntry.rb'
class Unit
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
				#puts item
				gear_cost = gear_cost + gear_hash[item].getCost()
				#puts "#{item}, #{gear_cost}"
			end
		
			#create model, and give it an id, add it to the unit array
			id = @models.count
			new_model = Model.new(id, codex, name, new_gear)
			@models.push(new_model)
			
			#find out how much model costs and add costs to the unit
			new_cost = codex[name].getCost
			@cost = @cost + new_cost + gear_cost
			#puts @cost
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
		