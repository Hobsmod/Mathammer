class Weapon
	def initialize (id)
		@id = id
		@fire_types = Hash.new{|hash, key| hash[key] = Hash.new}
	end
	
	def addFireType(name, stats, rules)
		if @firetypes_list
			@firetypes_list.push(name)
		else 
			@firetypes_list = Array.new
			@firetypes_list.push(name)
		end
		
		@fire_types[name]['Cost'] = stats[0].to_i
		@fire_types[name]['Range'] = stats[1].to_i
		@fire_types[name]['Type'] = stats[2]
		@fire_types[name]['Shots'] = stats[3]
		@fire_types[name]['S'] = stats[4]
		@fire_types[name]['AP'] = stats[5]
		@fire_types[name]['D'] = stats[6]
		@fire_types[name]['Rules'] = rules
	end
	
	def addRules(rule)
		if @rules.nil?
			@rules = Array.new
		end
		rules.push(rule)
	end
	
	
	def hasRule(name, rule)
		if @fire_types[name]['Rules'].include? rule
			return true
		else
			return false
		end
	end
	
	def getID()
		@id
	end
	
	def getFiretypes()
		@firetypes_list
	end
	
	def	getCost()
		firetype = @firetypes_list[0]
		@fire_types[firetype]['Cost']
	end
	
	def getRange(fire_type)
		if fire_type.nil?
			firetype = @firetypes_list[0]
		end
		return @fire_types[fire_type]['Range']
	end
	
	def getType(fire_type)
		if fire_type.nil?
			firetype = @firetypes_list[0]
		end
		return @fire_types[fire_type]['Type']
	end
	
	def getS(fire_type)
		if fire_type.nil?
			firetype = @firetypes_list[0]
		end
		return @fire_types[fire_type]['S']
	end
	
	def getAP(fire_type)
		if fire_type.nil?
			firetype = @firetypes_list[0]
		end
		return @fire_types[fire_type]['AP']
	end
	
	def getD(fire_type)
		if fire_type.nil?
			firetype = @firetypes_list[0]
		end
		return @fire_types[fire_type]['D']
	end

	def getShots(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		@fire_types[fire_type]['Shots']
	end
	
	def getShotsAtRange(fire_type, firing_range)
		if fire_type.nil?
			firetype = @firetypes_list[0]
		end
		@fire_types[fire_type]['Shots']
	end

	
	def inspect()
		puts "ID:#{@id}"
		@firetypes_list.each do |name|
			puts "Cost: #{@fire_types[name]['Cost']}"
			puts "Range: #{@fire_types[name]['Range']}"
			puts "Type: #{@fire_types[name]['Type']}"
			puts "Shots: #{@fire_types[name]['Shots']}"
			puts "Strength: #{@fire_types[name]['S']}"
			puts "Armor Penetration: #{@fire_types[name]['AP']}"
			puts "Damage: #{@fire_types[name]['D']}"
			puts "Rules #{@fire_types[name]['Rules']}"
		end
	end
	
		
end