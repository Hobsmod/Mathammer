class Target
   def initialize(name, stats)
	@name = name
	@stats = Hash.new{}
	@stats['Toughness'] = stats[0]
	@stats['Save'] = stats[1]
	@stats['Invuln'] = stats[2]
	@stats['Wounds'] = stats[3]
	if stats[4]
		@stats['FNP1'] = stats[4]
	end
	if stats[5]
		@stats['FNP2'] = stats[5]
	end
	if stats[6]
		@stats['FNP3'] = stats[6]
	end	
   end
   
   def getName()
		@name
	end
   def getT()
		@stats['Toughness']
	end
	
	def getSv()
		@stats['Save']
	end
	
	def getInvuln()
		@stats['Invuln']
	end
	
	def getW()
		@stats['Wounds']
	end
	
	def getFNP()
		fnp = Array.new
		if @stats['FNP1']
			FNP.push(@stats['FNP1'])
		end
		if @stats['FNP2']
			FNP.push(@stats['FNP2'])
		end
		if @stats['FNP3']
			FNP.push(@stats['FNP3'])
		end
		return fnp
	end
end
