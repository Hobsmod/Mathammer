class CodexEntry
	attr_accessor :stats, :gear, :rules, :cost, :keywords
	
	def initialize(stats, gear, rules, cost, keywords)
		self.stats = Hash.new{}
		### Turn the stats array in the codex entry into a hash keyed by stat name
		self.stats['M'] = stats[0]
		self.stats['WS'] = stats[1]
		self.stats['BS'] = stats[2]
		self.stats['S'] = stats[3]
		self.stats['T'] = stats[4]
		self.stats['W'] = stats[5]
		self.stats['A'] = stats[6]
		self.stats['Ld'] = stats[7]
		self.stats['Sv'] = stats[8]
		if stats[9]
			@stats['Invuln'] = stats[9]
		else 
			@stats['Invuln'] = 7
		end
		
		self.gear = gear
		self.rules = rules
		self.cost = cost
		self.keywords = keywords
	end
	
end