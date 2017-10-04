class Weapon

	attr_accessor :name, :profiles, :stats, :rules, :cost
	
	def initialize (id)
		self.name = id
		self.stats  = Hash.new{|hash, key| hash[key] = Hash.new}
		self.rules = Hash.new
		self.profiles = Array.new()
		self.cost = nil
	end
	
	def addProfile(profile, wep_stats, wep_rules)
		profiles.push(profile)
		stats[profile]['Range'] = wep_stats[1].to_i
		stats[profile]['Type'] = wep_stats[2]
		stats[profile]['Shots'] = wep_stats[3]
		stats[profile]['S'] = wep_stats[4]
		stats[profile]['AP'] = wep_stats[5]
		stats[profile]['D'] = wep_stats[6]
		rules[profile] = wep_rules
		
		if self.cost == nil
			self.cost = wep_stats[0].to_i
		elsif self.cost != cost.to_i
			puts "Whoa There! The cost listed for #{name}'s #{profile} profile does not match the previously listed cost"
		end
	end
	
	def addRules(profile,rule)
		stats[profile]['Rules'].push(rule)
	end
	
	
	def hasRule?(profile, rule)
		rules[profile].include? rule
	end
	
	
	def getFiretypes
		profiles
	end
	
	def	getCost
		@cost
	end
	
	def getRange(fire_type)
		if fire_type.nil?
			firetype = stats_list[0]
		end
		return stats[fire_type]['Range']
	end
	
	def getType(fire_type)
		if fire_type.nil?
			firetype = stats_list[0]
		end
		return stats[fire_type]['Type']
	end
	
	def getS(fire_type)
		if fire_type.nil?
			firetype = stats_list[0]
		end
		return stats[fire_type]['S']
	end
	
	def getAP(fire_type)
		if fire_type.nil?
			firetype = stats_list[0]
		end
		return stats[fire_type]['AP']
	end
	
	def getD(fire_type)
		if fire_type.nil?
			firetype = stats_list[0]
		end
		
		return stats[fire_type]['D']
	end

	def getShots(fire_type)
		if fire_type.nil?
			fire_type = 'Standard'
		end
		stats[fire_type]['Shots']
	end
	
	def getRules(firetype)
		stats[firetype]['Rules']
	end
	def getShotsAtRange(fire_type, firing_range)
		if fire_type.nil?
			firetype = stats_list[0]
		end
		stats[fire_type]['Shots']
	end
	
	def inspect()
		name
	end
end