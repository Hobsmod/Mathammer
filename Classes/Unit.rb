require_relative 'Model.rb'

class Unit
	def initialize()
		@cost = 0
		@models = Array.new
	end
	
	def addModels(codex, gear_hash, name, quantity, add_gear, remove_gear)
		(1..quantity).each do |n|
			new_gear = Array.new
			codex[name].getGear.each do |item|
				new_gear.push(item)
			end
		
			remove_gear.each do |item|
				new_gear.delete(item)
			end
		
			add_gear.each do |item|
				new_gear.push(item)
			end
			
			#find out how much the gear costs
			gear_cost = 0
			new_gear.each do |item|
				gear_cost = gear_cost + gear_hash[item].getCost()
			end
			
			
			id = @models.count
			#create model
			new_model = Model.new(id, codex, name, new_gear)
			#find out how much model costs
			new_cost = codex[name].getCost
			@models.push(new_model)
			@cost = @cost + new_cost + gear_cost
		end	
	end
	
	def getSize
		return @models.count
	def getCost
		@cost
	end
	
	def getModels
		@models
	end
end
		