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
		end
		@fire_types[fire_type]['Shots']
	end
	
	def getRules(firetype)
		@fire_types[firetype]['Rules']
	end
	def getShotsAtRange(fire_type, firing_range)
		if fire_type.nil?
			firetype = @firetypes_list[0]
		end
		@fire_types[fire_type]['Shots']
	end

end