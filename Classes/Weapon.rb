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
			return TRUE
		else
			return FALSE
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
	
	def getD(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		if @fire_types[fire_type]['D'] == 'D6'
			if hasRule(fire_type,'Melta')
				return 4.47
			else
				return 3.5
			end
		elsif @fire_types[fire_type]['D'] == 'D3'
			return 2.0
		elsif @fire_types[fire_type]['D'] == '2D6'
			return 7.0
		else
			return @fire_types[fire_type]['D'].to_f
		end
	end

	def getShots(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		elsif @fire_types[fire_type]['Shots'] == 'D6'
			return 3.5
		elsif @fire_types[fire_type]['Shots'] == 'D3'
			return 2
		elsif @fire_types[fire_type]['Shots'] == '2D3'
			return 4
		elsif @fire_types[fire_type]['Shots'] == '4D3'
			return 8
		elsif @fire_types[fire_type]['Shots'] == '2D6'
			return 7
		else
			return @fire_types[fire_type]['Shots'].to_i
		end
	end
	
	def getShotsAtRange(fire_type, firing_range)
		#define rapid fire range
		rapid_fire_range = @fire_types[fire_type]['Range'] / 2
		#convert random shot numbers to averages
		
		if @fire_types[fire_type]['Shots'] == 'D6'
			shots = 3.5
		end
		if @fire_types[fire_type]['Shots'] == 'D3'
			shots = 2
		end
		if @fire_types[fire_type]['Shots'] == '2D6'
			shots =  7
		end
		if shots.nil?
			#puts 'Shots was nil'
			shots = @fire_types[fire_type]['Shots'].to_i
		end

		
		#check if we are in rapid fire range and return double the shots
		if @fire_types[fire_type]['Type'] == 'Rapid Fire' && rapid_fire_range >= firing_range
			real_shots = shots * 2
			#puts 'Rapid Firing'
		elsif  firing_range > @fire_types[fire_type]['Range']
			real_shots = 0
			#puts 'Out of range'
		else 
			real_shots = shots
			#puts 'normal firing'
		end
		
		return real_shots
	end

end