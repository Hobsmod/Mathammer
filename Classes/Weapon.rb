class Weapon
	def initialize (id)
		@id = id
		@fire_types = Hash.new{|hash, key| hash[key] = Hash.new}
	end
	
	def addFireType(name, stats, rules)
		@fire_types[name]['Cost'] = stats[0].to_i
		@fire_types[name]['Range'] = stats[1].to_i
		@fire_types[name]['Type'] = stats[2]
		@fire_types[name]['Shots'] = stats[3]
		@fire_types[name]['S'] = stats[4]
		@fire_types[name]['AP'] = stats[5]
		@fire_types[name]['Rules'] = rules
	end
		
	def addRules(rule)
		if @rules.nil?
			@rules = Array.new
		end
		rules.push(rule)
	end
	
	def	getCost()
		return @fire_types['Standard']['Cost']
	end
	
	def getRange(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		return @fire_types[fire_type]['Range']
	end
	
	def getType(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		return @fire_types[fire_type]['Type']
	end
	
	def getS(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		return @fire_types[fire_type]['S']
	end
	
	def getAP(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		return @fire_types[fire_type]['AP']
	end
	
	def getDamage(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		return @fire_types[fire_type]['D']
	end

	def getShots(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		return @fire_types[fire_type]['Shots']
	end
	
	def shots_at_range(firing_range)
		rapid_fire_range = @range / 2
		if @type == 'Rapid Fire' && rapid_fire_range >= firing_range
			real_shots = @shots * 2
		else 
			real_shots = @shots
		end
		returnn real_shots
	end

end