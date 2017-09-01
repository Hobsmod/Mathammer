class CodexEntry
	def initialize(stats, gear, rules, cost)
		@stats = Hash.new{}
		@stats['M'] = stats[0]
		@stats['WS'] = stats[1]
		@stats['BS'] = stats[2]
		@stats['S'] = stats[3]
		@stats['T'] = stats[4]
		@stats['W'] = stats[5]
		@stats['A'] = stats[6]
		@stats['Ld'] = stats[7]
		@stats['Sv'] = stats[8]		
		@gear = gear
		@rules = rules
		@cost = cost
	end
	
	def getGear()
		@gear
	end
	
	def getCost()
		@cost
	end

	### Return Hashes and Arrays
	
	def getStats() 
		@stats
	end
	
	def getRanged()
		@ranged_weapons
	end
	
	def getCC()
		@cc_weapons
	end
	
	def getKeywords()
		@keywords
	end
	
	
	### Return individual stats
	def getM 
		@stats['M']
	end
	
	def getWS
		@stats['WS']
	end
	
	def getBS 
		@stats['BS']
	end
	
	def getS 
		@stats['S']
	end
	
	def getT 
		@stats['T']
	end
	
	def getW 
		@stats['W']
	end
	
	def getA
		@stats['A']
	end
	
	def getLd 
		@stats['Ld']
	end
	
	def getSv 
		@stats['Sv']
	end
end